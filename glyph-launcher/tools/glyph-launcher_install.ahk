#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
#NoTrayIcon
#Warn ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetTitleMatchMode, 1 ; A windows's title must start with the specified WinTitle to be a match.
SetControlDelay 0 
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.

winTitle = ahk_class Qt5QWindowIcon ahk_exe glyphinstall.exe

; Accept Terms and continue with defaults
WinWait, %winTitle%,, 20
If WinExist(winTitle)
{
    WinActivate
    Send {Tab}
    Send {Tab}
    Send {Tab}
    Send {Space} ; Accept Terms
    Send {Tab}
    Send {Enter} ; Continue
}

Exit