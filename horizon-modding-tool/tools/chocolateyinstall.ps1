$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://www.wemod.com/horizon/download'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $toolsDir
  fileType       = 'EXE'
  url            = $url
  softwareName   = 'Horizon'
  checksum       = '0F832DD0FCE1413B4C785B718D132D39ECAD00E410824E734B5325083082AA03'
  checksumType   = 'sha256'
  silentArgs     = '-s'
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs