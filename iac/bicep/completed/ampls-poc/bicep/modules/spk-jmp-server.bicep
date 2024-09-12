param region string 
param tags object
param jmpVmProps object
param jmpNicId string
@secure()
param jmpVmPw string
 

resource vmDns 'Microsoft.Compute/virtualMachines@2023-11-01' = {
  name: jmpVmProps.vmName
  location: region
  tags: tags
  properties: {
    hardwareProfile: {
      vmSize: jmpVmProps.vmSize
    }
    osProfile: {
      adminUsername: jmpVmProps.osProfile.userName // use parameter value
      adminPassword: jmpVmPw // use parameter value
      computerName: jmpVmProps.vmName
      windowsConfiguration: {
        provisionVMAgent: jmpVmProps.windowsConfig.provisionVMAgent
        enableAutomaticUpdates: jmpVmProps.windowsConfig.enableAutoUpgrades
      }
    }
    storageProfile: {
      osDisk: {
        name: jmpVmProps.diskOs.osDiskName
        caching: jmpVmProps.diskOs.caching
        createOption: jmpVmProps.diskOs.createOption
        diskSizeGB: jmpVmProps.diskOs.diskSizeGB
        managedDisk: {
          storageAccountType: jmpVmProps.diskOs.diskType
        }
      }
      imageReference: {
        publisher: jmpVmProps.image.publisher
        offer: jmpVmProps.image.offer
        sku: jmpVmProps.image.sku
        version: jmpVmProps.image.version
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: jmpNicId
          properties: {
            primary: true
            deleteOption: 'Delete'
          }
        }
      ]
    }
  }
}