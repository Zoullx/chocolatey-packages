$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url      = 'https://launcher.ccpgames.com/eve-online/release/win32/x64/eve-online-latest+Setup.exe'

# DO NOT CHANGE THESE MANUALLY, USE update.ps1
$checksum = '2ede7661f3eab0990bf9001f7433dee2e2b6621603b04afa3479cbab89fcf826'

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
