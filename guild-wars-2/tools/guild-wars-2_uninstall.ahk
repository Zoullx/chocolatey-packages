#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
#NoTrayIcon
#Warn ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetTitleMatchMode, 1 ; A windows's title must start with the specified WinTitle to be a match.
SetControlDelay 0
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.

winTitle = ahk_class #32770 ahk_exe Gw2-64.exe

; Are you sure you want to uninstall
WinWait, %winTitle%,, 120
If WinExist(winTitle)
{
    WinActivate
    Send {Enter} ; Yes
    Sleep, 1000
}

; Uninstalled
WinWait, %winTitle%,, 15
If WinExist(winTitle)
{
    WinActivate
    Send {Enter} ; OK
}