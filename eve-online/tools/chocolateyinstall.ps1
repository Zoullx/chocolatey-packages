$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url      = 'https://launcher.ccpgames.com/eve-online/release/win32/x64/eve-online-latest+Setup.exe'

# DO NOT CHANGE THESE MANUALLY, USE update.ps1
$checksum = '062d1d7e652f9987301ac081cfca4a320de0bf4d635f842908cb8b5f9aa37cbe'

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
