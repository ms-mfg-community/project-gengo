// ====================================================================================================
// AZURE LOG ANALYTICS WORKSPACE MODULE
// ====================================================================================================
//
// PURPOSE:
//   This module deploys an Azure Log Analytics Workspace for centralized logging, monitoring,
//   and analytics across Azure resources. It serves as the foundation for observability and
//   provides comprehensive data collection and analysis capabilities.
//
// FEATURES:
//   - Centralized log collection from multiple Azure services
//   - KQL (Kusto Query Language) for advanced log analysis
//   - Integration with Azure Monitor and Application Insights
//   - Data export capabilities to Azure Storage
//   - Custom data sources and performance counters
//   - Security and compliance logging for audit trails
//
// MONITORING CAPABILITIES:
//   - Application performance and error tracking
//   - Infrastructure health and performance metrics
//   - Security event monitoring and alerting
//   - Custom business metrics and KPIs
//   - Real-time dashboards and reports
//
// COST OPTIMIZATION:
//   - Pay-per-GB ingestion model with PerGB2018 SKU
//   - Configurable daily quota to control costs
//   - Data retention policies for compliance and cost management
//   - Efficient querying with performance optimization
//
// BASED ON: Azure Verified Modules (AVM) pattern for enterprise-grade deployment
// RESOURCE TYPE: Microsoft.OperationalInsights/workspaces
// AVM VERSION: 0.11.2 (latest stable version)
// ====================================================================================================

// ====================================================================================================
// PARAMETERS SECTION
// ====================================================================================================

@description('The name of the Log Analytics Workspace - must be unique within the resource group')
param lawName string

@description('The Azure region where the Log Analytics Workspace will be deployed')
param location string

@description('The resource ID of the storage account for data export and long-term retention')
param storageAccountId string

@description('Tags to apply to the Log Analytics Workspace for governance and cost tracking')
param tags object

// ====================================================================================================
// LOG ANALYTICS WORKSPACE DEPLOYMENT
// ====================================================================================================
// Deploy using Azure Verified Module for enterprise-grade configuration and best practices

module workspace 'br/public:avm/res/operational-insights/workspace:0.11.2' = {
  name: 'workspaceDeployment'
  params: {
    // Required parameters
    name: lawName
    skuName: 'PerGB2018'
    // Non-required parameters
    dailyQuotaGb: 1
    dataSources: [
      {
        eventLogName: 'Application'
        eventTypes: [
          {
            eventType: 'Error'
          }
          {
            eventType: 'Warning'
          }
          {
            eventType: 'Information'
          }
        ]
        kind: 'WindowsEvent'
        name: 'applicationEvent'
      }
      {
        counterName: '% Processor Time'
        instanceName: '*'
        intervalSeconds: 60
        kind: 'WindowsPerformanceCounter'
        name: 'windowsPerfCounter1'
        objectName: 'Processor'
      }
      {
        kind: 'IISLogs'
        name: 'sampleIISLog1'
        state: 'OnPremiseEnabled'
      }
      {
        kind: 'LinuxSyslog'
        name: 'sampleSyslog1'
        syslogName: 'kern'
        syslogSeverities: [
          {
            severity: 'emerg'
          }
          {
            severity: 'alert'
          }
          {
            severity: 'crit'
          }
          {
            severity: 'err'
          }
          {
            severity: 'warning'
          }
        ]
      }
      {
        kind: 'LinuxSyslogCollection'
        name: 'sampleSyslogCollection1'
        state: 'Enabled'
      }
      {
        instanceName: '*'
        intervalSeconds: 10
        kind: 'LinuxPerformanceObject'
        name: 'sampleLinuxPerf1'
        objectName: 'Logical Disk'
        syslogSeverities: [
          {
            counterName: '% Used Inodes'
          }
          {
            counterName: 'Free Megabytes'
          }
          {
            counterName: '% Used Space'
          }
          {
            counterName: 'Disk Transfers/sec'
          }
          {
            counterName: 'Disk Reads/sec'
          }
          {
            counterName: 'Disk Writes/sec'
          }
        ]
      }
      {
        kind: 'LinuxPerformanceCollection'
        name: 'sampleLinuxPerfCollection1'
        state: 'Enabled'
      }
    ]
    features: {
      enableLogAccessUsingOnlyResourcePermissions: true
    }
    linkedStorageAccounts: [
      {
        name: 'Query'
        storageAccountIds: [
          storageAccountId
        ]
      }
    ]
    location: location
    managedIdentities: {
      systemAssigned: true
    }
    publicNetworkAccessForIngestion: 'Disabled'
    publicNetworkAccessForQuery: 'Disabled'
    tags: tags
  }
}

@description('The resource ID of the Log Analytics Workspace')
output workspaceId string = workspace.outputs.resourceId

@description('The name of the Log Analytics Workspace')
output workspaceName string = workspace.outputs.name

@description('The Log Analytics Workspace customer ID')
output customerId string = workspace.outputs.logAnalyticsWorkspaceId
