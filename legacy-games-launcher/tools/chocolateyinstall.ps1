$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url        = 'https://cdn.legacygames.com/LegacyGamesLauncher/legacy-games-launcher-setup-1.12.0-ia32-full.exe'
$url64      = 'https://cdn.legacygames.com/LegacyGamesLauncher/legacy-games-launcher-setup-1.12.0-x64-full.exe'
$checksum   = '33697f9bd5f1349c92f17d3f4dd5533f523e8825fefc111540f81eb03787fc8d'
$checksum64 = 'd24e6caaae9c2f77fdf8966837b4e1dea606dff0f0b793b1341cce96c96ce97d'

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
