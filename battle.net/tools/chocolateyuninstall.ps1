$ErrorActionPreference = 'Stop';
Stop-Process -Name Agent -Force -ErrorAction SilentlyContinue
Stop-Process -Name Battle.net -Force -ErrorAction SilentlyContinue
Remove-Item "${env:LocalAppData}\Battle.net" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "${env:LocalAppData}\Blizzard Entertainment" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "${env:AppData}\Battle.net" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "${env:ProgramData}\Battle.net" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "${env:ProgramFiles}\Battle.net" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "${env:ProgramFiles(x86)}\Battle.net" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "${env:ALLUSERSPROFILE}\Microsoft\Windows\Start Menu\Programs\Battle.net" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "${env:PUBLIC}\Desktop\Battle.net.lnk" -Force -ErrorAction SilentlyContinue
Remove-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Battle.net" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Battle.net" -Recurse -Force -ErrorAction SilentlyContinue