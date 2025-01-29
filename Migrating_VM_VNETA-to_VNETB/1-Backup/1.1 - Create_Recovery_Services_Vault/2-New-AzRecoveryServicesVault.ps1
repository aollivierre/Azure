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


    Name              : Outlook1ARSV1
ID                : /subscriptions/408a6c03-bd25-471b-ae84-cf82b3dff420/resourceGroups/CanPrintEquip_Outlook_RG/providers/Microsoft.RecoveryServi 
                    ces/vaults/Outlook1ARSV1
Type              : Microsoft.RecoveryServices/vaults
Location          : canadacentral
ResourceGroupName : CanPrintEquip_Outlook_RG
SubscriptionId    : 408a6c03-bd25-471b-ae84-cf82b3dff420
Properties        : Microsoft.Azure.Commands.RecoveryServices.ARSVaultProperties

.NOTES
    General notes

    You will get the vague error below if you have any illegel or imporper or invalid characters in any of your variables specifially the ARS Vault name like under score _ will throw the following error

    New-AzRecoveryServicesVault : Operation failed.
ClientRequestId: 7441125a-cac5-4a2d-92a0-05e3cd327b24-2020-12-12 06:08:34Z-P
One or more errors occurred.
At C:\Users\Abdullah.Ollivierre\AzureRepos2\Azure\Migrating_VM_VNETA-to_VNETB\2-New-AzRecoveryServicesVault.ps1:16 char:1
+ New-AzRecoveryServicesVault @newAzRecoveryServicesVaultSplat
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : CloseError: (:) [New-AzRecoveryServicesVault], Exception
    + FullyQualifiedErrorId : Microsoft.Azure.Commands.RecoveryServices.NewAzureRmRecoveryServicesVault
#>

$LocationName = 'CanadaCentral'
$CustomerName = 'CanPrintEquip'
$VMName = 'Outlook1'
$ResourceGroupName = -join ("$CustomerName", "_Outlook", "_RG")
# $ResourceGroupName = 'CanPrintEquip_Outlook_RG'
$Vaultname = -join ("$VMName", "ARSV1")
# $Vaultname = 'Outlook1_ARSV1'

$Tags = ''


$newAzRecoveryServicesVaultSplat = @{
    Name = $Vaultname
    ResourceGroupName = $ResourceGroupName 
    Location = $LocationName
    Tag = $Tags

}

New-AzRecoveryServicesVault @newAzRecoveryServicesVaultSplat




# New-AzRecoveryServicesVault -Name 'Outlook1_ARSV1' -ResourceGroupName 'CanPrintEquip_Outlook_RG' -Location 'CanadaCentral'