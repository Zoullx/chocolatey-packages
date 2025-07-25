$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url = 'https://overseas.hprtcloud.com/upgrade/app_version/2025_07_21/1WG2LwxopvqxDgoS/HereLabel%20V1.04.05.exe'
$checksum = '060C842B51CDA6ABCF596E1A0A2C185E9192C05D969C4874FD14240AFC04F6F3'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $toolsDir
  fileType       = 'EXE'
  url            = $url
  softwareName   = 'HereLabel*'
  checksum       = $checksum
  checksumType   = 'sha256'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs