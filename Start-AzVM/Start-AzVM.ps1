Start-AzVM -ResourceGroupName "CCI_PS_AUTOMATION_RG" -Name "PSAutomation1"
$pip = Get-AzPublicIpAddress -ResourceGroupName "CCI_PS_AUTOMATION_RG" -Name "PSAutomation1-ip"
Write-Output $pip.IpAddress
mstsc.exe



# Stop-AzVM -ResourceGroupName "CCI_PS_AUTOMATION_RG" -Name "PSAutomation1"

# Get-AzVirtualNetwork | Out-GridView
# Get-AzVirtualNetwork | Select-Object name, ResourceGroupName



# $vnet = Get-AzVirtualNetwork -Name CCI_PS_Automation_RG-vnet -ResourceGroupName CCI_PS_Automation_RG

# Get-AzVirtualNetworkSubnetConfig -VirtualNetwork $vnet | Select-Object name, ResourceGroupName
# Get-AzVirtualNetworkSubnetConfig -VirtualNetwork $vnet | Select-Object *

# Get-AzNetworkInterface -Name psautomation1230 -ResourceGroupName CCI_PS_Automation_RG | select * | Out-GridView
# Get-AzNetworkInterface -Name psautomation1230 -ResourceGroupName CCI_PS_Automation_RG | select * | Out-GridView

# Get-AzPublicIpAddress -Name PSAutomation1-ip | select *


# $subnet = Get-AzVirtualNetworkSubnetConfig -Name myVMSubnet -VirtualNetwork $vnet
# $nic = Get-AzNetworkInterface -Name myVMVMNic -ResourceGroupName myResourceGroup
# $pip = Get-AzPublicIpAddress -Name myVMPublicIP -ResourceGroupName myResourceGroup
# $nic | Set-AzNetworkInterfaceIpConfig -Name ipconfigmyVM -PublicIPAddress $pip -Subnet $subnet
# $nic | Set-AzNetworkInterface