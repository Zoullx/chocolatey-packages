$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# DO NOT CHANGE THESE MANUALLY, USE update.ps1
$RazerSynapseDependenciesSetupUrl = 'https://cdn.razersynapse.com/1636529708apzqqkJyRazerSynapseDependenciesSetup_v3.6.1114.1.exe'
$RazerCentralUrl = 'https://cdn.razersynapse.com/16451840740cGZUAd2RazerCentral_v7.3.35.234.exe'
$GMSSetupUrl = 'https://cdn.razersynapse.com/1637126918NTD1BQjFRzGMS_Setup_V2.0.160.96.exe'
$RazerStringTranslationsSetupUrl = 'https://cdn.razersynapse.com/1645757317l2oj0nFFRazerStringTranslationsSetup_v3.7.0228.022504.exe'
$RazerSynapseConfigurationDataSetupUrl = 'https://cdn.razersynapse.com/1645773526hAk1MLvTRazerSynapseConfigurationDataSetup_v3.7.0228.022514.exe'
$RazerSynapseSetupUrl = 'https://cdn.razersynapse.com/1646042181tNtpXEOHRazerSynapseSetup_v3.7.0228.022817.exe'
$RazerSynapseDependenciesSetupChecksum = 'F21BFD1C50DB5E9A6E4CFA43CDBB2E768BCD0C1779EAF9F61826EF0B7729D968'
$RazerCentralChecksum = 'C04F456450178B55A67EF3993AC4BD146A471A675F35677A2337024E48B0F5D8'
$GMSSetupChecksum = 'C14A80E9A3F08723FE76AED4AA0921E0970DEF69462A837EE9FF62F8B83FB0D3'
$RazerStringTranslationsSetupChecksum = '7024550DC39B3D1BCFA73503FFB3377D34F252DC0968CAF97FBA830EEEF6D831'
$RazerSynapseConfigurationDataSetupChecksum = '0B26EAD7EDB9A8250AD6513353E2E4591E66FEBCAE58D25F2C3D92A477B71CD7'
$RazerSynapseSetupChecksum = 'D2F968AC1965A95D9AE705EB7C0456EC2B18729C634C63B9B830C929D0FFCFB3'

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