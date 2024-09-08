
param region string 

resource spkNsg 'Microsoft.Network/networkSecurityGroups@2023-11-01' = {
  name: spkNsgName
  location: location
  tags: {
    project: 'project-gengo'
    workstream: 'ampls'
  }
  properties: {
    flushConnection: true
  }
}