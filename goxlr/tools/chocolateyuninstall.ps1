$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$goXLRPackageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = '*GoXLR*'
  fileType      = 'EXE'
  silentArgs    = '/SILENT'
  validExitCodes= @(0, 3010, 1605, 1614, 1641)
  file          = 'C:\Program Files (x86)\TC-Helicon\GOXLR\unins000.exe'
}

$goXLRDriverPackageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = 'GoXLR*'
  fileType      = 'EXE'
  silentArgs    = '/U /S'
  validExitCodes= @(0, 3010, 1605, 1614, 1641)
  file          = 'C:\Program Files\TC-Helicon\GoXLR_Audio_Driver\setup.exe'
}

Uninstall-ChocolateyPackage @goXLRPackageArgs
Uninstall-ChocolateyPackage @goXLRDriverPackageArgs