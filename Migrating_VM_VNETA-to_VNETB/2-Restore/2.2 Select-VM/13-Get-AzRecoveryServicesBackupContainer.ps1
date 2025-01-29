<#
.SYNOPSIS
    Short description
.DESCRIPTION
    Long description
.EXAMPLE
    PS C:\> <example usage>
    Explanation of what the example does
.INPUTS
    Inputs (if any)
.OUTPUTS
    Output (if any)
    FriendlyName                             ResourceGroupName                        Status               ContainerType       
------------                             -----------------                        ------               -------------
Outlook1                                 canprintequip_outlook_rg                 Registered           AzureVM
.NOTES
    General notes


#>


# $LocationName = 'CanadaCentral'
$CustomerName = 'CanPrintEquip'
$VMName = 'Outlook1'
$ResourceGroupName = -join ("$CustomerName", "_Outlook", "_RG")
# $ResourceGroupName = 'CanPrintEquip_Outlook_RG'
$Vaultname = -join ("$VMName", "ARSV1")

$getAzRecoveryServicesVaultSplat = @{
    ResourceGroupName = $ResourceGroupName
    Name = $Vaultname
}

$targetVault = Get-AzRecoveryServicesVault @getAzRecoveryServicesVaultSplat
# $targetVault.ID


$getAzRecoveryServicesBackupContainerSplat = @{
    ContainerType = "AzureVM"
    Status = "Registered"
    FriendlyName = $VMName
    VaultId = $targetVault.ID
}

$namedContainer = Get-AzRecoveryServicesBackupContainer  @getAzRecoveryServicesBackupContainerSplat
$namedContainer