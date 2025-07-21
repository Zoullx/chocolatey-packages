# Import-Module Chocolatey-AU
# Import-Module "$env:ChocolateyInstall\helpers\chocolateyInstaller.psm1"

# $softwareName = 'Ubisoft Connect'

# function global:au_SearchReplace {
#   @{
#     ".\tools\chocolateyInstall.ps1"   = @{
#       "(?i)^(\s*softwareName\s*=\s*)'.*'" = "`${1}'$softwareName'"
#       "(?i)^(\s*url\s*=\s*)'.*'"          = "`${1}'$($Latest.URL32)'"
#       "(?i)^(\s*checksum\s*=\s*)'.*'"     = "`${1}'$($Latest.Checksum32)'"
#       "(?i)^(\s*checksumType\s*=\s*)'.*'" = "`${1}'$($Latest.ChecksumType32)'"
#     }
#     ".\tools\chocolateyUninstall.ps1" = @{
#       "(?i)^(\s*softwareName\s*=\s*)'.*'" = "`${1}'$softwareName'"
#     }
#   }
# }

# function global:au_AfterUpdate {
#   Update-Changelog -useIssueTitle
# }

# function GetResultInformation([string]$url32) {
#   $dest = "$env:TEMP\ubisoft-connect.exe"
#   Get-WebFile $url32 $dest | Out-Null

#   return @{
#     URL32          = $url32
#     Version        = Get-Item $dest | % { $_.VersionInfo.ProductVersion }
#     Checksum32     = Get-FileHash $dest -Algorithm SHA512 | % Hash
#     ChecksumType32 = 'sha512'
#   }
# }

# function global:au_GetLatest {
#   $url32 = Get-RedirectedUrl "https://ubi.li/4vxt9"

#   return Update-OnETagChanged -execUrl $url32 -OnETagChanged {
#     GetResultInformation $url32
#   } -OnUpdated { @{ URL32 = $url32 } }
# }

# update -ChecksumFor none

#Requires -Version 5.0
#Requires -Modules chocolatey-au
[cmdletbinding()]
param (
  [switch]$Force
)

$ErrorActionPreference = 'Stop'

$downloadUrl = 'https://ubi.li/4vxt9'

function Get-RemoteFileVersion( [string] $Url ) {
  $fn = [System.IO.Path]::GetTempFileName()
  Invoke-WebRequest $Url -Outfile $fn -UseBasicParsing
  $res = (Get-ItemProperty $fn).VersionInfo.ProductVersion
  Remove-Item $fn -ea ignore
  return $res
}

function global:au_BeforeUpdate {
  $Latest.Checksum32 = Get-RemoteChecksum -Url $Latest.Url32 -Algorithm 'SHA512'
}

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^[$]checksum\s*=\s*)'.*'" = "`${1}'$($Latest.Checksum32)'"
    }
  }
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