#Requires -Version 5.0
#Requires -Modules chocolatey-au
[cmdletbinding()]
param (
  [switch]$Force
)

$ErrorActionPreference = 'Stop'

$downloadUrl = 'https://api.github.com/repos/getstation/desktop-app/releases/latest'

function Get-RemoteFileVersion( [string] $Url ) {
  $fn = [System.IO.Path]::GetTempFileName()
  Invoke-WebRequest $Url -Outfile $fn -UseBasicParsing
  $res = (Get-ItemProperty $fn).VersionInfo.FileVersion
  Remove-Item $fn -ea ignore
  return $res
}

function global:au_BeforeUpdate {
  $Latest.Checksum32 = Get-RemoteChecksum -Url $Latest.Url32 -Algorithm 'SHA256'
}

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^[$]url\s*=\s*)'.*'"      = "`${1}'$($Latest.URL32)'"
      "(?i)(^[$]checksum\s*=\s*)'.*'" = "`${1}'$($Latest.Checksum32)'"
    }
  }
}

function global:au_GetLatest {
  $response = Invoke-RestMethod $downloadUrl -Method Get
  $asset = $response.assets | Where-Object { $_.name -eq "Station-Setup.exe" } | Select-Object -First 1
  $url = $asset.browser_download_url
  $version = Get-RemoteFileVersion -Url $url

  return @{
    Version = $version
    URL32   = $url
  }
}

# run the update only if this script is not sourced by the virtual package
if ($MyInvocation.InvocationName -ne '.') {
  [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12
  Update-Package -NoCheckUrl -NoCheckChocoVersion -NoReadme -ChecksumFor none -Force:$Force
}