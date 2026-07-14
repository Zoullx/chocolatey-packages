$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://launcher.ccpgames.com/eve-online/release/win32/x64/eve-online-latest+Setup.exe'

# DO NOT CHANGE THESE MANUALLY, USE update.ps1
$checksum = '6373f77c77c76532d28da607cd8ae9ad7bc58f4b72ca7889254c5449e59d44f9'

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
