$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$checksumType = 'sha256'
$7zip = Join-Path "$env:ChocolateyInstall" 'tools\7z.exe'
$rstarInstallUnzipFile = Join-Path $toolsDir 'Rockstar-Games-Launcher.exe'
$rstarInstallUnzipFileDir = Join-Path $toolsDir 'Rockstar'
$rstarInstallParams = "x `"$rstarInstallUnzipFile`" -t# -aoa -bd -bb1 -o`"$rstarInstallUnzipFileDir`" -y"
$rstarInstallDir = Join-Path ${env:ProgramFiles} "Rockstar Games\Launcher"
$rstarStartMenuRunShortcutFolder = Join-Path $env:AppData "Microsoft\Windows\Start Menu\Programs\Rockstar Games"
$rstarStartMenuRunShortcut = Join-Path $rstarStartMenuRunShortcutFolder "Rockstar Games Launcher.lnk"
$rstarRunTarget = Join-Path $rstarInstallDir "LauncherPatcher.exe"
$initialWorkingDir = $workingDirectory
$url = 'https://gamedownloads.rockstargames.com/public/installer/Rockstar-Games-Launcher.exe'

# DO NOT CHANGE THESE MANUALLY, USE update.ps1
$checksum = 'd3a83b442e688393ea4a0eb8d57546a7671264b662266f49c9b522955f8b7a49'

# Stop Rockstar Services
Stop-Process -Name Launcher -Force -ErrorAction SilentlyContinue
Stop-Process -Name LauncherPatcher -Force -ErrorAction SilentlyContinue
Stop-Process -Name RockstarService -Force -ErrorAction SilentlyContinue
Stop-Process -Name RockstarErrorHandler -Force -ErrorAction SilentlyContinue
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

# Create Program Files folders to prepare for copying files
New-Item "$rstarInstallDir\Redistributables\VCRed" -ItemType Directory -Force
New-Item "$rstarInstallDir\ThirdParty\Steam" -ItemType Directory -Force

# Copy VC++ Redistributables
Copy-Item "$rstarInstallUnzipFileDir\52.exe" "$rstarInstallDir\Redistributables\VCRed\vc_redist.x64.exe" -Force
Copy-Item "$rstarInstallUnzipFileDir\53.exe" "$rstarInstallDir\Redistributables\VCRed\vc_redist.x86.exe" -Force

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

# Reset variables like paths because they seem to get unset after the above installs
$workingDirectory = $initialWorkingDir
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$rstarInstallUnzipFileDir = Join-Path $toolsDir 'Rockstar'
$rstarInstallDir = Join-Path ${env:ProgramFiles} "Rockstar Games\Launcher"
$rstarStartMenuRunShortcutFolder = Join-Path $env:AppData "Microsoft\Windows\Start Menu\Programs\Rockstar Games"
$rstarStartMenuRunShortcut = Join-Path $rstarStartMenuRunShortcutFolder "Rockstar Games Launcher.lnk"
$rstarRunTarget = Join-Path $rstarInstallDir "LauncherPatcher.exe"

# Copy Steam DLL
Copy-Item "$rstarInstallUnzipFileDir\54.steam_api.dll" "$rstarInstallDir\ThirdParty\Steam\steam_api64.dll" -Force

