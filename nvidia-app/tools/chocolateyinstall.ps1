$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://us.download.nvidia.com/nvapp/client/11.0.9.565/NVIDIA_app_v11.0.9.565.exe'
$checksum = 'd70cc78e9f4d89326dd106bdaeaa01c190b9354afa3136f6543c64743139576a'

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
