$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkExe   = 'AutoHotKey'
$ahkFile  = "$toolsDir\rockstar-launcher_install.ahk"
$url      = 'https://gamedownloads.rockstargames.com/public/installer/Rockstar-Games-Launcher.exe'

# DO NOT CHANGE THESE MANUALLY, USE update.ps1
$checksum = '0dade66c1b6701d782e64933a2bbe8fc8b277b739e329978a8fbed716b837945'

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
