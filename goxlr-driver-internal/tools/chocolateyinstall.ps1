$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
# $zipFile     = 'GoXLR_Driver_v5.12.0_2021-06-28.zip'
# $zipLocation = Join-Path $toolsDir $zipFile

$zipPackageArgs = @{
  packageName   = $env:ChocolateyPackageName
  # file          = $zipLocation
  url           = 'https://mediadl.musictribe.com/download/software/tchelicon/GoXLR/TC-Helicon_GoXLR_Driver.zip'
  unzipLocation = $toolsDir
  checksum      = '81107314A71DA7AD621D94053F6CFE744E0751C74CADADD12C9EBD5C43954909'
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @zipPackageArgs

$fileName = (Get-ChildItem $toolsDir -Filter *.exe | Select-Object -First 1).Name
$fileLocation = Join-Path $toolsDir $fileName

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $toolsDir
  fileType       = 'EXE'
  file           = $fileLocation
  softwareName   = 'TC-HELICON GoXLR USB Audio Driver*'
  checksum       = '2AE900DAEE1A0E4DE671927287EE012662262423FF92E7710CF6E9AD82DB8048'
  checksumType   = 'sha256'
  silentArgs     = "/S"
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyInstallPackage @packageArgs