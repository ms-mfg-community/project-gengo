# Start-VSCodeWithADO.ps1
# Script to prompt for Azure DevOps PAT and start VS Code with the environment variable set

param(
    [string]$WorkspacePath = "."
)

# Function to securely prompt for PAT
function Get-SecureADOToken {
    Write-Host "Azure DevOps Personal Access Token Required" -ForegroundColor Yellow
    Write-Host "Please enter your Azure DevOps PAT (input will be hidden):" -ForegroundColor Cyan
    
    $secureToken = Read-Host -AsSecureString
    $bstr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($secureToken)
    $token = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr)
    [System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($bstr)
    
    return $token
}

# Get the PAT token
$adoToken = Get-SecureADOToken

if ([string]::IsNullOrWhiteSpace($adoToken)) {
    Write-Error "No token provided. Exiting."
    exit 1
}

# Set the environment variable for this session
$env:AZURE_DEVOPS_PAT = $adoToken

Write-Host "Environment variable set. Starting VS Code..." -ForegroundColor Green

# Start VS Code with the environment variable
Start-Process -FilePath "code" -ArgumentList $WorkspacePath -NoNewWindow

Write-Host "VS Code started with Azure DevOps PAT configured." -ForegroundColor Green
Write-Host "The token will be available for the MCP server connection." -ForegroundColor Cyan
