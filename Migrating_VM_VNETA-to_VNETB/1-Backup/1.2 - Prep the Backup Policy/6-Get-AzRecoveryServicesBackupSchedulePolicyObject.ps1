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

ScheduleRunFrequency ScheduleRunDays ScheduleRunTimes       
-------------------- --------------- ----------------       
               Daily {Sunday}        {2020-12-12 5:00:00 PM}
.NOTES
    General notes

The Get-AzRecoveryServicesBackupSchedulePolicyObject cmdlet gets a base AzureRMRecoveryServicesSchedulePolicyObject. This object is not persisted in the system. It is temporary object that you can manipulate and use with the New-AzRecoveryServicesBackupProtectionPolicy cmdlet to create a new backup protection policy.
    
#>

$getAzRecoveryServicesBackupSchedulePolicyObjectSplat = @{
    WorkloadType = "AzureVM"
}

Get-AzRecoveryServicesBackupSchedulePolicyObject @getAzRecoveryServicesBackupSchedulePolicyObjectSplat