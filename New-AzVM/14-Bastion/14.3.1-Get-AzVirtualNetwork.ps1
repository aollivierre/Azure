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

        You do not need to create a new VNET as Bastion deployment is per virtual network, not per subscription/account or virtual machine. So ensure you place the Bastion in your existing VNET
#>

$getAzVirtualNetworkSplat = @{
    Name = 'ProductionVNET'
}

$vnet = Get-AzVirtualNetwork @getAzVirtualNetworkSplat