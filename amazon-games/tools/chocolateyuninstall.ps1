$ErrorActionPreference = 'Stop'
$amazonGamesInstallDir = Join-Path $env:LocalAppData "Amazon Games"
$amazonGamesUIDir = Join-Path $env:AppData "electron-platform"
$amazonGamesStartMenuShortcut = Join-Path $env:AppData "Microsoft\Windows\Start Menu\Programs\Amazon Games.lnk"
$glyphDesktopShortcut = Join-Path "$([Environment]::GetFolderPath("Desktop"))" "Amazon Games.lnk"

Start-WaitandStop "Amazon Games"

Remove-Item $amazonGamesInstallDir -Recurse -Force
Remove-Item $amazonGamesUIDir -Recurse -Force
Remove-Item $amazonGamesStartMenuShortcut -Force
Remove-Item $glyphDesktopShortcut -Force
Remove-Item "Registry::HKEY_CLASSES_ROOT\amazon-games" -Recurse -Force
Remove-Item "HKCU:\SOFTWARE\Amazon\Amazon Games" -Recurse -Force
Remove-Item "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{4DD10B06-78A4-4E6F-AA39-25E9C38FA568}" -Recurse -Force
Remove-Item "Registry::HKEY_CLASSES_ROOT\amazon-games" -Recurse -Force
Remove-ItemProperty -Path "Registry::HKEY_CLASSES_ROOT\Local Settings\Software\Microsoft\Windows\Shell\MuiCache" -Name "C:\Users\UserName\AppData\Local\Amazon Games\App\Amazon Games.exe.ApplicationCompany" -Force
Remove-ItemProperty -Path "Registry::HKEY_CLASSES_ROOT\Local Settings\Software\Microsoft\Windows\Shell\MuiCache" -Name "C:\Users\UserName\AppData\Local\Amazon Games\App\Amazon Games.exe.FriendlyAppName" -Force