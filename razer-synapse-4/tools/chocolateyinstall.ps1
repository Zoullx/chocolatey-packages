$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$RazerAppEngineUrl = 'https://manifest-assets.razersynapse.com/1754652226fc4V0s2BRazerAppEngineSetup-v4.0.563.exe'
$RazerSynapse4Url = 'https://manifest-assets.razersynapse.com/1754652305Bbi6eb8iRazerSynapse4-Web-v4.0.563.exe'
$RazerChromaUrl = 'https://manifest-assets.razersynapse.com/17546529453ad24dWjRazerChroma-Web-v4.0.563.exe'
$RazerCentralUrl = 'https://manifest-assets.razersynapse.com/174185873801onVKXeRazerCentral_v7.18.0.849.exe'
$RazerGameManagerUrl = 'https://manifest-assets.razersynapse.com/1748421749hhMKJNozRazerGameManager_3.10.0.917.exe'
$RazerAppEngineChecksum = '561b536e39c2f557102569fb5780014121ee256c4e15001bd832a2060de896a1'
$RazerSynapse4Checksum = 'b98f60447d8bc34abc65f116bb501c6b33ce5e750e86984f72ab6c5bf58b78b4'
$RazerChromaChecksum = 'd4e3a3a9a57b6cdea3998bfa117df704c16bd9833c02355ae6b028a31457f42d'
$RazerCentralChecksum = '007cfda793716495112fe90bd36e2b99395915cf65f5673f358c440624ba3e90'
$RazerGameManagerChecksum = '272766991ea8f6355fa17a647d0b7715c8f9019e7047f0437983817ed28ec91c'

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
