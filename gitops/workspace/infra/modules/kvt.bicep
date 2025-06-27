// ====================================================================================================
// AZURE KEY VAULT MODULE
// ====================================================================================================
//
// PURPOSE:
//   This module deploys an Azure Key Vault for secure storage and management of secrets,
//   keys, and certificates. It provides enterprise-grade security for sensitive data
//   with comprehensive access controls and audit capabilities.
//
// FEATURES:
//   - Secure storage for secrets, keys, and certificates
//   - Role-based access control (RBAC) and access policies
//   - Soft delete and purge protection for data recovery
//   - Integration with Azure services for seamless operations
//   - Hardware Security Module (HSM) support with Premium SKU
//   - Comprehensive audit logging and monitoring
//
// SECURITY CONSIDERATIONS:
//   - Soft delete enabled by default for accidental deletion protection
//   - Network access controls for enhanced security
//   - Integration with Azure Active Directory for authentication
//   - Diagnostic settings for security monitoring and compliance
//
// BASED ON: Azure Verified Modules patterns for consistency and best practices
// RESOURCE TYPE: Microsoft.KeyVault/vaults
// API VERSION: 2023-07-01 (latest stable version)
// ====================================================================================================

// ====================================================================================================
// PARAMETERS SECTION
// ====================================================================================================

@description('The name of the Key Vault - must be globally unique, 3-24 characters, letters/numbers/hyphens')
param keyVaultName string

@description('The Azure region where the Key Vault will be deployed')
param location string = resourceGroup().location

@description('Key Vault SKU - determines available features and performance')
@allowed([
  'standard'  // Standard tier: software-protected keys and secrets
  'premium'   // Premium tier: HSM-protected keys, enhanced performance
])
param skuName string = 'standard'

@description('Azure AD tenant ID for Key Vault access control')
param tenantId string = tenant().tenantId

@description('Enable vault for Azure Virtual Machine deployment scenarios')
param enabledForDeployment bool = false

@description('Enable vault for Azure Disk Encryption scenarios')
param enabledForDiskEncryption bool = false

@description('Enable vault for Azure Resource Manager template deployment scenarios')
param enabledForTemplateDeployment bool = true

@description('Enable soft delete for accidental deletion protection - recommended for production')
param enableSoftDelete bool = true

@description('Soft delete retention period in days - balance between recovery and compliance')
@minValue(7)
@maxValue(90)
param softDeleteRetentionInDays int = 7

@description('Enable purge protection to prevent permanent deletion - required for high-security scenarios')
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

@description('Storage account resource ID for diagnostic settings (optional)')
param storageAccountId string = ''

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
resource diagnosticSettings 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = if (!empty(storageAccountId)) {
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
    storageAccountId: storageAccountId
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
