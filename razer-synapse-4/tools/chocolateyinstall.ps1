$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$RazerAppEngineUrl = 'https://manifest-assets.razersynapse.com/1748425693kIEF0aCBRazerAppEngineSetup-v4.0.531.exe'
$RazerSynapse4Url = 'https://manifest-assets.razersynapse.com/17484257870iF2xI3vRazerSynapse4-Web-v4.0.531.exe'
$RazerChromaUrl = 'https://manifest-assets.razersynapse.com/1748425889E0zBVcoTRazerChroma-Web-v4.0.531.exe'
$RazerCentralUrl = 'https://manifest-assets.razersynapse.com/174185873801onVKXeRazerCentral_v7.18.0.849.exe'
$RazerGameManagerUrl = 'https://manifest-assets.razersynapse.com/1747726231q154Yy4CRazerGameManager_3.9.0.905.exe'
$RazerAppEngineChecksum = '8c50764f0b43bd9f04eb1284f540396f94b6beac4e16051ea2c7a2a28ba856ff'
$RazerSynapse4Checksum = 'f9f4be52c0b21ed81440185682bc7cf193df4e22e44b567d20e79ca145c8f779'
$RazerChromaChecksum = '16f749f830e631e0a5c696234e06cceb8d46ed628827f9b59096e7eafc3cf609'
$RazerCentralChecksum = '007cfda793716495112fe90bd36e2b99395915cf65f5673f358c440624ba3e90'
$RazerGameManagerChecksum = '46547868c3feda142bdd188c461de7e5b38102d4a0aae57eaad195635907fe24'

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
