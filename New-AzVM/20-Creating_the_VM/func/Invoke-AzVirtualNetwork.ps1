function Invoke-AzVirtualNetwork {
#Region func New-AzVirtualNetwork
#Creating the VNET for the VM
$newAzVirtualNetworkSplat = @{
    Name              = $NetworkName
    ResourceGroupName = $ResourceGroupName
    Location          = $LocationName
    AddressPrefix     = $VnetAddressPrefix
    Subnet            = $SingleSubnet
    Tag               = $Tags
}
$Vnet = New-AzVirtualNetwork @newAzVirtualNetworkSplat
#endRegion func New-AzVirtualNetwork
    
}