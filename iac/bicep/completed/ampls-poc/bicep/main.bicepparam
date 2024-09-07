using './main.bicep'

param hubRgp = 'ampls-hub-rgp'
param spokeRgp = 'ampls-spk-rgp'
param location = 'eastus2'
param hubNetwork = {
	vnetName: 'ampls-hub-vnt'
	vnetAddressPrefix: '10.100.0.0/22'
	subnetAddressPrefixAseV3: '10.100.0.0/24'
	subnetAddressPrefixServers: '10.100.1.0/29'
	subnetName: {
		ase: 'hub-snt-ase'
		srv: 'hub-snt-servers'
	}
	nsgName: 'hub-snt-nsg'
	dnsServer: '168.63.129.16'
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