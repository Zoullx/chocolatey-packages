$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
# $zipFile     = 'GoXLR-App-1.5.11.228.zip'
# $zipLocation = Join-Path $toolsDir $zipFile

# $zipPackageArgs = @{
#   packageName   = $env:ChocolateyPackageName
#   # file          = $zipLocation
#   url           = 'https://mediadl.musictribe.com/download/software/tchelicon/GoXLR/app/GoXLR%20App%20V1.6.4.013.exe'
#   unzipLocation = $toolsDir
#   checksum      = '8EE0F584BF88EC8788087AE6FCF0516F7D4E4297A35D1869A3B8FE449A2DE9DD'
#   checksumType  = 'sha256'
# }

# Install-ChocolateyZipPackage @zipPackageArgs

# $fileName = (Get-ChildItem $toolsDir -Filter *.exe | Select-Object -First 1).Name
# $fileLocation = Join-Path $toolsDir $fileName

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $toolsDir
  fileType       = 'EXE'
  # file          = $fileLocation
  url            = 'https://mediadl.musictribe.com/download/software/tchelicon/GoXLR/app/GoXLR%20App%20V1.6.4.013.exe'
  softwareName   = 'GoXLR App*'
  checksum       = '0821B5A7ADEDC55C46BC92A7BBD9E9B486B3E06DD9CCFA1F41F09AC5FA76EFF9'
  checksumType   = 'sha256'
  silentArgs     = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes = @(0, 3010, 1641)
}

# Install-ChocolateyInstallPackage @packageArgs
Install-ChocolateyPackage @packageArgs