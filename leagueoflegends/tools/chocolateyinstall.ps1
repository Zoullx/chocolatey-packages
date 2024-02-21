$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://lol.secure.dyn.riotcdn.net/channels/public/x/installer/current/live.na.exe'

# DO NOT CHANGE THESE MANUALLY, USE update.ps1
$checksum = 'e5b332fb8b84eca20c4a94b84736233dc3fdd6d5d6b09cf7c75b982f35dc7751'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  softwareName  = 'League of Legends*'
  checksum      = $checksum
  checksumType  = 'sha256'
  silentArgs    = "--skip-to-install"
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
Start-WaitandStop "RiotClient*"
