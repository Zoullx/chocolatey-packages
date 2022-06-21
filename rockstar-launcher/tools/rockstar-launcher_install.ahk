#NoEnv
#NoTrayIcon
#Warn ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetTitleMatchMode, 1 ; A windows's title must start with the specified WinTitle to be a match.
SetControlDelay 0 
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.

winTitle = ahk_class Rockstar Games Launcher Installer ahk_exe Rockstar-Games-Launcher.exe

Sleep, 13000

WinWait, %winTitle%,, 120
If WinExist(winTitle)
{
    ; Select a Language
    ; English by default, unless otherwise stated
    WinActivate
    ControlClick, x1830 y1065, %winTitle% ; Continue
}

Sleep, 1500
WinWait, %winTitle%,, 15
If WinExist(winTitle)
{
    WinActivate
    ; Accept components and component licenses
    ControlClick, x1830 y1065, %winTitle% ; Continue
}

Sleep, 2000
WinWait, %winTitle%,, 15
If WinExist(winTitle)
{
    WinActivate
    ; Accept Rockstar License Agreement
    MouseClick, left, 215, 960 ; Accept License
    Sleep, 500
    ControlClick, x1830 y1065, %winTitle% ; Continue
}

Sleep, 1500
WinWait, %winTitle%,, 15
If WinExist(winTitle)
{
    WinActivate
    ; Choose install location and add Desktop Shortcut
    ControlClick, x1830 y1065, %winTitle% ; Continue (w/ defaults)
}

; Wait for redistributables and launcher setup
Sleep, 7000
WinWait, %winTitle%,, 15
If WinExist(winTitle)
{
    WinActivate
    ; Finalize installation
    MouseClick, left, 220, 735 ; Don't run on install close
    Sleep, 500
    ControlClick, x1830 y1065, %winTitle% ; Close
}

Exit