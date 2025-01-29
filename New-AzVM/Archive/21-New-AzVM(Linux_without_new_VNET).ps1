."$PSScriptRoot\13-Set-AzVMAutoShutdown.ps1"

$LocationName = 'CanadaCentral'
$CustomerName = 'FGCHealth'
$VMName = 'Prod-Nifi1'
$ResourceGroupName = -join ("$CustomerName", "_$VMName", "_RG")


#Creating the Tag Hashtable for the VM
$datetime = [System.DateTime]::Now.ToString("yyyy_MM_dd_HH_mm_ss")
[hashtable]$Tags = @{

    "Autoshutown"       = 'OFF'
    "Createdby"         = 'Abdullah Ollivierre'
    "CustomerName"      = "$CustomerName"
    "DateTimeCreated"   = "$datetime"
    "Environment"       = 'Production'
    "Application"       = 'Apache Nifi'  
    "Purpose"           = 'EDW Prod'
    "Uptime"            = '5 hours by 31 days'
    "Workload"          = 'Apache Nifi'
    "VMGenenetation"    = 'Gen2'
    "RebootCaution"     = 'Schedule a maintenance window first before rebooting'
    "VMSize"            = 'Standard_F8s_v2'
    "Location"          = "$LocationName"
    "Approved By"       = "Hamza Musaphir"
    "Approved On"       = "Friday Dec 11 2020"
    "Ticket ID"         = "1515933"
    "CSP"               = "Canada Computing Inc."
    "Subscription Name" = "Microsoft Azure - FGC Production"
    "Subscription ID"   = "3532a85c-c00a-4465-9b09-388248166360"
    "Tenant ID"         = "e09d9473-1a06-4717-98c1-528067eab3a4"

}

#Creating the Resource Group Name
$newAzResourceGroupSplat = @{
    Name     = $ResourceGroupName
    Location = $LocationName
    Tag      = $Tags
}

New-AzResourceGroup @newAzResourceGroupSplat

## VM Account
# Credentials for Local Admin account you created in the sysprepped (generalized) vhd image
# $VMLocalAdminUser = "LocalAdminUser"
# $VMLocalAdminSecurePassword = ConvertTo-SecureString "Whatever your password is" -AsPlainText -Force
## Azure Account
# $LocationName = "westus"


# $ResourceGroupName = "MyResourceGroup"

# $ResourceGroupName = "CanPrintEquip_Outlook_RG"
# This a Premium_LRS storage account.
# It is required in order to run a client VM with efficiency and high performance.
# $StorageAccount = "Mydisk"

## VM



# $OSDiskUri = "https://Mydisk.blob.core.windows.net/disks/MyOSDisk.vhd"
# $SourceImageUri = "https://Mydisk.blob.core.windows.net/vhds/MyOSImage.vhd"
# $VMName = "MyVM"

$ComputerName = $VMName
# Modern hardware environment with fast disk, high IOPs performance.
# Required to run a client VM with efficiency and performance

# $VMSize = "Standard_DS3"
$VMSize = "Standard_F8s_v2"
$OSDiskCaching = "ReadWrite"
$OSCreateOption = "FromImage"

# $OSDiskName = "MyClient"
$GUID = [guid]::NewGuid()
$OSDiskName = -join ("$VMName", "_OSDisk", "_1", "_$GUID")

## Networking
# $DNSNameLabel = "mydnsname" # mydnsname.westus.cloudapp.azure.com
# $DNSNameLabel = -join ("$VMName","-DNS") # mydnsname.westus.cloudapp.azure.com
$DNSNameLabel = -join ("$VMName", "DNS").ToLower() # mydnsname.westus.cloudapp.azure.com

# $NetworkName = "MyNet"
# $NetworkName = -join ("$VMName", "_group-vnet")

# $NICName = "MyNIC"
# $NICPrefix = ( Get-Random -Minimum 0 -Maximum 999 ).ToString('000')
$NICPrefix = 'NIC1'
$NICName = -join ("$VMName", "_$NICPrefix").ToLower()
$IPConfigName = -join ("$VMName", "$NICName", "_IPConfig1").ToLower()

# $PublicIPAddressName = "MyPIP"
$PublicIPAddressName = -join ("$VMName", "-ip")

# $SubnetName = "MySubnet"
$SubnetName = -join ("$VMName", "-subnet")
# $SubnetAddressPrefix = "10.0.0.0/24"
# $VnetAddressPrefix = "10.0.0.0/16"

