$ErrorActionPreference = 'Stop'

$checksum = '9cf5d59cb36a9cb333e3df602e062e51daf61e9ee1b6010e74edf18b77d9468ec08159031a102e5d3fd13967637e061eab8179e80bc599b3c6564fa1baeeaf73'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://static3.cdn.ubi.com/orbit/launcher_installer/UbisoftConnectInstaller.exe'
  softwareName   = 'Ubisoft Connect'
  checksum       = $checksum
  checksumType   = 'sha512'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
