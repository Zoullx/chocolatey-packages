$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'EXE'
  url            = 'https://content-system.gog.com/open_link/download?path=/open/galaxy/client/setup_galaxy_2.0.97.42.exe'
  softwareName   = 'GOG Galaxy*'
  checksum       = '5ea262b0914ee3048bebdf78e44ddeff'
  checksumType   = 'md5'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0, 1) # Code 1 - Same or newer version already installed. Uninstall before trying to downgrade.
}

$pp = Get-PackageParameters
If ($pp['stopprocess'] -eq 'true') {
  Get-Process GalaxyClient -ErrorAction 0 | Stop-Process
}
Install-ChocolateyPackage @packageArgs
