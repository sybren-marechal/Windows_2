

$csvfile = ".\Documents\NEW_USER\groups.csv"
$logfile = ".\Documents\NEW_USER\logfile.txt"
$date = Get-Date

$users = import-csv $csvfile
$domain_controller = "PoliformaSM"
$ou_afdeling = "PFafdeling"
$GivenName = $_.Voornaam 
$Surname = $_.naam



ForEach ($item in $users ) {
    if ($item.Manager.Equals("X")) {
        $ou = "verkoop"
    }
    if ($item.IT.Equals("X")) {
        $ou = "it"
    }
    if ($item.boekhouding.Equals("X")) {
        $ou = "boekhouding"
    }
    if ($item.logistiek.Equals("X")) {
        $ou = "logistiek"
    }
    if ($item.importExport.Equals("X")) {
        $ou = "importExport"
    }
}


write $ou

$users | ForEach-Object {
    New-ADUser -Name $_.Voornaam  -OtherAttributes @{'mail' = $_.voornaam + "." + $_.naam + "@fabrikam.com"; UserPrincipalName = $_.account}
    add-ADGroupMember -Identity $_.groupname -Members $_.voornaam
    Move-ADobject (get-aduser $_.voornaam).DistinguishedName -TargetPath "OU=$OU,OU=$ou_afdeling,DC=$domain_controller,DC=be";
}

