#To Determine location
# Get-AzLocation | Out-HtmlView

$location = 'Canada Central'
$imageName = 'FGC_Kroll_Image'
$rgName = 'FGC_Kroll_Image_RG'
$Diskname = 'FGC_Kroll_Image_Disk'


$newAzDiskConfigSplat = @{
    # SkuName = 'Standard_LRS'
    SkuName = 'Premium_LRS'
    OsType = 'Windows'
    UploadSizeInBytes = $vhdSizeBytes
    Location = $location
    CreateOption = 'Upload'
    HyperVGeneration = 'V2'
}

$diskconfig = New-AzDiskConfig @newAzDiskConfigSplat

New-AzDisk -ResourceGroupName $rgName -DiskName $Diskname -Disk $diskconfig