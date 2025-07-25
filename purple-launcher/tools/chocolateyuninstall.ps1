$ErrorActionPreference = 'Stop';
Stop-Process -Name PURPLE -Force -ErrorAction SilentlyContinue
Remove-Item "${env:ProgramFiles(x86)}\NCSOFT\Purple" -Recurse -Force -ErrorAction SilentlyContinue
if (-not (Test-Path -Path "${env:ProgramFiles(x86)}\NCSOFT\*")) {
  Remove-Item "${env:ProgramFiles(x86)}\NCSOFT" -Recurse -Force -ErrorAction SilentlyContinue
}
Remove-Item "${env:ProgramData}\Microsoft\Windows\Start Menu\Programs\Purple" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "${env:AppData}\Purple" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "${env:AppData}\Purple_RC" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "${env:AppData}\PurpleBox" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "${env:LocalAppData}\Purple" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "${env:LocalAppData}\Purple_RC" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "${env:LocalAppData}\PurpleDome" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "${env:UserProfile}\Desktop\PURPLE.lnk" -Force -ErrorAction SilentlyContinue
Remove-Item "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Purple_plaync" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "HKLM:\SOFTWARE\WOW6432Node\plaync\Purple" -Recurse -Force -ErrorAction SilentlyContinue
if (-not (Test-Path -Path "HKLM:\SOFTWARE\WOW6432Node\plaync")) {
  Remove-Item "HKLM:\SOFTWARE\WOW6432Node\plaync" -Force -ErrorAction SilentlyContinue
}
Remove-Item "HKCU:\Software\Classes\nc-purple" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "HKCR:\nc-purple" -Recurse -Force -ErrorAction SilentlyContinue