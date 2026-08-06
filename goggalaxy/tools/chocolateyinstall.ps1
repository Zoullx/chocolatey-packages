$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'EXE'
  url            = 'https://content-system.gog.com/open_link/download?path=/open/galaxy/client/setup_galaxy_2.1.8.30.exe'
  softwareName   = 'GOG Galaxy*'
  checksum       = 'f610f3e65d1c9854b5764c032f9765df'
  checksumType   = 'md5'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0, 1) # Code 1 - Same or newer version already installed. Uninstall before trying to downgrade.
}

$pp = Get-PackageParameters
If ($pp['stopprocess'] -eq 'true') {
  Get-Process GalaxyClient -ErrorAction 0 | Stop-Process
}
Install-ChocolateyPackage @packageArgs
