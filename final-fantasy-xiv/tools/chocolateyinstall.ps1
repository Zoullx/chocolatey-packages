$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
# $ahkExe   = 'AutoHotKey'
# $ahkFile  = "$toolsDir\final-fantasy-xiv_install.ahk"
$7zip = Join-Path "$env:ChocolateyInstall" 'tools\7z.exe'
$ffInstallUnzipFile = Join-Path $toolsDir 'ffxivsetup_ft.exe'
$url      = 'https://etailers.square-enix-games.com/etailer/283335?e=Free%20Trial&p=Windows&s=Square%20Enix%20Store'
$checksum = '6810954D1EAF0D0951BB5534D6369644405FBD784F7374F85627A53FA70FB0DF'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  softwareName  = 'FINAL FANTASY XIV ONLINE*'
  checksum      = $checksum
  checksumType  = 'sha256'
  validExitCodes= @(0, 3010, 1641)
}

Start-Process $ahkExe $ahkFile
Install-ChocolateyPackage @packageArgs