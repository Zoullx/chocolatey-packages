#Requires -Version 5.0
#Requires -Modules AU
[cmdletbinding()]
param (
  [switch]$Force
)

$ErrorActionPreference = 'Stop'

$Env:au_PushUrl = 'https://chocolatey.zdl.io/chocolatey'
$au_GalleryPackageRootUrl = 'https://chocolatey.zdl.io/chocolatey/Packages'
$razerSynapseUrl = 'http://rzr.to/synapse-pc-download'

function global:au_BeforeUpdate {
  $Latest.Checksum32 = Get-RemoteChecksum -Url $Latest.Url32 -Algorithm 'SHA256'
}

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^[$]url\s*=\s*)'.*'"        = "`${1}'$($Latest.URL32)'"
      "(?i)(^[$]checksum\s*=\s*)'.*'"   = "`${1}'$($Latest.Checksum32)'"
    }
  }
}

function global:au_GetLatest {
  $response = try {
    Invoke-WebRequest -Uri $razerSynapseUrl -UseBasicParsing
  } catch {
    $_.Exception.Response
  }
  if ($response.StatusCode -ne 200) {
    throw "HTTP $($response.StatusCode) when requesting $razerSynapseUrl"
  }
  if (-not $response.BaseResponse.ResponseUri.AbsoluteUri) {
    throw "No redirection uri returned when requesting $razerSynapseUrl"
  }

  $downloadUrl = $response.BaseResponse.ResponseUri.AbsoluteUri
  if (-not ($downloadUrl -match '.*_v(?<Version>.*)\.exe')) {
    throw "Could not determine version from url $downloadUrl"
  }
  $version = $matches.Version

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