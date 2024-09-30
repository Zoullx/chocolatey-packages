$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://lol.secure.dyn.riotcdn.net/channels/public/x/installer/current/live.na.exe'

# DO NOT CHANGE THESE MANUALLY, USE update.ps1
$checksum = 'f2cb802521315185423c51c088927e95899c78cfcf4b7a2ae8efd85b5f2e428e'

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
