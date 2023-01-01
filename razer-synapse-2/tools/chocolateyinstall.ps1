$ErrorActionPreference = 'Stop';
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$checksumType = 'sha256'

# DO NOT CHANGE THESE MANUALLY, USE update.ps1
$url      = 'https://dl.razerzone.com/drivers/Synapse2/win/Web_Razer_Synapse_Installer_v2.21.24.41.exe'
$checksum = 'CC8AFA3FB773DC68840E7D4B3423AE47E19A12BFCEEADC332CDDEC9D1D545627'

$zipPackageArgs = @{
  packageName   = $env:ChocolateyPackageName
  url           = $url
  unzipLocation = $toolsDir
  checksum      = $checksum
  checksumType  = $checksumType
}

Install-ChocolateyZipPackage @zipPackageArgs

$pluginsDir = Join-Path $toolsDir '$PLUGINSDIR'
$fileName = (Get-ChildItem $pluginsDir -Filter *.exe | Select-Object -First 1).Name
$fileLocation = Join-Path $pluginsDir $fileName

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  file          = $fileLocation
  softwareName  = 'Razer Synapse*'
  silentArgs    = '/s /v"/qn"'
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyInstallPackage @packageArgs