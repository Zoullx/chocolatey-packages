$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkExe = 'AutoHotKey'
$ahkFile = "$toolsDir\guild-wars-2_install.ahk"
$url = 'https://account.arena.net/content/download/gw2/win/64'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $toolsDir
  fileType       = 'EXE'
  url            = $url
  softwareName   = 'Guild Wars 2'
  checksum       = 'EAA97F5C70E5D41439DDD9AB9A00090B0CD11940097D453DD6C6BC874F0302C8'
  checksumType   = 'sha256'
  validExitCodes = @(0, 3010, 1641)
}

Start-Process $ahkExe $ahkFile
Install-ChocolateyPackage @packageArgs