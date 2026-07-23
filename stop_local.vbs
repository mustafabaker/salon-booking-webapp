Set objShell = CreateObject("WScript.Shell")
Set objFSO = CreateObject("Scripting.FileSystemObject")

root = "D:\vscode proj\salon booking webapp"
pidDir = root & "\.local_pids"
frontendPidFile = pidDir & "\frontend.pid"
backendPidFile = pidDir & "\backend.pid"

If Not objFSO.FolderExists(pidDir) Then
  MsgBox "No PID folder found. Nothing to stop.", vbExclamation, "Stop servers"
  WScript.Quit
End If

Sub KillPidFile(pidFile)
  If objFSO.FileExists(pidFile) Then
    Set f = objFSO.OpenTextFile(pidFile, 1)
    pid = Trim(f.ReadAll)
    f.Close
    If pid <> "" Then
      On Error Resume Next
      objShell.Run "taskkill /PID " & pid & " /F", 0, True
      On Error Goto 0
    End If
    objFSO.DeleteFile pidFile
  End If
End Sub

KillPidFile frontendPidFile
KillPidFile backendPidFile

MsgBox "Stopped local frontend and backend (if running).", vbInformation, "Servers stopped"