$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# DO NOT CHANGE THESE MANUALLY, USE update.ps1
$url = 'https://github.com/CrealityOfficial/CrealityPrint/releases/download/v6.3.0/CrealityPrint_6.3.0.3417_Release.exe'
$checksum = 'd67c7dd55dfda73d29f1b38793038a397c79ebff6d187822497db8984b0219e2'

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
