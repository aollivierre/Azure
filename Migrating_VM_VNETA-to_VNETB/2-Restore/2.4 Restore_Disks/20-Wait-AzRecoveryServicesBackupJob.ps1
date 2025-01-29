$waitAzRecoveryServicesBackupJobSplat = @{
    Job = $restorejob
    Timeout = 43200
}

Wait-AzRecoveryServicesBackupJob @waitAzRecoveryServicesBackupJobSplat