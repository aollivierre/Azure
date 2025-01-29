function Invoke-AzVMExtension {
    
    #Region func Set-AzVMExtension 
#Post Deployment Configuration #1
$setAzVMExtensionSplat = @{
    ResourceGroupName = $ResourceGroupName
    Location = $LocationName
    VMName = $VMName
    Name = "AADLoginForWindows"
    Publisher = "Microsoft.Azure.ActiveDirectory"
    ExtensionType = "AADLoginForWindows"
    TypeHandlerVersion = "1.0"
    # SettingString = $SettingsString
}
Set-AzVMExtension @setAzVMExtensionSplat
#endRegion func Set-AzVMExtension 

    
}