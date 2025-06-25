// Azure App Service Plan Module
// Based on Azure Verified Modules patterns
// Resource Type: Microsoft.Web/serverfarms

@description('The name of the App Service Plan')
param appServicePlanName string

@description('The location for the App Service Plan')
param location string = resourceGroup().location

@description('App Service Plan SKU')
@allowed([
  'F1'
  'D1'
  'B1'
  'B2'
  'B3'
  'S1'
  'S2'
  'S3'
  'P1'
  'P2'
  'P3'
  'P1V2'
  'P2V2'
  'P3V2'
  'P1V3'
  'P2V3'
  'P3V3'
])
param skuName string = 'B1'

@description('App Service Plan tier')
@allowed([
  'Free'
  'Shared'
  'Basic'
  'Standard'
  'Premium'
  'PremiumV2'
  'PremiumV3'
])
param skuTier string = 'Basic'

@description('Number of worker instances')
@minValue(1)
@maxValue(20)
param capacity int = 1

@description('Operating system type')
@allowed([
  'Linux'
  'Windows'
])
param kind string = 'Linux'

@description('Reserved instances (Linux only)')
param reserved bool = (kind == 'Linux')

@description('Tags to apply to the App Service Plan')
param tags object = {}

// App Service Plan Resource
resource appServicePlan 'Microsoft.Web/serverfarms@2023-01-01' = {
  name: appServicePlanName
  location: location
  tags: tags
  kind: kind
  properties: {
    reserved: reserved
    targetWorkerCount: capacity
    targetWorkerSizeId: 0
  }
  sku: {
    name: skuName
    tier: skuTier
    capacity: capacity
  }
}

// Outputs
output appServicePlanName string = appServicePlan.name
output appServicePlanId string = appServicePlan.id
output appServicePlanKind string = appServicePlan.kind
output skuName string = appServicePlan.sku.name
output skuTier string = appServicePlan.sku.tier
