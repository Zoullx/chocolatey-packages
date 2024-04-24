$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://foreverfile.hprtcloud.com/upgrade/app_version/2024_04_10/y4MPqgtuVnVMfLig/HMark%20V1.02.10.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $toolsDir
  fileType       = 'EXE'
  url            = $url
  softwareName   = 'HMark*'
  checksum       = '1FD814C2F03DE6B226B9C3DC1BDA44ED8978CC22436DA11BF89EAF49B0ADBAD1'
  checksumType   = 'sha256'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs