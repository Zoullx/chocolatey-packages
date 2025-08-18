$ErrorActionPreference = 'Stop'

$checksum = '4e94792311f23006d000a8a8d9d7d18637094b4b3d47b6cfa05ce419552369b8229cfcd2d230b0ad6c201f9dad712c17e5d98a0bba2036f23f7552b298bc7453'

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
