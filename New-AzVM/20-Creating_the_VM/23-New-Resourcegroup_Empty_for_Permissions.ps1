$ErrorActionPreference = 'stop'

# #region dot sourcing
# $Helpers = "$PsScriptRoot\Helpers\"

# Get-ChildItem -Path $Helpers -Recurse -Filter '*.ps1' | ForEach-Object { . $_.FullName }
#endregion dot sourcing

#Region Param GLOBAL
$LocationName = 'CanadaCentral'
# $CustomerName = 'CanadaComputing'
$CustomerName = 'CCI'
$VMName = 'VEEAM_VPN_1'
$ResourceGroupName = -join ("$CustomerName", "_$VMName", "_RG")
#EndRegion Param GLOBAL

#Region Param Date
#Creating the Tag Hashtable for the VM
$datetime = [System.DateTime]::Now.ToString("yyyy_MM_dd_HH_mm_ss")
[hashtable]$Tags = @{

    "Autoshutown"     = 'ON'
    "Createdby"       = 'Abdullah Ollivierre'
    "CustomerName"    = "$CustomerName"
    "DateTimeCreated" = "$datetime"
    "Environment"     = 'Dev'
    "Application"     = 'Veeam PN/VEEAM VPN'  
    "Purpose"         = 'Testing VEEAM BACKUP over S2S tunnel or S2P tunnel'
    "Uptime"          = '16/7'
    "Workload"        = 'VEEAM BACKUP AND REPLICATION'
    "RebootCaution"   = 'Reboot any time'
    "VMSize"          = 'B2MS'
    "Location"        = "$LocationName"
    "Approved By"     = "Abdullah Ollivierre"
    "Approved On"     = "$datetime"
    "Used by"         = "Michael.P/Help Desk Admins"

}
#endRegion Param Date


#Region func New-AzResourceGroup
#Creating the Resource Group Name
$newAzResourceGroupSplat = @{
    Name     = $ResourceGroupName
    Location = $LocationName
    Tag      = $Tags
}


New-AzResourceGroup @newAzResourceGroupSplat
#endregion func New-AzResourceGroup
