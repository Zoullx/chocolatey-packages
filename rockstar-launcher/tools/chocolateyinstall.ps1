$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$checksumType = 'sha256'
$7zip = Join-Path "$env:ChocolateyInstall" 'tools\7z.exe'
$rstarInstallUnzipFile = Join-Path $toolsDir 'Rockstar-Games-Launcher.exe'
$rstarInstallUnzipFileDir = Join-Path $toolsDir 'Rockstar'
$rstarCabUnzipFile = Join-Path $rstarInstallUnzipFileDir '251.cab'
$rstarDllUnzipFile = Join-Path $rstarInstallUnzipFileDir '251\a10'
$rstarCabUnzipFileDir = Join-Path $rstarInstallUnzipFileDir '251'
$rstarDllUnzipFileDir = Join-Path $rstarInstallUnzipFileDir '251\a10extracted'
$rstarInstallParams = "x `"$rstarInstallUnzipFile`" -t#:e -aoa -bd -bb1 -o`"$rstarInstallUnzipFileDir`" -y"
$rstarInstallDir = Join-Path ${env:ProgramFiles} "Rockstar Games\Launcher"
$rstarStartMenuRunShortcutFolder = Join-Path $env:AppData "Microsoft\Windows\Start Menu\Programs\Rockstar Games"
$rstarStartMenuRunShortcut = Join-Path $rstarStartMenuRunShortcutFolder "Rockstar Games Launcher.lnk"
$rstarRunTarget = Join-Path $rstarInstallDir "LauncherPatcher.exe"
$url = 'https://gamedownloads.rockstargames.com/public/installer/Rockstar-Games-Launcher.exe'

# DO NOT CHANGE THESE MANUALLY, USE update.ps1
$checksum = '141ff9af883a01e924a49bc4a21e2f05cfacebb5980880b4a53d7cb332986601'

# Stop Rockstar Services
Stop-Process -Name Launcher -Force -ErrorAction SilentlyContinue
Stop-Process -Name RockstarService -Force -ErrorAction SilentlyContinue
Stop-Process -Name SocialClubHelper -Force -ErrorAction SilentlyContinue

# Download EXE
$webFileArgs = @{
  packageName  = $env:ChocolateyPackageName
  url          = $url
  file         = $rstarInstallUnzipFile
  checksum     = $checksum
  checksumType = $checksumType
}

Get-ChocolateyWebFile @webFileArgs

# Extract files from EXE
$rstarInstallExtractProcess = New-Object System.Diagnostics.Process
$rstarInstallExtractProcess.EnableRaisingEvents = $true

$rstarInstallExtractProcess.StartInfo = New-Object System.Diagnostics.ProcessStartInfo($7zip, $rstarInstallParams)
$rstarInstallExtractProcess.StartInfo.RedirectStandardOutput = $true
$rstarInstallExtractProcess.StartInfo.RedirectStandardError = $true
$rstarInstallExtractProcess.StartInfo.UseShellExecute = $false
$rstarInstallExtractProcess.StartInfo.WorkingDirectory = $workingDirectory
$rstarInstallExtractProcess.StartInfo.WindowStyle = [System.Diagnostics.ProcessWindowStyle]::Hidden
$rstarInstallExtractProcess.StartInfo.CreateNoWindow = $true

$rstarInstallExtractProcess.Start() | Out-Null
if ($rstarInstallExtractProcess.StartInfo.RedirectStandardOutput) { $rstarInstallExtractProcess.BeginOutputReadLine() }
if ($rstarInstallExtractProcess.StartInfo.RedirectStandardError) { $rstarInstallExtractProcess.BeginErrorReadLine() }
$rstarInstallExtractProcess.WaitForExit()
$rstarInstallExtractProcess.Dispose()

# Extract Cab file
Get-ChocolateyUnzip -FileFullPath $rstarCabUnzipFile -Destination $rstarCabUnzipFileDir

# Extract DLL files
Get-ChocolateyUnzip -FileFullPath $rstarDllUnzipFile -Destination $rstarDllUnzipFileDir

# Create Program Files folders to prepare for copying files
New-Item "$rstarInstallDir\Redistributables\VCRed" -ItemType Directory -Force
New-Item "$rstarInstallDir\ThirdParty\Steam" -ItemType Directory -Force

# Copy VC++ Redistributables
Copy-Item "$rstarInstallUnzipFileDir\249.exe" "$rstarInstallDir\Redistributables\VCRed\vc_redist.x64.exe" -Force
Copy-Item "$rstarInstallUnzipFileDir\252.exe" "$rstarInstallDir\Redistributables\VCRed\vc_redist.x86.exe" -Force

# check if newer VC++ Redistributables are already installed
$keys = Get-UninstallRegistryKey -SoftwareName '*Visual C++*Redistributable*'
$vcAlreadyInstalled = $keys | Where-Object { [version]($_.DisplayVersion) -gt [version]'14.36.32532.0' }

