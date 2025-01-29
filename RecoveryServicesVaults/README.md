# Azure Recovery Services Vault Management Scripts

This repository contains PowerShell scripts for managing Azure Recovery Services vaults. These scripts provide different approaches to removing Recovery Services vaults and their associated backup items.

## Scripts Overview

### 1. Remove-RecoveryServicesVaults-Updated.ps1
**Purpose**: Bulk deletion of Recovery Services vaults across all subscriptions.

**Features**:
- Automatically scans all accessible Azure subscriptions
- Can remove multiple vaults in one operation
- Handles all types of backup items:
  - Azure VM backups
  - SQL Server backups
  - SAP HANA backups
  - Azure File Share backups
  - MARS/MABS/DPM servers
  - ASR (Site Recovery) items
  - Private endpoints
- Includes safety confirmations and detailed status reporting
- Thorough cleanup process following Microsoft best practices

**Usage**:
```powershell
# Connect to Azure first
Connect-AzAccount

# Run the script
.\Remove-RecoveryServicesVaults-Updated.ps1
```

### 2. Remove-RSV.ps1
**Purpose**: Single vault deletion following official Microsoft approach.

**Features**:
- Targets a specific vault by name
- Requires manual input of vault parameters
- Thorough cleanup of all backup items
- Follows official Microsoft cleanup process

**Usage**:
```powershell
# Edit these variables in the script:
$VaultName = "YourVaultName"
$Subscription = "YourSubscriptionName"
$ResourceGroup = "YourResourceGroupName"
$SubscriptionId = "YourSubscriptionId"

# Run the script
.\Remove-RSV.ps1
```

## Prerequisites

- PowerShell 7 or later
- Az PowerShell modules:
  - Az.Accounts
  - Az.RecoveryServices (version 5.3.0 or later)
  - Az.Network (version 4.15.0 or later)
- Azure subscription with appropriate permissions

## Important Notes

1. **Backup Data**: These scripts will permanently delete all backup data. Make sure you have any needed backups before running these scripts.

2. **Permissions**: You need appropriate permissions in Azure to:
   - List and access subscriptions
   - Modify Recovery Services vault properties
   - Delete backup items and vaults

3. **Soft Delete**: The scripts handle soft delete feature automatically, but be aware that this is a permanent deletion.

4. **Error Handling**: Both scripts include error handling and will report any issues encountered during the deletion process.

## Script Selection Guide

- Use **Remove-RecoveryServicesVaults-Updated.ps1** when:
  - You need to remove multiple vaults
  - You want to clean up vaults across multiple subscriptions
  - You want automated discovery of vaults

- Use **Remove-RSV.ps1** when:
  - You need to remove a specific vault
  - You want to follow the official Microsoft approach
  - You prefer manual control over vault selection

## Contributing

Feel free to submit issues and enhancement requests!
