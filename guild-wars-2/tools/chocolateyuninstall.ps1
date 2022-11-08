﻿$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkExe   = 'AutoHotKey'
$ahkFile  = "$toolsDir\guild-wars-2_uninstall.ahk"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = 'Guild Wars 2'
  fileType      = 'EXE'
  silentArgs    = "-uninstall"
  validExitCodes= @(0, 3010, 1605, 1614, 1641)
}

[array]$key = Get-UninstallRegistryKey -SoftwareName $packageArgs['softwareName']

if ($key.Count -eq 1) {
  $key | % {
    $file = $_.UninstallString -Split " -" | Select-Object -First 1

    $packageArgs['file'] = $file

    Start-Process $ahkExe $ahkFile
    Uninstall-ChocolateyPackage @packageArgs
    Start-Sleep -s 5
  }
} elseif ($key.Count -eq 0) {
  Write-Warning "$packageName has already been uninstalled by other means."
} elseif ($key.Count -gt 1) {
  Write-Warning "$($key.Count) matches found!"
  Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
  Write-Warning "Please alert package maintainer the following keys were matched:"
  $key | % {Write-Warning "- $($_.DisplayName)"}
}