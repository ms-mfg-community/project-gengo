using 'main.bicep'

param resourceGroupName = 'gaw-iac-azure-deployment'
param location = 'eastus2'
param storageAccountName = '1staplaceholder'
param containerRegistryName = 'acrplaceholder'
param storageAccountSku = 'Standard_LRS'
param containerRegistrySku = 'Basic'

// Note: storageAccountName and containerRegistryName will be overridden at deployment time 
// via GitHub Actions variables with the format '1sta${randomResourceSuffix}' and 'acr${randomResourceSuffix}'
