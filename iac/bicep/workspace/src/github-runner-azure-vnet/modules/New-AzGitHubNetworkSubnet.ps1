# New-AzGitHubNetworkSubnet.ps1
#
# This script creates the following resources in the specified subscription:
# - Resource group
# - Network Security Group rules
# - Virtual network (vnet) and subnet
# - Network Settings with specified subnet and GitHub Enterprise database ID
#
# It also registers the `GitHub.Network` resource provider with the subscription,
# delegates the created subnet to the Actions service via the `GitHub.Network/NetworkSettings`
# resource type, and applies the NSG rules to the created subnet.

# Stop on failure
$ErrorActionPreference = "Stop"

# Set environment variables
$AzureLocation = "eastus2" # Change to your preferred Azure region
$SubscriptionId = "976c53b8-965c-4f97-ab51-993195a8623c"
$ResourceGroupName = "Runner-Group-PP-1"
$VnetName = "Runner-Vnet-PP-1"
$SubnetName = "Runner-Subnet-PP-1"
$NsgName = "github-runner-nsg-prd"
$NetworkSettingsResourceName = "Vnet-PP-1-NetworkSettings"
$DatabaseId = "292708"
$ApiVersion = "2024-04-02"

# These are the default values. You can adjust your address and subnet prefixes.
$AddressPrefix = "10.30.4.0/23"
$SubnetPrefix = "10.30.4.0/24"

function Write-StepMessage {
    param (
        [string]$Message
    )
    Write-Host ""
    Write-Host $Message -ForegroundColor Cyan
} # end Write-StepMessage

# Main script execution begins
Write-StepMessage "Login to Azure"
az login --output none

Write-StepMessage "Set account context $SubscriptionId"
az account set --subscription $SubscriptionId

Write-StepMessage "Register resource provider GitHub.Network"
az provider register --namespace GitHub.Network

Write-StepMessage "Create resource group $ResourceGroupName at $AzureLocation"
az group create --name $ResourceGroupName --location $AzureLocation

Write-StepMessage "Create NSG rules deployed with 'actions-nsg-deployment.bicep' file"
az deployment group create --resource-group $ResourceGroupName --template-file ./actions-nsg-deployment.bicep --parameters location=$AzureLocation nsgName=$NsgName

Write-StepMessage "Create vnet $VnetName and subnet $SubnetName"
az network vnet create --resource-group $ResourceGroupName --name $VnetName --address-prefix $AddressPrefix --subnet-name $SubnetName --subnet-prefixes $SubnetPrefix

Write-StepMessage "Delegate subnet to GitHub.Network/networkSettings and apply NSG rules"
az network vnet subnet update --resource-group $ResourceGroupName --name $SubnetName --vnet-name $VnetName --delegations GitHub.Network/networkSettings --network-security-group $NsgName

# Create the JSON properties string and save to a file
$propertiesHashTable = @{
    location = $AzureLocation
    properties = @{
        subnetId = "/subscriptions/$SubscriptionId/resourceGroups/$ResourceGroupName/providers/Microsoft.Network/virtualNetworks/$VnetName/subnets/$SubnetName"
        businessId = $DatabaseId
    }
}
# Create a temporary JSON file
$jsonFile = Join-Path $env:TEMP "network-settings-properties.json"
$propertiesHashTable | ConvertTo-Json -Depth 10 | Set-Content -Path $jsonFile

Write-StepMessage "Create network settings resource $NetworkSettingsResourceName"
az resource create --resource-group $ResourceGroupName --name $NetworkSettingsResourceName --resource-type GitHub.Network/networkSettings --properties "@$jsonFile" --is-full-object --api-version $ApiVersion

# Clean up the temporary file
Remove-Item -Path $jsonFile

Write-StepMessage "To clean up and delete resources run the following command:"
Write-Host "az group delete --resource-group $ResourceGroupName" -ForegroundColor Yellow

<#
The script will return the full payload for the created resource.
The GitHubId hash value returned in the payload for the created resource is the network settings resource ID you will use in the next steps
while configuring a network configuration in GitHub.
#>