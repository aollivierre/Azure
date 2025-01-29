# $VNETA = ''
# $VNETB = ''

# $ResourceGroupNameA = ''
# $ResourceGroupNameB = ''
# $VMName = ''
# $OSDiskName ''


# 1-Create a Recovery Services vault in the same region as your VM. - completed

# 2-Onboard the target VM to Recovery Services and initiate a manual backup.
# 2.1 Define a backup policy (a Recovery Services Vault comes with a default policy)
# 2.2 Apply the backup policy to protect multiple virtual machines
# 2.3 Trigger an on-demand backup job for the protected virtual machines Before you can back up (or protect) a virtual machine, you must complete the prerequisites to prepare your environment for protecting your VMs.

# 3-Ensure your target Vnet is ready to receive the VM.

# 4-Stop and deprovision the target VM.

# 5-Restore the backed-up VM to the target Vnet