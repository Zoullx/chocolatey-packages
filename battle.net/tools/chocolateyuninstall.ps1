﻿$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkExe     = 'AutoHotKey'
$ahkFile    = "$toolsDir\battle.net_uninstall.ahk"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = 'Battle.net*'
  fileType      = 'EXE'
  silentArgs    = '--lang=enUS --uid=battle.net --displayname="Battle.net"'
  # installArguments = "--lang=enUS --uid=battle.net --displayname='Battle.net'"
  validExitCodes= @(0, 3010, 1605, 1614, 1641)
  file          = 'C:\ProgramData\Battle.net\Agent\Blizzard Uninstaller.exe'
}

Start-Process $ahkExe $ahkFile
Uninstall-ChocolateyPackage @packageArgs

# # Get-UninstallRegistryKey is new to 0.9.10, if supporting 0.9.9.x and below,
# # take a dependency on "chocolatey-core.extension" in your nuspec file.
# # This is only a fuzzy search if $softwareName includes '*'. Otherwise it is
# # exact. In the case of versions in key names, we recommend removing the version
# # and using '*'.
# [array]$key = Get-UninstallRegistryKey -SoftwareName $packageArgs['softwareName']

# if ($key.Count -eq 1) {
#   $key | % {
#     $packageArgs['file'] = "$($_.UninstallString)" #NOTE: You may need to split this if it contains spaces, see below

#     if ($packageArgs['fileType'] -eq 'MSI') {
#       # The Product Code GUID is all that should be passed for MSI, and very
#       # FIRST, because it comes directly after /x, which is already set in the
#       # Uninstall-ChocolateyPackage msiargs (facepalm).
#       $packageArgs['silentArgs'] = "$($_.PSChildName) $($packageArgs['silentArgs'])"

#       # Don't pass anything for file, it is ignored for msi (facepalm number 2)
#       # Alternatively if you need to pass a path to an msi, determine that and
#       # use it instead of the above in silentArgs, still very first
#       $packageArgs['file'] = ''
#     } else {
#       # NOTES:
#       # - You probably will need to sanitize $packageArgs['file'] as it comes from the registry and could be in a variety of fun but unusable formats
#       # - Split args from exe in $packageArgs['file'] and pass those args through $packageArgs['silentArgs'] or ignore them
#       # - Ensure you don't pass double quotes in $file (aka $packageArgs['file']) - otherwise you will get "Illegal characters in path when you attempt to run this"
#       # - Review the code for auto-uninstaller for all of the fun things it does in sanitizing - https://github.com/chocolatey/choco/blob/bfe351b7d10c798014efe4bfbb100b171db25099/src/chocolatey/infrastructure.app/services/AutomaticUninstallerService.cs#L142-L192
#     }

#     Uninstall-ChocolateyPackage @packageArgs
#   }
# } elseif ($key.Count -eq 0) {
#   Write-Warning "$packageName has already been uninstalled by other means."
# } elseif ($key.Count -gt 1) {
#   Write-Warning "$($key.Count) matches found!"
#   Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
#   Write-Warning "Please alert package maintainer the following keys were matched:"
#   $key | % {Write-Warning "- $($_.DisplayName)"}
# }


# $ErrorActionPreference = 'Stop'
# $packageName = 'sumo'
# $packageSearch = 'KC Softwares SUMo'
# $installerType = 'exe'
# $silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
# $validExitCodes = @(0)

# Get-ItemProperty -Path @( 'HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*',
#                           'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*',
#                           'HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*' ) `
#                  -ErrorAction:SilentlyContinue `
# | Where-Object   { $_.DisplayName -like "$packageSearch" } `
# | ForEach-Object { Uninstall-ChocolateyPackage -PackageName "$packageName" `
#                                                -FileType "$installerType" `
#                                                -SilentArgs "$($silentArgs)" `
#                                                -File "$($_.UninstallString.Replace('"',''))" `
#                                                -ValidExitCodes $validExitCodes }