$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkExe   = 'AutoHotKey'
$ahkFile  = "$toolsDir\glyph-launcher_install.ahk"
$url      = 'https://glyph.dyn.triongames.com/glyph/live/GlyphInstall.exe'

# DO NOT CHANGE THESE MANUALLY, USE update.ps1
$checksum = 'b29b57f13e370e9d4107ae2c2c1d8d1ae334c36922bfbe92bfbf8b3a65921d26'

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
Start-WaitandStop "Glyph*"
