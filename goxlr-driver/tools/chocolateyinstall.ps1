$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://mediadl.musictribe.com/media/PLM/sftp/incoming/hybris/import/goxlr/download/GoXLR_Driver_v5.12.0_2021-06-28.zip'

$zipPackageArgs = @{
  packageName   = $env:ChocolateyPackageName
  url           = $url
  unzipLocation = $toolsDir
  checksum      = '10446A5D32B0B8F65852959C2E78EEB88A1D5F88AE2E414B28496C1FC3B5485C'
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
  softwareName  = 'TC-HELICON GoXLR USB Audio Driver*'
  checksum      = 'C0B24A8D942BA906DF022A4F245EBAA9FAB5B256A0E5461F979222E29D729262'
  checksumType  = 'sha256'
  silentArgs    = "/S"
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyInstallPackage @packageArgs