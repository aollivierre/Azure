function Invoke-AzPublicIpAddress {
 #Region func New-AzPublicIpAddress
#Creating the PublicIP for the VM
$newAzPublicIpAddressSplat = @{
    Name              = $PublicIPAddressName
    DomainNameLabel   = $DNSNameLabel
    ResourceGroupName = $ResourceGroupName
    Location          = $LocationName
    # AllocationMethod  = 'Dynamic'
    AllocationMethod  = 'Static'
    # IpTag             = $ipTag
    Tag               = $Tags
}
$PIP = New-AzPublicIpAddress @newAzPublicIpAddressSplat
#endRegion func New-AzPublicIpAddress
    
}

