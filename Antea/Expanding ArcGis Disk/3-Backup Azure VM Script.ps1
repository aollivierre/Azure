# Function to create Azure VM backup
function New-AzureVMBackup {
    param (
        [Parameter(Mandatory = $true)]
        [string]$VMName,
        
        [Parameter(Mandatory = $true)]
        [string]$ResourceGroupName,
        
        [Parameter(Mandatory = $true)]
        [string]$VaultName,
        
        [Parameter(Mandatory = $true)]
        [string]$VaultResourceGroup,
        
        [Parameter(Mandatory = $false)]
        [int]$RetentionDays = 30
    )
    
    try {
        # Ensure Az.RecoveryServices module is imported
        if (-not (Get-Module -Name Az.RecoveryServices -ListAvailable)) {
            Write-Host "Installing Az.RecoveryServices module..." -ForegroundColor Yellow
            Install-Module -Name Az.RecoveryServices -Force -AllowClobber
        }
        Import-Module -Name Az.RecoveryServices -ErrorAction Stop

        # Get VM details
        Write-Host "Verifying VM existence..." -ForegroundColor Yellow
        $vm = Get-AzVM -ResourceGroupName $ResourceGroupName -Name $VMName -ErrorAction Stop

        # Get Recovery Services Vault
        Write-Host "Accessing Recovery Services Vault..." -ForegroundColor Yellow
        $vault = Get-AzRecoveryServicesVault -ResourceGroupName $VaultResourceGroup -Name $VaultName -ErrorAction Stop
        
        # Set vault context
        Set-AzRecoveryServicesVaultContext -Vault $vault -ErrorAction Stop

        # Start backup job
        Write-Host "Initiating backup job..." -ForegroundColor Yellow
        $backupJob = Start-AzRecoveryServicesAsrBackupNow -Name $VMName -ErrorAction Stop

        # Create backup details object
        $backupDetails = [PSCustomObject]@{
            VMName = $VMName
            ResourceGroup = $ResourceGroupName
            VaultName = $VaultName
            BackupJobId = $backupJob.JobId
            StartTime = Get-Date
            Status = $backupJob.Status
            RetentionDays = $RetentionDays
        }

        # Generate HTML report
        New-HTML -FilePath ".\VMBackupReport.html" -ShowHTML {
            New-HTMLTable -DataTable @($backupDetails) -Title "VM Backup Operation Report" {
                New-HTMLTableHeader -Title "VM Backup - $(Get-Date -Format 'yyyy-MM-dd HH:mm')" -BackgroundColor '#007bff' -Color '#ffffff'
            }
        }

        # Export CSV report
        $backupDetails | Export-Csv -Path ".\VMBackupReport.csv" -NoTypeInformation

        # Monitor backup progress
        Write-Host "Monitoring backup progress..." -ForegroundColor Yellow
        while ($backupJob.Status -eq "InProgress") {
            $backupJob = Get-AzRecoveryServicesBackupJob -Job $backupJob
            Write-Host "Backup Status: $($backupJob.Status) - $(Get-Date)" -ForegroundColor Cyan
            Start-Sleep -Seconds 30
        }

        return $backupDetails
    }
    catch {
        Write-Error "Failed to create VM backup: $_"
        throw
    }
}

# Main execution
try {
    Write-Host "Starting Azure VM backup process..." -ForegroundColor Cyan
    
    # Backup parameters for ArcGisS1
    $backupParams = @{
        VMName = 'ArcGisS1'
        ResourceGroupName = 'anteausa'
        VaultName = '' # Need vault name
        VaultResourceGroup = '' # Need vault resource group
        RetentionDays = 30
    }
    
    Write-Host "`nInitiating backup with following parameters:" -ForegroundColor Yellow
    $backupParams | Format-Table -AutoSize
    
    # Create backup
    Write-Host "`nCreating backup..." -ForegroundColor Yellow
    $backup = New-AzureVMBackup @backupParams
    
    Write-Host "`nBackup operation completed!" -ForegroundColor Green
    Write-Host "Backup Job ID: $($backup.BackupJobId)" -ForegroundColor Green
    Write-Host "Final Status: $($backup.Status)" -ForegroundColor Green
}
catch {
    Write-Host "Error during backup process: $_" -ForegroundColor Red
    throw
}