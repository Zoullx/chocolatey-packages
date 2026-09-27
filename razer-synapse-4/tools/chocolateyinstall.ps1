$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$RazerAppEngineUrl = 'https://manifest-assets.razersynapse.com/1789694553BOrGfRHQRazerAppEngineSetup-v4.0.823.exe'
$RazerSynapse4Url = 'https://manifest-assets.razersynapse.com/1789694431HWi8mIhGRazerSynapse4-Web-v4.0.823.exe'
$RazerChromaUrl = 'https://manifest-assets.razersynapse.com/178969467491wOyrmwRazerChroma-Web-v4.0.823.exe'
$RazerCentralUrl = 'https://manifest-assets.razersynapse.com/1778658202qKgcx3XSRazerCentral_v7.23.0.1220.exe'
$RazerGameManagerUrl = 'https://manifest-assets.razersynapse.com/1785486685H9YLgvmuRazerGameManager_3.15.0.1200.exe'
$RazerAppEngineChecksum = '3f7f0be00f4a8a0304760d2dda507bdbec0b9b643dec39dffd7e9b430bb94265'
$RazerSynapse4Checksum = '477a5de23a220a33229869fbbde2e761db98f6c84da6219a46d8419fc835770b'
$RazerChromaChecksum = 'ef28b718b22791cc09ae16f7f6079a1b50017be31eab7a699b9850e838475d5e'
$RazerCentralChecksum = 'aace29226ac0cdf023dc06ebf4cfaac54597138d42810da0cbe99b8a90dc3fd8'
$RazerGameManagerChecksum = '352655029a1f3d9ba2425a2818475d2b82e29d16f874a852b426ac49edff3171'

$RazerAppEnginePackageArgs = @{
  packageName    = 'Razer App Engine'
  unzipLocation  = $toolsDir
  fileType       = 'EXE'
  url            = $RazerAppEngineUrl
  checksum       = $RazerAppEngineChecksum
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0, 3010, 1641)
}

$RazerSynapse4PackageArgs = @{
  packageName    = 'Razer Synapse 4'
  unzipLocation  = $toolsDir
  fileType       = 'EXE'
  url            = $RazerSynapse4Url
  checksum       = $RazerSynapse4Checksum
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0, 3010, 1641)
}

$RazerChromaPackageArgs = @{
  packageName    = 'Razer Chroma'
  unzipLocation  = $toolsDir
  fileType       = 'EXE'
  url            = $RazerChromaUrl
  checksum       = $RazerChromaChecksum
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0, 3010, 1641)
}

$RazerCentralPackageArgs = @{
  packageName    = 'Razer Central'
  unzipLocation  = $toolsDir
  fileType       = 'EXE'
  url            = $RazerCentralUrl
  checksum       = $RazerCentralChecksum
  checksumType   = 'sha256'
  silentArgs     = '/silent'
  validExitCodes = @(0, 3010, 1641)
}

$RazerGameManagerPackageArgs = @{
  packageName    = 'Razer Game Manager'
  unzipLocation  = $toolsDir
  fileType       = 'EXE'
  url            = $RazerGameManagerUrl
  checksum       = $RazerGameManagerChecksum
  checksumType   = 'sha256'
  silentArgs     = '/SP- /VERYSILENT /SUPRESSMSGBOXES /NORESTART'
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @RazerAppEnginePackageArgs
Install-ChocolateyPackage @RazerSynapse4PackageArgs
Install-ChocolateyPackage @RazerChromaPackageArgs
Install-ChocolateyPackage @RazerCentralPackageArgs
Install-ChocolateyPackage @RazerGameManagerPackageArgs
