$ScriptDirectory = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
try {
    . ("$ScriptDirectory\test.ps1")

}
catch {
    Write-Host "Error while loading supporting PowerShell Scripts" 
}

$dev = [Device]::new()
$dev.Brand = "Microsoft"
$dev