$newAzApplicationSecurityGroupSplat = @{
    ResourceGroupName = "MyResourceGroup"
    Name = "MyApplicationSecurityGroup"
    Location = "West US"
    Tag = '' 
}

New-AzApplicationSecurityGroup @newAzApplicationSecurityGroupSplat