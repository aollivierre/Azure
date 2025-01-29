function Invoke-GetAzVirtualNetworkSubnetConfig {

    #Region func Get-AzVirtualNetworkSubnetConfig
    #Creating the IP config for the NIC
    # $vnet = Get-AzVirtualNetwork -Name myvnet -ResourceGroupName myrg
    $getAzVirtualNetworkSubnetConfigSplat = @{
        Name           = $SubnetName
        VirtualNetwork = $vnet
    }

    $Subnet = Get-AzVirtualNetworkSubnetConfig @getAzVirtualNetworkSubnetConfigSplat
    # $PIP1 = Get-AzPublicIPAddress -Name "PIP1" -ResourceGroupName "RG1"
    Get-AzVirtualNetworkSubnetConfig
    #endRegion func Get-AzVirtualNetworkSubnetConfig
    
}