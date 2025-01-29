$DomainName = "Canadacomputing.ca"
$VMName = "TrueSky1"
# $credential = Get-Credential
$ResourceGroupName = "CCI_TrueSky1_RG"

$setAzVMADDomainExtensionSplat = @{
    DomainName = $DomainName
    # Credential = $credential
    ResourceGroupName = $ResourceGroupName
    VMName = $VMName
    # OUPath = $OU
    JoinOption = 0x00000003
    Restart = $true
    Verbose = $true
}

Set-AzVMADDomainExtension @setAzVMADDomainExtensionSplat

 
$setAzVMADDomainExtensionSplat = @{
    DomainName = $DomainName
    VMName = $VMName
    Credential = $credential
    ResourceGroupName = $ResourceGroupName
    JoinOption = 0x00000001
    Restart = $true
    Verbose = $true
}

Set-AzVMADDomainExtension @setAzVMADDomainExtensionSplat



$setAzVMADDomainExtensionSplat = @{

    # publisher = "Microsoft.Azure.ActiveDirectory"
    # type = "AADLoginForWindows"
    typeHandlerVersion = "0.3"
    # autoUpgradeMinorVersion = $true
}

Set-AzVMADDomainExtension @setAzVMADDomainExtensionSplat



$setAzVMADDomainExtensionSplat = @{
    DomainName = $domainToJoin
    Credential = $WvdDJCredUPN
    ResourceGroupName = $ResourceGroup
    VMName = $vmName
    # OUPath = $OU
    JoinOption = 0x00000003
    Restart = $true
    Verbose = $true
}

Set-AzVMADDomainExtension @setAzVMADDomainExtensionSplat








# $DomainName = "Canadacomputing.ca"

# $credential = Get-Credential


# az vm extension set \
#     --publisher Microsoft.Azure.ActiveDirectory \
#     --name AADLoginForWindows \
#     --resource-group $ResourceGroupName \
#     --vm-name $VMName


#     $AzCLISplat = @{
#         publisher = 'Microsoft.Azure.ActiveDirectory'
#         name = 'AADLoginForWindows'
#         # resource-group = $ResourceGroupName
#         g = $ResourceGroupName
#         vm-name = $VMName
#         # n = $VMName
#     }
    
#     az vm extension set @AzCLISplat

#     Az


#     Az Login

# $VMName = "TrueSky1"
# $ResourceGroupName = "CCI_TrueSky1_RG"
#     $options_1 = @(
#         'vm extension set'
#         '--publisher Microsoft.Azure.ActiveDirectory'
#         '--name AADLoginForWindows'
#         "--resource-group $ResourceGroupName"
#         "--vm-name $VMName"
#     )

#     $cmdArgs_1 = @(
#         $options_1
#     )


#     & Az @cmdArgs_1




# $VMName = "TrueSky1"
# $ResourceGroupName = "CCI_TrueSky1_RG"
# az vm extension set --publisher Microsoft.Azure.ActiveDirectory --name AADLoginForWindows --resource-group $ResourceGroupName --vm-name $VMName


# $SettingsString = "{ ""AntimalwareEnabled"": true }"