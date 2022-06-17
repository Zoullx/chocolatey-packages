$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://mediadl.musictribe.com/media/PLM/sftp/incoming/hybris/import/goxlr/download/GoXLR_App_v1.4.25.190.zip'

$zipPackageArgs = @{
  packageName   = $env:ChocolateyPackageName
  url           = $url
  unzipLocation = $toolsDir
  checksum      = '288874AC262F19E71360407AF39DBCC749A1EB87C7E10CEBC8F12F40448A77CA'
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @zipPackageArgs

$fileName = (Get-ChildItem $toolsDir -Filter *.exe | Select-Object -First 1).Name
$fileLocation = Join-Path $toolsDir $fileName

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  file          = $fileLocation
  softwareName  = 'GoXLR App*'
  checksum      = 'F398E982E97F44188B9245A7FF2BBB1E3FD29A44100F467B82B1D0A249DA6F19'
  checksumType  = 'sha256'
  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyInstallPackage @packageArgs