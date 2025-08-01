$ErrorActionPreference = 'Stop'
$razerAppEnginePackageArgs = @{
  packageName    = 'Razer App Engine'
  file           = 'C:\Windows\Installer\Razer\RazerAppEngine\uninstall.exe'
  fileType       = 'EXE'
  silentArgs     = '"/U:C:\Windows\Installer\Razer\RazerAppEngine\uninstall.xml" /S'
  validExitCodes = @(0, 3010, 1605, 1614, 1641)
}

$razerSynapsePackageArgs = @{
  packageName    = 'Razer Synapse 4'
  file           = 'C:\Windows\Installer\Razer\Razer Synapse\uninstall.exe'
  fileType       = 'EXE'
  silentArgs     = '"/U:C:\Windows\Installer\Razer\Razer Synapse\uninstall.xml" /S'
  validExitCodes = @(0, 3010, 1605, 1614, 1641)
}

$razerGameManagerPackageArgs = @{
  packageName    = 'Razer Game Manager'
  file           = 'C:\Program Files (x86)\Razer\Razer Services\GMS3\unins000.exe'
  fileType       = 'EXE'
  silentArgs     = '/SP- /VERYSILENT /SUPRESSMSGBOXES /NORESTART'
  validExitCodes = @(0, 3010, 1605, 1614, 1641)
}

$razerChromaPackageArgs = @{
  packageName    = 'Razer Chroma'
  file           = 'C:\Windows\Installer\Razer\Razer Chroma\uninstall.exe'
  fileType       = 'EXE'
  silentArgs     = '"/U:C:\Windows\Installer\Razer\Razer Chroma\uninstall.xml" /S'
  validExitCodes = @(0, 3010, 1605, 1614, 1641)
}

$razerCentralPackageArgs = @{
  packageName    = 'Razer Central'
  file           = 'C:\Windows\Installer\Razer Central\RCUninstall.exe'
  fileType       = 'EXE'
  silentArgs     = '"/U:C:\Windows\Installer\Razer Central\RCUninstall\uninstall.xml" /S'
  validExitCodes = @(0, 3010, 1605, 1614, 1641)
}

Uninstall-ChocolateyPackage @razerAppEnginePackageArgs
Uninstall-ChocolateyPackage @razerSynapsePackageArgs
Uninstall-ChocolateyPackage @razerGameManagerPackageArgs
Uninstall-ChocolateyPackage @razerChromaPackageArgs
Uninstall-ChocolateyPackage @razerCentralPackageArgs