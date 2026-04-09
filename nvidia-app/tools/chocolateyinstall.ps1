$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://us.download.nvidia.com/nvapp/client/11.0.7.237/NVIDIA_app_v11.0.7.237.exe'
$checksum = 'bb0dcc80e30a4d807e6e87c1f879146a117ce57cebe1f79cfd8de7dd1563b111'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $toolsDir
  fileType       = 'EXE'
  url            = $url
  softwareName   = 'NVIDIA App'
  checksum       = $checksum
  checksumType   = 'sha256'
  silentArgs     = '-s'
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
