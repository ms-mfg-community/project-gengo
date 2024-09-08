
param region string 
param nsgName string
param tags object

resource hubNsg 'Microsoft.Network/networkSecurityGroups@2023-11-01' = {
  name: nsgName
  location: location
  tags: tags
  properties: {
    flushConnection: true
  }
}