@description('The name of the storage account')
param storageAccountName string

@description('The location for the storage account')
param location string = resourceGroup().location

@description('Random suffix for resource names')
param randomResourceSuffix string

@description('Storage account SKU')
param skuName string = 'Standard_LRS'

@description('Storage account kind')
param kind string = 'StorageV2'

// Storage account resource
resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: '${storageAccountName}${randomResourceSuffix}'
  location: location
  sku: {
    name: skuName
  }
  kind: kind
  properties: {
    supportsHttpsTrafficOnly: true
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: false
    allowSharedKeyAccess: true
    defaultToOAuthAuthentication: false
    accessTier: 'Hot'
    publicNetworkAccess: 'Enabled'
    networkAcls: {
      defaultAction: 'Allow'
    }
  }
  tags: {
    Environment: 'Development'
    Project: 'GitOps-Workflows'
    CreatedBy: 'Bicep'
  }
}

// Outputs
output storageAccountName string = storageAccount.name
output storageAccountId string = storageAccount.id
output primaryEndpoints object = storageAccount.properties.primaryEndpoints
