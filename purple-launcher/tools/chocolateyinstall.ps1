$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url = 'https://dw.uptodown.net/dwn/RvVkii134Riphftvun7hQBZyU0aCwJjJMFI3FD3XyiRG_EkDcqCx3GdZA6pJEYTIXrvo6lqoOlYyP3U76hSXO3MOFvm-fbXPfmMIX0hgTEl1LZ7Elt1VdOIl7Ozcb40g/wUUUrrKKn47QfLZ1txkler3aGHxNree99keo59iJc0N2OhqWTXk261Wm1Km2GtsiwA2dc9M5RcLOFMc122KaAsqNqXw9XDKrLwKVy67sDrvt09NfWn5sYNyuiQBNYLco/G2KGhx9NUfJtkxNUom1w2A-_XHFMepYxgkJ5RfyStTp2ZAv46H2JwX6rzQsj1CsI_6fIRHW1bFd1k_HmrK0bag==/purple-2-25-716-22.exe'
$checksum = 'FC82388A209C53DEB638E498B95A7435058FF1F4327D9545B442C818AAA57CBC'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $toolsDir
  fileType       = 'EXE'
  url            = $url
  url64bit       = $url64
  softwareName   = 'PURPLE'
  checksum       = $checksum
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs