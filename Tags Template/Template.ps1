$LocationName = 'CanadaCentral'
$CustomerName = 'FGCHealth'
$VMName = 'FGC-CR08NW2'
$ResourceGroupName = -join ("$CustomerName", "_$VMName", "_RG")


#Creating the Tag Hashtable for the VM
$datetime = [System.DateTime]::Now.ToString("yyyy_MM_dd_HH_mm_ss")
[hashtable]$Tags = @{

    "Autoshutown"     = 'OFF'
    "Createdby"       = 'Abdullah Ollivierre'
    "CustomerName"    = "$CustomerName"
    "DateTimeCreated" = "$datetime"
    "Environment"     = 'Dev/test lab'
    "Application"     = 'Kroll'  
    "Purpose"         = 'Kroll Server'
    "Uptime"          = '24/7'
    "Workload"        = 'Kroll Windows'
    "VMGenenetation"  = 'Gen2'
    "RebootCaution"   = 'Schedule a window first before rebooting'
    "VMSize"          = 'B8MS'
    "Location"        = "$LocationName"
    "Approved By"     = "Sandeep Vedula "
    "Approved On"     = "December 22 2020"
    "Ticket ID"         = "1516093"
    "CSP"               = "Canada Computing Inc."
    "Subscription Name" = "Microsoft Azure"
    "Subscription ID"   = "fef973de-017d-49f7-9098-1f644064f90d"
    "Tenant ID"         = "e09d9473-1a06-4717-98c1-528067eab3a4"

}

#Creating the Resource Group Name
$newAzResourceGroupSplat = @{
    Name = $ResourceGroupName
    Location = $LocationName
    Tag = $Tags
}

New-AzResourceGroup @newAzResourceGroupSplat