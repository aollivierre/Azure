function Invoke-Creds {
    #Region func Generate-Password
    #Define a credential object to store the username and password for the VM
    $VMLocalAdminPassword = Generate-Password -length 16
    $VMLocalAdminSecurePassword = $VMLocalAdminPassword | ConvertTo-SecureString -Force -AsPlainText
    # $Credential = New-Object System.Management.Automation.PSCredential ($VMLocalAdminUser, $VMLocalAdminSecurePassword);
    $Credential = New-Object PSCredential ($VMLocalAdminUser, $VMLocalAdminSecurePassword);


    # $Credential = Get-Credential
    #Creating the Cred Object for the VM
    # $Credential = New-Object System.Management.Automation.PSCredential ($VMLocalAdminUser, $VMLocalAdminSecurePassword);
    $Credential = Get-Credential
    #endRegion func Generate-Password
    
}

