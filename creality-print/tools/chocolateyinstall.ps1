$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# DO NOT CHANGE THESE MANUALLY, USE update.ps1
$url = 'https://github.com/CrealityOfficial/CrealityPrint/releases/download/v6.0.2/CrealityPrint_6.0.2.1574_Release.exe'
$checksum = 'b8a95f9aa474948dd2c83ef6fb4b08cf0f8f8ce14f780a96586cfc7a65854e1b'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $toolsDir
  fileType       = 'EXE'
  url            = $url
  softwareName   = 'Creality Print*'
  checksum       = $checksum
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
