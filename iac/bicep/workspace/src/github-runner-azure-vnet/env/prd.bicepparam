using '../main.bicep'

@description('Azure region for all resources')
param location = 'eastus2' // Default to East US 2

@description('Environment name for resource naming and tagging')
@allowed([
  'dev'
  'tst'
  'prd'
])

@description('Name for the Network Security Group')
param nsgName = 'github-runner-nsg-prd'
