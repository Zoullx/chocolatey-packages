$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkExe   = 'AutoHotKey'
$ahkFile  = "$toolsDir\eve-online_install.ahk"

# DO NOT CHANGE THESE MANUALLY, USE update.ps1
$url      = 'http://binaries.eveonline.com/EveLauncher-2198233.exe'
$checksum = '1d9de3cd4deae5af9123ccffc73eadfa20b10e80ffe7b4353ee2ccf486ccb955'

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
