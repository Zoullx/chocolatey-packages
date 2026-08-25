$ErrorActionPreference = 'Stop';
$xgproInstallDir = Join-Path $env:SystemDrive "Xgpro"
$xgproStartMenuRunShortcutFolder = Join-Path $env:AppData "Microsoft\Windows\Start Menu\Programs\Xgpro"
$xgproDesktopShortcut = Join-Path "$([Environment]::GetFolderPath("Desktop"))" "Xgpro.lnk"

Start-WaitandStop "Xgpro*"

Remove-Item $xgproInstallDir -Recurse -Force
Remove-Item $xgproStartMenuRunShortcutFolder -Recurse -Force
Remove-Item $xgproDesktopShortcut -Force