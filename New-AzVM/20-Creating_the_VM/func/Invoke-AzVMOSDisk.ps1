function FunctionName {
    #Region func Set-AzVMOSDisk
    #Setting the VM OS Disk to the VM
    $setAzVMOSDiskSplat = @{
        VM           = $VirtualMachine
        Name         = $OSDiskName
        # VhdUri = $OSDiskUri
        # SourceImageUri = $SourceImageUri
        Caching      = $OSDiskCaching
        CreateOption = $OSCreateOption
        # Windows = $true
        DiskSizeInGB = '128'
    }
    $VirtualMachine = Set-AzVMOSDisk @setAzVMOSDiskSplat
    #endRegion func Set-AzVMOSDisk

    
}