#Defining the NGS name
$NSGName = -join ("$VMName", "-nsg")

#Creating the Subnet for the VM
# $newAzVirtualNetworkSubnetConfigSplat = @{
#     Name          = $SubnetName
#     AddressPrefix = $SubnetAddressPrefix
# }
# $SingleSubnet = New-AzVirtualNetworkSubnetConfig @newAzVirtualNetworkSubnetConfigSplat

#Creating the VNET for the VM
# $newAzVirtualNetworkSplat = @{
#     Name              = $NetworkName
#     ResourceGroupName = $ResourceGroupName
#     Location          = $LocationName
#     AddressPrefix     = $VnetAddressPrefix
#     Subnet            = $SingleSubnet
#     Tag               = $Tags
# }
# $Vnet = New-AzVirtualNetwork @newAzVirtualNetworkSplat

$getAzVirtualNetworkSplat = @{
    Name = 'ProductionVNET'
}

$vnet = Get-AzVirtualNetwork @getAzVirtualNetworkSplat

#Create the PublicIP tag
# $newAzPublicIpTagSplat = @{
# IpTagType = "FirstPartyUsage"
# Tag       = "/Sql"
# }

# $ipTag = New-AzPublicIpTag @newAzPublicIpTagSplat

#Creating the PublicIP for the VM
$newAzPublicIpAddressSplat = @{
    Name              = $PublicIPAddressName
    DomainNameLabel   = $DNSNameLabel
    ResourceGroupName = $ResourceGroupName
    Location          = $LocationName
    # AllocationMethod  = 'Dynamic'
    AllocationMethod  = 'Static'
    # IpTag             = $ipTag
    Tag               = $Tags
}
$PIP = New-AzPublicIpAddress @newAzPublicIpAddressSplat



#Creating the NGS with default rules and 1 custom rule
#Define Rule #1

#SourceAddressPrefix
# $SourceAddressPrefix = (Invoke-WebRequest -uri "http://ifconfig.me/ip").Content #Gets the public IP of the current machine
# $SourceAddressPrefixCIDR = -join ("$SourceAddressPrefix", "/32")
#Description
# $NSGRuleDescritption = Invoke-RestMethod -Uri ('http://ipinfo.io/'+(Invoke-WebRequest -uri "http://ifconfig.me/ip").Content) #this can not exceed 140 chars

# $DestinationAddressPrefixCIDR = -join ("$PIP", "/32") if you want to use this with the $PIP var then the $PIP has to be static not Dynamic other wise the the IP won't be allocated

#Creating the Application Security Group
$ASGName = -join ("$VMName", "_ASG1")
$newAzApplicationSecurityGroupSplat = @{
    ResourceGroupName = "$ResourceGroupName"
    Name              = "$ASGName"
    Location          = "$LocationName"
    Tag               = $Tags
}
$ASG = New-AzApplicationSecurityGroup @newAzApplicationSecurityGroupSplat


#Creating the IP config for the NIC
# $vnet = Get-AzVirtualNetwork -Name myvnet -ResourceGroupName myrg
$getAzVirtualNetworkSubnetConfigSplat = @{
    Name           = $SubnetName
    VirtualNetwork = $vnet
}

$Subnet = Get-AzVirtualNetworkSubnetConfig @getAzVirtualNetworkSubnetConfigSplat
# $PIP1 = Get-AzPublicIPAddress -Name "PIP1" -ResourceGroupName "RG1"

$newAzNetworkInterfaceIpConfigSplat = @{
    Name                     = $IPConfigName
    Subnet                   = $Subnet
    # Subnet                   = $Vnet.Subnets[0].Id
    # PublicIpAddress          = $PIP.ID
    PublicIpAddress          = $PIP
    ApplicationSecurityGroup = $ASG
    Primary                  = $true
}

$IPConfig1 = New-AzNetworkInterfaceIpConfig @newAzNetworkInterfaceIpConfigSplat

