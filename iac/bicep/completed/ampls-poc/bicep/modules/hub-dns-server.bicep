resource virtualMachine1 'Microsoft.Compute/virtualMachines@2023-11-01' = {
  name: vms[0].vmName
  location: primaryLocation
  properties: {
    availabilitySet: {
      id: availabilitySet.id // A race condition occurs with looping for this id property and throws an error. See bug 1316
    }
    hardwareProfile: {
      vmSize: vms[0].vmSize
    }
    osProfile: {
      adminUsername: userName // use parameter value
      adminPassword: pw // use parameter value
      computerName: vms[0].vmName
      windowsConfiguration: {
        provisionVMAgent: vms[0].windowsConfig.provisionVMAgent
        enableAutomaticUpdates: vms[0].windowsConfig.enableAutoUpgrades
      }
    }
    storageProfile: {
      osDisk: {
        name: vms[0].diskOs.osDiskName
        caching: vms[0].diskOs.caching
        createOption: vms[0].diskOs.createOption
        diskSizeGB: vms[0].diskOs.diskSizeGB
        managedDisk: {
          storageAccountType: vms[0].diskOs.diskType
        }
      }
      imageReference: {
        publisher: vms[0].image.publisher
        offer: vms[0].image.offer
        sku: vms[0].image.sku
        version: vms[0].image.version
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: interfacesAdSub1.id
          properties: {
            primary: true
            deleteOption: 'Delete'
          }
        }
      ]
    }
  }
}