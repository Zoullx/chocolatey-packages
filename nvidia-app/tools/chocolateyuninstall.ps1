$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://us.download.nvidia.com/nvapp/client/11.0.3.213/NVIDIA_app_beta_v11.0.3.213.exe'
$fileName = [System.IO.Path]::GetFileName($url)
$fileLocation = Join-Path $toolsDir $fileName
$checksum = '3b201eff9bfceedc2a2709db21d69ffecd63b630378b089affc7837a7a5066fe'

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
