$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://dw.uptodown.com/dwn/RvVkii134Riphftvun7hQBZyU0aCwJjJMFI3FD3XyiSzvjH_FvzdGUAmcDD622WCObvj44nyAyR7Jm2iOS9lupNAcMFDJhll-J3dTfrEH14wHLCtXmP6v27x8px7Johr/O01pbOMfh3GBYEX9O5b9ExJtmHhZ00RIH4-Cbf07HFHDk2XZDa4lgjdq3zHi1zfD174G5ULyf8bGE0dtrMDFCNFYGDXCrRpZDf_5n4ukQDhCrDs9f4cg96WtXQBKo7Nr/W7EWTqA3mlWEYCGj18TVcUoLt1ZK5kFWd8Kq7B15GyyRdSQR4_GNZGg5O7Ot8ST_0r61mMF9i5Z_91KQRSu27g==/'

# DO NOT CHANGE THESE MANUALLY, USE update.ps1
$checksum = '4733b4d36089c30aa96169f87e2f5887e2d1626d9679c325d7dfe51023667ec9'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $toolsDir
  fileType       = 'EXE'
  url            = $url
  softwareName   = 'Beeper*'
  checksum       = $checksum
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
