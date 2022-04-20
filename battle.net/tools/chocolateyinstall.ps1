$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkExe     = 'AutoHotKey'
$ahkFile    = "$toolsDir\battle.net_install.ahk"
$fileLocation = Join-Path $toolsDir 'Battle.net-Setup.exe'
# $url        = 'https://us.battle.net/download/getInstaller?os=win&installer=Battle.net-Setup.exe&id=undefined'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  file          = $fileLocation
  softwareName  = 'Battle.net*'
  checksum      = 'B32A976B66110524B7CC94C056E678617045D36DE80ABB5E798C2F91E91C5DA8'
  checksumType  = 'sha256'
  silentArgs    = ""
  validExitCodes= @(0, 3010, 1641)
}

Start-Process $ahkExe $ahkFile
Install-ChocolateyPackage @packageArgs
Start-Sleep -s 10
Start-CheckandStop "Battle.net"