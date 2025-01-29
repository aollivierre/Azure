$properties = $details.properties
$properties

$storageAccountName = $properties["Target Storage Account Name"]
$storageAccountName

$containerName = $properties["Config Blob Container Name"]
$containerName

$templateBlobURI = $properties["Template Blob Uri"]
$templateBlobURI

# $Templatename = $templateBlobURI -split ("https://<$storageAccountName.blob.core.windows.net>/<$containerName>/")
$Templatename = $templateBlobURI -split ("/")
$Templatename = $Templatename[4]
$Templatename
# https://<storageAccountName.blob.core.windows.net>/<containerName>/<templateName>