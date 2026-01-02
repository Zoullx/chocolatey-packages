$ErrorActionPreference = 'Stop'

$checksum = '4bb02b3cbfeea14e9e3de1e5f51f763ed882383937c941752c7c55cc7a6fa1bee5bd3867dee7ece5eed901c919dc1115aa3d93764894c6ffdb241dfec901de9b'

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
