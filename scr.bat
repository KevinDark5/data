@echo off
:: Lấy đường dẫn Desktop của người dùng
set desktopPath=%USERPROFILE%\Desktop

:: Tạo file PowerShell để chụp màn hình
echo Add-Type -AssemblyName System.Windows.Forms > "%temp%\screenshot.ps1"
echo Add-Type -AssemblyName System.Drawing >> "%temp%\screenshot.ps1"
echo $bounds = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds >> "%temp%\screenshot.ps1"
echo $bitmap = New-Object Drawing.Bitmap $bounds.Width, $bounds.Height >> "%temp%\screenshot.ps1"
echo $graphics = [Drawing.Graphics]::FromImage($bitmap) >> "%temp%\screenshot.ps1"
echo $graphics.CopyFromScreen($bounds.Location, [Drawing.Point]::Empty, $bounds.Size) >> "%temp%\screenshot.ps1"
echo $bitmap.Save("%desktopPath%\screenshot.png", [Drawing.Imaging.ImageFormat]::Png) >> "%temp%\screenshot.ps1"
echo $graphics.Dispose() >> "%temp%\screenshot.ps1"
echo $bitmap.Dispose() >> "%temp%\screenshot.ps1"

:: Chạy PowerShell để chụp ảnh màn hình
powershell -ExecutionPolicy Bypass -File "%temp%\screenshot.ps1"

:: Xóa file PowerShell tạm
del "%temp%\screenshot.ps1"

:: Thông báo hoàn tất
echo Screenshot saved to Desktop!
pause
