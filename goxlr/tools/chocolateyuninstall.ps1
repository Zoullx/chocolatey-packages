$ErrorActionPreference = 'Stop';
$goXLRDriverPackageArgs = @{
  packageName    = $env:ChocolateyPackageName
  softwareName   = '*GoXLR*'
  fileType       = 'EXE'
  silentArgs     = "/U /S"
  validExitCodes = @(0, 3010, 1605, 1614, 1641)
}

$goXLRPackageArgs = @{
  packageName    = $env:ChocolateyPackageName
  softwareName   = 'GoXLR*'
  fileType       = 'EXE'
  silentArgs     = "/SILENT"
  validExitCodes = @(0, 3010, 1605, 1614, 1641)
}

[array]$key = Get-UninstallRegistryKey -SoftwareName $goXLRPackageArgs['softwareName']

if ($key.Count -eq 1) {
  $key | ForEach-Object {
    $file = $_.UninstallString -Split " /" | Select-Object -First 1

    $goXLRPackageArgs['file'] = $file

    Uninstall-ChocolateyPackage @goXLRPackageArgs
    Start-Sleep -s 5
  }
}
elseif ($key.Count -eq 0) {
  Write-Warning "$packageName has already been uninstalled by other means."
}
elseif ($key.Count -gt 1) {
  Write-Warning "$($key.Count) matches found!"
  Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
  Write-Warning "Please alert package maintainer the following keys were matched:"
  $key | ForEach-Object { Write-Warning "- $($_.DisplayName)" }
}

[array]$key = Get-UninstallRegistryKey -SoftwareName $goXLRDriverPackageArgs['softwareName']

if ($key.Count -eq 1) {
  $key | ForEach-Object {
    $file = $_.UninstallString -Split " /" | Select-Object -First 1

    $goXLRDriverPackageArgs['file'] = $file

    Uninstall-ChocolateyPackage @goXLRDriverPackageArgs
    Start-Sleep -s 15
  }
}
elseif ($key.Count -eq 0) {
  Write-Warning "$packageName has already been uninstalled by other means."
}
elseif ($key.Count -gt 1) {
  Write-Warning "$($key.Count) matches found!"
  Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
  Write-Warning "Please alert package maintainer the following keys were matched:"
  $key | ForEach-Object { Write-Warning "- $($_.DisplayName)" }
}
