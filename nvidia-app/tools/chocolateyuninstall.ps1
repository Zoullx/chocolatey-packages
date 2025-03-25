$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://us.download.nvidia.com/nvapp/client/11.0.3.218/NVIDIA_app_v11.0.3.218.exe'
$fileName = [System.IO.Path]::GetFileName($url)
$fileLocation = Join-Path $toolsDir $fileName
$checksum = 'c19a150e53427175e5996100a25ed016f6730b627b1d6b85813811a8751c77b7'

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
