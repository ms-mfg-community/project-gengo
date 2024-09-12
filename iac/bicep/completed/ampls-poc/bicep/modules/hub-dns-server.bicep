param region string 
param tags object
param dnsVmProps object
param dnsNicId string
param dnsVmPw string
 

resource vmDns 'Microsoft.Compute/virtualMachines@2024-07-01' = {
  name: dnsVmProps.vmName
  location: region
  tags: tags
  properties: {
    hardwareProfile: {
      vmSize: dnsVmProps.vmSize
    }
    osProfile: {
      adminUsername: dnsVmProps.osProfile.userName // use parameter value
      adminPassword: dnsVmPw // use parameter value
      computerName: dnsVmProps.vmName
      windowsConfiguration: {
        provisionVMAgent: dnsVmProps.windowsConfig.provisionVMAgent
        enableAutomaticUpdates: dnsVmProps.windowsConfig.enableAutoUpgrades
      }
    }
    storageProfile: {
      osDisk: {
        name: dnsVmProps.diskOs.osDiskName
        caching: dnsVmProps.diskOs.caching
        createOption: dnsVmProps.diskOs.createOption
        diskSizeGB: dnsVmProps.diskOs.diskSizeGB
        managedDisk: {
          storageAccountType: dnsVmProps.diskOs.diskType
        }
      }
      imageReference: {
        publisher: dnsVmProps.image.publisher
        offer: dnsVmProps.image.offer
        sku: dnsVmProps.image.sku
        version: dnsVmProps.image.version
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: dnsNicId
          properties: {
            primary: true
            deleteOption: 'Delete'
          }
        }
      ]
    }
  }
}