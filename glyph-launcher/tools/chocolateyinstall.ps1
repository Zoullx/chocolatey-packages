$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkExe   = 'AutoHotKey'
$ahkFile  = "$toolsDir\glyph-launcher_install.ahk"
$url      = 'https://glyph.dyn.triongames.com/glyph/live/GlyphInstall.exe'

# DO NOT CHANGE THESE MANUALLY, USE update.ps1
$checksum = '102ed19e8119e1cdd97b83ab26415bfe5f3eeb8654859c1cffd46a07cd2834e8'

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

Start-WaitandStop "Glyph*"

Start-Process $ahkExe $ahkFile
Install-ChocolateyPackage @packageArgs
Start-CheckandStop "Glyph*"
