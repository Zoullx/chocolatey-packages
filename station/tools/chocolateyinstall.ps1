$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://github.com/getstation/desktop-app/releases/download/v3.3.0/Station-Setup.exe'

# DO NOT CHANGE THESE MANUALLY, USE update.ps1
$checksum = '5578486DF5E680A90537C18D0E8FFD1FFD865B38A076C59F70C2B12A28FD9244'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $toolsDir
  fileType       = 'EXE'
  url            = $url
  softwareName   = 'Station*'
  checksum       = $checksum
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs