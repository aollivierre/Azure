#region dot sourcing
$Helpers = "$PsScriptRoot\Helpers\"

Get-ChildItem -Path $Helpers -Recurse -Filter '*.ps1' | ForEach-Object { . $_.FullName }
#endregion dot sourcing

#Region Param
$LocationName = 'CanadaCentral'
# $CustomerName = 'CanadaComputing'
$CustomerName = 'CCI'
$VMName = 'TeamViewer'
$CustomerName = 'CanadaComputing'
$ResourceGroupName = -join ("$CustomerName", "_$VMName", "_RG")
#EndRegion Param


#Region Param
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
#endRegion Param

#Region VM Account param
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
#endRegion VM Account param

#Region Disk
# $OSDiskUri = "https://Mydisk.blob.core.windows.net/disks/MyOSDisk.vhd"
# $SourceImageUri = "https://Mydisk.blob.core.windows.net/vhds/MyOSImage.vhd"
#endRegion Disk

#Region Param
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
#endRegion Param

#Region PublicIP tag param
#Create the PublicIP tag
# $newAzPublicIpTagSplat = @{
    # IpTagType = "FirstPartyUsage"
    # Tag       = "/Sql"
# }

# $ipTag = New-AzPublicIpTag @newAzPublicIpTagSplat
#endRegion PublicIP tag param

#region $SourceAddressPrefix param
#Creating the NGS with default rules and 1 custom rule
#Define Rule #1

#SourceAddressPrefix
$SourceAddressPrefix = (Invoke-WebRequest -uri "http://ifconfig.me/ip").Content #Gets the public IP of the current machine
$SourceAddressPrefixCIDR = -join ("$SourceAddressPrefix", "/32")
#Description
# $NSGRuleDescritption = Invoke-RestMethod -Uri ('http://ipinfo.io/'+(Invoke-WebRequest -uri "http://ifconfig.me/ip").Content) #this can not exceed 140 chars

# $DestinationAddressPrefixCIDR = -join ("$PIP", "/32") if you want to use this with the $PIP var then the $PIP has to be static not Dynamic other wise the the IP won't be allocated
#endregion $SourceAddressPrefix param

#Region func Set-AzVMAutoShutdown
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
#endRegion func Set-AzVMAutoShutdown

#region to-do
#once I am back need to figure out the 
# Tags > Tags - done (has to be done at the resource level using the -Tag parameter or the -IPtags parameter)
# Disks > OSdisk -done
# Management > AutoShutdown - done
# Advanced > Generation - done
# Networking > NSG - done
#endregion to-do

#region output
#Give the user their VM Login Details
Write-Host 'The VM is now ready.... here is your login details'
Write-Host 'username:' $VMLocalAdminUser
Write-Host 'Password:' $VMLocalAdminPassword
Write-Host 'DNSName:' $DNSNameLabel
#endregion output