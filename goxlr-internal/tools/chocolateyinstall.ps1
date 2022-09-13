$ErrorActionPreference = 'Stop';
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$zipFile     = 'GoXLR-App-1.5.11.228.zip'
$zipLocation = Join-Path $toolsDir $zipFile

$zipPackageArgs = @{
  packageName   = $env:ChocolateyPackageName
  file          = $zipLocation
  unzipLocation = $toolsDir
  checksum      = '8EE0F584BF88EC8788087AE6FCF0516F7D4E4297A35D1869A3B8FE449A2DE9DD'
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @zipPackageArgs

$fileName = (Get-ChildItem $toolsDir -Filter *.exe | Select-Object -First 1).Name
$fileLocation = Join-Path $toolsDir $fileName

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  file          = $fileLocation
  softwareName  = 'GoXLR App*'
  checksum      = '02850EEC564255CB0AB1F0C3267578C3396028248EC1D754227F1F60FBC0E3AA'
  checksumType  = 'sha256'
  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyInstallPackage @packageArgs