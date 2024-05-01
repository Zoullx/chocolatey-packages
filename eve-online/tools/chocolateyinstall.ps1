$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url      = 'https://launcher.ccpgames.com/eve-online/release/win32/x64/eve-online-latest+Setup.exe'

# DO NOT CHANGE THESE MANUALLY, USE update.ps1
$checksum = '61a12e5f5999590494b8b85680bd9a16c67a25cc5ccadaaed0a2104d9021420b'

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
