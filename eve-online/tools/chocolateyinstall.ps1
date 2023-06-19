$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installScript = Join-Path $toolsDir 'eve-online_install.qs'

# DO NOT CHANGE THESE MANUALLY, USE update.ps1
$url      = 'http://binaries.eveonline.com/EveLauncher-2294803.exe'
$checksum = 'a3edcf102273eb6cda5de65d44687025880a788c47af6839081074eb380ac709'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  softwareName  = 'EVE Online*'
  checksum      = $checksum
  checksumType  = 'sha256'
  silentArgs    = "--script $installScript"
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
