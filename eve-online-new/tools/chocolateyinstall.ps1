$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://launcher.ccpgames.com/eve-online/release/win32/x64/eve-online-latest+Setup.exe'

# DO NOT CHANGE THESE MANUALLY, USE update.ps1
$checksum = '13792e6452a5dde12bec94a5b1f1af9fa377de7a30c0283cf5ab352f93ac0a91'

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
