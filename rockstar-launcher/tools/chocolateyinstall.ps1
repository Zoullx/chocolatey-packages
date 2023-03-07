$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkExe   = 'AutoHotKey'
$ahkFile  = "$toolsDir\rockstar-launcher_install.ahk"
$url      = 'https://gamedownloads.rockstargames.com/public/installer/Rockstar-Games-Launcher.exe'

# DO NOT CHANGE THESE MANUALLY, USE update.ps1
$checksum = '2f129e175d6c22a3b30ab871d8af54fabfbfb5f97396abbc74cb2d240baecbdd'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  softwareName  = 'Rockstar Games Launcher*'
  checksum      = $checksum
  checksumType  = 'sha256'
  validExitCodes= @(0, 3010, 1641)
}

Start-Process $ahkExe $ahkFile
Install-ChocolateyPackage @packageArgs
