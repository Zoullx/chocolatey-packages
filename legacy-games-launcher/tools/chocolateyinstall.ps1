$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url        = 'https://cdn.legacygames.com/LegacyGamesLauncher/legacy-games-launcher-setup-1.16.7-ia32-full.exe'
$url64      = 'https://cdn.legacygames.com/LegacyGamesLauncher/legacy-games-launcher-setup-1.16.7-x64-full.exe'
$checksum   = '2b6740443a9d78b76d52ffe0f102208f242c7d184cf70a64e1f12bfa2401aaa6'
$checksum64 = '87444744e6918f2ae107b9cc3124749cbe57f6144b3c16c8daacf8f2da27aef0'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  url64bit      = $url64
  softwareName  = 'Legacy Games Launcher*'
  checksum      = $checksum
  checksumType  = 'sha256'
  checksum64    = $checksum64
  checksumType64= 'sha256'
  silentArgs    = '/S'
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
