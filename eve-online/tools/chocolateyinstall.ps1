$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkExe   = 'AutoHotKey'
$ahkFile  = "$toolsDir\eve-online_install.ahk"

# DO NOT CHANGE THESE MANUALLY, USE update.ps1
$url      = 'https://www.eveonline.com/EveLauncher-2153627.exe'
$checksum = '8E621FCCACAE0217F7800B86AD9A91BA679255F2200D97915437DB1FE885938D'

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