$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url        = 'https://cdn.legacygames.com/LegacyGamesLauncher/legacy-games-launcher-setup-1.15.0-ia32-full.exe'
$url64      = 'https://cdn.legacygames.com/LegacyGamesLauncher/legacy-games-launcher-setup-1.15.0-x64-full.exe'
$checksum   = '8cde588f51c9f1b04c280f8bb8343d3173a490142023e623e05d8de0d4e8edd2'
$checksum64 = 'ccc3e125e028bd8b0618c69127f533ad487b38584ee41939cc7bfbc887b5f877'

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
