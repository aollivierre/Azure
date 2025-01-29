# $Helpers1 = "$PsScriptRoot"

# Get-ChildItem -Path $Helpers1 -Recurse -Filter '*.ps1' | ForEach-Object { . $_.FullName }

function New-IaaCAzVMWindows {
    [CmdletBinding()]
    param (

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]$LocationName,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]$CustomerName,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]$VMName,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]$ResourceGroupName,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]$datetime,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [hashtable]$Tags,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]$ComputerName,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$VMSize,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$OSDiskCaching,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$OSCreateOption,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$GUID,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$OSDiskName,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$ASGName,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$NSGName,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$DNSNameLabel,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$NICPrefix,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$NICName,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$IPConfigName,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$PublicIPAddressName,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$VnetName,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$SubnetName,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$PublicIPAllocation,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$VnetAddressPrefix, 
        # [Parameter(Mandatory = $true)]
        # [ValidateNotNullOrEmpty()]
        # [string]$SourceAddressPrefixCIDR,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$SubnetAddressPrefix,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$SourceAddressPrefix,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$PublisherName,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Offer,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Skus,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Version,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$DiskSizeInGB,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$ExtensionName,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$ExtensionPublisher,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$ExtensionType,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$TypeHandlerVersion,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$UsersGroupName,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$AdminsGroupName,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$RoleDefinitionNameUsers,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$RoleDefinitionNameAdmins,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Time,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$TimeZone,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Email,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]$secretLength

    )

    #Creating the Resource Group Name
    $newAzResourceGroupSplat = @{
        Name     = $ResourceGroupName
        Location = $LocationName
        Tag      = $Tags
    }

    New-AzResourceGroup @newAzResourceGroupSplat


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


    $getAzVirtualNetworkSubnetConfigSplat = @{
        Name           = $SubnetName
        VirtualNetwork = $vnet
    }
    
    $Subnet = Get-AzVirtualNetworkSubnetConfig @getAzVirtualNetworkSubnetConfigSplat


    $newAzNetworkInterfaceIpConfigSplat = @{
        Name                     = $IPConfigName
        Subnet                   = $Subnet
        PublicIpAddress          = $PIP
        ApplicationSecurityGroup = $ASG
        Primary                  = $true
    }
    
    $IPConfig1 = New-AzNetworkInterfaceIpConfig @newAzNetworkInterfaceIpConfigSplat

    #Creating the PublicIP for the VM
    $newAzPublicIpAddressSplat = @{
        Name              = $PublicIPAddressName
        DomainNameLabel   = $DNSNameLabel
        ResourceGroupName = $ResourceGroupName
        Location          = $LocationName
        AllocationMethod  = $PublicIPAllocation
        Tag               = $Tags
    }
    $PIP = New-AzPublicIpAddress @newAzPublicIpAddressSplat

    #Creating the Application Security Group
    $newAzApplicationSecurityGroupSplat = @{
        ResourceGroupName = "$ResourceGroupName"
        Name              = "$ASGName"
        Location          = "$LocationName"
        Tag               = $Tags
    }
    $ASG = New-AzApplicationSecurityGroup @newAzApplicationSecurityGroupSplat


    $newAzNetworkSecurityRuleConfigSplat = @{
        # Name = 'rdp-rule'
        Name                                = 'RDP-rule'
        # Description = "Allow RDP"
        Description                         = 'Allow RDP'
        Access                              = 'Allow'
        Protocol                            = 'Tcp'
        Direction                           = 'Inbound'
        Priority                            = 100
        SourceAddressPrefix                 = $SourceAddressPrefix
        # SourceAddressPrefixCIDR             = $SourceAddressPrefixCIDR
        SourcePortRange                     = '*'
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
        NetworkSecurityGroupId = $NSG.Id
        # ApplicationSecurityGroup = $ASG
        IpConfiguration        = $IPConfig1
        Tag                    = $Tags
    
    }
    $NIC = New-AzNetworkInterface @newAzNetworkInterfaceSplat


    #Define a credential object to store the username and password for the VM
    $VMLocalAdminPassword = Generate-Password -length $PassWordLength
    $VMLocalAdminSecurePassword = $VMLocalAdminPassword | ConvertTo-SecureString -Force -AsPlainText
    $Credential = New-Object PSCredential ($VMLocalAdminUser, $VMLocalAdminSecurePassword);
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
        Windows      = $true
        ComputerName = $ComputerName
        Credential   = $Credential
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
        PublisherName = $PublisherName
        Offer         = $Offer
        Skus          = $Skus
        Version       = $Version
    
    }
    $VirtualMachine = Set-AzVMSourceImage @setAzVMSourceImageSplat

    #Setting the VM OS Disk to the VM
    $setAzVMOSDiskSplat = @{
        VM           = $VirtualMachine
        Name         = $OSDiskName
        Caching      = $OSDiskCaching
        CreateOption = $OSCreateOption
        DiskSizeInGB = $DiskSizeInGB
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
        ResourceGroupName  = $ResourceGroupName
        Location           = $LocationName
        VMName             = $VMName
        Name               = $ExtensionName
        Publisher          = $ExtensionPublisher
        ExtensionType      = $ExtensionType
        TypeHandlerVersion = $TypeHandlerVersion
        # SettingString = $SettingsString
    }
    Set-AzVMExtension @setAzVMExtensionSplat


    #Post Deployment Configuration #2
    $UsersGroupName = $UsersGroupName
    #Store the Object ID in a var
    $ObjectID = (Get-AzADGroup -SearchString $UsersGroupName).ID
    #Store the Resource Type of the VM
    $vmtype = (Get-AzVM -ResourceGroupName $ResourceGroupName -Name $VMName).Type
    #Create a new AZ Role Assignment at the Azure RBAC Level for that VM for Standard users

    $NewAzRoleAssignmentParams = @{
        ObjectId           = $ObjectID
        RoleDefinitionName = $RoleDefinitionNameUsers
        ResourceGroupName  = $ResourceGroupName
        ResourceName       = $VMName
        ResourceType       = $vmtype
    }
    New-AzRoleAssignment @NewAzRoleAssignmentParams




    #Post Deployment Configuration #3
    $AdminsGroupName = $AdminsGroupName
    #Store the Object ID in a var
    $ObjectID = (Get-AzADGroup -SearchString $UsersGroupName).ID
    #Store the Resource Type of the VM
    $vmtype = (Get-AzVM -ResourceGroupName $ResourceGroupName -Name $VMName).Type
    #Create a new AZ Role Assignment at the Azure RBAC Level for that VM for Standard users
    
    $NewAzRoleAssignmentParams = @{
        ObjectId           = $ObjectID
        RoleDefinitionName = $RoleDefinitionNameAdmins
        ResourceGroupName  = $ResourceGroupName
        ResourceName       = $VMName
        ResourceType       = $vmtype
    }
    New-AzRoleAssignment @NewAzRoleAssignmentParams


    #Post Deployment Configuration #4
    $setAzVMAutoShutdownSplat = @{
        ResourceGroupName = $ResourceGroupName
        Name              = $VMName
        Enable            = $true
        Time              = $Time
        TimeZone          = $TimeZone
        Email             = $Email
    }

    Set-AzVMAutoShutdown @setAzVMAutoShutdownSplat



    #Give the user their VM Login Details
    Write-Host 'The VM is now ready.... here is your login details'
    Write-Host 'username:' $VMLocalAdminUser
    Write-Host 'Password:' $VMLocalAdminPassword
    Write-Host 'DNSName:' $DNSNameLabel
        

}
