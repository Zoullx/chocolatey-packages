$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://us.download.nvidia.com/nvapp/client/11.0.5.420/NVIDIA_app_v11.0.5.420.exe'
$fileName = [System.IO.Path]::GetFileName($url)
$fileLocation = Join-Path $toolsDir $fileName
$checksum = 'a5283562cd12cd94d28fc373c2d805054e626c29a2f33831936df6671200ab01'

$webFileArgs = @{
  packageName  = $env:ChocolateyPackageName
  fileFullPath = $fileLocation
  url          = $url
  checksum     = $checksum
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @webFileArgs

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  softwareName   = 'NVIDIA App'
  fileType       = 'EXE'
  file           = $fileLocation
  silentArgs     = '-uninstall -s'
  validExitCodes = @(0, 3010, 1605, 1614, 1641)
}

Uninstall-ChocolateyPackage @packageArgs
