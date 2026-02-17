$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$checksumType = 'sha256'
$7zip = Join-Path "$env:ChocolateyInstall" 'tools\7z.exe'
$glyphInstallUnzipFile = Join-Path $toolsDir 'GlyphInstall.exe'
$glyphInstallUnzipFileDir = Join-Path $toolsDir 'GlyphInstall'
$glyphExtractUnzipFileDir = Join-Path $glyphInstallUnzipFileDir 'Extracted'
$glyphInstallParams = "x `"$glyphInstallUnzipFile`" -t# -aoa -bd -bb1 -o`"$glyphInstallUnzipFileDir`" -y `"*.7z`""
$glyphextractParams = "x `"$glyphInstallUnzipFileDir\*`" -aoa -bd -bb1 -o`"$glyphExtractUnzipFileDir`" -y -r"
$glyphInstallDir = Join-Path ${env:ProgramFiles(x86)} "Glyph"
$glyphProgramDataConfig = Join-Path $env:ProgramData "Glyph\GlyphLibrary.cfg"
$glyphStartMenuRunShortcutFolder = Join-Path $env:ProgramData "Microsoft\Windows\Start Menu\Programs\Glyph"
$glyphStartMenuRunShortcut = Join-Path $env:ProgramData "Microsoft\Windows\Start Menu\Programs\Glyph\Glyph.lnk"
$glyphStartMenuUninstallShortcut = Join-Path $env:ProgramData "Microsoft\Windows\Start Menu\Programs\Glyph\Uninstall Glyph.lnk"
$glyphDesktopShortcut = Join-Path "$([Environment]::GetFolderPath("Desktop"))" "Glyph.lnk"
$glyphRunTarget = Join-Path $glyphInstallDir "GlyphClient.exe"
$glyphUninstallTarget = Join-Path $glyphInstallDir "glyphuninstall.exe"
$url = 'https://glyph.dyn.triongames.com/glyph/live/GlyphInstall.exe'

# DO NOT CHANGE THESE MANUALLY, USE update.ps1
$checksum = '5aa49cb90724ba687fbd0e57df7b8e3de0dba7b56a662e8738d9f448860d9882'

# Download EXE
$webFileArgs = @{
  packageName   = $env:ChocolateyPackageName
  url           = $url
  file          = $glyphInstallUnzipFile
  checksum      = $checksum
  checksumType  = $checksumType
}

Get-ChocolateyWebFile @webFileArgs

# Extract 7z files from EXE
$glyphInstallExtractProcess = New-Object System.Diagnostics.Process
$glyphInstallExtractProcess.EnableRaisingEvents = $true

$glyphInstallExtractProcess.StartInfo = New-Object System.Diagnostics.ProcessStartInfo($7zip, $glyphInstallParams)
$glyphInstallExtractProcess.StartInfo.RedirectStandardOutput = $true
$glyphInstallExtractProcess.StartInfo.RedirectStandardError = $true
$glyphInstallExtractProcess.StartInfo.UseShellExecute = $false
$glyphInstallExtractProcess.StartInfo.WorkingDirectory = $workingDirectory
$glyphInstallExtractProcess.StartInfo.WindowStyle = [System.Diagnostics.ProcessWindowStyle]::Hidden
$glyphInstallExtractProcess.StartInfo.CreateNoWindow = $true

$glyphInstallExtractProcess.Start() | Out-Null
if ($glyphInstallExtractProcess.StartInfo.RedirectStandardOutput) { $glyphInstallExtractProcess.BeginOutputReadLine() }
if ($glyphInstallExtractProcess.StartInfo.RedirectStandardError) { $glyphInstallExtractProcess.BeginErrorReadLine() }
$glyphInstallExtractProcess.WaitForExit()
$glyphInstallExtractProcess.Dispose()

# Extract Glyph files from 7z files
$glyph7zExtractProcess = New-Object System.Diagnostics.Process
$glyph7zExtractProcess.EnableRaisingEvents = $true

$glyph7zExtractProcess.StartInfo = New-Object System.Diagnostics.ProcessStartInfo($7zip, $glyphExtractParams)
$glyph7zExtractProcess.StartInfo.RedirectStandardOutput = $true
$glyph7zExtractProcess.StartInfo.RedirectStandardError = $true
$glyph7zExtractProcess.StartInfo.UseShellExecute = $false
$glyph7zExtractProcess.StartInfo.WorkingDirectory = $workingDirectory
$glyph7zExtractProcess.StartInfo.WindowStyle = [System.Diagnostics.ProcessWindowStyle]::Hidden
$glyph7zExtractProcess.StartInfo.CreateNoWindow = $true

$glyph7zExtractProcess.Start() | Out-Null
if ($glyph7zExtractProcess.StartInfo.RedirectStandardOutput) { $glyph7zExtractProcess.BeginOutputReadLine() }
if ($glyph7zExtractProcess.StartInfo.RedirectStandardError) { $glyph7zExtractProcess.BeginErrorReadLine() }
$glyph7zExtractProcess.WaitForExit()
$glyph7zExtractProcess.Dispose()

