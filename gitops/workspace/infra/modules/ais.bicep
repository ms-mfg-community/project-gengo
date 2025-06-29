// ====================================================================================================
// AZURE APPLICATION INSIGHTS MODULE
// ====================================================================================================
//
// PURPOSE:
//   This module deploys Azure Application Insights for comprehensive application performance
//   monitoring (APM) and analytics. It provides end-to-end visibility into application
//   health, performance, and user behavior across web and mobile applications.
//
// FEATURES:
//   - Real-time application performance monitoring
//   - Automatic dependency tracking and mapping
//   - Exception and error tracking with stack traces
//   - User behavior analytics and funnel analysis
//   - Custom telemetry and business metrics
//   - Integration with Azure Monitor and Log Analytics
//
// MONITORING CAPABILITIES:
//   - Response time and throughput metrics
//   - Failure rate and availability monitoring
//   - Database and external service dependency tracking
//   - Server and browser performance metrics
//   - Custom events and business KPIs
//   - Distributed tracing for microservices
//
// INTEGRATION BENEFITS:
//   - Seamless integration with Log Analytics Workspace for unified logging
//   - Data export to Azure Storage for long-term retention and analysis
//   - Alert rules for proactive incident response
//   - Power BI and Azure Dashboard integration for reporting
//
// BASED ON: Azure Verified Modules (AVM) pattern for enterprise-grade deployment
// RESOURCE TYPE: Microsoft.Insights/components
// AVM VERSION: 0.6.0 (latest stable version)
// ====================================================================================================

// ====================================================================================================
// PARAMETERS SECTION
// ====================================================================================================

@description('The name of the Application Insights component - used for identifying the monitoring instance')
param appInsightsName string

@description('The resource ID of the storage account for diagnostic data export and long-term retention')
param storageAccountId string

@description('The resource ID of the Log Analytics workspace for unified logging and correlation')
param workspaceId string

@description('The Azure region where the Application Insights component will be deployed')
param location string

@description('Tags to apply to the Application Insights component for governance and cost tracking')
param tags object

@description('Required. Unique deployment identifier to prevent deployment name conflicts.')
param deploymentId string

// ====================================================================================================
// APPLICATION INSIGHTS DEPLOYMENT
// ====================================================================================================
// Deploy using Azure Verified Module for enterprise-grade configuration and monitoring capabilities

module component 'br/public:avm/res/insights/component:0.6.0' = {
  name: 'componentDeployment-${deploymentId}'
  params: {
    // Required parameters
    name: appInsightsName
    workspaceResourceId: workspaceId
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
