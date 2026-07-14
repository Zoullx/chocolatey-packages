$ErrorActionPreference = 'Stop'

$checksum = '69fd1523afc7c92843698020722d292c489fa51c41492a7ebf64969b075ecfb3f9ab59c2bc82ca13151394aceaefebf36391ff24a1baa38dd602bcd30914e29a'

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
