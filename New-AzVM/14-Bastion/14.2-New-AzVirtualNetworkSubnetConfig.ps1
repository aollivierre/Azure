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

    Create a virtual network and an Azure Bastion subnet. You must create the Azure Bastion subnet using the name value AzureBastionSubnet. This value lets Azure know which subnet to deploy the Bastion resources to. This is different than a Gateway subnet. You must use a subnet of at least /27 or larger subnet (/27, /26, and so on). Create the AzureBastionSubnet without any route tables or delegations. If you use Network Security Groups on the AzureBastionSubnet, refer to the Work with NSGs article.
#>

$subnetName = "AzureBastionSubnet"
$newAzVirtualNetworkSubnetConfigSplat = @{
    Name = $subnetName
    AddressPrefix = '10.0.0.0/24'
}

$subnet = New-AzVirtualNetworkSubnetConfig @newAzVirtualNetworkSubnetConfigSplat