$FilesHL  = Get-ChildItem -Recurse -Path "E:\Plex\Movies" | Where-Object {$_.Mode.toLower() -notmatch "d" -and $_.LinkType -ne "HardLink"}
$FilesWHL = Get-ChildItem -Recurse -Path "E:\Plex\Movies" | Where-Object {$_.Mode.toLower() -notmatch "d" -and $_.LinkType -eq "HardLink"}

ForEach($File in $FilesHL)
{
    if($File.LinkType -ne "HardLink")
    {
        Remove-Item -Path $File.FullName -Force
    }
}

ForEach($File in $FilesWHL)
{
    if([Bool]($File.Target -notmatch 'E:\\deluge\\Data'))
    {
        Write-Host -ForegroundColor Red "$($File.FullName) has an invalid link would you like to delete Y\N"

        $Response = Read-Host

        If($Response.ToLower() -eq "y")
        {
            Remove-Item -Path $FIle.FullName -Force 
            Remove-Item -Path $File.Directory.FullName -Force
        }
    }
    else
    {
        Write-Host -ForegroundColor Green "$($File.FullName) has an valid link"
    }
}