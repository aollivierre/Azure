function Invoke-AzNetworkInterfaceIpConfig {
 

    #Region func New-AzNetworkInterfaceIpConfig
$newAzNetworkInterfaceIpConfigSplat = @{
    Name                     = $IPConfigName
    Subnet                   = $Subnet
    # Subnet                   = $Vnet.Subnets[0].Id
    # PublicIpAddress          = $PIP.ID
    PublicIpAddress          = $PIP
    ApplicationSecurityGroup = $ASG
    Primary                  = $true
}

$IPConfig1 = New-AzNetworkInterfaceIpConfig @newAzNetworkInterfaceIpConfigSplat
#endRegion func New-AzNetworkInterfaceIpConfig
    
}