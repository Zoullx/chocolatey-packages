$ErrorActionPreference = 'Stop'

$checksum = '52b8b7197217e35d647a11b937be8a373ab3fdfb0ca6bf115252fb49cf11b3df7bcbf764a687752e1928db1938c490f92e9dc5a30e5bb87d175f00eae32134a8'

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
