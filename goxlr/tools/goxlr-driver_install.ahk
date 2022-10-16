#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
#NoTrayIcon
#Warn ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetTitleMatchMode, 1 ; A windows's title must start with the specified WinTitle to be a match.
SetControlDelay 0
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.

winTitle = ahk_class #32770 ahk_exe setup.exe

; Wizard start window
WinWait, %winTitle%,, 120
If WinExist(winTitle)
{
    WinActivate
    Send {Enter} ; Continue
    Sleep 1000
}

; Choose install location
; C:\Program Files\TC-Helicon\GoXLR_Audio_Driver (Default)
WinWait, %winTitle%,, 15
If WinExist(winTitle)
{
    ; Proceed with default
    WinActivate
    Send {Enter} ; Install
    Sleep 1000
}

; Install window
; Wait for the download to finish
WinWait, %winTitle%,, 15
If WinExist(winTitle)
{
    Sleep, 15000
}

; Installation Complete
WinWait, %winTitle%,, 15
If WinExist(winTitle)
{
    WinActivate
    Send {Enter} ; Continue
    Sleep 1000
}

; Wizard finish window
WinWait, %winTitle%,, 15
If WinExist(winTitle)
{
    WinActivate
    Send {Enter} ; Finish
    Sleep 1000
}

; Exit wizard
WinWait, %winTitle%,, 15
If WinExist(winTitle)
{
    WinActivate
    Send {Tab} ; Switch to yes
    Send {Enter} ; Exit
}

Exit