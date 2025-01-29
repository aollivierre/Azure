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


#region dot sourcing
$Helpers = "$PsScriptRoot\Helpers\"

Get-ChildItem -Path $Helpers -Recurse -Filter '*.ps1' | ForEach-Object { . $_.FullName }
#endregion dot sourcing

#Region Define Global Param
$Param = Invoke-DefineParam
#EndRegion Define Global Param

#Region Create AZ RG
$param.newAzResourceGroupSplat | Invoke-CreateAZRG | Out-Null
#EndRegion Create AZ RG

#Region Create AZ VNET Subnet
$param = $param.newAzVirtualNetworkSubnetConfigSplat | Invoke-CreateAZVNETSubnet | Invoke-DefineParam
#EndRegion Create VNET Subnet

#Region Create AZ VNET
$VNETCONFIG = $param.newAzVirtualNetworkSplat | Invoke-CreateAZVNET
#EndRegion Create AZ VNET

#Region Create AZ Gateway Subnet
$Param = $VNETCONFIG | Invoke-DefineParam
$param.newAzVirtualNetworkGatewaySubnetConfigSplat | Invoke-CreateAZGatewaysubnet | Out-Null
$GatewaySubnetConfig = $param.newAzVirtualNetworkGatewaySubnetConfigSplat | Invoke-GetAZGatewaysubnet
$VNETCONFIG | Invoke-SetAZVNET | Out-Null
#EndRegion Create AZ Gateway Subnet

#Region Request a public IP address
$PublicIPConfig = $param.newAzPublicIpAddressSplat | Invoke-AzPublicIP
#EndRegion Request a public IP address

#Region Create the gateway IP address configuration
$Param = $GatewaySubnetConfig | Invoke-DefineParam
$Param = $PublicIPConfig | Invoke-DefineParam
$GatewayPublicIPConfig = $Param.newAzVirtualNetworkGatewayIpConfigSplat | Invoke-AzVirtualNetworkGatewayIpConfig
#EndRegion Create the gateway IP address configuration


#Region Create Create the VPN gateway
$Param = $GatewayPublicIPConfig | Invoke-DefineParam
# $Param.newAzVirtualNetworkGatewaysplat | Invoke-AzVPNGateway
# $Param.newAzVirtualNetworkGatewaysplat | New-AzVirtualNetworkGateway
#EndRegion Create Create the VPN gateway





