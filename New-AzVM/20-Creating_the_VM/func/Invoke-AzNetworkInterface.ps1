function Invoke-AzNetworkInterface {



    #Region func New-AzNetworkInterface
    #Creating the NIC for the VM
    $newAzNetworkInterfaceSplat = @{
        Name                   = $NICName
        ResourceGroupName      = $ResourceGroupName
        Location               = $LocationName
        # SubnetId                 = $Vnet.Subnets[0].Id
        # PublicIpAddressId        = $PIP.Id
        NetworkSecurityGroupId = $NSG.Id
        # ApplicationSecurityGroup = $ASG
        IpConfiguration        = $IPConfig1
        Tag                    = $Tags
    
    }
    $NIC = New-AzNetworkInterface @newAzNetworkInterfaceSplat
    #endRegion func New-AzNetworkInterface
    
}