#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
#NoTrayIcon
#Warn ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetTitleMatchMode, 1 ; A windows's title must start with the specified WinTitle to be a match.
SetControlDelay 0 
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.

winTitle = ahk_exe glyphuninstall.exe

; Uninstall Glyph and all games
WinWait, %winTitle%,, 15
If WinExist(winTitle)
{
    WinActivate
    Send {Tab}
    Send {Tab} ; Switch to include all games
    Send {Enter} ; Continue
}

; Process Window
; Wait for the uninstallation to finish
WinWait, %winTitle%,, 15
Sleep, 7000

; Confirm uninstallation
WinWait, %winTitle%,, 15
If WinExist(winTitle)
{
    WinActivate
    Send {Enter} ; Continue
}

Exit