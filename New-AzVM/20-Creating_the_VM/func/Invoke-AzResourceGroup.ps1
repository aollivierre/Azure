function Invoke-AzResourceGroup {
    #Region func New-AzResourceGroup
    #Creating the Resource Group Name
    $newAzResourceGroupSplat = @{
        Name     = $ResourceGroupName
        Location = $LocationName
        Tag      = $Tags
    }


    New-AzResourceGroup @newAzResourceGroupSplat
    #endregion func New-AzResourceGroup
    
}
