param name string
param privateIp string
param region string
param tags object
param nicProps object
param subnetId string

resource nic 'Microsoft.Network/networkInterfaces@2023-11-01' = {
  name: name
  location: region
  tags: tags
  properties: {
    ipConfigurations: [
      {
        name: nicProps.ipConfigName
        properties: {
          privateIPAllocationMethod: nicProps.allocMethod
          privateIPAddress: privateIp
          subnet: {
            id: subnetId
          }
        }
      }
    ]
  }
}
