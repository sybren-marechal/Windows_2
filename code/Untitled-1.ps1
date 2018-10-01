

$csvfile = ".\Documents\NEW_USER\groups.csv"
$logfile = ".\Documents\NEW_USER\logfile.txt"
$date = Get-Date



import-csv $csvfile | ForEach-Object {
New-ADUser -Name $_.Voornaam -OtherAttributes @{'mail'=$_.voornaam + "." + $_.naam + "@fabrikam.com"; UserPrincipalName= $_.account}
add-ADGroupMember -Identity $_.groupname -Members $_.voornaam
Move-ADobject (get-aduser $_.voornaam).DistinguishedName -TargetPath "OU=verkoop,OU=PFafdeling,DC=PoliFormaSM,DC=be";
}

##########