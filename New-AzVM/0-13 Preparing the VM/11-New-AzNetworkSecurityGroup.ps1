#Define Rule #1
$newAzNetworkSecurityRuleConfigSplat = @{
    Name = 'rdp-rule'
    Description = "Allow RDP"
    Access = 'Allow'
    Protocol = 'Tcp'
    Direction = 'Inbound'
    Priority = 100
    SourceAddressPrefix = 'Internet'
    SourcePortRange = '*'
    DestinationAddressPrefix = '*'
    DestinationPortRange = 3389
}

$rule1 = New-AzNetworkSecurityRuleConfig @newAzNetworkSecurityRuleConfigSplat


#Define Rule #2
$newAzNetworkSecurityRuleConfigSplat = @{
    Name = 'web-rule'
    Description = "Allow HTTP"
    Access = 'Allow'
    Protocol = 'Tcp'
    Direction = 'Outbound'
    Priority = 101
    SourceAddressPrefix = 'Internet'
    SourcePortRange = '*'
    DestinationAddressPrefix = '*'
    DestinationPortRange = 80
}
$rule2 = New-AzNetworkSecurityRuleConfig @newAzNetworkSecurityRuleConfigSplat

#Create a new NSG based on Rules #1 & #2
$newAzNetworkSecurityGroupSplat = @{
    ResourceGroupName = 'InspireAV_UniFi_RG'
    Location = 'CanadaCentral'
    Name = "NSG-FrontEnd"
    SecurityRules = $rule1, $rule2
}

$nsg = New-AzNetworkSecurityGroup @newAzNetworkSecurityGroupSplat