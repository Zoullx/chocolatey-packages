$ErrorActionPreference = 'Stop'

$checksum = '45af0fcde62ba35455ba277c80b1ce50363e0b7689f85e8cac2ce70d49a5063eff0626a92a59f0a6de2d8594c796fe658946f037c54e201a50bb20f1592657ac'

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
