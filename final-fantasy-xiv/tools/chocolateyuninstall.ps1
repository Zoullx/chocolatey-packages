$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkExe     = 'AutoHotKey'
$ahkFile    = "$toolsDir\final-fantasy-xiv_uninstall.ahk"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = 'FINAL FANTASY XIV ONLINE*'
  fileType      = 'EXE'
  silentArgs    = '-runfromtemp -l0x0009 -removeonly'
  validExitCodes= @(0, 3010, 1605, 1614, 1641)
  file          = 'C:\Program Files (x86)\InstallShield Installation Information\{2B41E132-07DF-4925-A3D3-F2D1765CCDFE}\setup.exe'
}

Start-Process $ahkExe $ahkFile
Uninstall-ChocolateyPackage @packageArgs
Start-Sleep -s 10