$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# DO NOT CHANGE THESE MANUALLY, USE update.ps1
$url = 'https://github.com/CrealityOfficial/CrealityPrint/releases/download/v7.0.0/CrealityPrint_7.0.0.4127_Release.exe'
$checksum = 'cc8651ed736133bf571bf58f3559a9f60871eea0e9a4278eeda4d08299d45206'

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
