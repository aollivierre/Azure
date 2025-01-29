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


    
# Use Set-AzRecoveryServicesBackupProperty command to set the Storage replication configuration of the vault to LRS/GRS
Storage Redundancy can be modified only if there are no backup items protected to the vault.

Default value when you create a new RSV

Recovery Services Vault --> Properties --> Storage Replication Type = Geo-Redundant

#>

# $LocationName = 'CanadaCentral'
# $CustomerName = 'CanPrintEquip'
$VMName = 'Outlook1'
# $ResourceGroupName = -join ("$CustomerName", "_Outlook", "_RG")
# $ResourceGroupName = 'CanPrintEquip_Outlook_RG'
$Vaultname = -join ("$VMName", "ARSV1")



$setAzRecoveryServicesBackupPropertySplat = @{
    Vault = $Vaultname
    BackupStorageRedundancy = 'GeoRedundant/LocallyRedundant'
}

Set-AzRecoveryServicesBackupProperty @setAzRecoveryServicesBackupPropertySplat

