Set objShell = CreateObject("WScript.Shell")
Set objFSO = CreateObject("Scripting.FileSystemObject")

' Paths
root = "D:\vscode proj\salon booking webapp"
frontendDir = root & "\salon-booking-system\frontend"
backendDir = root & "\salon-booking-system\backend\salon_backend"

' Files to store PIDs
pidDir = root & "\.local_pids"
If Not objFSO.FolderExists(pidDir) Then objFSO.CreateFolder(pidDir)
frontendPidFile = pidDir & "\frontend.pid"
backendPidFile = pidDir & "\backend.pid"

' Start backend (Django)
cmdBackend = "cmd /c """ & backendDir & "\..\..\..\venv\Scripts\activate && python manage.py runserver 0.0.0.0:8000"""
' If you don't use a venv, use: cmdBackend = "cmd /c python manage.py runserver 0.0.0.0:8000"
Set backendExec = objShell.Exec("cmd /c start ""Django Server"" /MIN " & """ & "cmd /c cd /d " & backendDir & " && python manage.py runserver 0.0.0.0:8000" & """")
backendPid = backendExec.ProcessID
If Not objFSO.FileExists(backendPidFile) Then
  Set f = objFSO.CreateTextFile(backendPidFile, True)
  f.Write backendPid
  f.Close
End If

' Start frontend (simple HTTP server)
Set frontendExec = objShell.Exec("cmd /c start ""Frontend"" /MIN " & """ & "cmd /c cd /d " & frontendDir & " && python -m http.server 3000" & """")
frontendPid = frontendExec.ProcessID
If Not objFSO.FileExists(frontendPidFile) Then
  Set f2 = objFSO.CreateTextFile(frontendPidFile, True)
  f2.Write frontendPid
  f2.Close
End If

MsgBox "Started frontend (http://127.0.0.1:3000) and backend (http://127.0.0.1:8000). PIDs saved to " & pidDir, vbInformation, "Local servers started"