$SubscriptionId = $AzContext.Context.Subscription.Id
$VM = Get-AzVM -ResourceGroupName $RGName -Name VMName
$VMResourceId = $VM.Id
$ScheduledShutdownResourceId = "/subscriptions/$SubscriptionId/resourceGroups/wayneVMRG/providers/microsoft.devtestlab/schedules/shutdown-computevm-$VMName"

$Properties = @{}
$Properties.Add('status', 'Enabled')
$Properties.Add('taskType', 'ComputeVmShutdownTask')
$Properties.Add('dailyRecurrence', @{'time'= 1159})
$Properties.Add('timeZoneId', "Eastern Standard Time")
$Properties.Add('notificationSettings', @{status='Disabled'; timeInMinutes=15})
$Properties.Add('targetResourceId', $VMResourceId)

#Error
New-AzResource -Location eastus -ResourceId $ScheduledShutdownResourceId  -Properties $Properties -Force