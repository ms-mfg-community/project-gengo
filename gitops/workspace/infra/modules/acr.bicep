// ====================================================================================================
// AZURE CONTAINER REGISTRY MODULE
// ====================================================================================================
//
// PURPOSE:
//   This module deploys an Azure Container Registry (ACR) for hosting private Docker images
//   and OCI artifacts. It provides secure, scalable container image storage with optional
//   advanced features based on the selected SKU tier.
//
// FEATURES:
//   - Multiple SKU tiers (Basic, Standard, Premium) with different capabilities
//   - Security configurations (admin user control, network access policies)
//   - Premium features (zone redundancy, geo-replication, advanced threat protection)
//   - Container image policies (retention, quarantine, trust)
//   - Integration with Azure security and monitoring services
//
// SKU COMPARISON:
//   - Basic: Core registry functionality, suitable for development
//   - Standard: Enhanced throughput and storage, webhook support
//   - Premium: Geo-replication, content trust, private link, zone redundancy
//
// BASED ON: Azure Verified Modules patterns for consistency and best practices
// RESOURCE TYPE: Microsoft.ContainerRegistry/registries
// API VERSION: 2023-07-01 (latest stable version)
// ====================================================================================================

// ====================================================================================================
// PARAMETERS SECTION
// ====================================================================================================

@description('The name of the container registry - must be globally unique, 5-50 alphanumeric characters')
param containerRegistryName string

@description('The Azure region where the container registry will be deployed')
param location string = resourceGroup().location

@description('Container registry SKU - determines available features and performance')
@allowed([
  'Basic'     // Basic tier: core functionality, development scenarios
  'Standard'  // Standard tier: enhanced throughput, webhook support
  'Premium'   // Premium tier: geo-replication, zone redundancy, private endpoints
])
param skuName string = 'Basic'

@description('Enable admin user for the container registry - not recommended for production')
param adminUserEnabled bool = false

@description('Enable public network access - can be disabled for enhanced security')
param publicNetworkAccess bool = true

@description('Enable zone redundancy for high availability - Premium SKU only')
param zoneRedundancy bool = false

@description('Tags to apply to the container registry for governance and cost tracking')
param tags object = {}

// ====================================================================================================
// CONTAINER REGISTRY RESOURCE
// ====================================================================================================

// Main Container Registry resource with comprehensive configuration
resource containerRegistry 'Microsoft.ContainerRegistry/registries@2023-07-01' = {
  name: containerRegistryName
  location: location
  tags: tags
  sku: {
    name: skuName    // Registry tier determining available features
  }
  properties: {
    adminUserEnabled: adminUserEnabled    // Admin user access (use service principals instead)
    
    // Container image and security policies
    policies: {
      // Quarantine policy for malware scanning (Premium tier)
      quarantinePolicy: {
        status: 'disabled'    // Disabled by default, enable for enhanced security
      }
      // Content trust policy using Notary (Premium tier)
      trustPolicy: {
        type: 'Notary'       // Digital signing for image integrity
        status: 'disabled'   // Disabled by default, enable for production security
      }
      // Image retention policy to manage storage costs
      retentionPolicy: {
        days: 7              // Retain untagged images for 7 days before cleanup
        status: 'disabled'   // Disabled by default, can be enabled for automatic cleanup
      }
      // Export policy for cross-region replication
      exportPolicy: {
        status: 'enabled'    // Allow export of container images
      }
    }
    
    // Encryption configuration
    encryption: {
      status: 'disabled'     // Customer-managed key encryption (Premium tier feature)
    }
    
    // Data endpoint configuration for improved performance
    dataEndpointEnabled: false    // Dedicated data endpoint for large image operations
    
    // Network access configuration
    publicNetworkAccess: publicNetworkAccess ? 'Enabled' : 'Disabled'  // Control public access
    networkRuleBypassOptions: 'AzureServices'   // Allow Azure services to bypass network rules
    
    // High availability configuration (Premium tier only)
    zoneRedundancy: (skuName == 'Premium' && zoneRedundancy) ? 'Enabled' : 'Disabled'
  }
}

// ====================================================================================================
// OUTPUTS SECTION
// ====================================================================================================
// Return container registry information for use by other modules and applications

output containerRegistryName string = containerRegistry.name                        // Registry name for Docker operations
output containerRegistryId string = containerRegistry.id                           // Full Azure resource ID
output loginServer string = containerRegistry.properties.loginServer               // Docker login server URL
output adminUserEnabled bool = containerRegistry.properties.adminUserEnabled      // Admin user status for configuration
