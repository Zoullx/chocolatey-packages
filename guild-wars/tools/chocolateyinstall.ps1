$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkExe   = 'AutoHotKey'
$ahkFile  = "$toolsDir\guild-wars_install.ahk"
$url      = 'https://cloudfront.guildwars2.com/client/GwSetup.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  softwareName  = 'Guild Wars*'
  checksum      = '1779F3AF0B0E39E7BBF78C48655F51CDF5D79296B79E3CFD84A5E2CBFE89523D'
  checksumType  = 'sha256'
  validExitCodes= @(0, 3010, 1641)
}

Start-Process $ahkExe $ahkFile
Install-ChocolateyPackage @packageArgs