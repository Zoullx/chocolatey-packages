$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkExe   = 'AutoHotKey'
$ahkFile  = "$toolsDir\glyph-launcher_install.ahk"
$url      = 'https://glyph.dyn.triongames.com/glyph/live/GlyphInstall.exe'

# DO NOT CHANGE THESE MANUALLY, USE update.ps1
$checksum = '5b9c21ce4329dec2d2c4f7dfc4ab5d1cbd6ee9704b0fcf0563dc9f0ebea5e3e9'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  softwareName  = 'Glyph*'
  checksum      = $checksum
  checksumType  = 'sha256'
  validExitCodes= @(0, 3010, 1641)
}

Start-Process $ahkExe $ahkFile
Install-ChocolateyPackage @packageArgs
Start-Sleep -s 10
Start-CheckandStop "Glyph*"
