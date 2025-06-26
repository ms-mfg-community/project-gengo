// Azure Storage Account Module
// Based on Azure Verified Modules patterns
// Resource Type: Microsoft.Storage/storageAccounts

@description('The name of the storage account')
param storageAccountName string

@description('The location for the storage account')
param location string = resourceGroup().location

@description('Storage account SKU')
@allowed([
  'Standard_LRS'
  'Standard_GRS'
  'Standard_RAGRS'
  'Standard_ZRS'
  'Premium_LRS'
  'Premium_ZRS'
])
param skuName string = 'Standard_LRS'

@description('Storage account kind')
@allowed([
  'Storage'
  'StorageV2'
  'BlobStorage'
  'FileStorage'
  'BlockBlobStorage'
])
param kind string = 'StorageV2'

@description('Storage account access tier')
@allowed([
  'Hot'
  'Cool'
])
param accessTier string = 'Hot'

@description('Allow or disallow public read access to all blobs or containers')
param allowBlobPublicAccess bool = false

@description('Enable hierarchical namespace for Azure Data Lake Storage Gen2')
param isHnsEnabled bool = false

@description('Tags to apply to the storage account')
param tags object = {}

// Storage Account Resource
resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: storageAccountName
  location: location
  tags: tags
  sku: {
    name: skuName
  }
  kind: kind
  properties: {
    accessTier: accessTier
    allowBlobPublicAccess: allowBlobPublicAccess
    isHnsEnabled: isHnsEnabled
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: true
    publicNetworkAccess: 'Enabled'
    allowSharedKeyAccess: true
    networkAcls: {
      defaultAction: 'Allow'
    }
  }
}

// Default container for blob storage
resource blobServices 'Microsoft.Storage/storageAccounts/blobServices@2023-05-01' = {
  parent: storageAccount
  name: 'default'
  properties: {
    deleteRetentionPolicy: {
      enabled: true
      days: 7
    }
    containerDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
  }
}

// Default container
resource defaultContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = {
  parent: blobServices
  name: 'default'
  properties: {
    publicAccess: 'None'
  }
}

// Outputs
output storageAccountName string = storageAccount.name
output storageAccountId string = storageAccount.id
output primaryEndpoints object = storageAccount.properties.primaryEndpoints
output primaryBlobEndpoint string = storageAccount.properties.primaryEndpoints.blob
output primaryWebEndpoint string = storageAccount.properties.primaryEndpoints.web
