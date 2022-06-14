$ErrorActionPreference = 'Stop';
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = 'TC-HELICON GoXLR USB Audio Driver*'
  fileType      = 'EXE'
  file          = "C:\Program Files\TC-HELICON\GoXLR_Audio_Driver\setup.exe"
  silentArgs    = "/U /S"
  validExitCodes= @(0, 3010, 1605, 1614, 1641)
}

Uninstall-ChocolateyPackage @packageArgs