#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
#NoTrayIcon
#Warn ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetTitleMatchMode, 1 ; A windows's title must start with the specified WinTitle to be a match.
SetControlDelay 0
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.

; Get AppData Env Var
EnvGet, appData, AppData

; Delete the left over AppData
FileRemoveDir, %appData%\Guild Wars 2, 1

winTitle = ahk_class ArenaNet ahk_exe Gw2Setup-64.exe

; Loading Installer
WinWait, %winTitle%,, 120
If WinExist(winTitle)
{
    Sleep, 25000
}

winTitle = ahk_class ArenaNet ahk_exe Gw2.exe

; Start install
WinWait, %winTitle%,, 15
If WinExist(winTitle)
{
    WinActivate
    Send {Tab}
    Send {Tab}
    Send {Tab}
    Send {Tab}
    Send {Tab}
    Send {Tab}
    Send {Tab}
    Send {Tab}
    Send {Enter} ; Install
}

winTitle = ahk_class #32770 ahk_exe Gw2.exe

; Choose install location
; C:\Program Files (x86)\Guild Wars 2 (Default)
WinWait, %winTitle%,, 15
If WinExist(winTitle)
{
    ; Proceed with defaults
    WinActivate
    Send {Enter} ; OK
}

winTitle = ahk_class ArenaNet ahk_exe Gw2-64.exe

; Download and install Launcher
WinWait, %winTitle%,, 15
If WinExist(winTitle)
{
    Sleep, 50000
}

; Launcher
WinWait, %winTitle%,, 15
If WinExist(winTitle)
{
    WinClose
}

Exit