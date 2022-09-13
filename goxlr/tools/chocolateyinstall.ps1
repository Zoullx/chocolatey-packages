$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url      = 'https://mediadl.musictribe.com/download/software/tchelicon/GoXLR/GoXLR-App-1.3.3.130.zip'

$zipPackageArgs = @{
  packageName   = $env:ChocolateyPackageName
  url           = $url
  unzipLocation = $toolsDir
  checksum      = '98ACDB9A349903D42B8E13C98F2923F5F587C4FA2AF85E0E452C2240C6187704'
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
  checksum      = '17FC0C0186DC7595899CC94DC52B646F18C428E007CEDBD3F055449FFF156ADE'
  checksumType  = 'sha256'
  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyInstallPackage @packageArgs