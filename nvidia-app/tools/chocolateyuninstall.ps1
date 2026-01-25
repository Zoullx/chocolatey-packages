$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://us.download.nvidia.com/nvapp/client/11.0.6.383/NVIDIA_app_v11.0.6.383.exe'
$fileName = [System.IO.Path]::GetFileName($url)
$fileLocation = Join-Path $toolsDir $fileName
$checksum = 'ce4cb43a778b177973dbeea9c3ffef5cfd6d04769cf106bc07ee11257e99e098'

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
