#Requires -Version 5.0
#Requires -Modules AU
[cmdletbinding()]
param (
  [switch]$Force
)

$ErrorActionPreference = 'Stop'

$downloadUrl = 'https://glyph.dyn.triongames.com/glyph/live/GlyphInstall.exe'

function Get-RemoteFileVersion( [string] $Url ) {
  $fn = [System.IO.Path]::ChangeExtension([System.IO.Path]::GetTempFileName(), "exe")
  Invoke-WebRequest $Url -Outfile $fn -UseBasicParsing
  $fi = Get-ItemProperty -Path $fn
  $sfo = (New-Object -ComObject Shell.Application).Namespace($fi.Directory.FullName)
  $sfi = $sfo.ParseName($fi.Name)
  $res = $sfo.GetDetailsOf($sfi, [int] 298)
  Remove-Item $fn -ea ignore
  return $res
}

function global:au_BeforeUpdate {
  $Latest.Checksum32 = Get-RemoteChecksum -Url $Latest.Url32 -Algorithm 'SHA256'
}

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^[$]checksum\s*=\s*)'.*'"   = "`${1}'$($Latest.Checksum32)'"
    }
  }
}

function global:au_GetLatest {
  $originalVersion = Get-RemoteFileVersion -Url $downloadUrl
  $discard, $majorAndMinor, $patchAndBuildArr = $originalVersion -Split "\."
  $major, $minorArr = $majorAndMinor.ToCharArray()
  $minor = $minorArr -Join ""
  $patchAndBuild = $patchAndBuildArr -Join "."

  return @{
    Version = "$major.$minor.$patchAndBuild"
    URL32   = $downloadUrl
  }
}

# run the update only if this script is not sourced by the virtual package
if ($MyInvocation.InvocationName -ne '.') {
  [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12
  Update-Package -NoCheckUrl -NoCheckChocoVersion -NoReadme -ChecksumFor none -Force:$Force
}