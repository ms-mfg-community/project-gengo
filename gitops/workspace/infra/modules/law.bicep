@description('The name of the Log Analytics Workspace')
param lawName string

@description('The location where the Log Analytics Workspace will be deployed')
param location string

@description('The resource ID of the storage account to link to the Log Analytics Workspace')
param storageAccountId string

@description('Tags to apply to the Log Analytics Workspace')
param tags object

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
