$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://dl.razerzone.com/drivers/Synapse2/win/Web_Razer_Synapse_Installer_v2.21.24.41.exe'

$zipPackageArgs = @{
  packageName   = $env:ChocolateyPackageName
  url           = $url
  unzipLocation = $toolsDir
  checksum      = 'CC8AFA3FB773DC68840E7D4B3423AE47E19A12BFCEEADC332CDDEC9D1D545627'
  checksumType  = 'sha256'
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
  checksum      = 'D901DA91EDB94180BB2B814D1EEB3D9DD20E2E43652C4FDE93CCAB6CDA0A332D'
  checksumType  = 'sha256'
  silentArgs    = '/s /v"/qn"'
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyInstallPackage @packageArgs