$ErrorActionPreference = 'Stop'

$checksum = '2efda93ad52bd85537fd7e483407f8993733f15dcd7ed4adfd342ec44ae4146e256f255716447e665145c073fc4affcc10cdba513c04a4428e9b5c60dc35fbf3'

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
