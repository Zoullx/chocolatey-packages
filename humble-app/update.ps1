#Requires -Version 5.0
#Requires -Modules AU
[cmdletbinding()]
param (
  [switch]$Force
)

$ErrorActionPreference = 'Stop'

$downloadUrl = 'https://www.humblebundle.com/app/download'

function Get-RemoteFileVersion( [string] $Url ) {
  $fn = [System.IO.Path]::GetTempFileName()
  Invoke-WebRequest $Url -Outfile $fn -UseBasicParsing
  $res = (Get-ItemProperty $fn).VersionInfo.ProductVersion
  Remove-Item $fn -ea ignore
  return $res
}

function global:au_GetLatest {
  $originalVersion = Get-RemoteFileVersion -Url $downloadUrl
  $version = $originalVersion -Replace "\+","."

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