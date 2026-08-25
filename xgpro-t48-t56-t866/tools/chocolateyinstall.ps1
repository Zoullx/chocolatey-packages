$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$checksumType = 'sha256'
$7zip = Join-Path "$env:ChocolateyInstall" 'tools\7z.exe'
$xgproRarFile = Join-Path $toolsDir 'xgproV1316_T48_T56_T866II_Setup.rar'
$xgproRarFileDir = Join-Path $toolsDir 'xgproV1316_T48_T56_T866II_Setup'
$xgproSetupFile = Join-Path $xgproRarFileDir 'XgproV1316_Setup.exe'
$xgproSetupFileDir = Join-Path $xgproRarFileDir 'XgproV1316_Setup'
$xgproRarParams = "x `"$xgproRarFile`" -aoa -bd -bb1 -o`"$xgproRarFileDir`" -y"
$xgproSetupParams = "x `"$xgproSetupFile`" -aoa -bd -bb1 -o`"$xgproSetupFileDir`" -y"
$xgproInstallDir = Join-Path $env:SystemDrive "Xgpro"
$xgproStartMenuRunShortcutFolder = Join-Path $env:AppData "Microsoft\Windows\Start Menu\Programs\Xgpro"
$xgproStartMenuRunShortcut = Join-Path $env:AppData "Microsoft\Windows\Start Menu\Programs\Xgpro\Xgpro.lnk"
$xgproDesktopShortcut = Join-Path "$([Environment]::GetFolderPath("Desktop"))" "Xgpro.lnk"
$xgproRunTarget = Join-Path $xgproInstallDir "Xgpro.exe"
$url = 'https://github.com/Kreeblah/XGecu_Software/raw/refs/heads/master/Xgpro/13/xgproV1316_T48_T56_T866II_Setup.rar'

# DO NOT CHANGE THESE MANUALLY, USE update.ps1
$checksum = '0F2A94BAA9D4A2170B07ECFCA48E9F6CEB636526B1BB4860E8671D9C0DFF2F03'

# Download EXE
$webFileArgs = @{
  packageName  = $env:ChocolateyPackageName
  url          = $url
  file         = $xgproRarFile
  checksum     = $checksum
  checksumType = $checksumType
}

Get-ChocolateyWebFile @webFileArgs

# Extract Setup EXE from RAR
$xgproRarExtractProcess = New-Object System.Diagnostics.Process
$xgproRarExtractProcess.EnableRaisingEvents = $true

$xgproRarExtractProcess.StartInfo = New-Object System.Diagnostics.ProcessStartInfo($7zip, $xgproRarParams)
$xgproRarExtractProcess.StartInfo.RedirectStandardOutput = $true
$xgproRarExtractProcess.StartInfo.RedirectStandardError = $true
$xgproRarExtractProcess.StartInfo.UseShellExecute = $false
$xgproRarExtractProcess.StartInfo.WorkingDirectory = $workingDirectory
$xgproRarExtractProcess.StartInfo.WindowStyle = [System.Diagnostics.ProcessWindowStyle]::Hidden
$xgproRarExtractProcess.StartInfo.CreateNoWindow = $true

$xgproRarExtractProcess.Start() | Out-Null
if ($xgproRarExtractProcess.StartInfo.RedirectStandardOutput) { $xgproRarExtractProcess.BeginOutputReadLine() }
if ($xgproRarExtractProcess.StartInfo.RedirectStandardError) { $xgproRarExtractProcess.BeginErrorReadLine() }
$xgproRarExtractProcess.WaitForExit()
$xgproRarExtractProcess.Dispose()

# Extract Install files from Setup EXE
$xgproSetupExtractProcess = New-Object System.Diagnostics.Process
$xgproSetupExtractProcess.EnableRaisingEvents = $true

$xgproSetupExtractProcess.StartInfo = New-Object System.Diagnostics.ProcessStartInfo($7zip, $xgproSetupParams)
$xgproSetupExtractProcess.StartInfo.RedirectStandardOutput = $true
$xgproSetupExtractProcess.StartInfo.RedirectStandardError = $true
$xgproSetupExtractProcess.StartInfo.UseShellExecute = $false
$xgproSetupExtractProcess.StartInfo.WorkingDirectory = $workingDirectory
$xgproSetupExtractProcess.StartInfo.WindowStyle = [System.Diagnostics.ProcessWindowStyle]::Hidden
$xgproSetupExtractProcess.StartInfo.CreateNoWindow = $true

$xgproSetupExtractProcess.Start() | Out-Null
if ($xgproSetupExtractProcess.StartInfo.RedirectStandardOutput) { $xgproSetupExtractProcess.BeginOutputReadLine() }
if ($xgproSetupExtractProcess.StartInfo.RedirectStandardError) { $xgproSetupExtractProcess.BeginErrorReadLine() }
$xgproSetupExtractProcess.WaitForExit()
$xgproSetupExtractProcess.Dispose()

$fileLocation = Join-Path $xgproSetupFileDir "drv\DPInst64.exe"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $toolsDir
  fileType       = 'EXE'
  file           = $fileLocation
  softwareName   = 'Xgpro USB Driver'
  checksum       = 'FE76503B53CCADA59C79054193AD0F9CE8C3A28C156C6BCB1C58C99ABA091C4E'
  checksumType   = 'sha256'
  silentArgs     = "/S"
  validExitCodes = @(0, 3010, 1641, 256)
}

Install-ChocolateyInstallPackage @packageArgs

# Copy Xgpro files into folder
Copy-Item "$xgproSetupFileDir\" $xgproInstallDir -Recurse -Force

# Create Start Menu shortcut folder
New-Item $xgproStartMenuRunShortcutFolder -ItemType Directory -Force

# Create Start Menu run shortcut
Install-ChocolateyShortcut -ShortcutFilePath $xgproStartMenuRunShortcut -TargetPath $xgproRunTarget -WorkingDirectory "$xgproInstallDir\"

# Create Desktop shortcut
Install-ChocolateyShortcut -ShortcutFilePath $xgproDesktopShortcut -TargetPath $xgproRunTarget -WorkingDirectory "$xgproInstallDir\"
