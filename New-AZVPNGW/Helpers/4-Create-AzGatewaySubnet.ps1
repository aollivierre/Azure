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


function Invoke-CreateAZGatewaysubnet {
    [CmdletBinding()]
    param (

        # [Parameter(ValueFromPipelineByPropertyName)]
        # $newAzResourceGroupSplat
        [Parameter(ValueFromPipeline)]
        $newAzVirtualNetworkGatewaySubnetConfigSplat
        
    )
    
    begin {
        
    }
    
    process {
    
        try {

            
            $GatewaySubnetConfig = Add-AzVirtualNetworkSubnetConfig @newAzVirtualNetworkGatewaySubnetConfigSplat
            # $Vnet | Invoke-DefineParam
         
        }
     
        catch {
                
            Write-Error 'An Error happened when .. script execution will be halted'
         
            #Region CatchAll
         
            Write-Host "A Terminating Error (Exception) happened" -ForegroundColor Magenta
            Write-Host "Displaying the Catch Statement ErrorCode" -ForegroundColor Yellow
            $PSItem
            Write-Host $PSItem.ScriptStackTrace -ForegroundColor Red
            
            
            $ErrorMessage_1 = $_.Exception.Message
            write-host $ErrorMessage_1  -ForegroundColor Red
            Write-Output "Ran into an issue: $PSItem"
            Write-host "Ran into an issue: $PSItem" -ForegroundColor Red
            throw "Ran into an issue: $PSItem"
            throw "I am the catch"
            throw "Ran into an issue: $PSItem"
            $PSItem | Write-host -ForegroundColor
            $PSItem | Select-Object *
            $PSCmdlet.ThrowTerminatingError($PSitem)
            throw
            throw "Something went wrong"
            Write-Log $PSItem.ToString()
         
            #EndRegion CatchAll
         
            Exit
         
         
        }
    
        finally {
         
        }
        
    }
    
    end {

        return $GatewaySubnetConfig
        
    }
}


# Invoke-CreateAZVNET