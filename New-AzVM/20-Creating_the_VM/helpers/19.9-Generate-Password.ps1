function Generate-Password {
    [CmdletBinding()]
    param (

        [Parameter(Mandatory = $true, Position = 0)]
        [int] $length
        # [Parameter(Mandatory = $false, Position = 1)]
        # [string] $OrgName
    )
    
    begin {

        $O365Password = @()
        $lengthdivided = $length/4
        function Get-RandomCharacters($length, $characters) {
            $randomrange = 1..$length 
            $random = foreach ($singlerandomrange in $randomrange) {
                Get-Random -Maximum $characters.length
            }
            $private:ofs = ""
            return [String]$characters[$random]
            # return $characters[$random]
        }
         
        function Scramble-String([string]$inputString) {     
            $characterArray = $inputString.ToCharArray()   
            $scrambledStringArray = $characterArray | Get-Random -Count $characterArray.Length     
            # $outputString = -join $scrambledStringArray
            $outputString = (-join $scrambledStringArray).Replace(" ", "")
            return $outputString
        }
         
        $password = @()
        $Multicharacterlist = @(
            "abcdefghiklmnoprstuvwxyz",
            "ABCDEFGHKLMNOPRSTUVWXYZ",
            "1234567890"
            '`~!@#$%^&*()_+-={}|[]\:";<>?,.'
        )

        $MultiPasswordrandom = foreach ($SingleCharacterlist in $Multicharacterlist) {
            Get-RandomCharacters -length $lengthdivided -characters $SingleCharacterlist
        }

        $password = Scramble-String $MultiPasswordrandom
        
    }
    
    process {

        try {
            # Write-Host $password -ForegroundColor Green
            $length = $password.length
            # Write-Host "Generating an O365 Password of length" $length -ForegroundColor Green
            $Script:O365Password = $password
            # $password | Out-File -FilePath "C:\1.txt"
            # $password
        }
        catch {

            Write-Host "A Terminating Error (Exception) happened" -ForegroundColor Magenta
            Write-Host "Displaying the Catch Statement ErrorCode" -ForegroundColor Yellow
            Write-host $PSItem -ForegroundColor Red
            $PSItem
            Write-host $PSItem.ScriptStackTrace -ForegroundColor Red
            
        }
        finally {

            # Write-Host "Displaying the Final Statement" -ForegroundColor Green
            
        }
        
    }
    
    end {

        return $password

      
        
    }
}


#! If you are using 256 passwords then you need to reset the password from the admin center or from powershell 
#! the login at portal.office.com won't work with 256 passwords 
# Generate-Password -length 16