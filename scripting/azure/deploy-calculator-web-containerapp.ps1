#Requires -Version 7.0
param
(
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$SubscriptionId,

    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$ResourceGroupName,

    [Parameter(Mandatory = $false)]
    [ValidateNotNullOrEmpty()]
    [string]$Location = 'eastus2'
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Write-Host "Setting Azure subscription context to $SubscriptionId"
az account set --subscription $SubscriptionId | Out-Null

Write-Host "Ensuring Azure resource group '$ResourceGroupName' exists in $Location"
az group create --name $ResourceGroupName --location $Location | Out-Null

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..\..")).Path
$buildContext = Join-Path $repoRoot "programming\dotnet\csharp\workspace\calculator-xunit-testing"
$dockerfilePath = Join-Path $buildContext "calculator.web\Dockerfile"
$templateFile = Join-Path $repoRoot "infra\bicep\main.bicep"

if (-not (Test-Path $dockerfilePath))
{
    throw "Dockerfile not found at $dockerfilePath"
}

if (-not (Test-Path $templateFile))
{
    throw "Bicep template not found at $templateFile"
}

$rgToken = ($ResourceGroupName -replace '[^a-zA-Z0-9]', '').ToLower()
if ($rgToken.Length -lt 8)
{
    $rgToken = ($rgToken + 'calculatorweb').Substring(0, 8)
}
else
{
    $rgToken = $rgToken.Substring(0, [Math]::Min(20, $rgToken.Length))
}

$acrName = "acr$rgToken"
$acrName = $acrName.Substring(0, [Math]::Min(50, $acrName.Length))
$appName = 'calculator-web'
$envName = 'cae-calculator-web'
$lawName = 'law-calculator-web'
$uamiName = 'uami-calculator-web'
$tag = (Get-Date -Format 'yyyyMMddHHmmss')
$imageName = "${appName}:$tag"

Write-Host "Deploying infrastructure with Bicep template: $templateFile"
$deploymentResultJson = az deployment group create `
    --resource-group $ResourceGroupName `
    --template-file $templateFile `
    --parameters location=$Location `
                 acrName=$acrName `
                 containerAppEnvironmentName=$envName `
                 logAnalyticsWorkspaceName=$lawName `
                 userAssignedIdentityName=$uamiName `
    --query properties.outputs `
    --output json

$deploymentOutputs = $deploymentResultJson | ConvertFrom-Json
$acrLoginServer = $deploymentOutputs.acrLoginServer.value
$containerAppEnvironmentId = $deploymentOutputs.containerAppEnvironmentId.value
$userAssignedIdentityId = $deploymentOutputs.userAssignedIdentityId.value

if (-not $acrLoginServer)
{
    throw 'Failed to resolve ACR login server from Bicep outputs.'
}

Write-Host "Building and pushing container image to ACR: $acrName/$imageName"
az acr build `
    --registry $acrName `
    --image $imageName `
    --file $dockerfilePath `
    $buildContext | Out-Null

$imageRef = "$acrLoginServer/$imageName"
Write-Host "Deploying container app '$appName' with image '$imageRef'"

$exists = az containerapp show --name $appName --resource-group $ResourceGroupName --query name --output tsv 2>$null
if ([string]::IsNullOrWhiteSpace($exists))
{
    az containerapp create `
        --name $appName `
        --resource-group $ResourceGroupName `
        --environment $containerAppEnvironmentId `
        --image $imageRef `
        --target-port 8080 `
        --ingress external `
        --min-replicas 1 `
        --max-replicas 3 `
        --cpu 0.5 `
        --memory 1.0Gi `
        --user-assigned $userAssignedIdentityId `
        --registry-server $acrLoginServer `
        --registry-identity $userAssignedIdentityId `
        --env-vars ASPNETCORE_URLS=http://+:8080 ASPNETCORE_ENVIRONMENT=Production | Out-Null
}
else
{
    az containerapp update `
        --name $appName `
        --resource-group $ResourceGroupName `
        --image $imageRef `
        --set-env-vars ASPNETCORE_URLS=http://+:8080 ASPNETCORE_ENVIRONMENT=Production | Out-Null
}

$fqdn = az containerapp show --name $appName --resource-group $ResourceGroupName --query properties.configuration.ingress.fqdn --output tsv
Write-Host "Deployment completed successfully."
Write-Host "Application URL: https://$fqdn"
