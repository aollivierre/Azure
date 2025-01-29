$Helpers = "$PsScriptRoot\Helpers\"

Get-ChildItem -Path $Helpers -Recurse -Filter '*.ps1' | ForEach-Object { . $_.FullName }

$LocationName = 'CanadaCentral'
# $CustomerName = 'CanadaComputing'
# $CustomerName = 'CCI'
$VMName = 'TeamViewer'
$CustomerName = 'CanadaComputing'
$ResourceGroupName = -join ("$CustomerName", "_$VMName", "_RG")


#Creating the Tag Hashtable for the VM
$datetime = [System.DateTime]::Now.ToString("yyyy_MM_dd_HH_mm_ss")
[hashtable]$Tags = @{

    "Autoshutown"     = 'ON'
    "Createdby"       = 'Abdullah Ollivierre'
    "CustomerName"    = "$CustomerName"
    "DateTimeCreated" = "$datetime"
    "Environment"     = 'Production'
    "Application"     = 'TeamViewer'  
    "Purpose"         = 'TeamViewer'
    "Uptime"          = '24/7'
    "Workload"        = 'WinSCP'
    "RebootCaution"   = 'Schedule a window first before rebooting'
    "VMSize"          = 'B2MS'
    "Location"        = "$LocationName"
    "Approved By"     = "Abdullah Ollivierre"
    "Approved On"     = ""

}

