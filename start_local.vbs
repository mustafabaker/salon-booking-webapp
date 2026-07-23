Set objShell = CreateObject("WScript.Shell")
Set objFSO = CreateObject("Scripting.FileSystemObject")

' Paths
root = "D:\vscode proj\salon booking webapp"
frontendDir = root & "\salon-booking-system\frontend"
backendDir = root & "\salon-booking-system\backend\salon_backend"

' Look for common venv locations (backend/.venv, backend/venv, project .venv)
venvCandidates = Array(backendDir & "\\.venv\\Scripts\\activate.bat", backendDir & "\\venv\\Scripts\\activate.bat", root & "\\.venv\\Scripts\\activate.bat")
venvActivate = ""
For i = 0 To UBound(venvCandidates)
  If objFSO.FileExists(venvCandidates(i)) Then
    venvActivate = venvCandidates(i)
    Exit For
  End If
Next

' Build backend command. Use `call` to run the activate script when present.
If venvActivate <> "" Then
  backendCmd = "cmd.exe /k cd /d " & Chr(34) & backendDir & Chr(34) & " && call " & Chr(34) & venvActivate & Chr(34) & " && python manage.py runserver 0.0.0.0:8000"
Else
  backendCmd = "cmd.exe /k cd /d " & Chr(34) & backendDir & Chr(34) & " && python manage.py runserver 0.0.0.0:8000"
End If

' Build frontend command
frontendCmd = "cmd.exe /k cd /d " & Chr(34) & frontendDir & Chr(34) & " && python -m http.server 3000"

' Launch windows (visible) for backend and frontend. Do not wait.
objShell.Run backendCmd, 1, False
objShell.Run frontendCmd, 1, False

MsgBox "Started frontend (http://127.0.0.1:3000) and backend (http://127.0.0.1:8000).", vbInformation, "Local servers started"