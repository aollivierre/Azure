# Azure Infrastructure Automation Scripts

This repository contains a comprehensive collection of PowerShell scripts and automation tools designed for managing and deploying Azure infrastructure at scale. These scripts enable efficient management of various Azure resources, from VM deployments to VPN gateway configurations and storage management.

## Features

- Automated VM deployment with best practices
- VPN Gateway setup and configuration
- VHD migration tools
- Cross-VNet VM migration utilities
- Storage account management
- Azure Functions deployment
- Resource comparison tools
- Certificate management for Azure Key Vault
- VM lifecycle management
- Standardized resource tagging

## Repository Structure

### Core Components

#### VM Management (`New-AzVM/`)
- **VM Preparation (0-13)**: Prerequisites and environment setup scripts
- **Bastion Configuration (14)**: Secure access configuration
- **VM Creation (20)**: Automated VM deployment scripts
- **Disk Management (22)**: Storage and disk configuration utilities

#### Networking (`New-AZVPNGW/`)
- VPN Gateway deployment automation
- Connection configuration
- Route management
- Security policy implementation

#### Migration Tools
- **VHD Migration** (`Migrating_VHD_to_Azure/`): Streamlined VHD import process
- **Network Migration** (`Migrating_VM_VNETA-to_VNETB/`): Cross-VNet VM movement utilities

#### Storage Management (`Storage/`)
- Storage account lifecycle management
- Blob container operations
- File share management
- Access policy configuration

#### Authentication (`Establish_AZ_Account_Connection/`)
- Secure authentication workflows
- Connection management
- Session persistence handling

### Supporting Components

- **Azure Functions** (`Azure_Functions/`): Serverless automation scripts
- **Resource Comparison** (`Compare/`): Infrastructure analysis tools
- **Certificate Management** (`Import-AzPFXCertAzKeyvault/`): Key Vault certificate operations
- **VM Operations** (`Start-AzVM/`): VM lifecycle scripts
- **Resource Tagging** (`Tags Template/`): Standardized tagging templates

## Prerequisites

### Required Software
- PowerShell 5.1 or PowerShell 7.x
- Azure PowerShell Module (Az)
- Azure CLI (recommended)
- Git for version control

### Azure Requirements
- Active Azure subscription
- Appropriate RBAC permissions
- Service Principal (for automated deployments)

## Installation

1. Clone the repository:
   ```powershell
   git clone <repository-url>
   cd azure-infrastructure-automation
   ```

2. Install required PowerShell modules:
   ```powershell
   Install-Module -Name Az -Force -AllowClobber
   Install-Module -Name PSWriteHTML -Force
   ```

3. Configure Azure authentication:
   ```powershell
   Connect-AzAccount
   Set-AzContext -Subscription "<subscription-name>"
   ```

## Usage Guidelines

### VM Deployment

1. Navigate to the VM deployment directory:
   ```powershell
   cd New-AzVM
   ```

2. Follow the numbered sequence (0-22) for complete VM deployment:
   - Scripts 0-13: Environment preparation
   - Script 14: Bastion host setup
   - Script 20: VM deployment
   - Script 22: Disk configuration

### VPN Gateway Configuration

1. Access the VPN Gateway scripts:
   ```powershell
   cd New-AZVPNGW
   ```

2. Execute the deployment script with required parameters:
   ```powershell
   .\Deploy-AzVPNGateway.ps1 -ResourceGroupName "<rg-name>" -Location "<location>"
   ```

### Storage Management

1. Navigate to storage scripts:
   ```powershell
   cd Storage
   ```

2. Run storage account creation:
   ```powershell
   .\New-AzStorageAccount.ps1 -Name "<storage-name>" -ResourceGroupName "<rg-name>"
   ```

## Best Practices

### Security
- Use service principals with minimum required permissions
- Store credentials in Azure Key Vault
- Enable JIT VM access where applicable
- Implement network security groups with least-privilege access
- Use Azure Bastion for secure VM access

### Performance
- Implement proper resource sizing
- Use managed disks for VMs
- Enable diagnostic logging
- Implement proper backup strategies

### Maintenance
- Regularly update PowerShell modules
- Keep scripts version controlled
- Document any customizations
- Test in non-production environment first

## Troubleshooting

Common issues and solutions:

1. Authentication Failures
   - Verify Azure credentials
   - Check service principal permissions
   - Ensure correct subscription context

2. Deployment Errors
   - Review Azure activity logs
   - Check resource quota limits
   - Verify network connectivity

3. Performance Issues
   - Monitor resource utilization
   - Check for resource contention
   - Review diagnostic logs

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## Support

For support:
1. Check existing issues in the repository
2. Create a new issue with detailed information
3. Contact the repository maintainers
4. Review Azure documentation for specific services

## License

MIT License - See LICENSE file for details

## Disclaimer

These scripts are provided as-is with no warranty. Always test in a non-production environment first.