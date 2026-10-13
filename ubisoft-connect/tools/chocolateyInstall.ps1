$ErrorActionPreference = 'Stop'

$checksum = '42ff0c9792c1a4eb1c4b956420da837dcdf3999e01a96fe1fe1de2e8f9e23afe198188c7a650a85805dac0795cfb52cc02f37fa9c3001e0e2f7c4c3c37d7d1ef'

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
