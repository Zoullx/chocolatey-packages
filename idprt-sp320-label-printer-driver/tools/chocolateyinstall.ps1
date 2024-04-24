$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://www.idprt.com/prt_v2/files/down_file/id/275/fid/471.html'

$zipPackageArgs = @{
  packageName   = $env:ChocolateyPackageName
  url           = $url
  unzipLocation = $toolsDir
  checksum      = 'F25B4BC9A705ACEECF3FA7865C23A3535A1D5BB418696DA4042646A75C2084AC'
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @zipPackageArgs

$fileName = (Get-ChildItem $toolsDir -Filter *.exe | Select-Object -First 1).Name
$fileLocation = Join-Path $toolsDir $fileName

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $toolsDir
  fileType       = 'EXE'
  file           = $fileLocation
  softwareName   = 'iDPRT TSPL Label Printer Windows Driver*'
  checksum       = '96446DB5007A555599F37210BB3BE0C03AE624A3B5175F996ACC1C113A99A7CA'
  checksumType   = 'sha256'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs