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

    
VmVersion            : Compute
IsCancellable        : False
IsRetriable          : False
ErrorDetails         :
ActivityId           : 143fe923-d37f-4c59-ac7f-8d0882cfabc8
JobId                : 064ee552-fb05-4d1c-a2c3-80051f40b533
Operation            : Restore
Status               : Completed
WorkloadName         : outlook1
StartTime            : 2020-12-13 1:17:35 AM
EndTime              : 2020-12-13 1:20:41 AM
Duration             : 00:03:06.3374736
BackupManagementType : AzureVM





DynamicErrorMessage  :
Properties           : {[Job Type, Recover disks], [Target Storage Account Name, outlook1restoredsa], [Recovery point time , 12/12/2020   
                       11:18:41 PM], [Config Blob Name, config-outlook1-064ee552-fb05-4d1c-a2c3-80051f40b533.json]...}
SubTasks             : {Transfer data from vault}
VmVersion            : Compute
IsCancellable        : False
IsRetriable          : False
ErrorDetails         :
ActivityId           : 143fe923-d37f-4c59-ac7f-8d0882cfabc8
JobId                : 064ee552-fb05-4d1c-a2c3-80051f40b533
Operation            : Restore
Status               : Completed
WorkloadName         : outlook1
StartTime            : 2020-12-13 1:17:35 AM
EndTime              : 2020-12-13 1:20:41 AM
Duration             : 00:03:06.3374736
BackupManagementType : AzureVM
.NOTES
    General notes
#>

$getAzRecoveryServicesBackupJobSplat = @{
    # Job = $restorejob
    # JobId = '064ee552-fb05-4d1c-a2c3-80051f40b533'
    VaultId = $targetVault.ID
    Status = 'Completed'
    From = (Get-Date).AddDays(-30).ToUniversalTime()
}
$restorejob = Get-AzRecoveryServicesBackupJob @getAzRecoveryServicesBackupJobSplat | Where-Object {$_.JobId -eq '064ee552-fb05-4d1c-a2c3-80051f40b533'}
# $restorejob | Format-List
# $restorejob | Format-Table

$getAzRecoveryServicesBackupJobDetailsSplat = @{
    Job = $restorejob
    VaultId = $targetVault.ID
}
$details = Get-AzRecoveryServicesBackupJobDetail @getAzRecoveryServicesBackupJobDetailsSplat
$details | Format-List