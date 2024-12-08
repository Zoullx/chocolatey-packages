$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://launcher.ccpgames.com/eve-online/release/win32/x64/eve-online-latest+Setup.exe'

# DO NOT CHANGE THESE MANUALLY, USE update.ps1
$checksum = '8c3f525b2697b032cc7df8cef17cacf4a8d8e2e8690abc4c36bcf505e49c169f'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $toolsDir
  fileType       = 'EXE'
  url            = $url
  softwareName   = 'eve-online'
  checksum       = $checksum
  checksumType   = 'sha256'
  silentArgs     = '/silent'
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
