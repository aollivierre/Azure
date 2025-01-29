<#
.SYNOPSIS
    Short description
.DESCRIPTION
    Long description
.EXAMPLE
    PS C:\> <example usage>
    Explanation of what the example does
.INPUTS
    Inputs (if any)
.OUTPUTS
    Output (if any)
.NOTES
    General notes
#>




# New-AzureADUser -DisplayName "<display name>" -GivenName "<first name>" -SurName "<last name>" -UserPrincipalName <sign-in name> -UsageLocation <ISO 3166-1 alpha-2 country code> -MailNickName <mailbox name> -PasswordProfile $PasswordProfile -AccountEnabled $true



$PasswordProfile=New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
$PasswordProfile.Password="Default1234"

New-AzureADUser -DisplayName "testAzFuncPSUserDisplayName" -GivenName "testAzFuncPSUserGivenName" -SurName "testAzFuncPSUsersurname" -UserPrincipalName 'testAzFuncPSUser@canadacomputing.ca' -UsageLocation 'CA' -MailNickName 'testAzFuncPSUser' -PasswordProfile $PasswordProfile -AccountEnabled $true
