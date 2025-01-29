# ."$PSScriptRoot\13-Set-AzVMAutoShutdown.ps1"

function New-IaaCAzVM {
    [CmdletBinding()]
    param (

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]$LocationName,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]$CustomerName,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]$VMName,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]$ResourceGroupName,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]$datetime,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [hashtable]$Tags,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]$ComputerName,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$VMSize,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$OSDiskCaching,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$OSCreateOption,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$GUID,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$OSDiskName,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$ASGName,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$NSGName,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$DNSNameLabel,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$NICPrefix,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$NICName,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$IPConfigName,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$PublicIPAddressName,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$VnetName,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$SubnetName,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$PublicIPAllocation,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$PublisherName,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Offer,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Skus,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Version,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$DiskSizeInGB

    )

    #Creating the Resource Group Name
    $newAzResourceGroupSplat = @{
        Name     = $ResourceGroupName
        Location = $LocationName
        Tag      = $Tags
    }

    New-AzResourceGroup @newAzResourceGroupSplat

    #Getting the Existing VNET. We put our VMs in the same VNET as much as possible, so we do not have to create new bastions and new VPN gateways for each VM
    $getAzVirtualNetworkSplat = @{
        Name = $VnetName
    }
    $vnet = Get-AzVirtualNetwork @getAzVirtualNetworkSplat

    #Getting the Existing Subnet
    $getAzVirtualNetworkSubnetConfigSplat = @{
        VirtualNetwork = $vnet
        Name           = $SubnetName
    }
    $VMsubnet = Get-AzVirtualNetworkSubnetConfig @getAzVirtualNetworkSubnetConfigSplat

    #Creating the PublicIP for the VM
    $newAzPublicIpAddressSplat = @{
        Name              = $PublicIPAddressName
        DomainNameLabel   = $DNSNameLabel
        ResourceGroupName = $ResourceGroupName
        Location          = $LocationName
        AllocationMethod  = $PublicIPAllocation
        Tag               = $Tags
    }
    $PIP = New-AzPublicIpAddress @newAzPublicIpAddressSplat

    #Creating the Application Security Group
    $newAzApplicationSecurityGroupSplat = @{
        ResourceGroupName = "$ResourceGroupName"
        Name              = "$ASGName"
        Location          = "$LocationName"
        Tag               = $Tags
    }
    $ASG = New-AzApplicationSecurityGroup @newAzApplicationSecurityGroupSplat

    $newAzNetworkInterfaceIpConfigSplat = @{
        Name                     = $IPConfigName
        Subnet                   = $VMSubnet
        PublicIpAddress          = $PIP
        ApplicationSecurityGroup = $ASG
        Primary                  = $true
    }
    $IPConfig1 = New-AzNetworkInterfaceIpConfig @newAzNetworkInterfaceIpConfigSplat

    $newAzNetworkSecurityGroupSplat = @{
        ResourceGroupName = $ResourceGroupName
        Location          = $LocationName
        Name              = $NSGName
        Tag               = $Tags
    }
    $NSG = New-AzNetworkSecurityGroup @newAzNetworkSecurityGroupSplat

    #Creating the NIC for the VM
    $newAzNetworkInterfaceSplat = @{
        Name                   = $NICName
        ResourceGroupName      = $ResourceGroupName
        Location               = $LocationName
        NetworkSecurityGroupId = $NSG.Id
        IpConfiguration        = $IPConfig1
        Tag                    = $Tags
    
    }
    $NIC = New-AzNetworkInterface @newAzNetworkInterfaceSplat

    #Creating the Cred Object for the VM
    $Credential = Get-Credential

    #Creating the VM Config Object for the VM
    $newAzVMConfigSplat = @{
        VMName = $VMName
        VMSize = $VMSize
        Tags   = $Tags
    }
    $VirtualMachine = New-AzVMConfig @newAzVMConfigSplat

    #Creating the OS Object for the VM
    $setAzVMOperatingSystemSplat = @{
        VM           = $VirtualMachine
        Windows        = $true
        ComputerName = $ComputerName
        Credential   = $Credential
    }
    $VirtualMachine = Set-AzVMOperatingSystem @setAzVMOperatingSystemSplat

    #Adding the NIC to the VM
    $addAzVMNetworkInterfaceSplat = @{
        VM = $VirtualMachine
        Id = $NIC.Id
    }
    $VirtualMachine = Add-AzVMNetworkInterface @addAzVMNetworkInterfaceSplat

    $setAzVMSourceImageSplat = @{
        VM            = $VirtualMachine
        PublisherName = $PublisherName
        Offer         = $Offer
        Skus          = $Skus
        Version       = $Version
    
    }
    $VirtualMachine = Set-AzVMSourceImage @setAzVMSourceImageSplat

    #Setting the VM OS Disk to the VM
    $setAzVMOSDiskSplat = @{
        VM           = $VirtualMachine
        Name         = $OSDiskName
        Caching      = $OSDiskCaching
        CreateOption = $OSCreateOption
        DiskSizeInGB = $DiskSizeInGB
    }
    $VirtualMachine = Set-AzVMOSDisk @setAzVMOSDiskSplat

    #Creating the VM
    $newAzVMSplat = @{
        ResourceGroupName = $ResourceGroupName
        Location          = $LocationName
        VM                = $VirtualMachine
        Verbose           = $true
        Tag               = $Tags
    }
    New-AzVM @newAzVMSplat
    
}



