#Requires -Version 5.0
#Requires -Modules AU
[cmdletbinding()]
param (
  [switch]$Force
)

$ErrorActionPreference = 'Stop'

$razerSynapseUrl = 'http://rzr.to/synapse-3-pc-download'

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
    throw "No Location header returned when requesting $razerSynapseUrl"
  }

  $downloadUrl = $response.BaseResponse.ResponseUri.AbsoluteUri
  if (-not ($downloadUrl -match '.*_V(?<Version>.*)\.exe')) {
    throw "Could not determine version from url $downloadUrl"
  }
  $version = $matches.Version

  return @{
    Version = $version
  }
}

# run the update only if this script is not sourced by the virtual package
if ($MyInvocation.InvocationName -ne '.') {
  [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12
  Update-Package -NoCheckUrl -NoCheckChocoVersion -NoReadme -ChecksumFor none -Force:$Force
}