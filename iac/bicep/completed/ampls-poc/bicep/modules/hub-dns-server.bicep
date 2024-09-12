param region string 
param tags object
param dnsVmProps object
param dnsNicId string
@secure()
param dnsVmPw string
 

resource virtualMachine1 'Microsoft.Compute/virtualMachines@2023-11-01' = {
  name: dnsVmProps.vmName
  location: region
  properties: {
    hardwareProfile: {
      vmSize: dnsVmProps.vmSize
    }
    osProfile: {
      adminUsername: dnsVmProps.osProfile.userName // use parameter value
      adminPassword: dnsVmProps.pw // use parameter value
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