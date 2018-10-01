
MAKE USER

import-csv ".\Documents\NEW_USER\groups.csv" | ForEach-Object {
    New-ADUser -Name $_.voornaam -OtherAttributes @{'title'="director";'mail'="chewdavid@fabrikam.com"}
} 


ADD USER TO GROOP

import-csv ".\Documents\NEW_USER\groups.csv" | ForEach-Object {
    add-ADGroupMember -Identity $_.groupname -Members $_.voornaam
}



MOVE USER

import-csv ".\Documents\NEW_USER\groups.csv" | ForEach-Object {
    Move-ADobject (get-aduser $_.voornaam).DistinguishedName -TargetPath 'OU=verkoop,OU=PFafdeling,DC=PoliFormaSM,DC=be';
}

ALLL

import-csv ".\Documents\NEW_USER\groups.csv" | ForEach-Object {
    New-ADUser -Name $_.voornaam -OtherAttributes @{'SamAccountName'= $_.Account ;'name'=$_.voornaam; 'surname'=$_.naam;'mail'=$_.voornaam+"."+$_.naam+"@fabrikam.com"}
    add-ADGroupMember -Identity $_.groupname -Members $_.voornaam
    Move-ADobject (get-aduser $_.voornaam).DistinguishedName -TargetPath 'OU=verkoop,OU=PFafdeling,DC=PoliFormaSM,DC=be';
}

##########