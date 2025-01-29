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

function Invoke-DefineParam {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline)]
        $SubnetConfig,
        [Parameter(ValueFromPipeline)]
        $VnetCONFIG,
        [Parameter(ValueFromPipeline)]
        $GatewaySubnetConfig,
        [Parameter(ValueFromPipeline)]
        $PublicIPConfig,
        [Parameter(ValueFromPipeline)]
        $GatewayPublicIPConfig
        
    )
    
    begin {
        
    }
    
    process {


        try {

            #Region Param Global
            $LocationName = 'CanadaCentral'
            $CustomerName = 'CCI'
            $VMName = 'VPN505050'
            $CustomerName = 'CanadaComputing'
            $ResourceGroupName = -join ("$CustomerName", "_$VMName", "_RG")
            #EndRegion Param Global
    
    
            #Region Param Date
            #Creating the Tag Hashtable for the VM
            $datetime = [System.DateTime]::Now.ToString("yyyy_MM_dd_HH_mm_ss")
            [hashtable]$Tags = @{
    
                "Autoshutown"     = 'ON'
                "Createdby"       = 'Abdullah Ollivierre'
                "CustomerName"    = "$CustomerName"
                "DateTimeCreated" = "$datetime"
                "Environment"     = 'Production'
                "Application"     = 'VPN'  
                "Purpose"         = 'VPN'
                "Uptime"          = '24/7'
                "Workload"        = 'VPN'
                "RebootCaution"   = 'Schedule a window first before rebooting'
                "VMSize"          = 'B2MS'
                "Location"        = "$LocationName"
                "Approved By"     = "Abdullah Ollivierre"
                "Approved On"     = ""
    
            }
    
    
            $newAzResourceGroupSplat = @{
                Name     = $ResourceGroupName
                Location = $LocationName
                Tag      = $Tags
            }
    
            #endRegion Param Date



            #Region Param VNETSubnet

            $SubnetName = -join ("$VMName", "-subnet")
            $SubnetAddressPrefix = "10.0.0.0/24"
       
            $newAzVirtualNetworkSubnetConfigSplat = @{
                Name          = $SubnetName
                AddressPrefix = $SubnetAddressPrefix
                # VirtualNetwork = $VNET
            }
            #EndRegion Param VNETSubnet     
    
            #Region Param VNET
            $NetworkName = -join ("$VMName", "_group-vnet")
            $VnetAddressPrefix = "10.0.0.0/16"

    
            $newAzVirtualNetworkSplat = @{
                Name              = $NetworkName
                ResourceGroupName = $ResourceGroupName
                Location          = $LocationName
                AddressPrefix     = $VnetAddressPrefix
                Subnet            = $SubnetConfig
                Tag               = $Tags
            }
            #EndRegion Param VNET




            $newAzVirtualNetworkConfigSplat = @{
                Name              = $NetworkName
                ResourceGroupName = $ResourceGroupName
            }


            #Region Param VNET Gateway Subnet

            $GatewaySubnetName = 'GatewaySubnet'
            $SubnetAddressPrefix = "10.0.255.0/27"
                   
            $newAzVirtualNetworkGatewaySubnetConfigSplat = @{
                Name           = $GatewaySubnetName
                AddressPrefix  = $SubnetAddressPrefix
                VirtualNetwork = $VnetCONFIG
            }
            #EndRegion Param VNET Gateway Subnet 



            $PublicIPAddressName = -join ("$VMName", "-ip")
            $PublicIPAllocationMethod = 'Dynamic' 
        
            $newAzPublicIpAddressSplat = @{
                Name              = $PublicIPAddressName
                DomainNameLabel   = $DNSNameLabel
                ResourceGroupName = $ResourceGroupName
                Location          = $LocationName
                AllocationMethod  = $PublicIPAllocationMethod
                Tag               = $Tags
            }



            $GetAzVirtualNetworkSubnetConfigsplat = @{
                Name              = $GatewaySubnetName
                VirtualNetwork    = $NetworkName
            }


            $gwipconfigname = -join ("$VMName", "-gwipconfig")
            $NewAzVirtualNetworkGatewayIpConfigSplat = @{
                Name              = $gwipconfigname
                SubnetId          = $GatewaySubnetConfig.ID
                PublicIpAddressId = $PublicIPConfig.ID
            }


            $GatewayName = -join ("$VMName", '-VNet1GW')
            $GatewayType = 'Vpn'
            $VpnType = 'RouteBased'
            $GatewaySku = 'VpnGw1'

            $newAzVirtualNetworkGatewaysplat = @{
                Name              = $GatewayName
                ResourceGroupName = $ResourceGroupName
                Location          = $LocationName
                IpConfigurations  = $GatewayPublicIPConfig
                GatewayType       = $GatewayType
                VpnType           = $VpnType
                GatewaySku        = $GatewaySku
            }

            $mypscustomobject = [PSCustomObject]@{
                newAzResourceGroupSplat                     = $newAzResourceGroupSplat
                newAzVirtualNetworkSubnetConfigSplat        = $newAzVirtualNetworkSubnetConfigSplat
                newAzVirtualNetworkSplat                    = $newAzVirtualNetworkSplat
                newAzVirtualNetworkConfigSplat              = $newAzVirtualNetworkConfigSplat
                newAzVirtualNetworkGatewaySubnetConfigSplat = $newAzVirtualNetworkGatewaySubnetConfigSplat
                newAzPublicIpAddressSplat                   = $newAzPublicIpAddressSplat
                GetAzVirtualNetworkSubnetConfigsplat        = $GetAzVirtualNetworkSubnetConfigsplat
                newAzVirtualNetworkGatewayIpConfigSplat     = $newAzVirtualNetworkGatewayIpConfigSplat
                newAzVirtualNetworkGatewaysplat             = $newAzVirtualNetworkGatewaysplat
            }
             
  
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


        return $mypscustomobject
        
    }
}


# $param = Invoke-DefineParam
# Write-Host 'param 0' $param[0] | Out-String
# Write-Host 'param x' $param.X
# Write-Host 'param 1' $param[1] | Out-String
# Write-Host 'param y' $param.y



# $param | Get-Member
# $param | Select-Object -Property x
# $param | Select-Object -Property y