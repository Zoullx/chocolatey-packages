$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url        = 'https://cdn.legacygames.com/LegacyGamesLauncher/legacy-games-launcher-setup-1.15.3-ia32-full.exe'
$url64      = 'https://cdn.legacygames.com/LegacyGamesLauncher/legacy-games-launcher-setup-1.15.3-x64-full.exe'
$checksum   = '1c7ed8a325184a149b67c2986f7584327c502c8b7d7b9d85278b9c815acde297'
$checksum64 = '2c20b5c28bf75d30b51d46fb1baedde01878aa1e346b3786de1cd0899e318af1'

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