# $newAzNetworkSecurityRuleConfigSplat = @{
#     # Name = 'rdp-rule'
#     Name                                = 'RDP-rule'
#     # Description = "Allow RDP"
#     Description                         = 'Allow RDP'
#     Access                              = 'Allow'
#     Protocol                            = 'Tcp'
#     Direction                           = 'Inbound'
#     Priority                            = 100
#     SourceAddressPrefix                 = $SourceAddressPrefixCIDR
#     SourcePortRange                     = '*'
#     # DestinationAddressPrefix = '*'
#     # DestinationAddressPrefix = $DestinationAddressPrefixCIDR #this will throw an error due to {Microsoft.Azure.Commands.Network.Models.PSPublicIpAddress/32} work on it some time to fix 
#     # DestinationAddressPrefix = '*'
#     # DestinationPortRange = 3389
#     DestinationPortRange                = '3389'
#     DestinationApplicationSecurityGroup = $ASG
# }
# $rule1 = New-AzNetworkSecurityRuleConfig @newAzNetworkSecurityRuleConfigSplat

#Create a new NSG based on Rules #1 & #2
$newAzNetworkSecurityGroupSplat = @{
    ResourceGroupName = $ResourceGroupName
    Location          = $LocationName
    Name              = $NSGName
    # SecurityRules     = $rule1, $rule2
    # SecurityRules     = $rule1
    Tag               = $Tags
}
$NSG = New-AzNetworkSecurityGroup @newAzNetworkSecurityGroupSplat

#Creating the NIC for the VM
$newAzNetworkInterfaceSplat = @{
    Name                   = $NICName
    ResourceGroupName      = $ResourceGroupName
    Location               = $LocationName
    # SubnetId                 = $Vnet.Subnets[0].Id
    # PublicIpAddressId        = $PIP.Id
    NetworkSecurityGroupId = $NSG.Id
    # ApplicationSecurityGroup = $ASG
    IpConfiguration        = $IPConfig1
    Tag                    = $Tags
    
}
$NIC = New-AzNetworkInterface @newAzNetworkInterfaceSplat

#Creating the Cred Object for the VM
# $Credential = New-Object System.Management.Automation.PSCredential ($VMLocalAdminUser, $VMLocalAdminSecurePassword);
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
    # Windows      = $true
    Linux        = $true
    ComputerName = $ComputerName
    Credential   = $Credential
    # ProvisionVMAgent = $true
    # EnableAutoUpdate = $true
}
$VirtualMachine = Set-AzVMOperatingSystem @setAzVMOperatingSystemSplat

#Adding the NIC to the VM
$addAzVMNetworkInterfaceSplat = @{
    VM = $VirtualMachine
    Id = $NIC.Id
}
$VirtualMachine = Add-AzVMNetworkInterface @addAzVMNetworkInterfaceSplat


# $setAzVMSourceImageSplat = @{
#     VM            = $VirtualMachine
#     # PublisherName = "Canonical"
#     # Offer         = "0001-com-ubuntu-server-focal"
#     # Skus          = "20_04-lts-gen2"
#     # Version       = "latest"
#     publisherName = "MicrosoftWindowsServer"
#     offer         = "WindowsServer"
#     Skus          = "2019-datacenter-gensecond"
#     version       = "latest"
# }


$setAzVMSourceImageSplat = @{
    VM            = $VirtualMachine
    PublisherName = "OpenLogic"
    Offer         = "CentOS"
    Skus          = "8_2-gen2"
    Version       = "latest"
}

$VirtualMachine = Set-AzVMSourceImage @setAzVMSourceImageSplat

#Setting the VM OS Disk to the VM
$setAzVMOSDiskSplat = @{
    VM           = $VirtualMachine
    Name         = $OSDiskName
    # VhdUri = $OSDiskUri
    # SourceImageUri = $SourceImageUri
    Caching      = $OSDiskCaching
    CreateOption = $OSCreateOption
    # Windows = $true
    DiskSizeInGB = '100'
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


# $setAzVMAutoShutdownSplat = @{
#     # ResourceGroupName = 'RG-WE-001'
#     ResourceGroupName = $ResourceGroupName
#     # Name              = 'MYVM001'
#     Name              = $VMName
#     Enable            = $true
#     Time              = '23:59'
#     # TimeZone = "W. Europe Standard Time"
#     TimeZone          = "Central Standard Time"
#     Email             = "abdullah@canadacomputing.ca"
# }

# Set-AzVMAutoShutdown @setAzVMAutoShutdownSplat

#once I am back need to figure out the 
# Tags > Tags - done (has to be done at the resource level using the -Tag parameter or the -IPtags parameter)
# Disks > OSdisk -done
# Management > AutoShutdown - done
# Advanced > Generation - done
# Networking > NSG - done