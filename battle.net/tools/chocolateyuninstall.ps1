$ErrorActionPreference = 'Stop';
Stop-Process -Name Agent -Force -ErrorAction SilentlyContinue
Stop-Process -Name Battle.net -Force -ErrorAction SilentlyContinue
Remove-Item "%LocalAppData%\Battle.net" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "%LocalAppData%\Blizzard Entertainment" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "%AppData%\Battle.net" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "%ProgramData%\Battle.net" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "%ProgramFiles%\Battle.net" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "%ProgramFiles(x86)%\Battle.net" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\Battle.net" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "%PUBLIC%\Desktop\Battle.net.lnk" -Force -ErrorAction SilentlyContinue
Remove-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Battle.net" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Battle.net" -Recurse -Force -ErrorAction SilentlyContinue