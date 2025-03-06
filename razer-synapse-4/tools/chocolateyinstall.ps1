$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$RazerAppEngineUrl = 'https://manifest-assets.razersynapse.com/1738727264GrGfAlrLRazerAppEngineSetup-v4.0.433.exe'
$RazerSynapse4Url = 'https://manifest-assets.razersynapse.com/1738727304i3OQFi9MRazerSynapse4-Web-v4.0.433.exe'
$RazerChromaUrl = 'https://manifest-assets.razersynapse.com/1738727421TohBEd9oRazerChroma-Web-v4.0.433.exe'
$RazerCentralUrl = 'https://manifest-assets.razersynapse.com/1732602975pp88vFe1RazerCentral_v7.17.0.732.exe'
$RazerGameManagerUrl = 'https://manifest-assets.razersynapse.com/17357850615O56ifBpRazerGameManager_3.8.0.603.exe'
$RazerAppEngineChecksum = 'D855178C9D9DC765F341A049A845C0AC802311AD414444222011E33EB79B9B51'
$RazerSynapse4Checksum = '34710090364DE5A541768173A9A565771CFD4B66E3442A9FEF761C95418D79F5'
$RazerChromaChecksum = 'C1DE4FC77CCE4CFD67D620E092CA525F5C853FDA84ECE4A67C7496882734E688'
$RazerCentralChecksum = 'BEFB944B790AFD0D1A2C8D31D442DD0FD5F8569F4DD003906B316D463B0DD5A1'
$RazerGameManagerChecksum = '9A40BE50EAB4DF70F4C656D2501AB51A0D0B5388477F97F9C72ED214ACB2BFFE'

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