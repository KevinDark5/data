Dim shell
Set shell = CreateObject("WScript.Shell")

' Define the path to the PowerShell script in the TEMP folder
tempPath = shell.ExpandEnvironmentStrings("%TEMP%")
psScript = tempPath & "\pydata.ps1"

' Check if the file exists
Set fso = CreateObject("Scripting.FileSystemObject")
If fso.FileExists(psScript) Then
    ' Execute the PowerShell script
    command = "powershell.exe -NoProfile -ExecutionPolicy Bypass -File """ & psScript & """"
    shell.Run command, 0, False
Else
    MsgBox "The file pydata.ps1 does not exist in TEMP.", vbCritical, "Error"
End If
