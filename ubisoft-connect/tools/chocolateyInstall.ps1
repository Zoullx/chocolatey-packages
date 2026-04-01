$ErrorActionPreference = 'Stop'

$checksum = 'b76d68fbd05f17ba226d923c9df7f90d647d0ada17f52ac73d2318cbfda0a9e34e14c21a904fb1642440d87e168b7ea7209be3467e2710c93a5c9834367836f3'

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
