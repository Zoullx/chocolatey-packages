$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url        = 'https://cdn.legacygames.com/LegacyGamesLauncher/legacy-games-launcher-setup-1.13.0-ia32-full.exe'
$url64      = 'https://cdn.legacygames.com/LegacyGamesLauncher/legacy-games-launcher-setup-1.13.0-x64-full.exe'
$checksum   = '21a062bc4c20d6ea14c1c1c647ea944a29788681db9c1e0e2b5c52f77d982de7'
$checksum64 = 'a898082a156aac4a0012ac5b36bd9aba0873f604c92fbfd0579a3d9e00b3d6ba'

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
