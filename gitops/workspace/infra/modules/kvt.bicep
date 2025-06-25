// Azure Key Vault Module
// Based on Azure Verified Modules patterns
// Resource Type: Microsoft.KeyVault/vaults

@description('The name of the Key Vault')
param keyVaultName string

@description('The location for the Key Vault')
param location string = resourceGroup().location

@description('Key Vault SKU')
@allowed([
  'standard'
  'premium'
])
param skuName string = 'standard'

@description('Tenant ID for Key Vault access')
param tenantId string = tenant().tenantId

@description('Enable vault for deployment')
param enabledForDeployment bool = false

@description('Enable vault for disk encryption')
param enabledForDiskEncryption bool = false

@description('Enable vault for template deployment')
param enabledForTemplateDeployment bool = true

@description('Enable soft delete')
param enableSoftDelete bool = true

@description('Soft delete retention days')
@minValue(7)
@maxValue(90)
param softDeleteRetentionInDays int = 7

@description('Enable purge protection')
param enablePurgeProtection bool = false

@description('Enable RBAC authorization')
param enableRbacAuthorization bool = true

@description('Public network access')
@allowed([
  'Enabled'
  'Disabled'
])
param publicNetworkAccess string = 'Enabled'

@description('Tags to apply to the Key Vault')
param tags object = {}

// Key Vault Resource
resource keyVault 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: keyVaultName
  location: location
  tags: tags
  properties: {
    tenantId: tenantId
    sku: {
      family: 'A'
      name: skuName
    }
    enabledForDeployment: enabledForDeployment
    enabledForDiskEncryption: enabledForDiskEncryption
    enabledForTemplateDeployment: enabledForTemplateDeployment
    enableSoftDelete: enableSoftDelete
    softDeleteRetentionInDays: softDeleteRetentionInDays
    enablePurgeProtection: enablePurgeProtection ? true : null
    enableRbacAuthorization: enableRbacAuthorization
    publicNetworkAccess: publicNetworkAccess
    accessPolicies: enableRbacAuthorization ? [] : [
      // Add access policies here if RBAC is disabled
    ]
    networkAcls: {
      defaultAction: 'Allow'
      bypass: 'AzureServices'
    }
  }
}

// Diagnostic settings (optional)
resource diagnosticSettings 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: '${keyVaultName}-diagnostics'
  scope: keyVault
  properties: {
    logs: [
      {
        categoryGroup: 'audit'
        enabled: true
        retentionPolicy: {
          enabled: false
          days: 0
        }
      }
    ]
    metrics: [
      {
        category: 'AllMetrics'
        enabled: true
        retentionPolicy: {
          enabled: false
          days: 0
        }
      }
    ]
  }
}

// Outputs
output keyVaultName string = keyVault.name
output keyVaultId string = keyVault.id
output vaultUri string = keyVault.properties.vaultUri
output tenantId string = keyVault.properties.tenantId
