

resource vnetPeerings 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2023-11-01' = {
  name: 'peerSpkWithHub'
  parent: vnt
  properties: {
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    useRemoteGateways: false
    remoteVirtualNetwork: {
      id: hubVnet.id
    }
  }
}