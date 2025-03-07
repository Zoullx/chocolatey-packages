#Requires -Version 5.0
#Requires -Modules chocolatey-au
[cmdletbinding()]
param (
  [switch]$Force
)

$ErrorActionPreference = 'Stop'

$discoveryUrl = 'https://discovery3.razerapi.com/api/v1/endpoints'
$manifestUrl = 'https://manifest3.razerapi.com/api/v1/releases/{0}/tags/{1}/products?os=windows&osver=11&arch=64'
$razerSynapseUrl = 'http://rzr.to/synapse-4-pc-download'

function Get-RemoteFileVersion( [string] $Url ) {
  $fn = [System.IO.Path]::GetTempFileName()
  Invoke-WebRequest $Url -Outfile $fn -UseBasicParsing
  $res = (Get-ItemProperty $fn).VersionInfo.FileVersion
  Remove-Item $fn -ea ignore
  return $res
}

function global:au_BeforeUpdate {
  $Latest.GameManagerChecksum = Get-RemoteChecksum -Url $Latest.GameManagerUrl -Algorithm 'SHA256'
  $Latest.CentralChecksum = Get-RemoteChecksum -Url $Latest.CentralUrl -Algorithm 'SHA256'
  $Latest.AppEngineChecksum = Get-RemoteChecksum -Url $Latest.AppEngineUrl -Algorithm 'SHA256'
  $Latest.ChromaChecksum = Get-RemoteChecksum -Url $Latest.ChromaUrl -Algorithm 'SHA256'
  $Latest.SynapseChecksum = Get-RemoteChecksum -Url $Latest.SynapseUrl -Algorithm 'SHA256'
}

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^[$]RazerAppEngineUrl\s*=\s*)'.*'"        = "`${1}'$($Latest.AppEngineUrl)'"
      "(?i)(^[$]RazerAppEngineChecksum\s*=\s*)'.*'"   = "`${1}'$($Latest.AppEngineChecksum)'"
      "(?i)(^[$]RazerSynapse4Url\s*=\s*)'.*'"         = "`${1}'$($Latest.SynapseUrl)'"
      "(?i)(^[$]RazerSynapse4Checksum\s*=\s*)'.*'"    = "`${1}'$($Latest.SynapseChecksum)'"
      "(?i)(^[$]RazerChromaUrl\s*=\s*)'.*'"           = "`${1}'$($Latest.ChromaUrl)'"
      "(?i)(^[$]RazerChromaChecksum\s*=\s*)'.*'"      = "`${1}'$($Latest.ChromaChecksum)'"
      "(?i)(^[$]RazerCentralUrl\s*=\s*)'.*'"          = "`${1}'$($Latest.CentralUrl)'"
      "(?i)(^[$]RazerCentralChecksum\s*=\s*)'.*'"     = "`${1}'$($Latest.CentralChecksum)'"
      "(?i)(^[$]RazerGameManagerUrl\s*=\s*)'.*'"      = "`${1}'$($Latest.GameManagerUrl)'"
      "(?i)(^[$]RazerGameManagerChecksum\s*=\s*)'.*'" = "`${1}'$($Latest.GameManagerChecksum)'"
    }
  }
}

function global:au_GetLatest {
  $response = try {
    Invoke-WebRequest -Uri $razerSynapseUrl -UseBasicParsing
  }
  catch {
    $_.Exception.Response
  }

  if ($response.StatusCode -ne 200) {
    throw "HTTP $($response.StatusCode) when requesting $razerSynapseUrl"
  }
  if (-not $response.BaseResponse.ResponseUri.AbsoluteUri) {
    throw "No Location header returned when requesting $razerSynapseUrl"
  }

  $downloadUrl = $response.BaseResponse.ResponseUri.AbsoluteUri
  $version = Get-RemoteFileVersion -Url $downloadUrl
  
  $discoveryResponse = Invoke-WebRequest -Uri $discoveryUrl -UseBasicParsing
  $discoveryJsonString = $discoveryResponse.Content
  $discoveryJson = $discoveryJsonString | ConvertFrom-Json
  $prodEndpoint = $discoveryJson.data.items | Where-Object { $_.name -eq "prod" }

  $manifestResponse = Invoke-WebRequest -Uri ($manifestUrl -f $prodEndpoint.hash, $prodEndpoint.name) -UseBasicParsing
  $manifestJsonString = $manifestResponse.Content
  $manifestJson = $manifestJsonString | ConvertFrom-Json
  $modules = @($manifestJson.data.items | Where-Object { $_.name -eq "Anne" -or $_.name -eq "Chroma" -or $_.name -eq "GameBooster2" } | ForEach-Object { $_.modules }) | Sort-Object -Property name -Unique
  $gameManager = $modules | Where-Object { $_.name -eq "GMS3" }
  $central = $modules | Where-Object { $_.name -eq "Natasha" }
  $appEngine = $modules | Where-Object { $_.name -eq "Razer App Engine" }
  $chroma = $modules | Where-Object { $_.name -eq "Razer Chroma" }
  $synapse = $modules | Where-Object { $_.name -eq "Razer Synapse" }

  return @{
    Version        = $version
    GameManagerUrl = $gameManager.download_url
    CentralUrl     = $central.download_url
    AppEngineUrl   = $appEngine.download_url
    ChromaUrl      = $chroma.download_url
    SynapseUrl     = $synapse.download_url
  }
}

# run the update only if this script is not sourced by the virtual package
if ($MyInvocation.InvocationName -ne '.') {
  [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12
  Update-Package -NoCheckUrl -NoCheckChocoVersion -NoReadme -ChecksumFor none -Force:$Force
}