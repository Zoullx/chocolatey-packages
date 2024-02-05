$ErrorActionPreference = 'Stop';

# Stop Rockstar Services
Stop-Process -Name Launcher -Force -ErrorAction SilentlyContinue
Stop-Process -Name LauncherPatcher -Force -ErrorAction SilentlyContinue
Stop-Process -Name RockstarService -Force -ErrorAction SilentlyContinue
Stop-Process -Name RockstarErrorHandler -Force -ErrorAction SilentlyContinue
Stop-Process -Name SocialClubHelper -Force -ErrorAction SilentlyContinue

[array]$key = Get-UninstallRegistryKey -SoftwareName "Rockstar*"

if ($key.Count -eq 0) {
  Write-Warning "$packageName has already been uninstalled by other means."
}
elseif ($key.Count -le 2) {
  $rstarInstallDir = Join-Path ${env:ProgramFiles} "Rockstar Games"
  $rstarStartMenuShortcutFolder = Join-Path $env:AppData "Microsoft\Windows\Start Menu\Programs\Rockstar Games"

  Remove-Item $rstarInstallDir -Recurse -Force
  Remove-Item $rstarStartMenuShortcutFolder -Recurse -Force

  $key | ForEach-Object {
    Remove-Item $_.PSPath -Recurse -Force
  }
}
