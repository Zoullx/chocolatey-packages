$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# DO NOT CHANGE THESE MANUALLY, USE update.ps1
$RazerSynapseDependenciesSetupUrl = 'https://cdn.razersynapse.com/1660119346OLtIZnKORazerSynapseDependenciesSetup_v3.7.0830.1.exe'
$RazerCentralUrl = 'https://cdn.razersynapse.com/17323272942R1wGyAsRazerCentral_v7.17.0.732.exe'
$GMSSetupUrl = 'https://cdn.razersynapse.com/1729824018fkSwByXhRzGMS_Setup_V2.4.160.155.exe'
$RazerStringTranslationsSetupUrl = 'https://cdn.razersynapse.com/1729231680NrXgFZRTRazerStringTranslationsSetup_v3.9.1130.101807.exe'
$RazerSynapseConfigurationDataSetupUrl = 'https://cdn.razersynapse.com/17325863935tg0xvJmRazerSynapseConfigurationDataSetup_v3.9.1130.112605.exe'
$RazerSynapseSetupUrl = 'https://cdn.razersynapse.com/1732600232FFkCuOA7RazerSynapseSetup_v3.9.1231.112613.exe'
$RazerSynapseDependenciesSetupChecksum = '3DADA5E79327C7EBBA4838AA9D7615A29310525D04213C311230FAA79E26CA1E'
$RazerCentralChecksum = 'BEFB944B790AFD0D1A2C8D31D442DD0FD5F8569F4DD003906B316D463B0DD5A1'
$GMSSetupChecksum = '824F158D16480F628C505A168F90008679E4A86508753648B471DF8000312CE7'
$RazerStringTranslationsSetupChecksum = 'A364F32AAFD0EBB1BB58797ECDD0B8FBE84382B002DBD352969231CEDB594D6D'
$RazerSynapseConfigurationDataSetupChecksum = '669825C8D5092F114D9982C12A5207B8363FE5F6FB15CE1C772B41142BE31424'
$RazerSynapseSetupChecksum = '59755C454136F72DB59FC338C5666BB728417084B11C43CB7DD158E767D7CA23'

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
