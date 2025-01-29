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

    Name                                     ContainerType        ContainerUniqueName                      WorkloadType         ProtectionStatus    
----                                     -------------        -------------------                      ------------         ----------------    
VM;iaasvmcontainerv2;canprintequip_ou... AzureVM              iaasvmcontainerv2;canprintequip_outlo... AzureVM              Healthy
 
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

$getAzRecoveryServicesBackupItemSplat = @{
    Container = $namedContainer
    WorkloadType = "AzureVM"
    VaultId = $targetVault.ID
}

$backupitem = Get-AzRecoveryServicesBackupItem @getAzRecoveryServicesBackupItemSplat
$backupitem