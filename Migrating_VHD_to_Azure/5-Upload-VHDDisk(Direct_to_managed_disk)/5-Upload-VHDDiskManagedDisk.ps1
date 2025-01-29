# Upload a VHD
# Now that you have a SAS for your empty managed disk, you can use it to set your managed disk as the destination for your upload command.

# Use AzCopy v10 to upload your local VHD file to a managed disk by specifying the SAS URI you generated.

# This upload has the same throughput as the equivalent standard HDD. For example, if you have a size that equates to S4, you will have a throughput of up to 60 MiB/s. But, if you have a size that equates to S70, you will have a throughput of up to 500 MiB/s.



AzCopy.exe copy "c:\somewhere\mydisk.vhd" $diskSas.AccessSAS --blob-type PageBlob


# I used Azure Graph Explorer which is built on top of AzCopy
