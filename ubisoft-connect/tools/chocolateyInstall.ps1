$ErrorActionPreference = 'Stop'

$checksum = 'af4a1e7574f4a2db79b05c4c595144ad79ac2a1f56612b9041ed8d566bcf6819ab6c01fa0ffbe44c6db558c2aab2f033aad6fe97c819b1d270a73f1df1e283d6'

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
