using './main.bicep'

param hubRgp = 'ampls-hub-rgp'
param spokeRgp = 'ampls-spk-rgp'
param location = 'eastus2'
param hubNetwork = {
	vnetName: 'ampls-hub-vnt'
	vnetAddressPrefix: '10.176.130.0/22'
	subnetAddressPrefixAseV3: '10.176.131.0/24'
	subnetAddressPrefixServers: '10.176.130.0/29'
	subnetName: {
		ase: 'hub-snt-ase'
		srv: 'hub-snt-servers'
	}
	nsgName: 'hub-snt-nsg'
	dnsServer: '10.176.130.4'
}

param spokeNetwork = {
	vnetName: 'ampls-spk-vnt'
	vnetAddressPrefix: '172.16.1.0/24'
	subnetAddressPrefixSpk: '172.16.1.0/29'
	nsgName: 'spk-snt-nsg'
	subnetAddressPrefixBastion: '172.16.1.8/27'
	subnetName: {
		spk: 'spk-snt'
		bas: 'AzureBastionSubnet'
	}
}