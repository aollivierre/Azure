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
ID                : /subscriptions/408a6c03-bd25-471b-ae84-cf82b3dff420/resourceGroups/CanPrintEquip_Outlook_RG/providers/Microsoft.Recov 
                    eryServices/vaults/Outlook1ARSV1
Type              : Microsoft.RecoveryServices/vaults
Location          : canadacentral
ResourceGroupName : CanPrintEquip_Outlook_RG
SubscriptionId    : 408a6c03-bd25-471b-ae84-cf82b3dff420
Properties        : Microsoft.Azure.Commands.RecoveryServices.ARSVaultProperties

.NOTES
    General notes

    Fetch the vault ID
We plan on deprecating the vault context setting in accordance with Azure PowerShell guidelines. Instead, you can store or fetch the vault ID, and pass it to relevant commands. So, if you haven't set the vault context or want to specify the command to run for a certain vault, pass the vault ID as "-vaultID" to all relevant command, as follows:
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
$targetVault.ID
$targetVault


# $targetVaultID = Get-AzRecoveryServicesVault -ResourceGroupName "Contoso-docs-rg" -Name "testvault" | select -ExpandProperty ID