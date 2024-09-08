
param nsgName string
param region string
param tags object

resource spkNsg 'Microsoft.Network/networkSecurityGroups@2023-11-01' = {
  name: spkNsgName
  location: location
  tags: tags
  properties: {
    flushConnection: true
  }
}