# Get vault selection function from previous script
function Get-AzureBackupVaultDetails {
    try {
        Write-Host "Retrieving Recovery Services vaults..." -ForegroundColor Yellow
        $vaults = Get-AzRecoveryServicesVault
        
        $vaultDetails = @()
        $menuOptions = @{}
        $menuIndex = 0
        
        foreach ($vault in $vaults) {
            $vaultInfo = [PSCustomObject]@{
                Name             = $vault.Name
                ResourceGroup    = $vault.ResourceGroupName
                Location         = $vault.Location
                SubscriptionId   = (Get-AzContext).Subscription.Id
                SubscriptionName = (Get-AzContext).Subscription.Name
                VaultObject      = $vault
            }
            $vaultDetails += $vaultInfo
            $menuOptions[$menuIndex] = $vault
            $menuIndex++
        }

        return @{
            Details     = $vaultDetails
            MenuOptions = $menuOptions
        }
    }
    catch {
        Write-Error "Failed to retrieve vault details: $_"
        throw
    }
}

# Function to get backup jobs list
function Get-BackupJobsList {
    param (
        [Parameter(Mandatory = $true)]
        [Microsoft.Azure.Commands.RecoveryServices.ARSVault]$Vault,
        
        [Parameter(Mandatory = $false)]
        [int]$DaysToLook = 1
    )
    
    try {
        Write-Host "Setting vault context for $($Vault.Name)..." -ForegroundColor Yellow
        Set-AzRecoveryServicesVaultContext -Vault $Vault -ErrorAction Stop
        
        # Get UTC time range
        $startTime = (Get-Date).ToUniversalTime().AddDays(-$DaysToLook)
        $endTime = (Get-Date).ToUniversalTime()
        
        Write-Host "Retrieving backup jobs from $($startTime) to $($endTime) UTC..." -ForegroundColor Yellow
        
        $jobs = Get-AzRecoveryServicesBackupJob -From $startTime -To $endTime | 
        Where-Object { $_.WorkloadName -like "*ArcGis*" -or $_.WorkloadName -like "*arcgis*" } |
        Sort-Object StartTime -Descending
            
        if (-not $jobs) {
            Write-Host "No backup jobs found in the last $DaysToLook day(s)" -ForegroundColor Red
            Write-Host "Expanding search to last 7 days..." -ForegroundColor Yellow
            
            $startTime = (Get-Date).ToUniversalTime().AddDays(-7)
            $jobs = Get-AzRecoveryServicesBackupJob -From $startTime -To $endTime | 
            Where-Object { $_.WorkloadName -like "*ArcGis*" -or $_.WorkloadName -like "*arcgis*" } |
            Sort-Object StartTime -Descending
        }

        if (-not $jobs) {
            Write-Host "No ArcGis-related jobs found. Listing all recent jobs..." -ForegroundColor Yellow
            $jobs = Get-AzRecoveryServicesBackupJob -From $startTime -To $endTime |
            Sort-Object StartTime -Descending
        }
        
        return $jobs
    }
    catch {
        Write-Error "Failed to retrieve backup jobs: $_"
        throw
    }
}

# Function to select a backup job
function Select-BackupJob {
    param (
        [Parameter(Mandatory = $true)]
        [Array]$Jobs
    )
    
    Write-Host "`nAvailable backup jobs:" -ForegroundColor Yellow
    $menuOptions = @{}
    $index = 0
    
    foreach ($job in $Jobs) {
        $menuOptions[$index] = $job
        Write-Host "[$index] WorkloadName: $($job.WorkloadName)" -ForegroundColor Cyan
        Write-Host "     Status: $($job.Status)" -ForegroundColor Gray
        Write-Host "     Started: $($job.StartTime) UTC" -ForegroundColor Gray
        Write-Host "     Operation: $($job.Operation)" -ForegroundColor Gray
        Write-Host "     JobId: $($job.JobId)" -ForegroundColor Gray
        Write-Host ""
        $index++
    }
    
    do {
        $selection = Read-Host "`nEnter the number of the backup job to monitor (0-$($menuOptions.Count - 1))"
        $validSelection = $selection -match "^\d+$" -and $menuOptions.ContainsKey([int]$selection)
        
        if (-not $validSelection) {
            Write-Host "Invalid selection. Please enter a number between 0 and $($menuOptions.Count - 1)" -ForegroundColor Red
        }
    } while (-not $validSelection)
    
    return $menuOptions[[int]$selection]
}







