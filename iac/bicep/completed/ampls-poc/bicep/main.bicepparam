using './main.bicep'

param resourceGroups = ['ampls-hub-rgp', 'ampls-spk-rgp']
param location = 'eastus2'
param hubNetwork = {
	vnetName: 'ampls-hub-vnt'
	vnetAddressPrefix: '10.176.128.0/22'
	subnetAddressPrefixAseV3: '10.176.131.0/24'
	subnetAddressPrefixServers: '10.176.130.0/29'
	subnetName: {
		ase: 'hub-snt-ase'
		srv: 'hub-snt-servers'
	}
	dnsServer: '10.176.130.4'
}

param spokeNetwork = {
	vnetName: 'ampls-spk-vnt'
	vnetAddressPrefix: '172.16.1.0/24'
	subnetAddressPrefixSpk: '172.16.1.0/29'
	subnetAddressPrefixBastion: '172.16.1.32/27'
	subnetName: {
		spk: 'spk-snt'
		bas: 'AzureBastionSubnet'
	}
}

param hubNsgName = 'hub-snt-nsg'
param spkNsgName = 'spk-snt-nsg'

param tagDefaults = {
	project: 'project-gengo'
	workstream: 'ampls'
}