# Copy API DLLs
Copy-Item "$rstarInstallUnzipFileDir\2.apisetstub" "$rstarInstallDir\api-ms-win-core-console-l1-1-0.dll" -Force
Copy-Item "$rstarInstallUnzipFileDir\3.apisetstub" "$rstarInstallDir\api-ms-win-core-datetime-l1-1-0.dll" -Force
Copy-Item "$rstarInstallUnzipFileDir\4.apisetstub" "$rstarInstallDir\api-ms-win-core-debug-l1-1-0.dll" -Force
Copy-Item "$rstarInstallUnzipFileDir\5.apisetstub" "$rstarInstallDir\api-ms-win-core-errorhandling-l1-1-0.dll" -Force
Copy-Item "$rstarInstallUnzipFileDir\6.apisetstub" "$rstarInstallDir\api-ms-win-core-file-l1-1-0.dll" -Force
Copy-Item "$rstarInstallUnzipFileDir\7.apisetstub" "$rstarInstallDir\api-ms-win-core-file-l1-2-0.dll" -Force
Copy-Item "$rstarInstallUnzipFileDir\8.apisetstub" "$rstarInstallDir\api-ms-win-core-file-l2-1-0.dll" -Force
Copy-Item "$rstarInstallUnzipFileDir\9.apisetstub" "$rstarInstallDir\api-ms-win-core-handle-l1-1-0.dll" -Force
Copy-Item "$rstarInstallUnzipFileDir\10.apisetstub" "$rstarInstallDir\api-ms-win-core-heap-l1-1-0.dll" -Force
Copy-Item "$rstarInstallUnzipFileDir\11.apisetstub" "$rstarInstallDir\api-ms-win-core-interlocked-l1-1-0.dll" -Force
Copy-Item "$rstarInstallUnzipFileDir\12.apisetstub" "$rstarInstallDir\api-ms-win-core-libraryloader-l1-1-0.dll" -Force
Copy-Item "$rstarInstallUnzipFileDir\13.apisetstub" "$rstarInstallDir\api-ms-win-core-localization-l1-2-0.dll" -Force
Copy-Item "$rstarInstallUnzipFileDir\14.apisetstub" "$rstarInstallDir\api-ms-win-core-memory-l1-1-0.dll" -Force
Copy-Item "$rstarInstallUnzipFileDir\15.apisetstub" "$rstarInstallDir\api-ms-win-core-namedpipe-l1-1-0.dll" -Force
Copy-Item "$rstarInstallUnzipFileDir\16.apisetstub" "$rstarInstallDir\api-ms-win-core-processenvironment-l1-1-0.dll" -Force
Copy-Item "$rstarInstallUnzipFileDir\17.apisetstub" "$rstarInstallDir\api-ms-win-core-processthreads-l1-1-0.dll" -Force
Copy-Item "$rstarInstallUnzipFileDir\18.apisetstub" "$rstarInstallDir\api-ms-win-core-processthreads-l1-1-1.dll" -Force
Copy-Item "$rstarInstallUnzipFileDir\19.apisetstub" "$rstarInstallDir\api-ms-win-core-profile-l1-1-0.dll" -Force
Copy-Item "$rstarInstallUnzipFileDir\20.apisetstub" "$rstarInstallDir\api-ms-win-core-rtlsupport-l1-1-0.dll" -Force
Copy-Item "$rstarInstallUnzipFileDir\21.apisetstub" "$rstarInstallDir\api-ms-win-core-string-l1-1-0.dll" -Force
Copy-Item "$rstarInstallUnzipFileDir\22.apisetstub" "$rstarInstallDir\api-ms-win-core-synch-l1-1-0.dll" -Force
Copy-Item "$rstarInstallUnzipFileDir\23.apisetstub" "$rstarInstallDir\api-ms-win-core-synch-l1-2-0.dll" -Force
Copy-Item "$rstarInstallUnzipFileDir\24.apisetstub" "$rstarInstallDir\api-ms-win-core-sysinfo-l1-1-0.dll" -Force
Copy-Item "$rstarInstallUnzipFileDir\25.apisetstub" "$rstarInstallDir\api-ms-win-core-timezone-l1-1-0.dll" -Force
Copy-Item "$rstarInstallUnzipFileDir\26.apisetstub" "$rstarInstallDir\api-ms-win-core-util-l1-1-0.dll" -Force
Copy-Item "$rstarInstallUnzipFileDir\27.apisetstub" "$rstarInstallDir\api-ms-win-crt-conio-l1-1-0.dll" -Force
Copy-Item "$rstarInstallUnzipFileDir\28.apisetstub" "$rstarInstallDir\api-ms-win-crt-convert-l1-1-0.dll" -Force
Copy-Item "$rstarInstallUnzipFileDir\29.apisetstub" "$rstarInstallDir\api-ms-win-crt-environment-l1-1-0.dll" -Force
Copy-Item "$rstarInstallUnzipFileDir\30.apisetstub" "$rstarInstallDir\api-ms-win-crt-filesystem-l1-1-0.dll" -Force
Copy-Item "$rstarInstallUnzipFileDir\31.apisetstub" "$rstarInstallDir\api-ms-win-crt-heap-l1-1-0.dll" -Force
Copy-Item "$rstarInstallUnzipFileDir\32.apisetstub" "$rstarInstallDir\api-ms-win-crt-locale-l1-1-0.dll" -Force
Copy-Item "$rstarInstallUnzipFileDir\33.apisetstub" "$rstarInstallDir\api-ms-win-crt-math-l1-1-0.dll" -Force
Copy-Item "$rstarInstallUnzipFileDir\34.apisetstub" "$rstarInstallDir\api-ms-win-crt-multibyte-l1-1-0.dll" -Force
Copy-Item "$rstarInstallUnzipFileDir\35.apisetstub" "$rstarInstallDir\api-ms-win-crt-private-l1-1-0.dll" -Force
Copy-Item "$rstarInstallUnzipFileDir\36.apisetstub" "$rstarInstallDir\api-ms-win-crt-process-l1-1-0.dll" -Force
Copy-Item "$rstarInstallUnzipFileDir\37.apisetstub" "$rstarInstallDir\api-ms-win-crt-runtime-l1-1-0.dll" -Force
Copy-Item "$rstarInstallUnzipFileDir\38.apisetstub" "$rstarInstallDir\api-ms-win-crt-stdio-l1-1-0.dll" -Force
Copy-Item "$rstarInstallUnzipFileDir\39.apisetstub" "$rstarInstallDir\api-ms-win-crt-string-l1-1-0.dll" -Force
Copy-Item "$rstarInstallUnzipFileDir\40.apisetstub" "$rstarInstallDir\api-ms-win-crt-time-l1-1-0.dll" -Force
Copy-Item "$rstarInstallUnzipFileDir\41.apisetstub" "$rstarInstallDir\api-ms-win-crt-utility-l1-1-0.dll" -Force

