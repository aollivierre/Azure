#Firs install Hyper-V role on the Windows 10 or the Windows Server on-premise (this is the full feature name which will include Microsoft-Hyper-V-Management-PowerShell)
DISM /Online /Enable-Feature /All /FeatureName:Microsoft-Hyper-V




#Enable Hyper-V on a VM in Ezure to Sysprep the VHD file
# DISM /Online /Enable-Feature /All /FeatureName:Microsoft-Hyper-V
# DISM /Online /Enable-Feature /All /FeatureName:Microsoft-Hyper-V-Management-PowerShell


Get-WindowsOptionalFeature -Online -FeatureName *hyper-v* | Select-Object DisplayName, FeatureName

# Install only the PowerShell module
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-Management-PowerShell

# Install the Hyper-V management tool pack (Hyper-V Manager and the Hyper-V PowerShell module)
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-Tools-All

# Install the entire Hyper-V stack (hypervisor, services, and tools)
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All