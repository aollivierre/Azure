function Invoke-AzVMNetworkInterface {

    #Region func Add-AzVMNetworkInterface
    #Adding the NIC to the VM
    $addAzVMNetworkInterfaceSplat = @{
        VM = $VirtualMachine
        Id = $NIC.Id
    }
    $VirtualMachine = Add-AzVMNetworkInterface @addAzVMNetworkInterfaceSplat
    #endRegion func Add-AzVMNetworkInterface
    
}