$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$checksumType = 'sha256'

# DO NOT CHANGE THESE MANUALLY, USE update.ps1
$url = 'https://lmu.lge.com/ExternalService/onscreencontrol/win/2.0/OnScreenControl_9.28.zip'
$checksum = '51096DDF31E528C36E59CDC06472A7CFAF9B3A0D348855EF1424C6F91FBCFF67'

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
  $packageMajor, $packageMinor, $packageBuild, $packageRevision = $env:ChocolateyPackageVersion -Split "\."
  $installedMajor = (Get-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{E5C1B339-0E4E-49A5-859E-5E1DE1938706}" -Name VersionMajor).VersionMajor
  $installedMinor = (Get-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{E5C1B339-0E4E-49A5-859E-5E1DE1938706}" -Name VersionMinor).VersionMinor
  if ("$packageMajor.$packageMinor" -ne "$installedMajor.$installedMinor") {
    $silentScript = Join-Path $toolsDir 'upgrade.iss'
  }
  else {
    $silentScript = Join-Path $toolsDir 'reinstall.iss'
  }
}
else {
  $silentScript = Join-Path $toolsDir 'install.iss'
}

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $toolsDir
  fileType       = 'EXE'
  file           = $fileLocation
  softwareName   = 'OnScreen Control'
  silentArgs     = "-f1`"$silentScript`" -s"
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyInstallPackage @packageArgs
