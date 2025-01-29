function Invoke-AzApplicationSecurityGroup {
    #Region func New-AzApplicationSecurityGroup
    #Creating the Application Security Group
    $ASGName = -join ("$VMName", "_ASG1")
    $newAzApplicationSecurityGroupSplat = @{
        ResourceGroupName = "$ResourceGroupName"
        Name              = "$ASGName"
        Location          = "$LocationName"
        Tag               = $Tags
    }
    $ASG = New-AzApplicationSecurityGroup @newAzApplicationSecurityGroupSplat
    #endRegion func New-AzApplicationSecurityGroup
    
}