// Bicep Parameters File for Azure Infrastructure Deployment
// Author: GitHub Copilot
// Date: June 25, 2025

using './main.bicep'

// Resource Group Configuration
param resourceGroupName = 'gaw-iac-azure-deployment'
param location = 'eastus2'

// Resource Naming with Random Suffix (to be provided at deployment time)
param randomResourceSuffix = readEnvironmentVariable('RANDOM_RESOURCE_SUFFIX', 'default01')

// Storage Account Configuration
param storageAccountName = '1sta#{RANDOM_RESOURCE_SUFFIX}#'

// Container Registry Configuration  
param containerRegistryName = 'acr#{RANDOM_RESOURCE_SUFFIX}#'

// App Service Plan Configuration
param appServicePlanName = 'asp-#{RANDOM_RESOURCE_SUFFIX}#'

// App Service Configuration
param appServiceName = 'app-#{RANDOM_RESOURCE_SUFFIX}#'

// Key Vault Configuration
param keyVaultName = 'kvt-#{RANDOM_RESOURCE_SUFFIX}#'

// API Version
param apiVersion = '2025-04-28'

// Resource Tags
param tags = {
  Environment: 'Development'
  Project: 'GitOps-Azure-Workflow'
  ManagedBy: 'Bicep-IaC'
  DeployedBy: 'GitHub-Actions'
  Purpose: 'Infrastructure-as-Code-Demo'
  Owner: 'DevOps-Team'
  CostCenter: 'Engineering'
}
