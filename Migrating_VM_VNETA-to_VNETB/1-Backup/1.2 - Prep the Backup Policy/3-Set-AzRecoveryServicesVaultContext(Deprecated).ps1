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
.NOTES
    General notes

    Description
The Set-AzRecoveryServicesVaultContext cmdlet sets the vault context for Azure Site Recovery services.

Warning: This cmdlet is being deprecated in a future breaking change release. There will be no replacement for it. Please use the -VaultId parameter in all Recovery Services commands going forward.

    Use a Recovery Services vault to protect your virtual machines. Before you apply the protection, set the vault context (the type of data protected in the vault), and verify the protection policy. The protection policy is the schedule when the backup jobs run, and how long each backup snapshot is retained.

Set vault context
Before enabling protection on a VM, use Set-AzRecoveryServicesVaultContext to set the vault context. Once the vault context is set, it applies to all subsequent cmdlets. The following example sets the vault context for the vault, testvault.
#>


$CustomerName = 'CanPrintEquip'
$VMName = 'Outlook1'
$ResourceGroupName = -join ("$CustomerName", "_Outlook", "_RG")
# $ResourceGroupName = 'CanPrintEquip_Outlook_RG'
$Vaultname = -join ("$VMName", "ARSV1")

$getAzRecoveryServicesVaultSplat = @{
    ResourceGroupName = $ResourceGroupName
    Name = $Vaultname
}

Get-AzRecoveryServicesVault @getAzRecoveryServicesVaultSplat | Set-AzRecoveryServicesVaultContext