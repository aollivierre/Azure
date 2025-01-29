# import-module Az
# Get-AzVm | select ResourceGroupName, Name
# Get-AzVm | select * | Out-GridView

# $VM = Get-AzVm -ResourceGroupName "CCI_PS_AUTOMATION_RG" -Name "PSAutomation1" | select *

# $VM.Statuses.DisplayStatus


# $VM = Start-AzVM -ResourceGroupName "CCI_PS_AUTOMATION_RG" -Name "PSAutomation1"

function Get-ARMVM {

    [CmdletBinding()]
    param (
        [Parameter()]
        [String]$RGNAME,
        [String]$VMNAME

    )
    
    begin {
        
    }
    
    process {


        try {
        
            $RGs = Get-AzResourceGroup
            foreach ($RG in $RGs) {

                if ($RG.ResourceGroupName -eq $RGNAME) {

                    $VMs = Get-AzVM -ResourceGroupName $RG.ResourceGroupName
                    foreach ($VM in $VMs) {

                        if ($VM.name -eq $VMNAME ) {
                            $VMDetail = Get-AzVM -ResourceGroupName $RG.ResourceGroupName -Name $VM.Name -Status
                            $RGN = $VMDetail.ResourceGroupName  
                            foreach ($VMStatus in $VMDetail.Statuses) { 
                                $VMStatusDetail = $VMStatus.DisplayStatus
                            }
                            Write-Output "Resource Group: $RGN", ("VM Name: " + $VM.Name), "Status: $VMStatusDetail" `n
                        }
                    }
                }
        
            }
        }
        catch {
            
        }
        finally {
            
        }
        
    }
    
    end {
        
    }
}

Get-ARMVM -RGNAME "CCI_PS_AUTOMATION_RG" -VMName "PSAutomation1"