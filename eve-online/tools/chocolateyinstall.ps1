$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url      = 'https://launcher.ccpgames.com/eve-online/release/win32/x64/eve-online-latest+Setup.exe'

# DO NOT CHANGE THESE MANUALLY, USE update.ps1
$checksum = 'fc14c1a469569a1b8efb30d19c2dad2632849b599b42701e1fcd49329c59f52d'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  softwareName  = 'eve-online'
  checksum      = $checksum
  checksumType  = 'sha256'
  silentArgs    = '/silent'
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
