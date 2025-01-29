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

    # Use the Restore-AzRecoveryServicesBackupItem cmdlet to restore a backup item's data and configuration to a recovery point. Once you identify a recovery point, use it as the value for the -RecoveryPoint parameter. In the sample above, $rp[0] was the recovery point to use. In the following sample code, $rp[0] is the recovery point to use for restoring the disk.

    Restores the data and configuration for a Backup item to the specified recovery point. The required parameters vary with the backup item type. The same command is used to restore Azure Virtual machines, databases running within Azure Virtual machines and Azure file shares as well.

# To restore the disks and configuration information:
#>

# $StorageAccountName = ''
# $StorageAccountResourceGroupName = ''

# $restoreAzRecoveryServicesBackupItemSplat = @{
#     RecoveryPoint = $rp[0]
#     StorageAccountName = "DestAccount"
#     StorageAccountResourceGroupName = "DestRG"
#     VaultId = $targetVault.ID
# }

# $restorejob = Restore-AzRecoveryServicesBackupItem @restoreAzRecoveryServicesBackupItemSplat
# $restorejob

# It's strongly recommended to use the TargetResourceGroupName parameter for restoring managed disks since it results in significant performance improvements. If this parameter isn't given, then you can't benefit from the instant restore functionality and the restore operation will be slower in comparison. If the purpose is to restore managed disks as unmanaged disks, then don't provide this parameter and make the intention clear by providing the -RestoreAsUnmanagedDisks parameter. The -RestoreAsUnmanagedDisks parameter is available from Azure PowerShell 3.7.0 onwards. In future versions, it will be mandatory to provide either of these parameters for the right restore experience.

$StorageAccountName = "outlook1restoredsa"
$StorageAccountResourceGroupName = "CanPrintEquip_Outlook1Restored_RG"
$TargetResourceGroupName = "CanPrintEquip_Outlook1Restored_RG"


$restoreAzRecoveryServicesBackupItemSplat = @{
    RecoveryPoint = $rp[0]
    StorageAccountName = $StorageAccountName
    StorageAccountResourceGroupName = $StorageAccountResourceGroupName
    TargetResourceGroupName = $TargetResourceGroupName
    VaultId = $targetVault.ID
    VaultLocation = $targetVault.Location
}

$restorejob = Restore-AzRecoveryServicesBackupItem @restoreAzRecoveryServicesBackupItemSplat
$restorejob


    # WorkloadName    Operation       Status          StartTime              EndTime
    # ------------    ---------       ------          ---------              -------
    # V2VM            Restore         InProgress      26-Apr-16 1:14:01 PM   01-Jan-01 12:00:00 AM