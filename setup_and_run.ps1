# setup_and_run.ps1
# Creates a backend virtualenv, installs requirements, then opens two PowerShell windows
# to run the Django backend and the static frontend server.

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$backendDir = Join-Path $root 'salon-booking-system\backend'
$backendAppDir = Join-Path $backendDir 'salon_backend'
$frontendDir = Join-Path $root 'salon-booking-system\frontend'
$venvPath = Join-Path $backendDir '.venv'
$requirements = Join-Path $backendDir 'requirements.txt'

Write-Host "Root: $root"
Write-Host "Backend dir: $backendDir"
Write-Host "Frontend dir: $frontendDir"

# Create venv if missing
if (-not (Test-Path $venvPath)) {
    Write-Host "Creating virtual environment at $venvPath"
    python -m venv $venvPath
}

$python = Join-Path $venvPath 'Scripts\python.exe'
$pip = Join-Path $venvPath 'Scripts\pip.exe'

if (-not (Test-Path $python)) {
    Write-Error "Python executable not found in venv ($python). Ensure Python is installed and accessible."
    exit 1
}

# Upgrade pip and install requirements
& $pip install --upgrade pip
if (Test-Path $requirements) {
    Write-Host "Installing backend requirements from $requirements"
    & $pip install -r $requirements
} else {
    Write-Warning "requirements.txt not found at $requirements"
}

# Start backend in new PowerShell window
$backendCommand = "cd `"$backendAppDir`"; `$env:VIRTUAL_ENV='$venvPath'; `"$python`" manage.py runserver 0.0.0.0:8000"
Start-Process -FilePath powershell -ArgumentList "-NoExit","-Command","$backendCommand" -WindowStyle Normal
Write-Host "Started backend in new window"

# Start frontend in new PowerShell window
$frontendCommand = "cd `"$frontendDir`"; python -m http.server 3000"
Start-Process -FilePath powershell -ArgumentList "-NoExit","-Command","$frontendCommand" -WindowStyle Normal
Write-Host "Started frontend in new window (http://127.0.0.1:3000)"

Write-Host "All done."
