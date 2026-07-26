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

$venvPython = Join-Path $venvPath 'Scripts\python.exe'

if (-not (Test-Path $venvPython)) {
    Write-Error "Python executable not found in venv ($venvPython). Ensure Python is installed and accessible."
    exit 1
}

# Upgrade pip and install requirements
& $venvPython -m pip install --upgrade pip
if (Test-Path $requirements) {
    Write-Host "Installing backend requirements from $requirements"
    & $venvPython -m pip install -r $requirements
} else {
    Write-Warning "requirements.txt not found at $requirements"
}

# Run migrations before starting the backend
Push-Location $backendAppDir
try {
    Write-Host "Running Django migrations"
    & $venvPython manage.py migrate
} finally {
    Pop-Location
}

# Start backend in new PowerShell window
$backendCommand = "cd `"$backendAppDir`"; `$env:VIRTUAL_ENV='$venvPath'; `"$venvPython`" manage.py runserver 0.0.0.0:8000"
Start-Process -FilePath powershell -ArgumentList "-NoExit","-NoProfile","-Command","$backendCommand" -WindowStyle Normal
Write-Host "Started backend in new window"

# Start frontend in new PowerShell window
$frontendCommand = "cd `"$frontendDir`"; `"$venvPython`" -m http.server 3000"
Start-Process -FilePath powershell -ArgumentList "-NoExit","-NoProfile","-Command","$frontendCommand" -WindowStyle Normal
Write-Host "Started frontend in new window (http://127.0.0.1:3000)"

Write-Host "All done."
