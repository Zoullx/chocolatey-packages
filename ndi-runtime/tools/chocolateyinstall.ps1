$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# DO NOT CHANGE THESE MANUALLY, USE update.ps1
$url = 'https://ndi.link/NDIRedistV6'
$checksum = '7ee73eedb56402bca5100868353dbab4e944b6c37d2d9881580698a3b61346cd'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $toolsDir
  fileType       = 'EXE'
  url            = $url
  softwareName   = 'NDI 6 Runtime'
  checksum       = $checksum
  checksumType   = 'sha256'
  silentArgs     = '/VERYSILENT /LOG /NORESTART /SUPPRESSMSGBOXES'
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
Write-Warning "You must reboot your computer to make a new or updated NDI Runtime installation effective"
