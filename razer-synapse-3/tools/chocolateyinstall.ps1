$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# DO NOT CHANGE THESE MANUALLY, USE update.ps1
$RazerSynapseDependenciesSetupUrl = 'https://cdn.razersynapse.com/1660119346OLtIZnKORazerSynapseDependenciesSetup_v3.7.0830.1.exe'
$RazerCentralUrl = 'https://cdn.razersynapse.com/1692682610i2tfrqaTRazerCentral_v7.13.0.628.exe'
$GMSSetupUrl = 'https://cdn.razersynapse.com/1676531804G7ekRXhnRzGMS_Setup_V2.3.160.119.exe'
$RazerStringTranslationsSetupUrl = 'https://cdn.razersynapse.com/16989977910fnxbrasRazerStringTranslationsSetup_v3.8.1031.110315.exe'
$RazerSynapseConfigurationDataSetupUrl = 'https://cdn.razersynapse.com/16874074071Ki2KwkFRazerSynapseConfigurationDataSetup_v3.8.0630.062205.exe'
$RazerSynapseSetupUrl = 'https://cdn.razersynapse.com/16995079738ZYrnNaCRazerSynapseSetup_v3.8.1031.110912.exe'
$RazerSynapseDependenciesSetupChecksum = '3DADA5E79327C7EBBA4838AA9D7615A29310525D04213C311230FAA79E26CA1E'
$RazerCentralChecksum = '44D4ACF3D32FE29F4390B6D7F778ED22DB17651247E2CCDA1D394AC53B5BF5B4'
$GMSSetupChecksum = '3D40D6686DAA1C7C4B1B074307D139AE11843327FD21D1E6F85844BF12328850'
$RazerStringTranslationsSetupChecksum = '4FB664EF2A7D402E3E6A4255DC063F4E9A9D4CD6CFF6379F8B491EE2F4BDC99B'
$RazerSynapseConfigurationDataSetupChecksum = 'D8ED985926EEFEE644195CE994652493085F2545BB5EFD42031D149FC961235E'
$RazerSynapseSetupChecksum = '3D8EBDE6F09F5DEB4106E247E0104E41185380D461C0BA4201B40FB09204C748'

$RazerSynapseDependenciesSetupPackageArgs = @{
  packageName   = 'Razer Synapse Dependecies'
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $RazerSynapseDependenciesSetupUrl
  checksum      = $RazerSynapseDependenciesSetupChecksum
  checksumType  = 'sha256'
  silentArgs    = '/S /LWIDIR="C:\Program Files (x86)\Razer" /ISLASTMODULE=False'
  validExitCodes= @(0, 3010, 1641)
}

$RazerCentralPackageArgs = @{
  packageName   = 'Razer Central'
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $RazerCentralUrl
  checksum      = $RazerCentralChecksum
  checksumType  = 'sha256'
  silentArgs    = '/silent /ISLASTMODULE=False'
  validExitCodes= @(0, 3010, 1641)
}

$GMSSetupPackageArgs = @{
  packageName   = 'GMS'
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $GMSSetupUrl
  checksum      = $GMSSetupChecksum
  checksumType  = 'sha256'
  silentArgs    = '/S /ISLASTMODULE=False'
  validExitCodes= @(0, 3010, 1641)
}

$RazerStringTranslationsSetupPackageArgs = @{
  packageName   = 'Razer String Translation'
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $RazerStringTranslationsSetupUrl
  checksum      = $RazerStringTranslationsSetupChecksum
  checksumType  = 'sha256'
  silentArgs    = '/S /LWIDIR="C:\Program Files (x86)\Razer" /ISLASTMODULE=False'
  validExitCodes= @(0, 3010, 1641)
}

$RazerSynapseConfigurationDataSetupPackageArgs = @{
  packageName   = 'Razer Synapse Configuration Data'
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $RazerSynapseConfigurationDataSetupUrl
  checksum      = $RazerSynapseConfigurationDataSetupChecksum
  checksumType  = 'sha256'
  silentArgs    = '/S /LWIDIR="C:\Program Files (x86)\Razer" /ISLASTMODULE=False'
  validExitCodes= @(0, 3010, 1641)
}

$RazerSynapseSetupPackageArgs = @{
  packageName   = 'Razer Synapse'
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $RazerSynapseSetupUrl
  checksum      = $RazerSynapseSetupChecksum
  checksumType  = 'sha256'
  silentArgs    = '/S /LWIDIR="C:\Program Files (x86)\Razer" /ISLASTMODULE=True'
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @RazerSynapseDependenciesSetupPackageArgs
Install-ChocolateyPackage @RazerCentralPackageArgs
Install-ChocolateyPackage @GMSSetupPackageArgs
Install-ChocolateyPackage @RazerStringTranslationsSetupPackageArgs
Install-ChocolateyPackage @RazerSynapseConfigurationDataSetupPackageArgs
Install-ChocolateyPackage @RazerSynapseSetupPackageArgs
