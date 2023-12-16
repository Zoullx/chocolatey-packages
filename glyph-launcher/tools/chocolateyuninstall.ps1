$ErrorActionPreference = 'Stop';
$glyphInstallDir = Join-Path ${env:ProgramFiles(x86)} "Glyph"
$glyphProgramDataConfig = Join-Path $env:ProgramData "Glyph\GlyphLibrary.cfg"
$glyphStartMenuRunShortcutFolder = Join-Path $env:ProgramData "Microsoft\Windows\Start Menu\Programs\Glyph"
$glyphDesktopShortcut = Join-Path "$([Environment]::GetFolderPath("Desktop"))" "Glyph.lnk"

Start-WaitandStop "Glyph*"

Remove-Item $glyphInstallDir -Recurse -Force
Remove-Item $glyphProgramDataConfig -Force
Remove-Item $glyphStartMenuRunShortcutFolder -Recurse -Force
Remove-Item $glyphDesktopShortcut -Force
Remove-Item "Registry::HKEY_CLASSES_ROOT\glyph" -Recurse -Force
Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "Glyph Client" -Force
Remove-Item "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Glyph" -Recurse -Force