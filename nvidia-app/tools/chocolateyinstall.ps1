$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://us.download.nvidia.com/nvapp/client/11.0.5.420/NVIDIA_app_v11.0.5.420.exe'
$checksum = 'a5283562cd12cd94d28fc373c2d805054e626c29a2f33831936df6671200ab01'

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
