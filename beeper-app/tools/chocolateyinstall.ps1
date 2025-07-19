$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://api.beeper.com/desktop/download/windows/x64/stable/com.automattic.beeper.desktop'

# DO NOT CHANGE THESE MANUALLY, USE update.ps1
$checksum = '4733b4d36089c30aa96169f87e2f5887e2d1626d9679c325d7dfe51023667ec9'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $toolsDir
  fileType       = 'EXE'
  url            = $url
  softwareName   = 'Beeper*'
  checksum       = $checksum
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
