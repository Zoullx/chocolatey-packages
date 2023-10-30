$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkExe = 'AutoHotKey'
$ahkFile = "$toolsDir\guild-wars_install.ahk"
$url = 'https://cloudfront.guildwars2.com/client/GwSetup.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $toolsDir
  fileType       = 'EXE'
  url            = $url
  softwareName   = 'Guild Wars'
  checksum       = '9152740C834EEF57DB881B51B46149E0BEDEBC65DEEF0900050ABD0C41CE1C4B'
  checksumType   = 'sha256'
  validExitCodes = @(0, 3010, 1641)
}

Start-Process $ahkExe $ahkFile
Install-ChocolateyPackage @packageArgs