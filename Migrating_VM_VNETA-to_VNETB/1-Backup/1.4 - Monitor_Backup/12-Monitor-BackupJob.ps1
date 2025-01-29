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
outlook1         Backup               InProgress           2020-12-12 11:18:36 PM                              81511a3c-ff52-4677-b6d0-339


$AFTER AN HOUR A minute for 128 GiB Disk Premium SSD Managed
    
WorkloadName     Operation            Status               StartTime                 EndTime                   JobID
------------     ---------            ------               ---------                 -------                   -----
outlook1         Backup               Completed            2020-12-12 11:18:36 PM    2020-12-13 12:19:50 AM    81511a3c-ff52-4677-b6d0... 
.NOTES
    General notes

    Monitoring a backup job
You can monitor long-running operations, such as backup jobs, without using the Azure portal. To get the status of an in-progress job, use the Get-AzRecoveryservicesBackupJob cmdlet. This cmdlet gets the backup jobs for a specific vault, and that vault is specified in the vault context. The following example gets the status of an in-progress job as an array, and stores the status in the $joblist variable.

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

$getAzRecoveryservicesBackupJobSplat = @{
    # Status = "InProgress" #you may ommit this out if you want to see all statuses
    VaultId = $targetVault.ID
}

$joblist = Get-AzRecoveryservicesBackupJob @getAzRecoveryservicesBackupJobSplat
$joblist[0]


# $waitAzRecoveryServicesBackupJobSplat = @{
#     Job = $joblist[0]
#     Timeout = 43200
#     VaultId = $targetVault.ID
# }

# Wait-AzRecoveryServicesBackupJob @waitAzRecoveryServicesBackupJobSplat