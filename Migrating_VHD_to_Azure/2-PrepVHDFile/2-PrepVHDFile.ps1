# The values in the column below is what you should set your sizeBytes parameter to !AFTER Converting the VHD from Dynamic to Fixed
	
# GiB	Byte (Valid Values in Azure Multiples of GiB)
# 128	= 137438953472
# 256	= 274877906944
# 512	= 549755813888
# 1024	= 1099511627776
# 2048	= 2199023255552
# 4096	= 4398046511104



#Restart your machine to apply new Hyper-V role

#Convert your VHD to Fixed size instead of Dynamic (you must do this) and also convert from VHDX to VHD
Convert-VHD -Path filepathtoyourDynamicVHDorVHDX.VHDX file  -DestinationPath destinationfileofnewVHD.VHD -VHDType Fixed

#Verify the Size of your FIXED SIZE VHD BEFORE RESIZING (not file size) the filesize will always be equal to Size + 512 Bytes (automatically you do not need to add 512 Bytes)
Get-VHD -Path 'PathtoYourFixedSized.VHD' | Select-Object *          

#Now the magical Resize Command which requires Hyper-V to be installed                                 
Resize-VHD -Path 'PathtoYourFixedSized.VHD' -SizeBytes '274877906944' #for a 256 GiB Disk

#Verify the Size BEFORE RESIZING (not file size) the filesize will always be equal to Size + 512 Bytes (automatically you do not need to add 512 Bytes)
Get-VHD -Path 'PathtoYourFixedSized.VHD' | Select-Object * 

#Examples Below

$VHDfile = 'E:\FGC_Kroll_Lab_P2V_Clone_VHD_to_Azure\FGC-CR08NW2.VHD'
$vhdSizeBytes = (Get-Item $VHDfile).length


# The values in the column below is what you should set your sizeBytes parameter to !AFTER Converting the VHD from Dynamic to Fixed
	
# GiB	Byte
# 128	= 137438953472
# 256	= 274877906944
# 512	= 549755813888
# 1024	= 1099511627776
# 2048	= 2199023255552
# 4096	= 4398046511104


Resize-VHD -Path 'D:\FGC_Kroll_Lab_P2V_Clone_VHD_to_Azure\FGC-CR08NW2_fixed.VHD' -SizeBytes '274877906944'

#Verify the new Size (not file size) the filesize will be equal to Size + 512 Bytes 
Get-VHD -Path 'D:\FGC_Kroll_Lab_P2V_Clone_VHD_to_Azure\FGC-CR08NW2_fixed.VHD' | Select-Object * 


#Sysprep.exe running while being logged in to the VM (so you need to create a VM on-premises Hyper-V)
$Script:SYS_ENV_SYSDIRECTORY = $null
$Script:SYS_ENV_SYSDIRECTORY = [System.Environment]::SystemDirectory


write-host "Starting Sysprep with OOBE"
& $SYS_ENV_SYSDIRECTORY\sysprep\sysprep.exe /generalize /reboot /oobe

# C:\windows\system32\sysprep\sysprep.exe


Get-AppxPackage -AllUsers *HP* | Remove-AppxPackage -AllUsers #the AllUsers parameter is important to show the app in all users




