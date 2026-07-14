$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$RazerAppEngineUrl = 'https://manifest-assets.razersynapse.com/1783511305UoZQZzlFRazerAppEngineSetup-v4.0.695.exe'
$RazerSynapse4Url = 'https://manifest-assets.razersynapse.com/1783511238Mc6ogn8gRazerSynapse4-Web-v4.0.695.exe'
$RazerChromaUrl = 'https://manifest-assets.razersynapse.com/1783511414vZ7UiWaqRazerChroma-Web-v4.0.695.exe'
$RazerCentralUrl = 'https://manifest-assets.razersynapse.com/1778658202qKgcx3XSRazerCentral_v7.23.0.1220.exe'
$RazerGameManagerUrl = 'https://manifest-assets.razersynapse.com/1771912713VmKGN0gDRazerGameManager_3.13.0.1050.exe'
$RazerAppEngineChecksum = 'b4467e364b484735fb9ce16944b29c262c6fdc8c253a57f9be092c3ff4f2aab1'
$RazerSynapse4Checksum = 'be40903e8ce15a2d9912e7f8ba2ab54d71495637d5252b06372a34e741e8dcbb'
$RazerChromaChecksum = '1fca7983ca90dae1a63f970e6f0489f382da9cb31073a1d85572719aeae9298e'
$RazerCentralChecksum = 'aace29226ac0cdf023dc06ebf4cfaac54597138d42810da0cbe99b8a90dc3fd8'
$RazerGameManagerChecksum = '82ee0061eab3929c8718736b370a70ef1956d7c1202d698a983d69e14c9ff73e'

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
