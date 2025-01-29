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
#>

Get-AzNetworkSecurityGroup | Select-Object -Property Name

Get-AzNetworkSecurityGroup -Name 'FAX1-nsg' -ResourceGroupName "FAX1_GROUP"

