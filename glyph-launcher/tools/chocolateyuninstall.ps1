$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkExe     = 'AutoHotKey'
$ahkFile    = "$toolsDir\glyph-launcher_uninstall.ahk"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = 'Glyph*'
  fileType      = 'EXE'
  validExitCodes= @(0, 3010, 1605, 1614, 1641, 1)
  file          = 'C:\Program Files (x86)\Glyph\glyphuninstall.exe'
}

Start-Process $ahkExe $ahkFile
Uninstall-ChocolateyPackage @packageArgs
Start-Sleep -s 10