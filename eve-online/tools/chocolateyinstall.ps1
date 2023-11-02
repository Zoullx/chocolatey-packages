$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url      = 'https://launcher.ccpgames.com/eve-online/release/win32/x64/eve-online-latest+Setup.exe'

# DO NOT CHANGE THESE MANUALLY, USE update.ps1
$checksum = 'd04852f5f71724fce7b31aa9ccd4a1c90031aaec15568c2cfa752dd64ce4fa52'

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
