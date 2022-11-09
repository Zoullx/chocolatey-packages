$ErrorActionPreference = 'Stop';

& "C:\Windows\Installer\Razer Central\RCUninstall.exe" "/U:C:\Windows\Installer\Razer Central\RCUninstall\uninstall.xml" "/S"
& "C:\Windows\Installer\Razer Game Manager Service\RzGMSuninstall.exe" "/U:C:\ProgramData\Razer\GMS\RzGMSUninstall\uninstall.xml" "/S"
& "C:\ProgramData\Razer\Synapse3\Uninstall\RazerStringTranslations\RazerStringTranslationsUninstall.exe" "/S"
& "C:\ProgramData\Razer\Synapse3\Uninstall\RazerSynapseConfigurationData\RazerSynapseConfigurationDataUninstall.exe" "/S"
& "C:\ProgramData\Razer\Synapse3\Uninstall\RazerSynapse\RazerSynapseUninstall.exe" "/S"