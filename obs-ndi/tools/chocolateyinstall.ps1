$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://github.com/obs-ndi/obs-ndi/releases/download/4.13.2/obs-ndi-4.13.2-windows-x64-Installer.exe'

# First, install NDI Runtime
$runtimePackageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $toolsDir
  fileType       = 'EXE'
  url            = 'http://ndi.link/NDIRedistV5'
  softwareName   = 'NDI 5 Runtime'
  checksum       = 'BC666D409FA6B2D81FF8650A5B92481742F5E895E4994A1A414BAC423CD8448C'
  checksumType   = 'sha256'
  silentArgs     = '/VERYSILENT /LOG /NORESTART /SUPPRESSMSGBOXES'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @runtimePackageArgs

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $toolsDir
  fileType       = 'EXE'
  url            = $url
  softwareName   = 'obs-ndi*'
  checksum       = '54B606C2746B9A3D0531E26347B74853C4BB0871FB312FD7D507627D6EE37C4C'
  checksumType   = 'sha256'
  silentArgs     = '/VERYSILENT /LOG /NORESTART /SUPPRESSMSGBOXES'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs