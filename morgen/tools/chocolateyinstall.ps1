$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://dl.todesktop.com/210203cqcj00tw1/windows/nsis/x64'

# DO NOT CHANGE THESE MANUALLY, USE update.ps1
$checksum = '21c3e00fa2388ce37dfaf567fba2fecc7455b2fa411384b2351d910bc55dd54f'

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
