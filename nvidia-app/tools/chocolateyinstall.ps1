$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://us.download.nvidia.com/nvapp/client/11.0.1.189/NVIDIA_app_v11.0.1.189.exe'
$checksum = 'f9d3e9aad532d4a9a804b14667fdcb71cd6ab8cbeca7089e49fbeca77ac7c653'

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
