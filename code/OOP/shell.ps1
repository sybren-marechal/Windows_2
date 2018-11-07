$ScriptDirectory = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
try {
    . ("$ScriptDirectory\ADUser.ps1")
    # . ("$ScriptDirectory\YourFile2.ps1")
    # . ("$ScriptDirectory\YourFile3.ps1")
    # . ("$ScriptDirectory\YourFile4.ps1")
}
catch {
    Write-Host "Error while loading supporting PowerShell Scripts" 
}

$user = [ADUser]::new()
$user.print