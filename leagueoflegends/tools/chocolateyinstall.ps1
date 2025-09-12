$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://lol.secure.dyn.riotcdn.net/channels/public/x/installer/current/live.na.exe'

# DO NOT CHANGE THESE MANUALLY, USE update.ps1
$checksum = '0f2af1a4754d5f3aec5ce724a4b49592889488662fb3252d6105ba19641c85d3'

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
