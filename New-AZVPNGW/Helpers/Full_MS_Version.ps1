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


  https://docs.microsoft.com/en-us/azure/vpn-gateway/create-routebased-vpn-gateway-powershell
#>

New-AzResourceGroup -Name TestRG1 -Location EastUS


$virtualNetwork = New-AzVirtualNetwork `
  -ResourceGroupName TestRG1 `
  -Location EastUS `
  -Name VNet1 `
  -AddressPrefix 10.1.0.0/16


  $subnetConfig = Add-AzVirtualNetworkSubnetConfig `
  -Name Frontend `
  -AddressPrefix 10.1.0.0/24 `
  -VirtualNetwork $virtualNetwork


  $virtualNetwork | Set-AzVirtualNetwork


  $vnet = Get-AzVirtualNetwork -ResourceGroupName TestRG1 -Name VNet1


  Add-AzVirtualNetworkSubnetConfig -Name 'GatewaySubnet' -AddressPrefix 10.1.255.0/27 -VirtualNetwork $vnet


  $vnet | Set-AzVirtualNetwork


  $gwpip= New-AzPublicIpAddress -Name VNet1GWIP -ResourceGroupName TestRG1 -Location 'East US' -AllocationMethod Dynamic

  $vnet = Get-AzVirtualNetwork -Name VNet1 -ResourceGroupName TestRG1
  $subnet = Get-AzVirtualNetworkSubnetConfig -Name 'GatewaySubnet' -VirtualNetwork $vnet
  $gwipconfig = New-AzVirtualNetworkGatewayIpConfig -Name gwipconfig1 -SubnetId $subnet.Id -PublicIpAddressId $gwpip.Id


  New-AzVirtualNetworkGateway -Name VNet1GW -ResourceGroupName TestRG1 `
-Location 'East US' -IpConfigurations $gwipconfig -GatewayType Vpn `
-VpnType RouteBased -GatewaySku VpnGw1


Get-AzVirtualNetworkGateway -Name Vnet1GW -ResourceGroup TestRG1



Get-AzPublicIpAddress -Name VNet1GWIP -ResourceGroupName TestRG1
