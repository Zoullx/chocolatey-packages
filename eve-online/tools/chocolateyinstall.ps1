$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkExe   = 'AutoHotKey'
$ahkFile  = "$toolsDir\eve-online_install.ahk"

# DO NOT CHANGE THESE MANUALLY, USE update.ps1
$url      = 'http://binaries.eveonline.com/EveLauncher-2162700.exe'
$checksum = '8B29AF73015E8EF45B07AE446FF69FCC69E704624C8FB99C2FD09512E64F6639'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  softwareName  = 'EVE Online*'
  checksum      = $checksum
  checksumType  = 'sha256'
  validExitCodes= @(0, 3010, 1641)
}

Start-Process $ahkExe $ahkFile
Install-ChocolateyPackage @packageArgs