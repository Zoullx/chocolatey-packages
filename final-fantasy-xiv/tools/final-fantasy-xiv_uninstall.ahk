#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
#NoTrayIcon
#Warn ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetTitleMatchMode, 1 ; A windows's title must start with the specified WinTitle to be a match.
SetControlDelay 0
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.

winTitle = ahk_class WinComponent_MyMessageBox_H ahk_exe setup.exe

; Confirm uninstall
WinWait, %winTitle%,, 15
If WinExist(winTitle)
{
    WinActivate
    Send {Y} ; Confirm
}

winTitle = ahk_class #32770 ahk_exe setup.exe

WinWait, %winTitle%,, 15
If WinExist(winTitle)
{
    Sleep, 1500
}

; Finish uninstall
WinWait, %winTitle%,, 15
If WinExist(winTitle)
{
    WinActivate
    Send {Enter} ; Finish
}

Exit