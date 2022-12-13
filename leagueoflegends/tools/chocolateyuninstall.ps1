$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkExe     = 'AutoHotKey'
$ahkFile    = "$toolsDir\leagueoflegends_uninstall.ahk"

$lolPackageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = 'League of Legends*'
  fileType      = 'EXE'
  silentArgs    = "--uninstall-product=league_of_legends --uninstall-patchline=live"
  validExitCodes= @(0, 3010, 1605, 1614, 1641)
}

[array]$key = Get-UninstallRegistryKey -SoftwareName $lolPackageArgs['softwareName']

if ($key.Count -eq 1) {
  $key | % {
    $file = $_.UninstallString -Split " -" | Select-Object -First 1

    $lolPackageArgs['file'] = $file

    Start-Process $ahkExe $ahkFile
    Uninstall-ChocolateyPackage @lolPackageArgs
  }
} elseif ($key.Count -eq 0) {
  Write-Warning "$packageName has already been uninstalled by other means."
} elseif ($key.Count -gt 1) {
  Write-Warning "$($key.Count) matches found!"
  Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
  Write-Warning "Please alert package maintainer the following keys were matched:"
  $key | % {Write-Warning "- $($_.DisplayName)"}
}

$rcPackageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = 'Riot Client*'
  fileType      = 'EXE'
  silentArgs    = "--uninstall-product=Riot_Client --uninstall-patchline="
  validExitCodes= @(0, 3010, 1605, 1614, 1641)
}

[array]$key = Get-UninstallRegistryKey -SoftwareName $rcPackageArgs['softwareName']

if ($key.Count -eq 1) {
  $key | % {
    $file = $_.UninstallString -Split " -" | Select-Object -First 1

    $rcPackageArgs['file'] = $file

    Start-Process $ahkExe $ahkFile
    Uninstall-ChocolateyPackage @rcPackageArgs
  }
} elseif ($key.Count -eq 0) {
  Write-Warning "$packageName has already been uninstalled by other means."
} elseif ($key.Count -gt 1) {
  Write-Warning "$($key.Count) matches found!"
  Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
  Write-Warning "Please alert package maintainer the following keys were matched:"
  $key | % {Write-Warning "- $($_.DisplayName)"}
}