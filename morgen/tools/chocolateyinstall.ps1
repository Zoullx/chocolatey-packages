$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://dl.todesktop.com/210203cqcj00tw1/windows/nsis/x64'

# DO NOT CHANGE THESE MANUALLY, USE update.ps1
$checksum = 'e726cbade54de19d6dc6fc9f94db92b2ef4aa7f9a733c0882fda2199dd29e1f9'

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
