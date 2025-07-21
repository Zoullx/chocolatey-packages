$ErrorActionPreference = 'Stop'

$checksum = '5a08a48af29578556a384a9e8d11369a22b5fd85529bb1b4136cc0eb66783316ffd6358bcfde059b663400e8087ea5a86b991e353e3288a9bc3fc603aa50d012'

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
