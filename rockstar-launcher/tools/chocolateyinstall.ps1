﻿$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkExe   = 'AutoHotKey'
$ahkFile  = "$toolsDir\rockstar-launcher_install.ahk"
$url      = 'https://gamedownloads.rockstargames.com/public/installer/Rockstar-Games-Launcher.exe'

# DO NOT CHANGE THESE MANUALLY, USE update.ps1
$checksum = 'd742994d2aca471399e353baf559a3bf857e97354a3df68f3bf4e2afd71556fb'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  softwareName  = 'Rockstar Games Launcher*'
  checksum      = $checksum
  checksumType  = 'sha256'
  validExitCodes= @(0, 3010, 1641)
}

Start-Process $ahkExe $ahkFile
Install-ChocolateyPackage @packageArgs
