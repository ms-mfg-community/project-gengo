
param nsgName string
param region string 
param tags object

resource hubNsg 'Microsoft.Network/networkSecurityGroups@2023-11-01' = {
  name: nsgName
  location: region
  tags: tags
  properties: {
    flushConnection: true
  }
}