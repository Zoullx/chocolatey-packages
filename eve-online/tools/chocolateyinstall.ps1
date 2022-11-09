$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkExe   = 'AutoHotKey'
$ahkFile  = "$toolsDir\eve-online_install.ahk"

# DO NOT CHANGE THESE MANUALLY, USE update.ps1
$url      = 'https://www.eveonline.com/EveLauncher-2136456.exe'
$checksum = '9C95A47A1B6865DE6686FCC77AF284805A9053FE6B59F1E83E30ED0C45733F54'

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