#Creating the Resource Group Name
$newAzResourceGroupSplat = @{
    Name = $ResourceGroupName
    Location = $LocationName
    Tag = $Tags
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
$VMSize = "Standard_B2MS"
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
$NetworkName = -join ("$VMName", "_group-vnet")

# $NICName = "MyNIC"
# $NICPrefix = ( Get-Random -Minimum 0 -Maximum 999 ).ToString('000')
$NICPrefix = 'NIC1'
$NICName = -join ("$VMName", "_$NICPrefix").ToLower()
$IPConfigName = -join ("$VMName", "$NICName", "_IPConfig1").ToLower()

# $PublicIPAddressName = "MyPIP"
$PublicIPAddressName = -join ("$VMName", "-ip")

# $SubnetName = "MySubnet"
$SubnetName = -join ("$VMName", "-subnet")
$SubnetAddressPrefix = "10.0.0.0/24"
$VnetAddressPrefix = "10.0.0.0/16"

#Defining the NGS name
$NSGName = -join ("$VMName", "-nsg")

#Creating the Subnet for the VM
$newAzVirtualNetworkSubnetConfigSplat = @{
    Name          = $SubnetName
    AddressPrefix = $SubnetAddressPrefix
}
$SingleSubnet = New-AzVirtualNetworkSubnetConfig @newAzVirtualNetworkSubnetConfigSplat

#Creating the VNET for the VM
$newAzVirtualNetworkSplat = @{
    Name              = $NetworkName
    ResourceGroupName = $ResourceGroupName
    Location          = $LocationName
    AddressPrefix     = $VnetAddressPrefix
    Subnet            = $SingleSubnet
    Tag               = $Tags
}
$Vnet = New-AzVirtualNetwork @newAzVirtualNetworkSplat


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
$SourceAddressPrefix = (Invoke-WebRequest -uri "http://ifconfig.me/ip").Content #Gets the public IP of the current machine
$SourceAddressPrefixCIDR = -join ("$SourceAddressPrefix", "/32")
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
    Name = $SubnetName
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

$newAzNetworkSecurityRuleConfigSplat = @{
    # Name = 'rdp-rule'
    Name                                = 'RDP-rule'
    # Description = "Allow RDP"
    Description                         = 'Allow RDP'
    Access                              = 'Allow'
    Protocol                            = 'Tcp'
    Direction                           = 'Inbound'
    Priority                            = 100
    SourceAddressPrefix                 = $SourceAddressPrefixCIDR
    SourcePortRange                     = '*'
    # DestinationAddressPrefix = '*'
    # DestinationAddressPrefix = $DestinationAddressPrefixCIDR #this will throw an error due to {Microsoft.Azure.Commands.Network.Models.PSPublicIpAddress/32} work on it some time to fix 
    # DestinationAddressPrefix = '*'
    # DestinationPortRange = 3389
    DestinationPortRange                = '3389'
    DestinationApplicationSecurityGroup = $ASG
}
$rule1 = New-AzNetworkSecurityRuleConfig @newAzNetworkSecurityRuleConfigSplat

#Create a new NSG based on Rules #1 & #2
$newAzNetworkSecurityGroupSplat = @{
    ResourceGroupName = $ResourceGroupName
    Location          = $LocationName
    Name              = $NSGName
    # SecurityRules     = $rule1, $rule2
    SecurityRules     = $rule1
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

#Define a credential object to store the username and password for the VM
$VMLocalAdminPassword = Generate-Password -length 16
$VMLocalAdminSecurePassword = $VMLocalAdminPassword | ConvertTo-SecureString -Force -AsPlainText
# $Credential = New-Object System.Management.Automation.PSCredential ($VMLocalAdminUser, $VMLocalAdminSecurePassword);
$Credential = New-Object PSCredential ($VMLocalAdminUser, $VMLocalAdminSecurePassword);

# $Credential = Get-Credential
#Creating the Cred Object for the VM
# $Credential = New-Object System.Management.Automation.PSCredential ($VMLocalAdminUser, $VMLocalAdminSecurePassword);
$Credential = Get-Credential

#Creating the VM Config Object for the VM
$newAzVMConfigSplat = @{
    VMName = $VMName
    VMSize = $VMSize
    Tags   = $Tags
    IdentityType = 'SystemAssigned'
}
$VirtualMachine = New-AzVMConfig @newAzVMConfigSplat

#Creating the OS Object for the VM
$setAzVMOperatingSystemSplat = @{
    VM           = $VirtualMachine
    Windows      = $true
    # Linux        = $true
    ComputerName = $ComputerName
    Credential   = $Credential
    ProvisionVMAgent = $true
    # EnableAutoUpdate = $true
    
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
    # PublisherName = "Canonical"
    # Offer         = "0001-com-ubuntu-server-focal"
    # Skus          = "20_04-lts-gen2"
    # Version       = "latest"
    publisherName = "MicrosoftWindowsDesktop"
    offer         = "office-365"
    Skus          = "20h2-evd-o365pp"
    version       = "latest"


    # publisherName = "MicrosoftWindowsServer"
    # offer         = "WindowsServer"
    # Skus          = "2019-datacenter-gensecond"
    # version       = "latest"



    # Caching = 'ReadWrite'
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
    DiskSizeInGB = '128'
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


#Post Deployment Configuration #1

$setAzVMExtensionSplat = @{
    ResourceGroupName = $ResourceGroupName
    Location = $LocationName
    VMName = $VMName
    Name = "AADLoginForWindows"
    Publisher = "Microsoft.Azure.ActiveDirectory"
    ExtensionType = "AADLoginForWindows"
    TypeHandlerVersion = "1.0"
    # SettingString = $SettingsString
}
Set-AzVMExtension @setAzVMExtensionSplat



#Post Deployment Configuration #2
$UsersGroupName = "Azure VM - Standard User"
#Store the Object ID in a var
$ObjectID = (Get-AzADGroup -SearchString $UsersGroupName).ID
#Store the Resource Type of the VM
$vmtype = (Get-AzVM -ResourceGroupName $ResourceGroupName -Name $VMName).Type
#Create a new AZ Role Assignment at the Azure RBAC Level for that VM for Standard users
New-AzRoleAssignment -ObjectId $ObjectID -RoleDefinitionName 'Virtual Machine User Login' -ResourceGroupName $ResourceGroupName -ResourceName $VMName -ResourceType $vmtype


#Post Deployment Configuration #3
$AdminsGroupName = "Azure VM - Admins"
#Store the Object ID in a var
$ObjectID = (Get-AzADGroup -SearchString $AdminsGroupName).ID
#Store the Resource Type of the VM
$vmtype = (Get-AzVM -ResourceGroupName $ResourceGroupName -Name $VMName).Type
#Create a new AZ Role Assignment at the Azure RBAC Level for that VM for Admins
New-AzRoleAssignment -ObjectId $ObjectID -RoleDefinitionName 'Virtual Machine Administrator Login' -ResourceGroupName $ResourceGroupName -ResourceName $VMName -ResourceType $vmtype



#Post Deployment Configuration #4
$setAzVMAutoShutdownSplat = @{
    # ResourceGroupName = 'RG-WE-001'
    ResourceGroupName = $ResourceGroupName
    # Name              = 'MYVM001'
    Name              = $VMName
    Enable            = $true
    Time              = '23:59'
    # TimeZone = "W. Europe Standard Time"
    TimeZone          = "Central Standard Time"
    Email             = "abdullah@canadacomputing.ca"
}

Set-AzVMAutoShutdown @setAzVMAutoShutdownSplat

#once I am back need to figure out the 
# Tags > Tags - done (has to be done at the resource level using the -Tag parameter or the -IPtags parameter)
# Disks > OSdisk -done
# Management > AutoShutdown - done
# Advanced > Generation - done
# Networking > NSG - done






#Give the user their VM Login Details
Write-Host 'The VM is now ready.... here is your login details'
Write-Host 'username:' $VMLocalAdminUser
Write-Host 'Password:' $VMLocalAdminPassword
Write-Host 'DNSName:' $DNSNameLabel