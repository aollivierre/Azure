# Then the full URL can be generated as explained here.


$StorageAccountName = "outlook1restoredsa"
$StorageAccountResourceGroupName = "CanPrintEquip_Outlook1Restored_RG"
# $TargetResourceGroupName = "CanPrintEquip_Outlook1Restored_RG"

$setAzCurrentStorageAccountSplat = @{
    Name              = $storageAccountName
    ResourceGroupName = $StorageAccountResourceGroupName
}

Set-AzCurrentStorageAccount @setAzCurrentStorageAccountSplat


$newAzStorageBlobSASTokenSplat = @{
    Container  = $containerName
    Permission = 'r'
    FullUri    = $true
    Blob = $Templatename
}

$templateBlobFullURI = New-AzStorageBlobSASToken @newAzStorageBlobSASTokenSplat
$templateBlobFullURI