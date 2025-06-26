// Azure App Service Module
// Based on Azure Verified Modules patterns
// Resource Type: Microsoft.Web/sites

@description('The name of the App Service')
param appServiceName string

@description('The resource ID of the App Service Plan')
param appServicePlanId string

@description('The location for the App Service')
param location string = resourceGroup().location

@description('Runtime stack for the App Service')
param runtimeStack string = 'NODE|18-lts'

@description('Enable HTTPS only')
param httpsOnly bool = true

@description('Client affinity enabled')
param clientAffinityEnabled bool = false

@description('Always on setting')
param alwaysOn bool = false

@description('Application settings')
param appSettings array = []

@description('Tags to apply to the App Service')
param tags object = {}

// App Service Resource
resource appService 'Microsoft.Web/sites@2023-12-01' = {
  name: appServiceName
  location: location
  tags: tags
  kind: 'app'
  properties: {
    serverFarmId: appServicePlanId
    httpsOnly: httpsOnly
    clientAffinityEnabled: clientAffinityEnabled
    siteConfig: {
      alwaysOn: alwaysOn
      linuxFxVersion: runtimeStack
      ftpsState: 'Disabled'
      minTlsVersion: '1.2'
      appSettings: appSettings
      metadata: [
        {
          name: 'CURRENT_STACK'
          value: 'node'
        }
      ]
    }
  }
  dependsOn: [
    appInsights
  ]
}

// Application Insights (optional)
resource appInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: '${appServiceName}-insights'
  location: location
  tags: tags
  kind: 'web'
  properties: {
    Application_Type: 'web'
    Request_Source: 'rest'
  }
}

// App Settings for Application Insights
resource appServiceConfig 'Microsoft.Web/sites/config@2023-12-01' = {
  parent: appService
  name: 'appsettings'
  properties: {
    APPINSIGHTS_INSTRUMENTATIONKEY: appInsights.properties.InstrumentationKey
    APPLICATIONINSIGHTS_CONNECTION_STRING: appInsights.properties.ConnectionString
    ApplicationInsightsAgent_EXTENSION_VERSION: '~3'
    XDT_MicrosoftApplicationInsights_Mode: 'Recommended'
  }
}

// Outputs
output appServiceName string = appService.name
output appServiceId string = appService.id
output defaultHostName string = appService.properties.defaultHostName
output outboundIpAddresses string = appService.properties.outboundIpAddresses
output possibleOutboundIpAddresses string = appService.properties.possibleOutboundIpAddresses
output appInsightsInstrumentationKey string = appInsights.properties.InstrumentationKey
output appInsightsConnectionString string = appInsights.properties.ConnectionString
