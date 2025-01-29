function Invoke-AzVM {
    
    

    #Region func New-AzVM
    #Creating the VM
    $newAzVMSplat = @{
        ResourceGroupName = $ResourceGroupName
        Location          = $LocationName
        VM                = $VirtualMachine
        Verbose           = $true
        Tag               = $Tags
    }
    New-AzVM @newAzVMSplat
    #endRegion func New-AzVM
    
}