$ErrorActionPreference = 'Stop'
$amazonGamesInstallDir = Join-Path $env:LocalAppData "Amazon Games"
$amazonGamesStartMenuShortcut = Join-Path $env:AppData "Microsoft\Windows\Start Menu\Programs\Amazon Games.lnk"
$glyphDesktopShortcut = Join-Path "$([Environment]::GetFolderPath("Desktop"))" "Amazon Games.lnk"

Start-WaitandStop 'Amazon Games*'

Remove-Item $amazonGamesInstallDir -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item $amazonGamesStartMenuShortcut -Force -ErrorAction SilentlyContinue
Remove-Item $glyphDesktopShortcut -Force -ErrorAction SilentlyContinue
Remove-Item "Registry::HKEY_CLASSES_ROOT\amazon-games" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "HKCU:\SOFTWARE\Amazon\Amazon Games" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{4DD10B06-78A4-4E6F-AA39-25E9C38FA568}" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "Registry::HKEY_CLASSES_ROOT\amazon-games" -Recurse -Force -ErrorAction SilentlyContinue

if (Test-Path -Path "Registry::HKEY_CLASSES_ROOT\Local Settings\Software\Microsoft\Windows\Shell\MuiCache") {
  Get-ItemProperty -Path "Registry::HKEY_CLASSES_ROOT\Local Settings\Software\Microsoft\Windows\Shell\MuiCache" |
  Select-Object -Property * |
  ForEach-Object {
    $_.PSObject.Properties |
    Where-Object { $_.Name -like "*Amazon Games*" -or $_.Name -like "*AmazonGames*" } |
    ForEach-Object {
      Remove-ItemProperty -Path "Registry::HKEY_CLASSES_ROOT\Local Settings\Software\Microsoft\Windows\Shell\MuiCache" -Name $_.Name -Force
    }
  }
}
