$ErrorActionPreference = 'Stop'

$checksum = 'f885dafd6097a2c3b580dbd6c35579b070e021fcf441fcffbf0c2ebbb4af709388b928557196c934ed3ab2e07ff5a703dea4b885bfe781c6352dfd0ef1bfb1d2'

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
