using '../modules/deploy-nsg-bastion.bicep'

@description('Location for all resources')
param location = 'eastus2'

@description('Name for the Network Security Group')
param nsgName = 'bas-nsg-01'
