@description('The name of the Application Insights component')
param appInsightsName string

@description('The resource ID of the Log Analytics Workspace to link to Application Insights')
param workspaceResourceId string

@description('The resource ID of the storage account for diagnostic settings')
param storageAccountId string

@description('The resource ID of the Log Analytics workspace for diagnostic settings')
param workspaceId string

@description('The location where the Application Insights component will be deployed')
param location string

@description('Tags to apply to the Application Insights component')
param tags object

module component 'br/public:avm/res/insights/component:0.6.0' = {
  name: 'componentDeployment'
  params: {
    // Required parameters
    name: appInsightsName
    workspaceResourceId: workspaceResourceId
    // Non-required parameters
    diagnosticSettings: [
      {
        name: 'customSetting'
        storageAccountResourceId: storageAccountId
        workspaceResourceId: workspaceId
      }
    ]
    location: location
    tags: tags
  }
}

@description('The resource ID of the Application Insights component')
output componentId string = component.outputs.resourceId

@description('The name of the Application Insights component')
output componentName string = component.outputs.name

@description('The Application Insights instrumentation key')
output instrumentationKey string = component.outputs.instrumentationKey

@description('The Application Insights connection string')
output connectionString string = component.outputs.connectionString