# Previous functions remain the same, adding Watch-AzureBackupJob function
function Watch-AzureBackupJob {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$JobId,
        
        [Parameter(Mandatory = $true)]
        [Microsoft.Azure.Commands.RecoveryServices.ARSVault]$Vault,

        [Parameter(Mandatory = $false)]
        [int]$RefreshIntervalSeconds = 30
    )

    try {
        Write-Host "Setting vault context for $($Vault.Name)..." -ForegroundColor Yellow
        Set-AzRecoveryServicesVaultContext -Vault $Vault -ErrorAction Stop

        $jobHistory = @()
        $completed = $false
        $startTime = Get-Date
        
        while (-not $completed) {
            Clear-Host
            $job = Get-AzRecoveryServicesBackupJob -JobId $JobId -ErrorAction Stop
            $elapsedTime = (Get-Date) - $startTime
            
            # Header
            Write-Host "=== Azure Backup Job Monitor ===" -ForegroundColor Cyan
            Write-Host "--------------------------------------------------" -ForegroundColor Gray
            
            # Basic Info
            Write-Host "Vault:     $($Vault.Name)" -ForegroundColor White
            Write-Host "Job ID:    $JobId" -ForegroundColor White
            Write-Host "Operation: $($job.Operation)" -ForegroundColor White
            Write-Host "Workload:  $($job.WorkloadName)" -ForegroundColor White
            Write-Host "--------------------------------------------------" -ForegroundColor Gray
            
            # Status Information
            $statusColor = switch ($job.Status) {
                "InProgress" { "Yellow" }
                "Completed" { "Green" }
                "Failed" { "Red" }
                default { "White" }
            }
            
            Write-Host "Status:     $($job.Status)" -ForegroundColor $statusColor
            Write-Host "Duration:   $($job.Duration)" -ForegroundColor White
            Write-Host "Start Time: $($job.StartTime)" -ForegroundColor White
            Write-Host "Monitoring: $($elapsedTime.ToString('hh\:mm\:ss'))" -ForegroundColor White
            
            # Subtasks
            if ($job.SubTasks) {
                Write-Host "--------------------------------------------------" -ForegroundColor Gray
                Write-Host "SubTasks:" -ForegroundColor White
                
                foreach ($task in $job.SubTasks) {
                    $taskColor = switch ($task.Status) {
                        "Completed" { "Green" }
                        "InProgress" { "Yellow" }
                        "Failed" { "Red" }
                        default { "Gray" }
                    }
                    Write-Host "* $($task.Name)" -ForegroundColor White
                    Write-Host "  Status: $($task.Status)" -ForegroundColor $taskColor
                    if ($task.Duration) {
                        Write-Host "  Duration: $($task.Duration)" -ForegroundColor White
                    }
                    Write-Host ""
                }
            }
            
            Write-Host "--------------------------------------------------" -ForegroundColor Gray
            
            # Update job history
            $jobHistory += [PSCustomObject]@{
                TimeStamp = Get-Date
                Status = $job.Status
                WorkloadName = $job.WorkloadName
                Operation = $job.Operation
                Duration = $job.Duration
                SubTasks = ($job.SubTasks | ForEach-Object { "$($_.Name): $($_.Status)" }) -join "; "
            }

            if ($job.Status -in @("Completed", "Failed", "CompletedWithWarnings")) {
                $completed = $true
                
                # Generate final reports
                New-HTML -FilePath ".\BackupJobReport.html" -ShowHTML {
                    New-HTMLTable -DataTable $jobHistory -Title "Backup Job History" {
                        New-HTMLTableHeader -Title "Backup Job Report - $($job.WorkloadName)" -BackgroundColor "#007bff" -Color "#ffffff"
                    }
                }

                $jobHistory | Export-Csv -Path ".\BackupJobHistory.csv" -NoTypeInformation
                
                Write-Host "`nJob completed with status: $($job.Status)" -ForegroundColor $statusColor
                Write-Host "Total duration: $($job.Duration)" -ForegroundColor White
                Write-Host "Reports generated: BackupJobReport.html and BackupJobHistory.csv" -ForegroundColor Green
            }
            else {
                Write-Host "`nRefreshing in $RefreshIntervalSeconds seconds... (Press Ctrl+C to stop)" -ForegroundColor Yellow
                Start-Sleep -Seconds $RefreshIntervalSeconds
            }
        }

        return $jobHistory
    }
    catch {
        Write-Error "Failed to monitor backup job: $_"
        throw
    }
}


# Main execution
try {
    Write-Host "Getting Recovery Services vault details..." -ForegroundColor Cyan
    $vaultInfo = Get-AzureBackupVaultDetails
    $menuOptions = $vaultInfo.MenuOptions
    
    Write-Host "`nPlease select a vault:" -ForegroundColor Yellow
    foreach ($key in $menuOptions.Keys | Sort-Object) {
        $vault = $menuOptions[$key]
        Write-Host "[$key] $($vault.Name) (ResourceGroup: $($vault.ResourceGroupName), Location: $($vault.Location))" -ForegroundColor Cyan
    }
    
    do {
        $selection = Read-Host "`nEnter the number of the vault to use (0-$($menuOptions.Count - 1))"
        $validSelection = $selection -match "^\d+$" -and $menuOptions.ContainsKey([int]$selection)
        
        if (-not $validSelection) {
            Write-Host "Invalid selection. Please enter a number between 0 and $($menuOptions.Count - 1)" -ForegroundColor Red
        }
    } while (-not $validSelection)

    $selectedVault = $menuOptions[[int]$selection]
    Write-Host "`nUsing vault: $($selectedVault.Name)" -ForegroundColor Green

    # Get list of backup jobs
    $jobs = Get-BackupJobsList -Vault $selectedVault
    if ($jobs) {
      
        $selectedJob = Select-BackupJob -Jobs $jobs
        Write-Host "`nMonitoring backup job:" -ForegroundColor Cyan
        Write-Host "Job ID: $($selectedJob.JobId)" -ForegroundColor Cyan
        Write-Host "Workload: $($selectedJob.WorkloadName)" -ForegroundColor Cyan
        Write-Host "Operation: $($selectedJob.Operation)" -ForegroundColor Cyan
        
        $jobProgress = Watch-AzureBackupJob -JobId $selectedJob.JobId -Vault $selectedVault -RefreshIntervalSeconds 30
        




    }
    else {
        Write-Host "No backup jobs found in the vault" -ForegroundColor Red
    }
}
catch {
    Write-Error $_
    throw
}