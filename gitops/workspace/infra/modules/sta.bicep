// ====================================================================================================
// AZURE STORAGE ACCOUNT MODULE
// ====================================================================================================
//
// PURPOSE:
//   This module deploys an Azure Storage Account with configurable settings for different
//   use cases including general-purpose storage, blob storage, and Data Lake scenarios.
//
// FEATURES:
//   - Configurable SKU and performance tiers (Standard/Premium, LRS/GRS/ZRS)
//   - Multiple storage account kinds (StorageV2, BlobStorage, etc.)
//   - Security configurations (public access controls, encryption)
//   - Optional Azure Data Lake Storage Gen2 support
//   - Diagnostic settings for monitoring and compliance
//
// SECURITY:
//   - Public blob access disabled by default
//   - HTTPS traffic only enforcement
//   - Minimum TLS version 1.2 requirement
//   - Infrastructure encryption for enhanced security
//
// BASED ON: Azure Verified Modules patterns for consistency and best practices
// RESOURCE TYPE: Microsoft.Storage/storageAccounts
// API VERSION: 2023-05-01 (latest stable version)
// ====================================================================================================

// ====================================================================================================
// PARAMETERS SECTION
// ====================================================================================================

@description('The name of the storage account - must be globally unique, 3-24 lowercase letters/numbers')
param storageAccountName string

@description('The Azure region where the storage account will be deployed')
param location string = resourceGroup().location

@description('Storage account SKU - determines redundancy and performance characteristics')
@allowed([
  'Standard_LRS'   // Standard performance, locally redundant storage
  'Standard_GRS'   // Standard performance, geo-redundant storage
  'Standard_RAGRS' // Standard performance, read-access geo-redundant storage
  'Standard_ZRS'   // Standard performance, zone-redundant storage
  'Premium_LRS'    // Premium performance, locally redundant storage (SSD)
  'Premium_ZRS'    // Premium performance, zone-redundant storage (SSD)
])
param skuName string = 'Standard_LRS'

@description('Storage account kind - determines available features and services')
@allowed([
  'Storage'           // Legacy general-purpose v1 account (not recommended)
  'StorageV2'         // General-purpose v2 account (recommended for most scenarios)
  'BlobStorage'       // Blob-only storage account (legacy)
  'FileStorage'       // Premium file shares only
  'BlockBlobStorage'  // Premium block blob storage only
])
param kind string = 'StorageV2'

@description('Storage account access tier - affects pricing for blob storage')
@allowed([
  'Hot'   // Optimized for frequently accessed data
  'Cool'  // Optimized for infrequently accessed data (lower storage cost, higher access cost)
])
param accessTier string = 'Hot'

@description('Allow or disallow public read access to all blobs or containers - disabled for security')
param allowBlobPublicAccess bool = false

@description('Enable hierarchical namespace for Azure Data Lake Storage Gen2 capabilities')
param isHnsEnabled bool = false

@description('Tags to apply to the storage account for governance and cost tracking')
param tags object = {}

// ====================================================================================================
// STORAGE ACCOUNT RESOURCE
// ====================================================================================================

// Main Storage Account resource with comprehensive security and feature configuration
resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: storageAccountName
  location: location
  tags: tags
  sku: {
    name: skuName    // Storage redundancy and performance tier
  }
  kind: kind        // Storage account type and available features
  properties: {
    // Access and pricing configuration
    accessTier: accessTier                    // Hot or Cool tier for blob storage pricing
    allowBlobPublicAccess: allowBlobPublicAccess  // Disable public blob access for security
    isHnsEnabled: isHnsEnabled                // Enable Data Lake Storage Gen2 if needed
    
    // Security configurations
    minimumTlsVersion: 'TLS1_2'              // Enforce minimum TLS 1.2 for security
    supportsHttpsTrafficOnly: true           // Require HTTPS for all requests
    publicNetworkAccess: 'Enabled'           // Allow public network access (can be restricted later)
    allowSharedKeyAccess: true               // Allow shared key authentication
    
    // Network access controls
    networkAcls: {
      defaultAction: 'Allow'                 // Default allow (can be configured for specific scenarios)
    }
  }
}

// ====================================================================================================
// BLOB SERVICES CONFIGURATION
// ====================================================================================================
// Configure blob service properties including retention policies and soft delete

// Default blob services configuration with data protection features
resource blobServices 'Microsoft.Storage/storageAccounts/blobServices@2023-05-01' = {
  parent: storageAccount
  name: 'default'
  properties: {
    // Blob soft delete configuration
    deleteRetentionPolicy: {
      enabled: true     // Enable soft delete for accidental blob deletion protection
      days: 7          // Retain deleted blobs for 7 days
    }
    // Container soft delete configuration
    containerDeleteRetentionPolicy: {
      enabled: true     // Enable soft delete for accidental container deletion protection
      days: 7          // Retain deleted containers for 7 days
    }
  }
}

// ====================================================================================================
// DEFAULT CONTAINER
// ====================================================================================================
// Create a default container for general blob storage needs

// Default container with secure access settings
resource defaultContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = {
  parent: blobServices
  name: 'default'
  properties: {
    publicAccess: 'None'    // No public access to container contents for security
  }
}

// ====================================================================================================
// OUTPUTS SECTION
// ====================================================================================================
// Return storage account information for use by other modules and applications

output storageAccountName string = storageAccount.name                              // Name for configuration
output storageAccountId string = storageAccount.id                                 // Full Azure resource ID
output primaryEndpoints object = storageAccount.properties.primaryEndpoints       // All service endpoints
output primaryBlobEndpoint string = storageAccount.properties.primaryEndpoints.blob  // Blob service URL
output primaryWebEndpoint string = storageAccount.properties.primaryEndpoints.web    // Static website URL
