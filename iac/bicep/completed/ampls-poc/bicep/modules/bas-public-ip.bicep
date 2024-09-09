param region string
param tags object 
param pubIpName string
param pubAlloc string

resource pubIp 'Microsoft.Network/publicIPAddresses@2020-11-01' = {
  name: pubIpName
  location: region
  tags: tags
  properties: {
	publicIPAllocationMethod: pubAlloc
  }
}

output pubIpId string = pubIp.id
