function Invoke-AzVMOperatingSystem {

    #Region func Set-AzVMOperatingSystem
    #Creating the OS Object for the VM
    $setAzVMOperatingSystemSplat = @{
        VM               = $VirtualMachine
        Windows          = $true
        # Linux        = $true
        ComputerName     = $ComputerName
        Credential       = $Credential
        ProvisionVMAgent = $true
        # EnableAutoUpdate = $true
    
    }
    $VirtualMachine = Set-AzVMOperatingSystem @setAzVMOperatingSystemSplat
    #endRegion func Set-AzVMOperatingSystem 

    
}
