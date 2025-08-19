$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://beeper-desktop.download.beeper.com/builds/Beeper%20x64%204.1.111.exe'

# DO NOT CHANGE THESE MANUALLY, USE update.ps1
$checksum = '9efb222fbf60fc1148d3d9c23cc861c7e98c17321868e1735445248dd2ff20c8'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $toolsDir
  fileType       = 'EXE'
  url            = $url
  softwareName   = 'Beeper*'
  checksum       = $checksum
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
