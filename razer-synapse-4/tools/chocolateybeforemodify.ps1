# This runs before upgrade or uninstall.
# Use this file to do things like stop services prior to upgrade or uninstall.
# NOTE: It is an anti-pattern to call chocolateyUninstall.ps1 from here. If you
#  need to uninstall an MSI prior to upgrade, put the functionality in this
#  file without calling the uninstall script. Make it idempotent in the
#  uninstall script so that it doesn't fail when it is already uninstalled.
# NOTE: For upgrades - like the uninstall script, this script always runs from
#  the currently installed version, not from the new upgraded package version.
$ErrorActionPreference = 'Stop';
$razerStringTranslationsPackageArgs = @{
  packageName    = 'Razer String Translations'
  file           = 'C:\ProgramData\Razer\Synapse3\Uninstall\RazerStringTranslations\RazerStringTranslationsUninstall.exe'
  fileType       = 'EXE'
  silentArgs     = '/S'
  validExitCodes = @(0, 3010, 1605, 1614, 1641)
}

$razerSynapseConfigurationDataPackageArgs = @{
  packageName    = 'Razer Synapse Configuration Data'
  file           = 'C:\ProgramData\Razer\Synapse3\Uninstall\RazerSynapseConfigurationData\RazerSynapseConfigurationDataUninstall.exe'
  fileType       = 'EXE'
  silentArgs     = '/S'
  validExitCodes = @(0, 3010, 1605, 1614, 1641)
}

$razerSynapsePackageArgs = @{
  packageName    = 'Razer Synapse'
  file           = 'C:\ProgramData\Razer\Synapse3\Uninstall\RazerSynapse\RazerSynapseUninstall.exe'
  fileType       = 'EXE'
  silentArgs     = '/S'
  validExitCodes = @(0, 3010, 1605, 1614, 1641)
}

if (Test-Path -Path "HKLM:\SOFTWARE\Razer\Synapse3") {
  Uninstall-ChocolateyPackage @razerStringTranslationsPackageArgs
  Uninstall-ChocolateyPackage @razerSynapseConfigurationDataPackageArgs
  Uninstall-ChocolateyPackage @razerSynapsePackageArgs
}