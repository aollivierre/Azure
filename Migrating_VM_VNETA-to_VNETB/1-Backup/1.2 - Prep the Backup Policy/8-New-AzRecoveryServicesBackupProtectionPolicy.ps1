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

    A backup protection policy is associated with at least one retention policy. A retention policy defines how long a recovery point is kept before it's deleted.

Use Get-AzRecoveryServicesBackupRetentionPolicyObject to view the default retention policy.
Similarly you can use Get-AzRecoveryServicesBackupSchedulePolicyObject to obtain the default schedule policy.
The New-AzRecoveryServicesBackupProtectionPolicy cmdlet creates a PowerShell object that holds backup policy information.
The schedule and retention policy objects are used as inputs to the New-AzRecoveryServicesBackupProtectionPolicy cmdlet.
#>


$RetPol = Get-AzRecoveryServicesBackupRetentionPolicyObject -WorkloadType 'AzureVM'
$RetPol.DailySchedule.DurationCountInDays = '365'
$SchPol = Get-AzRecoveryServicesBackupSchedulePolicyObject -WorkloadType 'AzureVM'

$newAzRecoveryServicesBackupProtectionPolicySplat = @{
    Name = "NewPolicy"
    WorkloadType = 'AzureVM'
    RetentionPolicy = $RetPol
    SchedulePolicy = $SchPol
    VaultId = $targetVault.ID
}

New-AzRecoveryServicesBackupProtectionPolicy @newAzRecoveryServicesBackupProtectionPolicySplat