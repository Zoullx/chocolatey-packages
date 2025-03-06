$ErrorActionPreference = 'Stop'

& "C:\Windows\Installer\Razer\RazerAppEngine\uninstall.exe" """/U:C:\Windows\Installer\Razer\RazerAppEngine\uninstall.xml""" "/S"
& "C:\Windows\Installer\Razer\Razer Synapse\uninstall.exe" """/U:C:\Windows\Installer\Razer\Razer Synapse\uninstall.xml""" "/S"
& "C:\Windows\Installer\Razer\Razer Chroma\uninstall.exe" """/U:C:\Windows\Installer\Razer\Razer Chroma\uninstall.xml""" "/S"
& "C:\Windows\Installer\Razer Central\RCUninstall.exe" """/U:C:\Windows\Installer\Razer Central\RCUninstall\uninstall.xml""" "/S"
& "C:\Program Files (x86)\Razer\Razer Services\GMS3\unins000.exe" "/SP-" "/VERYSILENT" "/SUPRESSMSGBOXES" "/NORESTART"