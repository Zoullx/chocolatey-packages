$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$uninstallScript = Join-Path $toolsDir 'eve-online_uninstall.qs'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = 'EVE Online*'
  fileType      = 'EXE'
  silentArgs    = "--script $uninstallScript"
  validExitCodes= @(0, 3010, 1605, 1614, 1641, 1)
}

[array]$key = Get-UninstallRegistryKey -SoftwareName $packageArgs['softwareName']

if ($key.Count -eq 1) {
  $key | % {
    $packageArgs['file'] = "$($_.UninstallString)"

    Uninstall-ChocolateyPackage @packageArgs

    Remove-Item -Path "HKCU:\SOFTWARE\CCP\EVEONLINE"
  }
} elseif ($key.Count -eq 0) {
  Write-Warning "$packageName has already been uninstalled by other means."
} elseif ($key.Count -gt 1) {
  Write-Warning "$($key.Count) matches found!"
  Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
  Write-Warning "Please alert package maintainer the following keys were matched:"
  $key | % {Write-Warning "- $($_.DisplayName)"}
}