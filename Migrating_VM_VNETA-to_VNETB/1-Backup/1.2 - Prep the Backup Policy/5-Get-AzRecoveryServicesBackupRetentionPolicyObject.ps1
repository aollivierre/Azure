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

    IsDailyScheduleEnabled   : True
IsWeeklyScheduleEnabled  : True
IsMonthlyScheduleEnabled : True
IsYearlyScheduleEnabled  : True
DailySchedule            : DurationCountInDays: 180, RetentionTimes: {2020-12-12 8:30:00 PM}
WeeklySchedule           : DurationCountInWeeks: 104, DaysOfTheWeek: {Sunday}, RetentionTimes: {2020-12-12 8:30:00 PM}
MonthlySchedule          : DurationCountInMonths:60, RetentionScheduleType:Weekly, RetentionTimes: {2020-12-12 8:30:00 PM},
                           RetentionScheduleDaily:DaysOfTheMonth:{Date:1, IsLast:False},RetentionScheduleWeekly:DaysOfTheWeek:{Sunday},      
                           WeeksOfTheMonth:{First}, RetentionTimes: {2020-12-12 8:30:00 PM}
YearlySchedule           : DurationCountInYears:10, RetentionScheduleType:Weekly, RetentionTimes: {2020-12-12 8:30:00 PM},
                           RetentionScheduleDaily:DaysOfTheMonth:{Date:1, IsLast:False},RetentionScheduleWeekly:DaysOfTheWeek:{Sunday},      
                           WeeksOfTheMonth:{First}, MonthsOfYear: {January}, RetentionTimes: {2020-12-12 8:30:00 PM}
BackupManagementType     :

.NOTES
    General notes


    # A backup protection policy is associated with at least one retention policy. A retention policy defines how long a recovery point is kept before it's deleted.

# Use Get-AzRecoveryServicesBackupRetentionPolicyObject to view the default retention policy.
# Similarly you can use Get-AzRecoveryServicesBackupSchedulePolicyObject to obtain the default schedule policy.
#>

$getAzRecoveryServicesBackupRetentionPolicyObjectSplat = @{
    WorkloadType = 'AzureVM'
}

Get-AzRecoveryServicesBackupRetentionPolicyObject @getAzRecoveryServicesBackupRetentionPolicyObjectSplat