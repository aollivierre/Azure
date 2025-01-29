function Invoke-AzVMConfig {
 
    #Region func New-AzVMConfig
    #Creating the VM Config Object for the VM
    $newAzVMConfigSplat = @{
        VMName       = $VMName
        VMSize       = $VMSize
        Tags         = $Tags
        IdentityType = 'SystemAssigned'
    }
    $VirtualMachine = New-AzVMConfig @newAzVMConfigSplat
    #endRegion func New-AzVMConfig
}