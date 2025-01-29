# if ($PSVersionTable.PSEdition -eq 'Desktop' -and (Get-Module -Name AzureRM -ListAvailable)) {
#     Write-Warning -Message ('Az module not installed. Having both the AzureRM and ' +
#       'Az modules installed at the same time is not supported.')
# } else {
#     Install-Module -Name 'Az' -AllowClobber -Scope AllUsers -force
#     Import-Module -Name 'Az' -Verbose -Force
# Get-Module -Name 'Az'-ListAvailable | Select-object Name, Version, Modulebase
# }

Import-Module 'PartnerCenter'

$TenantID_3001 = $null
# $TenantID_3001 = "dc3227a4-53ba-48f1-b54b-89936cd5ca53" #Canada Computing Tenant ID
$TenantID_3001 = "e09d9473-1a06-4717-98c1-528067eab3a4" #FGC Health Tenant ID

$RefreshToken_3001 = $null
$RefreshToken_3001 = "0.ARcApCcy3LpT8Ui1S4mTbNXKU0biMg2kdDBJrz9JcmUtdbsXAB8.AgABAAAAAAB2UyzwtQEKR7-rWbgdcBZIAQDs_wIA9P9pUxrVuXTg2zH4nC-eDuKt76Y8r544qqPu0Jw1DRa6Szg_xUeEDmiDPA64kaWOq8yW4evU8al0GB0h877MvgrTPpMPJMmE5FnOEz2VQNmwMia9uxNmUVwZyAyziJOIiPYH0sji3IBN0T3jRVww39_sylhbomngbZVMlEI3SyjU82UYxte4IIGR8Xvy6E8V7HPkYiVrG92mbJaSwGOaoX3Mjda3IqF4ZtdZrEXV-EhCG3Og78CtaTBBNKAyxhBb_owYceDIFfcV4W3PEZtzFNPQBZOscZrd31ojm8Nbcje-s1pHEZIyDuqba_2rcfJ7P0tGZnb-BGskwoGjhrf8uZEY50EyWiBG4D-E4Bhy4msNL19SHzEqd_WhvyNcCRJbGaI6eFBB7q81F0JQO_TTPoXlgmSeszCyBUyBPp8-R_kpshlZLrgdSVo1aARYdT1tuds635TNZa6IVfeE0f9QssIpb-dSw_kp3TEv5ijzYTEqPIZVHQWKROfZd3sDRaIjRgYDLbS50LiUU-G7xAtx2ATleDzLahpnMTCscIInmLJcE9NyFPixF3yamvTWkcXTAx9Ghn6XhnKsEZA15kjoAzK4s6NDGoL8M8Uaf4mYM_vMB42z1roksREn6GAAJ_5wjOeDSdBAHRaDn1_4BJ_FYX_eoAl8eeoqDejBRLtEOM7HrmtxHV-9aZjmw2C5TjJOUdOKOuZApBQ_p6Do01bhbjSO57ZCo6737sn0fv7zjCFkEKth1yu-JBXKcWqfvAdAAHWHIl4AwIB2XOjjlck6j5Am9YuwC2W9nEyGIqYO-3bGDz0-PmADXzqsr2xguVPrd1jRMyTvWNcocN7XT0KhgQDOJtybwmm4vfZXZzk76aVBPCtDE2LCBl_-CGC097VbNus2EFtZlQTjXhFAHOsxo9JEKm2vgnHv8dd3gtvV5yRZ2iYfqjs0hRtiZX1sjkluqey4rmZNuCrCY-K2o7hkMP_cDuPTik0UuFPBgNN7SJAQYipUp-_KdknxgmeAkhu-iNkIgiDnZ_ZLUj2vFa6giKlxiPKEHhSI1UtflQWhPPn4BZjdKurkIGhkHto7aJ3-IRKq1X_G6fTvvCNNLMxY-9m8LzExrHo82keOXw" #PSAutomation_M365SecureApp1
# $RefreshToken_3001 = "0.AAAAc5Sd4AYaF0eYwVKAZ-qzpPPZ5j5EVZhGnpmbveZ5Ar5RABQ.AgABAAAAAAB2UyzwtQEKR7-rWbgdcBZIAQDs_wIA9P8QXXpf7S8Gpw5rCAmtTIegsFYGRzlTqdqABXoXh8NqUWADlo3W02UA96MN5dV7Fz4dfT7fUTJtLey8aL1r3QetkBjPyxjZK_MUkyYVjeHVZO3hYd-TP9duomTwHwBkdjFMeKJHqdRsZi9LgSFVxVb_lmbGG_tx-3gxiBKF8DRcA_sCDVNR4Tr4UiaDPUYHhkVxD67T1sJvX5xpRnXteRudLULYSbv9JbUpd41_NhLtFI6TaBWlxIRP_3P8l4cmx7C9EXYd-HdDMPv5MjM8ficMrBT3B2hhvrld6vt6rdi6u7ZBM0gtdY8FboX5_i_TU87ocCkAwm3ulzfq6N2bIMR_wqH68MaiVgiilmx53SGNcbqnpRO-2zIoUYqKn2gWK9GsKZ7hzpnXzuayUEeHUUZbDe1t1t_qWzsvjoAul-tWRu3w-TfojoxLEbJPjwfre67gY_ECFphCq3POUMYPfkj7-rHYYfgfJeXIDWcX2iRm9owiqHFxO08j0NTfvQnnpncNpk5OifKGbLmfCJHRr7hYX8MVf-bhfwWvfBGgC2NfwyZ-Pmo8eJc2wJ3-yqRm_Ny-VSIkudL-2rJZiIsOtnu52OK2BVbP_c_M_A-8CHh0lgoVKRxL0Uhxd8U_EBfB-FIisIri5us9N0Oply3EGPGNRvA6Hn5vTY1hYvAnhfOln_4sSg6HMn-XTaRoQfUK-7O3ynMoN6W9gAZV8MmRQB-fitOUveq7hROuQyAceHud90RVep-jPoYPhvYzxunoa99Eu9mLyO_EJ7iUBoeOXLZHhSeYeChgTCo1nkGZWRKQQWcLi4RMJxahDnhseMjdVttTrVOvE9pdL63GJUafmjVWESxOS-w44_wUaugaTVfW4YWW-HSdWIJU-MSg7ENyQk0_m54qG0OF49UxKFUkAt9G_PmSVlGp6ooVYlOkj8W7heqgncY_TVLDRGjh2Jgu_w7-ZIq1KhUYxA-F48Z7F6ZT-68cUwgErjIYHku7mOxffhqefbyN-3tnbv_uHB1ilNqJU5_muIpXdwzgxXCvnAveBuB0165QFZ9DUQ_W89wPj5rnIt6w-6Raxw" #FGC_PSAutomation_M365SecureApp1

