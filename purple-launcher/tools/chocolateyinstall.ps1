$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url = 'https://dw.uptodown.net/dwn/g081nXyZ9qx5JnstDDnoCR3IcZv5cxyuqdt4FEK7kdJa0PvM61jLA72PcCLFLwRXvzKyzTBsNuKsxJ8XnITyMygop-nFRFMqVN2veZsKaEEcGvukA2ivRH7H7GAHwUQy/7zdyYeoKoq6BLJN2nnLsGE1apIKALOsmWZ-e5ghtZZ487TrHk_ANY6L6EDK9SjgP_suXt-70YuJc9AYjlSql8ipVI5T6UX7kTASNG7W-QtSRgLGVdJ8t8wsR4mN4Tjwb/MSISFGWUq-Cikl0CROgZIiZ2XmSpx0IhE5_W6jsB7TxonjIuCek_rToSS7MkewwgvLE-AKXrsAaFizjXJarTEA==/purple-2-25-728-14.exe'
$checksum = 'C992513DAAE37306975591A2BB73C1C383B2BBDD452EDB9FEDEFFF4CF1CB01E5'

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