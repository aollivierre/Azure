# $location = 'Canada Central'
# $imageName = 'FGC_Kroll_Image1'
# $rgName = 'FGC_Kroll_Image_RG'
# $Diskname = 'Kroll_Image_ManagedDisk_VHD_Fixed_Resized_274877906944bytes_OOBE'



$vmName = "FGC-CR08NW2-MIG"
$rgName = "FGC_AVD_RG1"
$location = "canadacentral"
$imageName = "FGC-CR08NW2-AVD-Nerdio-image-v1"



$vm = Get-AzVm -Name $vmName -ResourceGroupName $rgName


$diskID = $vm.StorageProfile.OsDisk.ManagedDisk.Id

# $disk = Get-AzDisk -ResourceGroupName $rgName -DiskName $Diskname


$imageConfig = New-AzImageConfig -Location $location
$setAzImageOsDiskSplat = @{
    Image = $imageConfig
    OsState = 'Generalized'
    # OsState = 'Specialized'
    OsType = 'Windows'
    # ManagedDiskId = $disk.Id
    ManagedDiskId = $diskID
}

$imageConfig = Set-AzImageOsDisk @setAzImageOsDiskSplat


$newAzImageSplat = @{
    ImageName = $imageName
    ResourceGroupName = $rgName
    Image = $imageConfig
}

$image = New-AzImage @newAzImageSplat