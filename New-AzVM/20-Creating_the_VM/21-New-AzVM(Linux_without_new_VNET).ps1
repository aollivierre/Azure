$Helpers = "$PsScriptRoot\Helpers\"

Get-ChildItem -Path $Helpers -Recurse -Filter '*.ps1' | ForEach-Object { . $_.FullName }



##Global Parameters
$LocationName = 'CanadaCentral'
$CustomerName = 'FGCHealth_PROD'
$VMName = 'BCQB1'
$ResourceGroupName = -join ("$CustomerName", "_$VMName", "_RG")


##VM
$ComputerName = $VMName
# $VMSize = "Standard_B2MS"
$VMSize = "Standard_D2ds_v5"
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
$VnetName = 'ProductionVNET'
$SubnetName = 'InsideSubnet'
$PublicIPAllocation = 'Static'
# $VnetName = 'DtlFGC_Devtestlab'
# $SubnetName = 'DtlFGC_DevtestlabSubnet'


##Operating System
# $PublisherName = "OpenLogic"
# $Offer = "CentOS"
# $Skus = "8_2-gen2"
# $Version = "latest"


$PublisherName = "Canonical"
$Offer         = "0001-com-ubuntu-server-impish"
$Skus          = "21_10-gen2"
$Version       = "latest"

##Disk
# $DiskSizeInGB = '100'
$DiskSizeInGB = '32'


#Creating the Tag Hashtable for the VM
$datetime = [System.DateTime]::Now.ToString("yyyy_MM_dd_HH_mm_ss")
[hashtable]$Tags = @{

    "Autoshutown"       = 'OFF'
    "Createdby"         = 'Abdullah Ollivierre'
    "CustomerName"      = "$CustomerName"
    "DateTimeCreated"   = "$datetime"
    "Environment"       = 'Prod'
    "Application"       = 'QuickBooks-BusinessCentral'  
    "Purpose"           = 'Integration of Quick Books and Business Central'
    "Uptime"            = '10 hours by 31 days'
    "Commitment"        = 'NA'
    "Workload"          = 'QuickBooks-BusinessCentral'
    "VMGenenetation"    = 'Gen2'
    "RebootCaution"     = 'Schedule a maintenance window first before rebooting'
    "VMSize"            = "$VMSize"
    "Location"          = "$LocationName"
    "Requested By"      = 'Jacob Evans <jevans@fgchealth.com>'
    "Approved By"       = "Hamza Musaphir"
    "Approved On"       = "Feb 11, 2022 6:30 PM CST"
    "Ticket ID"         = "1519543"
    "CSP"               = "Canada Computing Inc."
    "Subscription Name" = "Microsoft Azure"
    "Subscription ID"   = "fef973de-017d-49f7-9098-1f644064f90d"
    "Tenant ID"         = "e09d9473-1a06-4717-98c1-528067eab3a4"

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

