#! All commands are case sensitive for example status works but Status does NOT work

# git config --global user.email "Abdullah@canadacomputing.ca"
# git config --global user.name "Abdullah Ollivierre"

& "C:\Program Files\Git\mingw64\bin\git.exe" status
& "C:\Program Files\Git\mingw64\bin\git.exe" fetch

& "C:\Program Files\Git\mingw64\bin\git.exe" add -A

$commit_message = $null
$commit_message = Read-Host -Prompt 'Please enter commit message'

& "C:\Program Files\Git\mingw64\bin\git.exe" commit -m $commit_message
# & "C:\Program Files\Git\mingw64\bin\git.exe" push -u origin master #(or the name of your branch instead of master)
& "C:\Program Files\Git\mingw64\bin\git.exe" push

& "C:\Program Files\Git\mingw64\bin\git.exe" pull