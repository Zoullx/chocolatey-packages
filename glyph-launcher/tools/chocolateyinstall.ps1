$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkExe   = 'AutoHotKey'
$ahkFile  = "$toolsDir\glyph-launcher_install.ahk"
$url      = 'https://glyph.dyn.triongames.com/glyph/live/GlyphInstall.exe'

# DO NOT CHANGE THESE MANUALLY, USE update.ps1
$checksum = '5aa83899194b81e184e33c97f6c3950186571ceb97f69025118e30f9aec05e01'

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
