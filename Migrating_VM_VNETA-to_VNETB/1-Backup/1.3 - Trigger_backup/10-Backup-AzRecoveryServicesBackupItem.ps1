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

    WorkloadName     Operation            Status               StartTime                 EndTime                   JobID
------------     ---------            ------               ---------                 -------                   -----
outlook1         Backup               InProgress           2020-12-12 11:18:36 PM                              81511a3c-ff52-4677-b6d0-33943a3...
.NOTES
    General notes


    Trigger a backup
Use Backup-AzRecoveryServicesBackupItem to trigger a backup job. If it's the initial backup, it is a full backup. Subsequent backups take an incremental copy. The following example takes a VM backup to be retained for 60 days.
#>


# $LocationName = 'CanadaCentral'
$CustomerName = 'CanPrintEquip'
$VMName = 'Outlook1'
$ResourceGroupName = -join ("$CustomerName", "_Outlook", "_RG")
# $ResourceGroupName = 'CanPrintEquip_Outlook_RG'
$Vaultname = -join ("$VMName", "ARSV1")

$targetVault = Get-AzRecoveryServicesVault -ResourceGroupName $ResourceGroupName -Name $Vaultname
# $targetVault.ID

$getAzRecoveryServicesBackupContainerSplat = @{
    ContainerType = "AzureVM"
    Status = "Registered"
    FriendlyName = $VMName
    VaultId = $targetVault.ID
}
$namedContainer = Get-AzRecoveryServicesBackupContainer @getAzRecoveryServicesBackupContainerSplat

$getAzRecoveryServicesBackupItemSplat = @{
    Container = $namedContainer
    WorkloadType = "AzureVM"
    VaultId = $targetVault.ID
}
$item = Get-AzRecoveryServicesBackupItem @getAzRecoveryServicesBackupItemSplat

$endDate = (Get-Date).AddDays(60).ToUniversalTime()

$backupAzRecoveryServicesBackupItemSplat = @{
    Item = $item
    VaultId = $targetVault.ID
    ExpiryDateTimeUTC = $endDate
}

$job = Backup-AzRecoveryServicesBackupItem @backupAzRecoveryServicesBackupItemSplat



