$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
# $ahkExe   = 'AutoHotKey'
# $ahkFile  = "$toolsDir\final-fantasy-xiv_install.ahk"
$7zip = Join-Path "$env:ChocolateyInstall" 'tools\7z.exe'
$ffInstallFile = Join-Path $toolsDir '2.Setup.exe'
$ffInstallScript = Join-Path $toolsDir 'Setup.iss'
$ffInstallUnzipFile = Join-Path $toolsDir 'ffxivsetup_ft.exe'
$ffInstallParams = "x `"$ffInstallUnzipFile`" -t# -aoa -bd -bb1 -o`"$toolsDir`" -y"
$url      = 'https://etailers.square-enix-games.com/etailer/283335?e=Free%20Trial&p=Windows&s=Square%20Enix%20Store'
$checksum = '6810954D1EAF0D0951BB5534D6369644405FBD784F7374F85627A53FA70FB0DF'

# Download EXE
$webFileArgs = @{
  packageName   = $env:ChocolateyPackageName
  url           = $url
  file          = $ffInstallUnzipFile
  checksum      = $checksum
  checksumType  = 'sha256'
}

Get-ChocolateyWebFile @webFileArgs

# Extract actual Installer from EXE
$ffInstallExtractProcess = New-Object System.Diagnostics.Process
$ffInstallExtractProcess.EnableRaisingEvents = $true

$ffInstallExtractProcess.StartInfo = New-Object System.Diagnostics.ProcessStartInfo($7zip, $ffInstallParams)
$ffInstallExtractProcess.StartInfo.RedirectStandardOutput = $true
$ffInstallExtractProcess.StartInfo.RedirectStandardError = $true
$ffInstallExtractProcess.StartInfo.UseShellExecute = $false
$ffInstallExtractProcess.StartInfo.WorkingDirectory = $workingDirectory
$ffInstallExtractProcess.StartInfo.WindowStyle = [System.Diagnostics.ProcessWindowStyle]::Hidden
$ffInstallExtractProcess.StartInfo.CreateNoWindow = $true

$ffInstallExtractProcess.Start() | Out-Null
if ($ffInstallExtractProcess.StartInfo.RedirectStandardOutput) { $ffInstallExtractProcess.BeginOutputReadLine() }
if ($ffInstallExtractProcess.StartInfo.RedirectStandardError) { $ffInstallExtractProcess.BeginErrorReadLine() }
$ffInstallExtractProcess.WaitForExit()
$ffInstallExtractProcess.Dispose()

$ffInstallFileChecksum = '0C946D13BB96B32C684414F4B67050BAE9A235DDB1EFDB3955E16DFF34C7C91D'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  file          = $ffInstallFile
  softwareName  = 'FINAL FANTASY XIV ONLINE*'
  checksum      = $ffInstallFileChecksum
  checksumType  = 'sha256'
  silentArgs    = "-s -f1'$ffInstallScript'"
  validExitCodes= @(0, 3010, 1641)
}

# Start-Process $ahkExe $ahkFile
Install-ChocolateyPackage @packageArgs