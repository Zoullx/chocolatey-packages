$ErrorActionPreference = 'Stop';
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$checksumType = 'sha256'

$url      = 'https://gscs-b2c.lge.com/downloadFile?fileId=2DPPmX8OarXpELvvB8qMww'
$checksum = '2273FA80CD453F24985648F078981BCE0DC81353418DAD62C9EEDA4EFBF76BF7'

$zipPackageArgs = @{
  packageName   = $env:ChocolateyPackageName
  url           = $url
  unzipLocation = $toolsDir
  checksum      = $checksum
  checksumType  = $checksumType
}

Install-ChocolateyZipPackage @zipPackageArgs

$fileName = (Get-ChildItem $toolsDir -Filter *.exe | Select-Object -First 1).Name
$fileLocation = Join-Path $toolsDir $fileName
$silentScript = Join-Path $toolsDir 'install.iss'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  file          = $fileLocation
  softwareName  = 'LG UltraGear Control Center'
  silentArgs    = "-f1`"$silentScript`" -s"
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyInstallPackage @packageArgs