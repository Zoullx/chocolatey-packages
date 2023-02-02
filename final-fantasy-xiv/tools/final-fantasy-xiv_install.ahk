#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
#NoTrayIcon
#Warn ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetTitleMatchMode, 1 ; A windows's title must start with the specified WinTitle to be a match.
SetControlDelay 0
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.

winTitle = ahk_class FINAL FANTASY XIV LAUNCHER ahk_exe ffxivsetup_ft.exe

; Setup that loads actual installer
; Select region and language
WinWait, %winTitle%,, 120
If WinExist(winTitle)
{
    WinActivate
    Send {Enter} ; Accept
}

winTitle = ahk_class #32770 ahk_exe ffxivinstaller.exe

; Splash screen
; Grab the splash screen, wait a couple seconds for it to go away
WinWait, %winTitle%,, 120
If WinExist(winTitle)
{
    Sleep, 6000
}

; Actual installer
; Wait a good amount of time for this window
WinWait, %winTitle%,, 15
If WinExist(winTitle)
{
    WinActivate
    ; Welcome screen
    Send {Enter} ; Next
    Sleep, 500
    ; Note on background applications
    Send {Enter} ; Next
    Sleep, 500
    ; Choose install location
    ; C:\Program Files (x86) (Default)
    Send {Enter} ; Next
    Sleep, 500
    ; Confirm settings
    Send {Enter} ; Next
    Sleep, 5000
    ; Installs
    ; Final screen with Desktop Shortcut option
    Send {Enter} ; Finish
}

Exit