$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
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
# Remove-Item "HKCU:\Software\Classes\glyph" -Recurse -Force
Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "Glyph Client" -Force
Remove-Item "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Glyph" -Recurse -Force

# $packageArgs = @{
#   packageName   = $env:ChocolateyPackageName
#   softwareName  = 'Glyph*'
#   fileType      = 'EXE'
#   silentArgs    = "-uninstall -silent"
#   validExitCodes= @(0, 3010, 1605, 1614, 1641, 1)
# }

# [array]$key = Get-UninstallRegistryKey -SoftwareName $packageArgs['softwareName']

# if ($key.Count -eq 1) {
#   $key | % {
#     $packageArgs['file'] = "$($_.InstallLocation)GlyphClient.exe"

#     Uninstall-ChocolateyPackage @packageArgs

#     Remove-Item $glyphInstallDir -Recurse -Force
#     Remove-Item $glyphProgramDataConfig -Force
#     Remove-Item $glyphStartMenuRunShortcutFolder -Recurse -Force
#     Remove-Item $glyphDesktopShortcut -Force
#     Remove-Item "Registry::HKEY_CLASSES_ROOT\glyph" -Recurse -Force
#     # Remove-Item "HKCU:\Software\Classes\glyph" -Recurse -Force
#     Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "Glyph Client" -Force
#     Remove-Item "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Glyph" -Recurse -Force
#   }
# } elseif ($key.Count -eq 0) {
#   Write-Warning "$packageName has already been uninstalled by other means."
# } elseif ($key.Count -gt 1) {
#   Write-Warning "$($key.Count) matches found!"
#   Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
#   Write-Warning "Please alert package maintainer the following keys were matched:"
#   $key | % {Write-Warning "- $($_.DisplayName)"}
# }