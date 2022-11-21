$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# DO NOT CHANGE THESE MANUALLY, USE update.ps1
$RazerSynapseDependenciesSetupUrl = 'https://cdn.razersynapse.com/1660119346OLtIZnKORazerSynapseDependenciesSetup_v3.7.0830.1.exe'
$RazerCentralUrl = 'https://cdn.razersynapse.com/16672675016HwfFK3ERazerCentral_v7.8.0.381.exe'
$GMSSetupUrl = 'https://cdn.razersynapse.com/16449937295FFXHFSKRzGMS_Setup_V2.0.160.96.exe'
$RazerStringTranslationsSetupUrl = 'https://cdn.razersynapse.com/1667463402hT61IyLORazerStringTranslationsSetup_v3.7.1103.110315.exe'
$RazerSynapseConfigurationDataSetupUrl = 'https://cdn.razersynapse.com/1666173239iUquYXj8RazerSynapseConfigurationDataSetup_v3.7.1103.101914.exe'
$RazerSynapseSetupUrl = 'https://cdn.razersynapse.com/1667811903eJbGpp7NRazerSynapseSetup_v3.7.1103.110716.exe'
$RazerSynapseDependenciesSetupChecksum = '3DADA5E79327C7EBBA4838AA9D7615A29310525D04213C311230FAA79E26CA1E'
$RazerCentralChecksum = 'C50F10CD43D2B5244129D5492289C5D52768407BC01C47A11AAC88CD5181CF94'
$GMSSetupChecksum = 'C14A80E9A3F08723FE76AED4AA0921E0970DEF69462A837EE9FF62F8B83FB0D3'
$RazerStringTranslationsSetupChecksum = 'A4DEFE9BC3EC1158300B9EBE57D567396E974C59CB3ECFCB3A34FD4F62C826F0'
$RazerSynapseConfigurationDataSetupChecksum = '7FA2196DDD9FAD1A9864EE808132E5FB59E88013F748816B796A7EE4381FBCFF'
$RazerSynapseSetupChecksum = 'AE9F179626B54803F5FBBC7DBD5BB3EE8333628D68A1E146A35E8741159E7E33'

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
