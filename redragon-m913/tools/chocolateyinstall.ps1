$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://cdn.shopify.com/s/files/1/0012/4957/4961/files/Redragon_M913_Software.exe?v=1591950440'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  softwareName  = 'Redragon M913 Gaming Mouse*'
  checksum      = '96D9CCFA1F1EC3431B357DCC70D64D20A3348C8FA2DE60BEC30FED884721EB03'
  checksumType  = 'sha256'
  silentArgs    = "/silent"
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs