# Deploy-AzResourcesWithBicep.ps1
# PowerShell script to deploy Azure resources using Bicep template

$rgName = "Runner-Group-PP-1"
$location = "eastus2"

# Define network settings parameters
$networkParams = @{
    vnetName = "Vnet-PP-1"
    vnetAddressPrefix = "10.0.0.0/16"
    subnetName = "default"
    subnetAddressPrefix = "10.0.0.0/24"
}

# Create resource group if it doesn't exist
if (-not (Get-AzResourceGroup -Name $rgName -ErrorAction SilentlyContinue)) 
{
    Write-Verbose "Creating new resource group '$rgName' in location '$location'"
    New-AzResourceGroup -Name $rgName -Location $location -Verbose
} #end if
else
{
    Write-Verbose "Using existing resource group '$rgName'"
} #end else

# Deploy Bicep template to the resource group
Write-Verbose "Deploying Bicep template to resource group '$rgName'"
Write-Verbose "Creating network settings resource 'Vnet-PP-1-NetworkSettings'"
New-AzResourceGroupDeployment -ResourceGroupName $rgName `
                             -TemplateFile "./main.bicep" `
                             -networkSettingsName "Vnet-PP-1-NetworkSettings" `
                             -vnetName $networkParams.vnetName `
                             -vnetAddressPrefix $networkParams.vnetAddressPrefix `
                             -subnetName $networkParams.subnetName `
                             -subnetAddressPrefix $networkParams.subnetAddressPrefix `
                             -Verbose

Write-Output "Deployment completed. To clean up and delete resources run the following command:"
Write-Output "Remove-AzResourceGroup -Name $rgName -Force"