param region string
param tags object 
param pubIpName string
param pubAlloc string
param sku string

resource pubIp 'Microsoft.Network/publicIPAddresses@2020-11-01' = {
  name: pubIpName
  location: region
  tags: tags
  sku: {
	  name: sku
  }
  properties: {
	publicIPAllocationMethod: pubAlloc
  }
}

output pubIpId string = pubIp.id
