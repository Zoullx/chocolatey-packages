$ErrorActionPreference = 'Stop'

$checksum = '982e5f149aec4df8927057e225f87871c7382e964fd21700fb9905c94f1832ac666ba5284b834ec0386b1fb7933800281f633d77fa0bc842b8f5a210175727e5'

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
