$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://dl.todesktop.com/210203cqcj00tw1/windows/nsis/x64'

# DO NOT CHANGE THESE MANUALLY, USE update.ps1
$checksum = '9a9b9b26bfd3b1e9f6b51684973eab696d8206d2d91a585e21c560d5f6130e6e'

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
