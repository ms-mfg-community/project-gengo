// Bicep Parameters File for Azure Infrastructure Deployment
// Author: GitHub Copilot
// Date: June 25, 2025

using './main.bicep'

// Resource Group Configuration
param resourceGroupName = 'gaw-iac-azure-deployment'
param location = 'eastus2'

// Resource Naming with Random Suffix (to be provided at deployment time)
param randomResourceSuffix = 'default01'

// Storage Account Configuration
param storageAccountName = '1sta'

// Container Registry Configuration  
param containerRegistryName = 'acr'

// App Service Plan Configuration
param appServicePlanName = 'asp'

// App Service Configuration
param appServiceName = 'app'

// Key Vault Configuration
param keyVaultName = 'kvt'

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
