$ErrorActionPreference = 'Stop';
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://downloader.battle.net/download/getInstallerForGame?os=win&gameProgram=BATTLENET_APP&version=Live'
$fileLocation = Join-Path $toolsDir 'Battle.net-Setup.exe'
$checksumType = 'sha256'

Invoke-WebRequest $url -OutFile $fileLocation -UseBasicParsing
$checksum = (Get-FileHash $fileLocation -Algorithm $checksumType).Hash

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  file          = $fileLocation
  softwareName  = 'Battle.net*'
  checksum      = $checksum
  checksumType  = $checksumType
  silentArgs    = '--lang=enUS --installpath="C:\Program Files (x86)\Battle.net"'
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
Start-WaitandStop "Battle.net*"