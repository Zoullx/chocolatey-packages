$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ffInstallDir = Join-Path ${env:ProgramFiles(x86)} "SquareEnix"
$ffInstallShieldDir = Join-Path ${env:ProgramFiles(x86)} "InstallShield Installation Information\{2B41E132-07DF-4925-A3D3-F2D1765CCDFE}"
$installShieldDir = Join-Path ${env:ProgramFiles(x86)} "InstallShield Installation Information"
$ffStartMenuRunShortcutFolder = Join-Path $env:ProgramData "Microsoft\Windows\Start Menu\Programs\SQUARE ENIX"

Remove-Item $ffInstallDir -Recurse -Force
Remove-Item $ffInstallShieldDir -Recurse -Force
if (-not Test-Path -Path $installShieldDir) {
    Remove-Item $installShieldDir -Force
}
Remove-Item $ffStartMenuRunShortcutFolder -Recurse -Force
Remove-Item "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{2B41E132-07DF-4925-A3D3-F2D1765CCDFE}" -Recurse -Force