##Global Parameters
$LocationName = 'CanadaCentral'
$CustomerName = 'CanadaComputing'
$VMName = 'Client9'
$ResourceGroupName = -join ("$CustomerName", "_$VMName", "_RG")


##VM
$ComputerName = $VMName
$VMSize = "Standard_B2MS"
$OSDiskCaching = "ReadWrite"
$OSCreateOption = "FromImage"
$GUID = [guid]::NewGuid()
$OSDiskName = -join ("$VMName", "_OSDisk", "_1", "_$GUID")

#ASG
$ASGName = -join ("$VMName", "_ASG1")

#Defining the NSG name
$NSGName = -join ("$VMName", "-nsg")

## Networking
$DNSNameLabel = -join ("$VMName", "DNS").ToLower() # mydnsname.westus.cloudapp.azure.com
$NICPrefix = 'NIC1'
$NICName = -join ("$VMName", "_$NICPrefix").ToLower()
$IPConfigName = -join ("$VMName", "$NICName", "_IPConfig1").ToLower()
$PublicIPAddressName = -join ("$VMName", "-ip")
$VnetName = 'DC1_group-vnet'
$SubnetName = 'DC1-subnet'
$PublicIPAllocation = 'Dynamic'


##Operating System
$publisherName = "MicrosoftWindowsDesktop"
$offer = "office-365"
$Skus = "20h2-evd-o365pp"
$version = "latest"

##Disk
$DiskSizeInGB = '127'


#Creating the Tag Hashtable for the VM
$datetime = [System.DateTime]::Now.ToString("yyyy_MM_dd_HH_mm_ss")
[hashtable]$Tags = @{

    "Autoshutown"       = 'OFF'
    "Createdby"         = 'Abdullah Ollivierre'
    "CustomerName"      = "$CustomerName"
    "DateTimeCreated"   = "$datetime"
    "Environment"       = 'Production'
    "Application"       = 'WindowsADTesting'  
    "Purpose"           = 'WindowsADTesting'
    "Uptime"            = '730 hrs'
    "Workload"          = 'WindowsADTesting'
    "VMGenenetation"    = 'Gen2'
    "RebootCaution"     = 'Schedule a maintenance window first before rebooting'
    "VMSize"            = "$VMSize"
    "Location"          = "$LocationName"
    "CSP"               = "Canada Computing Inc."

}


$NewIaaCAzVMSplat = @{

    LocationName        = $LocationName
    CustomerName        = $CustomerName 
    VMName              = $VMName  
    ResourceGroupName   = $ResourceGroupName
        
    #Creating the Tag Hashtable for the VM
    datetime            = $datetime
    Tags                = $Tags 
        
        
    ##VM
    ComputerName        = $ComputerName
    VMSize              = $VMSize
    OSDiskCaching       = $OSDiskCaching
    OSCreateOption      = $OSCreateOption
    GUID                = $GUID
    OSDiskName          = $OSDiskName
        
    #ASG
    ASGName             = $ASGName 
        
    #Defining the NSG name
    NSGName             = $NSGName  
        
    ## Networking
    DNSNameLabel        = $DNSNameLabel   # mydnsname.westus.cloudapp.azure.com
    NICPrefix           = $NICPrefix 
    NICName             = $NICName
    IPConfigName        = $IPConfigName 
    PublicIPAddressName = $PublicIPAddressName
    VnetName            = $VnetName
    SubnetName          = $SubnetName
    PublicIPAllocation  = $PublicIPAllocation
        
        
    ##Operating System
    PublisherName       = $PublisherName
    Offer               = $Offer 
    Skus                = $Skus  
    Version             = $Version 
        
    ##Disk
    DiskSizeInGB        = $DiskSizeInGB

}
New-IaaCAzVM @NewIaaCAzVMSplat

