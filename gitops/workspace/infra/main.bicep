targetScope = 'subscription'

@description('The name of the resource group')
param resourceGroupName string

@description('The location for all resources')
param location string = 'eastus2'

@description('The name of the storage account')
param storageAccountName string

@description('The name of the container registry')
param containerRegistryName string

@description('Random suffix for resource names')
param randomResourceSuffix string

// Create resource group
resource resourceGroup 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: resourceGroupName
  location: location
  tags: {
    Environment: 'Development'
    Project: 'GitOps-Workflows'
    CreatedBy: 'Bicep'
  }
}

// Deploy storage account module
module storageAccount 'modules/sta.bicep' = {
  name: 'storageAccountDeployment'
  scope: resourceGroup
  params: {
    storageAccountName: storageAccountName
    location: location
    randomResourceSuffix: randomResourceSuffix
  }
}

// Deploy container registry module
module containerRegistry 'modules/acr.bicep' = {
  name: 'containerRegistryDeployment'
  scope: resourceGroup
  params: {
    containerRegistryName: containerRegistryName
    location: location
    randomResourceSuffix: randomResourceSuffix
  }
}

// Outputs
output resourceGroupName string = resourceGroup.name
output storageAccountName string = storageAccount.outputs.storageAccountName
output containerRegistryName string = containerRegistry.outputs.containerRegistryName
output containerRegistryLoginServer string = containerRegistry.outputs.loginServer
