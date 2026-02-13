$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://dl.todesktop.com/210203cqcj00tw1/windows/nsis/x64'

# DO NOT CHANGE THESE MANUALLY, USE update.ps1
$checksum = 'a497933d47da2f16d33b863c79125fb61df593234c620f11ec335deb4408dc8d'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $toolsDir
  fileType       = 'EXE'
  url            = $url
  softwareName   = 'Morgen*'
  checksum       = $checksum
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
