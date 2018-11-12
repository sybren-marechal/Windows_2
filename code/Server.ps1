#https://social.technet.microsoft.com/wiki/contents/articles/24541.powershell-bulk-create-ad-users-from-csv-file.aspx
#https://4sysops.com/archives/powershell-classes-part-3-methods/


$csvfile = "C:\Data\users.csv"
$logfile = ".\Documents\NEW_USER\logfile.txt"
$date = Get-Date

#----------------------------------------------------------
#STATIC VARIABLES
#----------------------------------------------------------

$users = import-csv $csvfile
$domain_controller = "C-Medics"
$ou_afdeling = "C-MedicsAfdelingen"

##########################################

ForEach ($item in $users ) {
    if ($item.Manager.Equals("X")) {
        $ou = "Manager" #manager
        $group = "Manager" #
         write-output "group =  $group" 
    }
    if ($item.IT.Equals("X")) {
        $ou = "IT" #it
        $group = "IT"
        write-output "group =  $group" 

    }
    if ($item.boekhouding.Equals("X")) {
        $ou = "Boekhouding" #boekhouding 
        $group = "Boekhouding"
        write-output "group =  $group" 
    }
    if ($item.logistiek.Equals("X")) {
        $ou = "Logistiek" #logistiek
        $group = "Logistiek"
        write-output "group =  $group" 
    }
    if ($item.ImportExport.Equals("X")) {
        $ou = "ImportExport" # importExport
        $group = "ImportExport"
        write-output "group =  $group" 
    }
}

$users | ForEach-Object {

    $GivenName = $_.Voornaam
    $Surname = $_.naam
    $accountName = $_.account
    $sam = $GivenName + "." + $Surname

    try {
        New-ADUser -Name $sam  -OtherAttributes @{'mail' = $GivenName + "." + $Surname + "@fabrikam.com"; UserPrincipalName = $accountName}
        write-output "created user $sam" 
    }
    catch {
        write-output "user $sam already exist" 
    }

    # add member to groop but do not delete it from the pre group
    add-ADGroupMember -Identity $group -Members $sam
    write-output "add $sam to the group $group" 
 
    Move-ADobject (get-aduser $sam).DistinguishedName -TargetPath "OU=$OU,OU=$ou_afdeling,DC=$domain_controller,DC=be";
    write-output "move $sam to the OU= $ou and the afdeling= $ou_afdeling " 

    $huidigeGroupen = @()
    foreach ($group in Get-ADPrincipalGroupMembership $sam | select name) {
        if ($group.name -ne "Domain Users") {
            $huidigeGroupen += $group.name
        }
    }
    
    foreach ($group in $huidigeGroupen) {
        if ($group -eq $ou) {
        }
        else {
            Remove-ADGroupMember -Identity $group -Members $sam
            write-output "remove $sam from the group= $group  "  
        }
    }

}