# Copy remaining Program Files files
Copy-Item "$rstarInstallUnzipFileDir\42.Launcher.exe" "$rstarInstallDir\Launcher.exe" -Force
Copy-Item "$rstarInstallUnzipFileDir\43" "$rstarInstallDir\Launcher.rpf" -Force
Copy-Item "$rstarInstallUnzipFileDir\44.LauncherPatcher.exe" "$rstarInstallDir\LauncherPatcher.exe" -Force
Copy-Item "$rstarInstallUnzipFileDir\45.dll" "$rstarInstallDir\libovr.dll" -Force
Copy-Item "$rstarInstallUnzipFileDir\46.zip" "$rstarInstallDir\offline.pak" -Force
Copy-Item "$rstarInstallUnzipFileDir\48.RockstarService.exe" "$rstarInstallDir\RockstarService.exe" -Force
Copy-Item "$rstarInstallUnzipFileDir\49.RockstarSteamHelper.exe" "$rstarInstallDir\RockstarSteamHelper.exe" -Force
Copy-Item "$rstarInstallUnzipFileDir\50.ucrtbase.dll" "$rstarInstallDir\ucrtbase.dll" -Force
Copy-Item "$rstarInstallUnzipFileDir\51.Rockstar-Games-Launcher.exe" "$rstarInstallDir\uninstall.exe" -Force

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

# Remove Temp files
Remove-Item $rstarInstallUnzipFileDir -Recurse -Force
