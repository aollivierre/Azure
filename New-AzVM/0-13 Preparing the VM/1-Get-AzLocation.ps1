Get-AzLocation | Select-Object -Property Location, DisplayName
Get-AzLocation | Select-Object -Property Location, DisplayName | Where-Object {$_.Location -eq 'CanadaCentral'}
Get-AzLocation | Select-Object -Property Location, DisplayName | Where-Object {$_.Location -like '*Canada*'}