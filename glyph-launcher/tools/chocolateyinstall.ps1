$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
# $ahkExe   = 'AutoHotKey'
# $ahkFile  = "$toolsDir\glyph-launcher_install.ahk"
$url      = 'https://glyph.dyn.triongames.com/glyph/live/GlyphInstall.exe'

# DO NOT CHANGE THESE MANUALLY, USE update.ps1
$checksum = '11c937235cdd0609c861540c11aff308b3cf6c9efbb9e4f723286e125bd919c1'

$zipPackageArgs = @{
  packageName   = $env:ChocolateyPackageName
  url           = $url
  unzipLocation = $toolsDir
  checksum      = $checksum
  checksumType  = $checksumType
}

Install-ChocolateyZipPackage @zipPackageArgs

# $packageArgs = @{
#   packageName   = $env:ChocolateyPackageName
#   unzipLocation = $toolsDir
#   fileType      = 'EXE'
#   url           = $url
#   softwareName  = 'Glyph*'
#   checksum      = $checksum
#   checksumType  = 'sha256'
#   validExitCodes= @(0, 3010, 1641)
# }

# Start-WaitandStop "Glyph*"

# Start-Process $ahkExe $ahkFile
# Install-ChocolateyPackage @packageArgs
# Start-CheckandStop "Glyph*"
