$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# DO NOT CHANGE THESE MANUALLY, USE update.ps1
$RazerSynapseDependenciesSetupUrl = 'https://cdn.razersynapse.com/1660119346OLtIZnKORazerSynapseDependenciesSetup_v3.7.0830.1.exe'
$RazerCentralUrl = 'https://cdn.razersynapse.com/1718868442PNDrFGTfRazerCentral_v7.16.0.695.exe'
$GMSSetupUrl = 'https://cdn.razersynapse.com/1676531804G7ekRXhnRzGMS_Setup_V2.3.160.119.exe'
$RazerStringTranslationsSetupUrl = 'https://cdn.razersynapse.com/1719484136f9tIMdt7RazerStringTranslationsSetup_v3.9.0630.062717.exe'
$RazerSynapseConfigurationDataSetupUrl = 'https://cdn.razersynapse.com/1716263614slNcWKLSRazerSynapseConfigurationDataSetup_v3.9.0531.052103.exe'
$RazerSynapseSetupUrl = 'https://cdn.razersynapse.com/1719470823SehqKvtZRazerSynapseSetup_v3.9.0630.062714.exe'
$RazerSynapseDependenciesSetupChecksum = '3DADA5E79327C7EBBA4838AA9D7615A29310525D04213C311230FAA79E26CA1E'
$RazerCentralChecksum = '9805053A89F33D3E4EB6CADD59E20B05661F6E40FBECD50062FFD6FB82AC3471'
$GMSSetupChecksum = '3D40D6686DAA1C7C4B1B074307D139AE11843327FD21D1E6F85844BF12328850'
$RazerStringTranslationsSetupChecksum = '268005BD66805B48522C9CF7E6F9A68353EABE1B26C48925D42E4AA0EB51D5E5'
$RazerSynapseConfigurationDataSetupChecksum = 'D1F917A60EDA782629E6AF3BE4B8645BC31FC9D50B01548F2BDD46954201241A'
$RazerSynapseSetupChecksum = '60E57651A7509A444548686524192319905F5183A0B912C041090D06ED4E2C2B'

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
