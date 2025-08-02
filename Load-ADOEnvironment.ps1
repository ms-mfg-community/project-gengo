# Load-ADOEnvironment.ps1
# Script to load environment variables from .env file and start VS Code

param(
    [string]$EnvFile = ".env",
    [string]$WorkspacePath = "."
)

if (-not (Test-Path $EnvFile)) {
    Write-Error "Environment file '$EnvFile' not found. Please create it with AZURE_DEVOPS_PAT=your-token"
    exit 1
}

# Read and set environment variables from .env file
Get-Content $EnvFile | ForEach-Object {
    if ($_ -match "^([^#].+?)=(.+)$") {
        $name = $matches[1].Trim()
        $value = $matches[2].Trim()
        [Environment]::SetEnvironmentVariable($name, $value, "Process")
        Write-Host "Set environment variable: $name" -ForegroundColor Green
    }
}

# Start VS Code
Write-Host "Starting VS Code with environment variables loaded..." -ForegroundColor Cyan
Start-Process -FilePath "code" -ArgumentList $WorkspacePath -NoNewWindow