#you will get the following error with the FGC Refresh token but not with the CCI refresh toke

# New-PartnerAccessToken : A configuration issue is preventing authentication - check the error message from the server for details.You can modify the 
# configuration in the application registration portal. See https://aka.ms/msal-net-invalid-client for details.  Original exception: AADSTS7000215: Invalid 
# client secret is provided.
# Trace ID: 46af93fa-00cb-4854-8666-e14b39c92801
# Correlation ID: 3ca39009-fc4f-4f76-9b82-ed9f0fa8a319
# Timestamp: 2020-12-08 14:23:14Z
# At C:\Users\Abdullah.Ollivierre\AzureRepos2\Azure\Connect-AzAccount\connect-Az_Secure_App_model.ps1:38 char:20
# + ... oken_3001 = New-PartnerAccessToken @newPartnerAccessTokenSplat_azureT ...
# +                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#     + CategoryInfo          : CloseError: (:) [New-PartnerAccessToken], MsalServiceException
#     + FullyQualifiedErrorId : Microsoft.Store.PartnerCenter.PowerShell.Commands.NewPartnerAccessToken

# New-PartnerAccessToken : A configuration issue is preventing authentication - check the error message from the server for details.You can modify the 
# configuration in the application registration portal. See https://aka.ms/msal-net-invalid-client for details.  Original exception: AADSTS7000215: Invalid 
# client secret is provided.
# Trace ID: 0b7a5fec-9e3a-4315-ad92-1dd40c3d3f01
# Correlation ID: 64964643-2353-45b3-9214-6aff758f9431
# Timestamp: 2020-12-08 14:23:14Z
# At C:\Users\Abdullah.Ollivierre\AzureRepos2\Azure\Connect-AzAccount\connect-Az_Secure_App_model.ps1:53 char:20
# + ... oken_3001 = New-PartnerAccessToken @newPartnerAccessTokenSplat_graphT ...
# +                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#     + CategoryInfo          : CloseError: (:) [New-PartnerAccessToken], MsalServiceException
#     + FullyQualifiedErrorId : Microsoft.Store.PartnerCenter.PowerShell.Commands.NewPartnerAccessToken

