

$csvfile = ".\Documents\NEW_USER\groups.csv"
$logfile = ".\Documents\NEW_USER\logfile.txt"
$date = Get-Date

##########################################

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
        $ou = "it"
        $group = "it"
    }
    if ($item.boekhouding.Equals("X")) {
        $ou = "boekhouding"
        $group = "boekhouding"
    }
    if ($item.logistiek.Equals("X")) {
        $ou = "logistiek"
        $group = "logistiek"
    }
    if ($item.importExport.Equals("X")) {
        $ou = "importExport"
        $group = "importExport"
    }
}


$users | ForEach-Object {

    $GivenName = $_.Voornaam
    $Surname = $_.naam
    $accountName =  $_.account
    $sam = $GivenName + "." + $Surname

    New-ADUser -Name $sam  -OtherAttributes @{'mail' = $GivenName + "." + $Surname + "@fabrikam.com"; UserPrincipalName = $accountName}
    add-ADGroupMember -Identity $group -Members $sam
    Move-ADobject (get-aduser $sam).DistinguishedName -TargetPath "OU=$OU,OU=$ou_afdeling,DC=$domain_controller,DC=be";
}

