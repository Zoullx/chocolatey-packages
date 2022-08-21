$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkExe     = 'AutoHotKey'
$ahkFile    = "$toolsDir\glyph-launcher_install.ahk"
$url        = 'https://glyph.dyn.triongames.com/glyph/live/GlyphInstall.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  softwareName  = 'Glyph*'
  checksum      = 'F1EE54C7E27FC0E7365FB3F4AB97B6B3EE93A335BD98FC4B5431DE1C47FCD08E'
  checksumType  = 'sha256'
  validExitCodes= @(0, 3010, 1641)
}

Start-Process $ahkExe $ahkFile
Install-ChocolateyPackage @packageArgs
Start-Sleep -s 10
Start-CheckandStop "Glyph*"