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

$xgproDriverDir = Join-Path $xgproSetupFileDir "drv"
if ((Get-OSArchitectureWidth) -eq 64) {
  $dpinst = Join-Path $xgproDriverDir "DPInst64.exe"
  $driverCatalog = Join-Path $xgproDriverDir "xgprowinusbx64.cat"
} else {
  $dpinst = Join-Path $xgproDriverDir "DPInst.exe"
  $driverCatalog = Join-Path $xgproDriverDir "xgprowinusbx86.cat"
}

# The driver is Authenticode-signed by the vendor (not WHQL), so Windows asks the user
# to trust the publisher before installing it. DPInst can't show that prompt in silent
# mode and fails, so add the publisher's certificate to TrustedPublisher first.
$driverSignature = Get-AuthenticodeSignature $driverCatalog
if ($driverSignature.Status -ne 'Valid') {
  throw "Driver catalog signature is not valid: $($driverSignature.StatusMessage)"
}
Write-Warning "Adding the Xgpro driver publisher certificate ($($driverSignature.SignerCertificate.Subject), thumbprint $($driverSignature.SignerCertificate.Thumbprint)) to the LocalMachine\TrustedPublisher store. It is not removed on uninstall."
$trustedPublisherStore = New-Object System.Security.Cryptography.X509Certificates.X509Store('TrustedPublisher', 'LocalMachine')
$trustedPublisherStore.Open('ReadWrite')
$trustedPublisherStore.Add($driverSignature.SignerCertificate)
$trustedPublisherStore.Close()

# Install driver
# DPInst returns a bitmask (0xWWXXYYZZ) rather than a plain exit code:
#   0x80000000 = a driver package could not be installed, 0x40000000 = restart required
#   XX = packages that failed, YY = packages copied to the driver store, ZZ = packages installed on a device
$dpinstProcess = Start-Process -FilePath $dpinst -ArgumentList '/S' -WorkingDirectory $xgproDriverDir -Wait -PassThru
$dpinstExitCode = $dpinstProcess.ExitCode
Write-Debug ("DPInst exited with 0x{0:X8}" -f $dpinstExitCode)
if (($dpinstExitCode -band 0x80000000) -or (($dpinstExitCode -shr 16) -band 0xFF)) {
  throw ("Xgpro USB driver install failed. DPInst exit code was 0x{0:X8}. See C:\Windows\DPINST.LOG for details." -f $dpinstExitCode)
}
if ($dpinstExitCode -band 0x40000000) {
  Write-Warning "A restart is required to finish installing the Xgpro USB driver."
}

# Copy Xgpro files into folder
Copy-Item "$xgproSetupFileDir\" $xgproInstallDir -Recurse -Force

# Create Start Menu shortcut folder
New-Item $xgproStartMenuRunShortcutFolder -ItemType Directory -Force

# Create Start Menu run shortcut
Install-ChocolateyShortcut -ShortcutFilePath $xgproStartMenuRunShortcut -TargetPath $xgproRunTarget -WorkingDirectory "$xgproInstallDir\"

# Create Desktop shortcut
Install-ChocolateyShortcut -ShortcutFilePath $xgproDesktopShortcut -TargetPath $xgproRunTarget -WorkingDirectory "$xgproInstallDir\"
