# stop_local.ps1
# Kills processes listening on ports 8000 (Django) and 3000 (frontend)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Stop-PortProcesses($port) {
    $matches = & netstat -ano | Select-String ":$port " | ForEach-Object { $_.ToString().Trim() }
    if (-not $matches) { return }
    foreach ($line in $matches) {
        $parts = -split $line
        $pid = $parts[-1]
        if ($pid -and $pid -match '^[0-9]+$') {
            Write-Host "Killing PID $pid (port $port)"
            taskkill /PID $pid /F | Out-Null
        }
    }
}

Stop-PortProcesses 8000
Stop-PortProcesses 3000
Write-Host "Stopped processes on ports 8000 and 3000 (if any)."
