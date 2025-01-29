function Invoke-AzVirtualNetworkSubnetConfig  {
#Region func New-AzVirtualNetworkSubnetConfig 
#Creating the Subnet for the VM
$newAzVirtualNetworkSubnetConfigSplat = @{
    Name          = $SubnetName
    AddressPrefix = $SubnetAddressPrefix
}
$SingleSubnet = New-AzVirtualNetworkSubnetConfig @newAzVirtualNetworkSubnetConfigSplat
#endRegion func New-AzVirtualNetworkSubnetConfig
    
}

