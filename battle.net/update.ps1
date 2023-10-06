#Requires -Version 5.0
#Requires -Modules AU
[cmdletbinding()]
param (
  [switch]$Force
)

$ErrorActionPreference = 'Stop'

$Env:au_PushUrl = 'https://chocolatey.zdl.io/chocolatey'
$au_GalleryPackageRootUrl = 'https://chocolatey.zdl.io/chocolatey/Packages'
$downloadUrl = 'https://downloader.battle.net/download/getInstallerForGame?os=win&gameProgram=BATTLENET_APP&version=Live'

function Get-RemoteFileVersion( [string] $Url ) {
  $fn = [System.IO.Path]::GetTempFileName()
  Invoke-WebRequest $Url -Outfile $fn -UseBasicParsing
  $res = (Get-ItemProperty $fn).VersionInfo.FileVersion
  Remove-Item $fn -ea ignore
  return $res
}

function global:au_GetLatest {
  $version = Get-RemoteFileVersion -Url $downloadUrl

  return @{
    Version = $version
    URL32   = $downloadUrl
  }
}

# run the update only if this script is not sourced by the virtual package
if ($MyInvocation.InvocationName -ne '.') {
  [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12
  Update-Package -NoCheckUrl -NoCheckChocoVersion -NoReadme -ChecksumFor none -Force:$Force
}