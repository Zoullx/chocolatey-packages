$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://file2-cdn.creality.com/file/af1e98f749d158f5847187618c438279/Creality_Print-v5.0.0.8636-win64-Release.exe?spm=..page_11484911.download+card_1.1'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $toolsDir
  fileType       = 'EXE'
  url            = $url
  softwareName   = 'Creality Print 5.0'
  checksum       = '8F5F8D5D4712AE7E2C3CCEBE668D8B0CD0BB8C230218E6C4B907EFA825DF7DFD'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs