function Invoke-AzVMSourceImage {
    #Region func Set-AzVMSourceImage 
    $setAzVMSourceImageSplat = @{
        VM            = $VirtualMachine
        # PublisherName = "Canonical"
        # Offer         = "0001-com-ubuntu-server-focal"
        # Skus          = "20_04-lts-gen2"
        # Version       = "latest"
        publisherName = "MicrosoftWindowsDesktop"
        offer         = "office-365"
        Skus          = "20h2-evd-o365pp"
        version       = "latest"


        # publisherName = "MicrosoftWindowsServer"
        # offer         = "WindowsServer"
        # Skus          = "2019-datacenter-gensecond"
        # version       = "latest"



        # Caching = 'ReadWrite'
    }


    $VirtualMachine = Set-AzVMSourceImage @setAzVMSourceImageSplat
    #endRegion func Set-AzVMSourceImage
    
}