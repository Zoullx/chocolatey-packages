$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# DO NOT CHANGE THESE MANUALLY, USE update.ps1
$url      = 'https://origin-a.akamaihd.net/EA-Desktop-Client-Download/installer-releases/EAappInstaller.exe'
$checksum = '15f806dda24653f7ffbd62a7dbf60a125119538e37c92a786bb14a176dc93299'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  softwareName  = 'EA app*'
  checksum      = $checksum
  checksumType  = 'sha256'
  silentArgs    = '/S'
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
Start-Sleep -s 20
Start-CheckandStop "EADesktop"
