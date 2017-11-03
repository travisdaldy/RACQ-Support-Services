Install-Module PSAlphaFS
#$path = "\\pempcrfile4001\COMPRO-Tourism & Entertainment\"
Net Use x: "\\pempcrfile4001\COMPRO-Tourism & Entertainment" #$path
#$path = "\\racqgroup\Deploy\LDMS\Driver Packages\Microsoft\Surface Pro 3 Win8 x64"

#$files = gci '\\racqgroup\deploy\LDMS\Applications\RACQ\Doc Center' -recurse | where  {-not $_.psiscontainer}
#$files = gci '\\racqgroup\deploy\LDMS\Applications\Mitsubishi\ASA\2_SourceFiles\DVD2' -recurse | where  {-not $_.psiscontainer}
$files = Get-LongChildItem -Path X:\ -recurse | where  {-not $_.psiscontainer} | where{$_.attributes -match "Offline"}
write-host $files.Length


$upperlimit = $files.count-1
$startingpoint = 0
#$startingpoint = $startingpoint - 100
do {
while ($startingpoint -lt $upperlimit)
{
$count = $startingpoint
$files[$startingpoint .. $upperlimit]  | 
% { 
#$_.fullname 
write-host "$count $($_.name )"
$h = [system.io.file]::OpenRead($_.fullname)
try 
{ 
$newbyte = $h.ReadByte()
}
catch [Exception]
{
$newbyte = $null
} 

$h.close() 
$count++
#sleep -milliseconds 5
if ($newbyte -like $null)
{
#cls
write-host "Count: $count"
write-host $_.fullname
$startingpoint = $count #- 5
write-host $startingpoint
write-host $upperlimit
sleep 15
break
}
}
#cls
#write-host "Count: $count"
#sleep 5
}
write-host "End"
} while ($startingpoint -lt $upperlimit)
Net Use x: /delete
