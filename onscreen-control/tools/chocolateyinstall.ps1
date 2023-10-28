﻿$ErrorActionPreference = 'Stop';
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$checksumType = 'sha256'

# DO NOT CHANGE THESE MANUALLY, USE update.ps1
$url      = 'https://gscs-b2c.lge.com/downloadFile?fileId=nUPbP289G9DRT8bqAsiCA'
$checksum = '73c976e780892f56285b0b1de79142157dce1bacf0e99fa0657411bd0489bca6'

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
  } else {
    $silentScript = Join-Path $toolsDir 'reinstall.iss'
  }
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
