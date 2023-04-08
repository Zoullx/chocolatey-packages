$ErrorActionPreference = 'Stop';
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$checksumType = 'sha256'

$url      = 'https://lmu.lge.com/ExternalService/onscreencontrol/win/2.0/OnScreenControl_7.95.zip'
$checksum = '4D5DF2C0399879B53DBC36CA958A9DCCFE6CF327A6B096EA9FC04EE90FFA3D45'

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