if (-not $vcAlreadyInstalled) {
  # Install VC++ Redistributables
  $vc64InstallPackageArgs = @{
    packageName    = $env:ChocolateyPackageName
    fileType       = 'EXE'
    file           = "$rstarInstallDir\Redistributables\VCRed\vc_redist.x64.exe"
    silentArgs     = "/install /quiet /norestart"
    validExitCodes = @(0, 3010, 1641, 1638)
    softwareName   = 'Visual C++ Redistributable x64*'
  }

  Install-ChocolateyInstallPackage @vc64InstallPackageArgs

  $vc86InstallPackageArgs = @{
    packageName    = $env:ChocolateyPackageName
    fileType       = 'EXE'
    file           = "$rstarInstallDir\Redistributables\VCRed\vc_redist.x86.exe"
    silentArgs     = "/install /quiet /norestart"
    validExitCodes = @(0, 3010, 1641, 1638)
    softwareName   = 'Visual C++ Redistributable x86*'
  }

  Install-ChocolateyInstallPackage @vc86InstallPackageArgs
}

# Copy Steam DLL
Copy-Item "$rstarInstallUnzipFileDir\255.steam_api.dll" "$rstarInstallDir\ThirdParty\Steam\steam_api64.dll" -Force

# Copy API DLLs
Copy-Item "$rstarDllUnzipFileDir\" "$rstarInstallDir" -Filter "api*.dll" -Force
# Rename API DLLs from having _'s to having -'s
Get-ChildItem "$rstarInstallDir\*.dll" | Rename-Item -NewName { $_.Name -replace '_', '-' }

# Copy remaining Program Files files
Copy-Item "$rstarInstallUnzipFileDir\42.Launcher.exe" "$rstarInstallDir\Launcher.exe" -Force
Copy-Item "$rstarInstallUnzipFileDir\43" "$rstarInstallDir\Launcher.rpf" -Force
Copy-Item "$rstarInstallUnzipFileDir\44.LauncherPatcher.exe" "$rstarInstallDir\LauncherPatcher.exe" -Force
Copy-Item "$rstarInstallUnzipFileDir\45.dll" "$rstarInstallDir\libovr.dll" -Force
Copy-Item "$rstarInstallUnzipFileDir\46.zip" "$rstarInstallDir\offline.pak" -Force
Copy-Item "$rstarInstallUnzipFileDir\202.RockstarService.exe" "$rstarInstallDir\RockstarService.exe" -Force
Copy-Item "$rstarInstallUnzipFileDir\203.RockstarSteamHelper.exe" "$rstarInstallDir\RockstarSteamHelper.exe" -Force
Copy-Item "$rstarInstallUnzipFileDir\204.ucrtbase.dll" "$rstarInstallDir\ucrtbase.dll" -Force
Copy-Item "$rstarInstallUnzipFileDir\205.Rockstar-Games-Launcher.exe" "$rstarInstallDir\uninstall.exe" -Force

# Create registry entries
New-Item "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Rockstar Games Launcher" -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Rockstar Games Launcher" -Name "DisplayName" -Value "Rockstar Games Launcher" -PropertyType "String" -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Rockstar Games Launcher" -Name "DisplayIcon" -Value "C:\Program Files\Rockstar Games\Launcher\Launcher.exe, 0" -PropertyType "String" -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Rockstar Games Launcher" -Name "DisplayVersion" -Value "$env:ChocolateyPackageVersion" -PropertyType "String" -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Rockstar Games Launcher" -Name "Publisher" -Value "Rockstar Games" -PropertyType "String" -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Rockstar Games Launcher" -Name "InstallLocation" -Value "C:\Program Files\Rockstar Games\Launcher" -PropertyType "String" -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Rockstar Games Launcher" -Name "EstimatedSize" -Value "$((Get-ChildItem $rstarInstallDir -recurse | Measure-Object -property length -sum).Sum -replace ".{3}$")" -PropertyType "DWord" -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Rockstar Games Launcher" -Name "UninstallString" -Value "C:\Program Files\Rockstar Games\Launcher\uninstall.exe" -PropertyType "String" -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Rockstar Games Launcher" -Name "QuietUninstallString" -Value "`"C:\Program Files\Rockstar Games\Launcher\uninstall.exe`" /S" -PropertyType "String" -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Rockstar Games Launcher" -Name "HelpLink" -Value "https://www.rockstargames.com/support" -PropertyType "String" -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Rockstar Games Launcher" -Name "URLInfoAbout" -Value "https://www.rockstargames.com/support" -PropertyType "String" -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Rockstar Games Launcher" -Name "URLUpdateInfo" -Value "https://www.rockstargames.com" -PropertyType "String" -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Rockstar Games Launcher" -Name "NoModify" -Value 1 -PropertyType "DWord" -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Rockstar Games Launcher" -Name "NoRepair" -Value 1 -PropertyType "DWord" -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Rockstar Games Launcher" -Name "Comments" -Value "Rockstar Games Launcher" -PropertyType "String" -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Rockstar Games Launcher" -Name "Readme" -Value "https://www.rockstargames.com/support" -PropertyType "String" -Force

# Create shortcut
Install-ChocolateyShortcut -ShortcutFilePath $rstarStartMenuRunShortcut -TargetPath $rstarRunTarget -WorkingDirectory "$rstarInstallDir\"
