function Invoke-AzNetworkSecurityGroup {


#Region func New-AzNetworkSecurityGroup
#Create a new NSG based on Rules #1 & #2
$newAzNetworkSecurityGroupSplat = @{
    ResourceGroupName = $ResourceGroupName
    Location          = $LocationName
    Name              = $NSGName
    # SecurityRules     = $rule1, $rule2
    SecurityRules     = $rule1
    Tag               = $Tags
}
$NSG = New-AzNetworkSecurityGroup @newAzNetworkSecurityGroupSplat
#endRegion func New-AzNetworkSecurityGroup

    
}