$ErrorActionPreference = 'Stop';
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = 'League of Legends*'
  fileType      = 'EXE'
  silentArgs    = "--uninstall-product=league_of_legends --uninstall-patchline=live"
  validExitCodes= @(0, 3010, 1605, 1614, 1641)
  file          = "C:\Riot Games\Riot Client\RiotClientServices.exe"
}

Uninstall-ChocolateyPackage @packageArgs