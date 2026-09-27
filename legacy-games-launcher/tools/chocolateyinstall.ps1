$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url        = 'https://legacy-games-desktop-launcher.sfo3.cdn.digitaloceanspaces.com/legacy-games-launcher-setup-1.19.2-ia32-full.exe'
$url64      = 'https://legacy-games-desktop-launcher.sfo3.cdn.digitaloceanspaces.com/legacy-games-launcher-setup-1.19.2-x64-full.exe'
$checksum   = '1df035e63dcab27ce8fa8176e38ddf50bace5c037606e6540052e833f4affea0'
$checksum64 = '3c5d63eda8a8bc0fa75acb0989590d21cdbc74e4c1851b8ba80c479385d93e97'

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
