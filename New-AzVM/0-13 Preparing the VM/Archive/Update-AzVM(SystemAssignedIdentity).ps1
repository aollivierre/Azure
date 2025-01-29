$VMName = "TrueSky1"
$ResourceGroupName = "CCI_TrueSky1_RG"
$vm = Get-AzVM -ResourceGroupName $ResourceGroupName -Name $VMName
Update-AzVM -ResourceGroupName $ResourceGroupName -VM $vm -IdentityType SystemAssigned