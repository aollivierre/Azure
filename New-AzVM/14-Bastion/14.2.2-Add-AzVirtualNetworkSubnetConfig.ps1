# $newAzResourceGroupSplat = @{
    # Name = 'TestResourceGroup'
    # Location = 'centralus'
# }

# New-AzResourceGroup @newAzResourceGroupSplat

    # $newAzVirtualNetworkSubnetConfigSplat = @{
        # Name = 'frontendSubnet'
        # AddressPrefix = "10.0.1.0/24"
    # }

    # $frontendSubnet = New-AzVirtualNetworkSubnetConfig @newAzVirtualNetworkSubnetConfigSplat
    # $newAzVirtualNetworkSplat = @{
    #     Name = 'MyVirtualNetwork'
    #     ResourceGroupName = 'TestResourceGroup'
    #     Location = 'centralus'
    #     AddressPrefix = "10.0.0.0/16"
    #     Subnet = $frontendSubnet
    # }

    # $Vnet = New-AzVirtualNetwork @newAzVirtualNetworkSplat

    $getAzVirtualNetworkSplat = @{
        Name = 'ProductionVNET'
    }
    
    $vnet = Get-AzVirtualNetwork @getAzVirtualNetworkSplat

    $addAzVirtualNetworkSubnetConfigSplat = @{
        Name = 'AzureBastionSubnet'
        VirtualNetwork = $vnet
        AddressPrefix = "10.0.2.0/24"
    }

    Add-AzVirtualNetworkSubnetConfig @addAzVirtualNetworkSubnetConfigSplat
    $vnet | Set-AzVirtualNetwork