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
Create a public IP address for Azure Bastion. The public IP is the public IP address the Bastion resource on which RDP/SSH will be accessed (over port 443). The public IP address must be in the same region as the Bastion resource you are creating.

#>

$newAzPublicIpAddressSplat = @{
    ResourceGroupName = "FGC_Prod_Bastion_RG"
    Name = "FGC_Prod_Bastion_PublicIP"
    Location = "canadacentral"
    AllocationMethod = 'Static'
    Sku = 'Standard'
}

$publicip = New-AzPublicIpAddress @newAzPublicIpAddressSplat