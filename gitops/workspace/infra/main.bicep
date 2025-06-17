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
@description('The resource ID of the resource group')
output resourceGroupId string = resourceGroup.id

@description('The name of the resource group')
output resourceGroupName string = resourceGroup.name

@description('The location of the resource group')
output location string = resourceGroup.location

@description('The resource ID of the storage account')
output storageAccountId string = storageAccount.outputs.storageAccountId

@description('The name of the storage account')
output storageAccountName string = storageAccount.outputs.storageAccountName

@description('The primary endpoints of the storage account')
output storageAccountEndpoints object = storageAccount.outputs.primaryEndpoints

@description('The resource ID of the container registry')
output containerRegistryId string = containerRegistry.outputs.containerRegistryId

@description('The name of the container registry')
output containerRegistryName string = containerRegistry.outputs.containerRegistryName

@description('The login server of the container registry')
output containerRegistryLoginServer string = containerRegistry.outputs.loginServer
