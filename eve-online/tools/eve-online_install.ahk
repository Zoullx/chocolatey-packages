#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
#NoTrayIcon
#Warn ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetTitleMatchMode, 1 ; A windows's title must start with the specified WinTitle to be a match.
SetControlDelay 0
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.

; CacheFolder suppressed to be set each time for Shared Cache
RegDelete, HKEY_CURRENT_USER\SOFTWARE\CCP\EVEONLINE, CACHEFOLDER

winTitle = ahk_class Qt5QWindowIcon ahk_exe EveLauncher-2153627.exe

; Choose install location
; C:\EVE (Default)
WinWait, %winTitle%,, 120
If WinExist(winTitle)
{
    WinActivate
    Send {Enter} ; Install
}

; Wait for install
WinWait, %winTitle%,, 15
If WinExist(winTitle)
{
    Sleep, 12000
}

; Finish
WinWait, %winTitle%,, 15
If WinExist(winTitle)
{
    WinActivate
    Send {Space} ; Turn off run now
    Send {Enter} ; Finish
}

Exit