# Connect-AzAccount : Cannot validate argument on parameter 'GraphAccessToken'. The argument is null or empty. Provide an argument that is not null or       
# empty, and then try the command again.
# At C:\Users\Abdullah.Ollivierre\AzureRepos2\Azure\Connect-AzAccount\connect-Az_Secure_App_model.ps1:64 char:19
# + Connect-AzAccount @connectAzAccountSplat_3001
# +                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~
#     + CategoryInfo          : InvalidData: (:) [Connect-AzAccount], ParameterBindingValidationException
#     + FullyQualifiedErrorId : ParameterArgumentValidationError,Microsoft.Azure.Commands.Profile.ConnectAzureRmAccountCommand

$AccountId_3001 = $null
$AccountId_3001 = 'Abdullah@canadacomputing.ca'

$Appcredential_3001 = $null
$Appcredential_3001 = Get-Credential

# $credential = Get-Credential
# $refreshToken = '<RefreshToken>'

$newPartnerAccessTokenSplat_azureToken_3001 = $null
$newPartnerAccessTokenSplat_azureToken_3001 = @{
    ApplicationId    = $Appcredential_3001.UserName
    Credential       = $Appcredential_3001
    RefreshToken     = $RefreshToken_3001 #comment out if you are usnig the UseAuthorizationCode parameter
    Scopes           = 'https://management.azure.com/user_impersonation'
    ServicePrincipal = $true
    Tenant           = $TenantID_3001
    # UseAuthorizationCode = $true #use only the first time to provide consent if you get a consent error
}

$azuretoken_3001 = $null
$azuretoken_3001 = New-PartnerAccessToken @newPartnerAccessTokenSplat_azureToken_3001


$newPartnerAccessTokenSplat_graphToken_3001 = $null
$newPartnerAccessTokenSplat_graphToken_3001 = @{
    ApplicationId    = $Appcredential_3001.UserName
    Credential       = $Appcredential_3001
    RefreshToken     = $RefreshToken_3001
    Scopes           = 'https://graph.windows.net/.default'
    ServicePrincipal = $true
    Tenant           = $TenantID_3001
    # UseAuthorizationCode = $true #use only the first time to provide consent if you get a consent error
}

$graphToken_3001 = $null
$graphToken_3001 = New-PartnerAccessToken @newPartnerAccessTokenSplat_graphToken_3001

# Az Module
$connectAzAccountSplat_3001 = $null
$connectAzAccountSplat_3001 = @{
    AccessToken      = $azuretoken_3001.AccessToken
    AccountId        = $AccountId_3001
    GraphAccessToken = $graphToken_3001.AccessToken
    Tenant           = $TenantID_3001
}

Connect-AzAccount @connectAzAccountSplat_3001



# When connecting to an environment where you have admin on behalf of privileges, you will need to specify the tenant identifier for the target environment through the Tenant parameter. With respect to the Cloud Solution Provider program this means you will specify the tenant identifier of the customer's Azure Active Directory tenant using the Tenant parameter.

