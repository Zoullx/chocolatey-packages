$ErrorActionPreference = 'Stop'

$checksum = 'e3c55d0f47bd90d6f5095c1ded2c7d6f314a6d1262b7e37c144b4da2f31115e33e0e5bcc389a5cf9d5b67726a58933d713d4418761fbe61872ae97c31baf98c0'

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
