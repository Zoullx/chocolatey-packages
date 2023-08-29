$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkExe   = 'AutoHotKey'
$ahkFile  = "$toolsDir\rockstar-launcher_install.ahk"
$url      = 'https://gamedownloads.rockstargames.com/public/installer/Rockstar-Games-Launcher.exe'

# DO NOT CHANGE THESE MANUALLY, USE update.ps1
$checksum = '2cc3617c0ac0e05331d6e256ed2ab804909a77b8369eaa2e02e6e7e9ac528410'

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
