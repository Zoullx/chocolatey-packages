$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# DO NOT CHANGE THESE MANUALLY, USE update.ps1
$url = 'https://github.com/obsproject/obs-studio/releases/download/32.2.2/OBS-Studio-32.2.2-Windows-x64-Installer.exe'
$checksum = 'c3a0b880adbe64dc4bcb68f93016916ab5b55ae43fd227115287bf80257d92dc'

$processNames = @(
  "obs64",
  "obs32",
  "obs",
  "chrome",
  "vivaldi",
  "msedge",
  "firefox",
  "Teams",
  "ms-teams",
  "msteams",
  "Skype",
  "lync",
  "Discord",
  "DiscordCanary",
  "DiscordPTB",
  "Webex",
  "WebexHost",
  "CiscoCollabHost",
  "atmgr",
  "WhatsApp",
  "Voicemod",
  "VoicemodDesktop",
  "Claude",
  "SamsungMagician",
  "SamsungMagicianSVC",
  "GoogleDriveFS",
  "googledrivesync",
  "IGCCTray",
  "IntelGraphicsCommandCenter",
  "DeepL",
  "CefSharp.BrowserSubprocess"
)

foreach ($name in $processNames) {
  Stop-Process -Name $name -Force -ErrorAction SilentlyContinue
}

$serviceNames = @(
  "Samsung",
  "Magician",
  "Waves",
  "WavesSysSvc",
  "Voicemod",
  "Google Drive"
)

foreach ($name in $serviceNames) {
  Stop-Service -Name $name -Force -ErrorAction SilentlyContinue
}

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $toolsDir
  fileType       = 'EXE'
  url            = $url
  softwareName   = 'OBS Studio'
  checksum       = $checksum
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
