$ErrorActionPreference = 'Stop'

$checksum = '70e0c876a2567b4fae72a50104af7938cf8dc042230eab1b999d8ae59bc451bda0ddd31947950069c754d357e97098551737fde8202f6e7ee16582c1238c6897'

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
