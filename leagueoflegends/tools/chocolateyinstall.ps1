$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://lol.secure.dyn.riotcdn.net/channels/public/x/installer/current/live.na.exe'

# DO NOT CHANGE THESE MANUALLY, USE update.ps1
$checksum = 'e9d9146a6c195e59dd37fa2fd6a96be3b4f3f02731ec6bba39d9578de261421a'

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
