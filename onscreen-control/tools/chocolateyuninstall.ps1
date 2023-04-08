$ErrorActionPreference = 'Stop';
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
# $checksumType = 'sha256'

# $url      = 'https://lmu.lge.com/ExternalService/onscreencontrol/win/2.0/OnScreenControl_7.95.zip'
# $checksum = '4D5DF2C0399879B53DBC36CA958A9DCCFE6CF327A6B096EA9FC04EE90FFA3D45'

# $zipPackageArgs = @{
#   packageName   = $env:ChocolateyPackageName
#   url           = $url
#   unzipLocation = $toolsDir
#   checksum      = $checksum
#   checksumType  = $checksumType
# }

# Install-ChocolateyZipPackage @zipPackageArgs

# $fileName = (Get-ChildItem $toolsDir -Filter *.exe | Select-Object -First 1).Name
# $fileLocation = Join-Path $toolsDir $fileName
$silentScript = Join-Path $toolsDir 'uninstall.iss'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  file          = $fileLocation
  softwareName  = 'OnScreen Control'
  silentArgs    = "-runfromtemp -l0x0409 -removeonly -f1`"$silentScript`" -s"
  validExitCodes= @(0, 3010, 1605, 1614, 1641)
}

# Uninstall-ChocolateyPackage @packageArgs


# "C:\Program Files (x86)\InstallShield Installation Information\{E5C1B339-0E4E-49A5-859E-5E1DE1938706}\setup.exe" -runfromtemp -l0x0409  -removeonly

[array]$key = Get-UninstallRegistryKey -SoftwareName $packageArgs['softwareName']

if ($key.Count -eq 1) {
  $key | % {
    $file = $_.UninstallString -Split " -" | Select-Object -First 1

    $packageArgs['file'] = $file

    Uninstall-ChocolateyPackage @packageArgs
    
Remove-Item -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{E5C1B339-0E4E-49A5-859E-5E1DE1938706}"
  }
} elseif ($key.Count -eq 0) {
  Write-Warning "$packageName has already been uninstalled by other means."
} elseif ($key.Count -gt 1) {
  Write-Warning "$($key.Count) matches found!"
  Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
  Write-Warning "Please alert package maintainer the following keys were matched:"
  $key | % {Write-Warning "- $($_.DisplayName)"}
}