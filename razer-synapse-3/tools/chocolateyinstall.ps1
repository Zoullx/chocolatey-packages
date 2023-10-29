$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# DO NOT CHANGE THESE MANUALLY, USE update.ps1
$RazerSynapseDependenciesSetupUrl = 'https://cdn.razersynapse.com/1660119346OLtIZnKORazerSynapseDependenciesSetup_v3.7.0830.1.exe'
$RazerCentralUrl = 'https://cdn.razersynapse.com/1692682610i2tfrqaTRazerCentral_v7.13.0.628.exe'
$GMSSetupUrl = 'https://cdn.razersynapse.com/1676531804G7ekRXhnRzGMS_Setup_V2.3.160.119.exe'
$RazerStringTranslationsSetupUrl = 'https://cdn.razersynapse.com/169763174863KM7rlURazerStringTranslationsSetup_v3.8.1030.101817.exe'
$RazerSynapseConfigurationDataSetupUrl = 'https://cdn.razersynapse.com/16874074071Ki2KwkFRazerSynapseConfigurationDataSetup_v3.8.0630.062205.exe'
$RazerSynapseSetupUrl = 'https://cdn.razersynapse.com/1698163098slsVQPj4RazerSynapseSetup_v3.8.1030.102422.exe'
$RazerSynapseDependenciesSetupChecksum = '3DADA5E79327C7EBBA4838AA9D7615A29310525D04213C311230FAA79E26CA1E'
$RazerCentralChecksum = '44D4ACF3D32FE29F4390B6D7F778ED22DB17651247E2CCDA1D394AC53B5BF5B4'
$GMSSetupChecksum = '3D40D6686DAA1C7C4B1B074307D139AE11843327FD21D1E6F85844BF12328850'
$RazerStringTranslationsSetupChecksum = '8A682E6452D980E2D93AE7F8C5E2A5A56FDF8536CDE69ED6570DE802E109BEDD'
$RazerSynapseConfigurationDataSetupChecksum = 'D8ED985926EEFEE644195CE994652493085F2545BB5EFD42031D149FC961235E'
$RazerSynapseSetupChecksum = '3B47D638912C7180D37CA26E0E88832B8DD3340CBCCF683E9286E08827ABA458'

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
