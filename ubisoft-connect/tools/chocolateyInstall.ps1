$ErrorActionPreference = 'Stop'

$checksum = '7cc2ba48c43da8706f0e9b782144cc6d29d1d7541bc82c165c3293f7ad5fdb9e2815b71860963e18d6fdf9c0175fd8a516eb159d49eeb5d49201e3a0c5548d9c'

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
