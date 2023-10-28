$ErrorActionPreference = 'Stop';
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$checksumType = 'sha256'

$url      = 'https://lmu.lge.com/ExternalService/onscreencontrol/win/2.0/OnScreenControl_8.04.zip'
$checksum = '512E331944353BE59DF0C41D65D41F11968504C82BDE63EE8F10AF0C06393DF4'

$zipPackageArgs = @{
  packageName   = $env:ChocolateyPackageName
  url           = $url
  unzipLocation = $toolsDir
  checksum      = $checksum
  checksumType  = $checksumType
}

Install-ChocolateyZipPackage @zipPackageArgs

$installed = Test-Path -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{E5C1B339-0E4E-49A5-859E-5E1DE1938706}"
$fileName = (Get-ChildItem $toolsDir -Filter *.exe | Select-Object -First 1).Name
$fileLocation = Join-Path $toolsDir $fileName
if ($installed) {
  $silentScript = Join-Path $toolsDir 'reinstall.iss'
} else {
  $silentScript = Join-Path $toolsDir 'install.iss'
}

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  file          = $fileLocation
  softwareName  = 'OnScreen Control'
  silentArgs    = "-f1`"$silentScript`" -s"
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyInstallPackage @packageArgs