# Copy Glyph files into Program Files
Copy-Item "$glyphExtractUnzipFileDir\" $glyphInstallDir -recurse -exclude "GlyphInstall*" -Force

# Create Glyph config
New-Item $glyphProgramDataConfig -ItemType File -Value "[Glyph]" -Force
Add-Content $glyphProgramDataConfig "Installed=true"

# Create Start Menu shortcut folder
New-Item $glyphStartMenuRunShortcutFolder -ItemType Directory -Force

# Create Start Menu run shortcut
Install-ChocolateyShortcut -ShortcutFilePath $glyphStartMenuRunShortcut -TargetPath $glyphRunTarget -WorkingDirectory "$glyphInstallDir\"

# Create Start Menu uninstall shortcut
Install-ChocolateyShortcut -ShortcutFilePath $glyphStartMenuUninstallShortcut -TargetPath $glyphUninstallTarget -WorkingDirectory "$glyphInstallDir\"

# Create Desktop shortcut
Install-ChocolateyShortcut -ShortcutFilePath $glyphDesktopShortcut -TargetPath $glyphRunTarget -WorkingDirectory "$glyphInstallDir\"

# Create Protocol Registry entries
New-Item "Registry::HKEY_CLASSES_ROOT\glyph" -Force
New-ItemProperty -Path "Registry::HKEY_CLASSES_ROOT\glyph" -Name "(Default)" -Value "URL:glyph protocol" -PropertyType "String" -Force
New-ItemProperty -Path "Registry::HKEY_CLASSES_ROOT\glyph" -Name "URL Protocol" -Value "" -PropertyType "String" -Force
New-Item "Registry::HKEY_CLASSES_ROOT\glyph\Shell\Open\Command" -Force
New-ItemProperty -Path "Registry::HKEY_CLASSES_ROOT\glyph\Shell\Open\Command" -Name "(Default)" -Value "`"$glyphRunTarget`" -url `"%1`"" -PropertyType "String" -Force
New-Item "HKCU:\Software\Classes\glyph" -Force
New-ItemProperty -Path "HKCU:\Software\Classes\glyph" -Name "(Default)" -Value "URL:glyph protocol" -PropertyType "String" -Force
New-ItemProperty -Path "HKCU:\Software\Classes\glyph" -Name "URL Protocol" -Value "" -PropertyType "String" -Force
New-Item "HKCU:\Software\Classes\glyph\Shell\Open\Command" -Force
New-ItemProperty -Path "HKCU:\Software\Classes\glyph\Shell\Open\Command" -Name "(Default)" -Value "`"$glyphRunTarget`" -url `"%1`"" -PropertyType "String" -Force

# Create Run Registry entry
New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "Glyph Client" -Value "C:\Program Files (x86)\Glyph\GlyphClient.exe -hidden" -PropertyType "String" -Force

# Create Glyph App Registry entries
New-Item "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Glyph" -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Glyph" -Name "DisplayName" -Value "Glyph" -PropertyType "String" -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Glyph" -Name "DisplayIcon" -Value "C:\Program Files (x86)\Glyph\GlyphClient.exe" -PropertyType "String" -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Glyph" -Name "Publisher" -Value "Trion Worlds, Inc." -PropertyType "String" -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Glyph" -Name "InstallDate" -Value "$(Get-Date -UFormat "%Y%m%d")" -PropertyType "String" -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Glyph" -Name "InstallLocation" -Value "C:\Program Files (x86)\Glyph\" -PropertyType "String" -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Glyph" -Name "InstallSource" -Value $glyphExtractUnzipFileDir -PropertyType "String" -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Glyph" -Name "VersionMajor" -Value 1 -PropertyType "DWord" -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Glyph" -Name "VersionMinor" -Value 0 -PropertyType "DWord" -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Glyph" -Name "EstimatedSize" -Value "$((Get-ChildItem $glyphInstallDir -recurse | Measure-Object -property length -sum).Sum -replace ".{3}$")" -PropertyType "DWord" -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Glyph" -Name "UninstallString" -Value "C:\Program Files (x86)\Glyph\glyphuninstall.exe" -PropertyType "String" -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Glyph" -Name "HelpLink" -Value "http://glyph.trionworlds.com" -PropertyType "String" -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Glyph" -Name "URLInfoAbout" -Value "http://glyph.trionworlds.com" -PropertyType "String" -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Glyph" -Name "URLUpdateInfo" -Value "http://glyph.trionworlds.com" -PropertyType "String" -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Glyph" -Name "Language" -Value 9 -PropertyType "DWord" -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Glyph" -Name "NoModify" -Value 1 -PropertyType "DWord" -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Glyph" -Name "NoRepair" -Value 1 -PropertyType "DWord" -Force
