$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkExe     = 'AutoHotKey'
$ahkFile    = "$toolsDir\rockstar-launcher_install.ahk"
$url = 'https://gamedownloads.rockstargames.com/public/installer/Rockstar-Games-Launcher.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  softwareName  = 'Rockstar Games Launcher*'
  checksum      = 'B2C39C684EA11045B500A389BEA611FE06C6AF6E5C2485DB5D3332868340533F'
  checksumType  = 'sha256'
  validExitCodes= @(0, 3010, 1641)
}

Start-Process $ahkExe $ahkFile
Install-ChocolateyPackage @packageArgs