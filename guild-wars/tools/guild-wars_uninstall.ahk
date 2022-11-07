#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
#NoTrayIcon
#Warn ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetTitleMatchMode, 1 ; A windows's title must start with the specified WinTitle to be a match.
SetControlDelay 0
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.

winTitle = ahk_class ArenaNet_Dialog_Class ahk_exe Gw.exe

; Loading Uninstaller
WinWait, %winTitle%,, 120
If WinExist(winTitle)
{
    Sleep, 5000
}

; Uninstall Guild Wars
WinWait, %winTitle%,, 15
If WinExist(winTitle)
{
    WinActivate
    Send {Tab} ; Switch from Reinstall to Uninstall
    Send {Enter} ; Uninstall
    Sleep, 1000
}

winTitle = ahk_class #32770 ahk_exe Gw.exe

; Uninstall Successful
WinWait, %winTitle%,, 15
If WinExist(winTitle)
{
    WinActivate
    Send {Enter} ; OK
}

Exit