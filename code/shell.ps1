#https://social.technet.microsoft.com/wiki/contents/articles/24541.powershell-bulk-create-ad-users-from-csv-file.aspx
#https://4sysops.com/archives/powershell-classes-part-3-methods/


$csvfile = ".\Documents\NEW_USER\groups.csv"
$logfile = ".\Documents\NEW_USER\logfile.txt"
$date = Get-Date

#----------------------------------------------------------
#STATIC VARIABLES
#----------------------------------------------------------

$users = import-csv $csvfile
$domain_controller = "PoliformaSM"
$ou_afdeling = "PFafdeling"

##########################################

ForEach ($item in $users ) {
    if ($item.Manager.Equals("X")) {
        $ou = "verkoop" #manager
        $group = "verkoop" #manager
    }
    if ($item.IT.Equals("X")) {
        $ou = "staf" #it
        $group = "staf"
    }
    if ($item.boekhouding.Equals("X")) {
        $ou = "Directie" #boekhouding 
        $group = "Directie"
    }
    if ($item.logistiek.Equals("X")) {
        $ou = "productie" #logistiek
        $group = "productie"
    }
    if ($item.importExport.Equals("X")) {
        $ou = "importExport" # importExport
        $group = "importExport"
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

