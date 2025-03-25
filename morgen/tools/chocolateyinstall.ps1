$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://dl.todesktop.com/210203cqcj00tw1/windows/nsis/x64'

# DO NOT CHANGE THESE MANUALLY, USE update.ps1
$checksum = 'c56c5077137dbc5e6f3b67fa4fe29dc5dbd5d6c9c50e5073125b5d64d1fc2861'

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
