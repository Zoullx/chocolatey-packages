$ErrorActionPreference = 'Stop'

$checksum = 'fda7ba97b55532c9331f98fcd3abf08f6ba2b0bbc4d43df0fafe7b050a488c3c4dc8e28e423286fb530b5a740379e12e4e156eff95cf64c9d0d72d3dbcb5a8e7'

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
