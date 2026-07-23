Set objShell = CreateObject("WScript.Shell")
Set objFSO = CreateObject("Scripting.FileSystemObject")

root = "D:\vscode proj\salon booking webapp"
pidDir = root & "\.local_pids"
frontendPidFile = pidDir & "\frontend.pid"
backendPidFile = pidDir & "\backend.pid"

' If old PID files exist, remove them after attempting to kill those PIDs.
If objFSO.FileExists(frontendPidFile) Then
  On Error Resume Next
  Set f = objFSO.OpenTextFile(frontendPidFile, 1)
  pid = Trim(f.ReadAll)
  f.Close
  If pid <> "" Then objShell.Run "taskkill /PID " & pid & " /F", 0, True
  objFSO.DeleteFile frontendPidFile
  On Error Goto 0
End If
If objFSO.FileExists(backendPidFile) Then
  On Error Resume Next
  Set f2 = objFSO.OpenTextFile(backendPidFile, 1)
  pid2 = Trim(f2.ReadAll)
  f2.Close
  If pid2 <> "" Then objShell.Run "taskkill /PID " & pid2 & " /F", 0, True
  objFSO.DeleteFile backendPidFile
  On Error Goto 0
End If

' Fallback: find processes listening on ports 8000 and 3000 and kill them.
' Uses netstat to locate PIDs and taskkill them.
On Error Resume Next
objShell.Run "cmd.exe /c for /f \"tokens=5\" %a in ('netstat -ano ^| findstr :8000') do taskkill /PID %a /F", 0, True
objShell.Run "cmd.exe /c for /f \"tokens=5\" %a in ('netstat -ano ^| findstr :3000') do taskkill /PID %a /F", 0, True
On Error Goto 0

MsgBox "Stopped local frontend and backend (if running).", vbInformation, "Servers stopped"