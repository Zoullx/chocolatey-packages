$ErrorActionPreference = 'Stop'

$checksum = '42dd4a3bd46a04a6687d12d9db574203693557470f9bacf8c81ee3344c72cc72e645aae578d081ef087ea77bf990119c8021098791739f4faadda53d7c014b45'

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
