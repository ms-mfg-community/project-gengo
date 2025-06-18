targetScope = 'subscription'

@description('The name of the resource group')
param resourceGroupName string

@description('The location/region for the resource group and resources')
param location string = 'eastus2'

@description('The name of the storage account')
param storageAccountName string

@description('The name of the container registry')
param containerRegistryName string

@description('The SKU for the storage account')
param storageAccountSku string = 'Standard_LRS'

@description('The SKU for the container registry')
param containerRegistrySku string = 'Basic'

@description('Tags to apply to all resources')
param tags object = {
  project: 'gaw-iac-azure-deployment'
  environment: 'dev'
  deployedBy: 'bicep'
  createdDate: utcNow('yyyy-MM-dd')
}

// Resource Group
resource resourceGroup 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: resourceGroupName
  location: location
  tags: tags
}

// Storage Account Module
module storageAccount 'modules/sta.bicep' = {
  name: 'deploy-storage-account'
  scope: resourceGroup
  params: {
    storageAccountName: storageAccountName
    location: location
    skuName: storageAccountSku
    tags: tags
  }
}

// Container Registry Module
module containerRegistry 'modules/acr.bicep' = {
  name: 'deploy-container-registry'
  scope: resourceGroup
  params: {
    containerRegistryName: containerRegistryName
    location: location
    skuName: containerRegistrySku
    tags: tags
  }
}

// Outputs
output resourceGroupId string = resourceGroup.id
output resourceGroupName string = resourceGroup.name
output storageAccountId string = storageAccount.outputs.storageAccountId
output storageAccountName string = storageAccount.outputs.storageAccountName
output containerRegistryId string = containerRegistry.outputs.containerRegistryId
output containerRegistryName string = containerRegistry.outputs.containerRegistryName
output containerRegistryLoginServer string = containerRegistry.outputs.loginServer
