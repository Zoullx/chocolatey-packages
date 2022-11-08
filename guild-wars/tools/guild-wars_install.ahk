#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
#NoTrayIcon
#Warn ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetTitleMatchMode, 1 ; A windows's title must start with the specified WinTitle to be a match.
SetControlDelay 0
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.

EnvGet, programFilesx86, ProgramFiles(x86)
EnvGet, programData, ProgramData

winTitle = ahk_class ArenaNet_Dialog_Class ahk_exe GwSetup.exe

; Loading Installer
WinWait, %winTitle%,, 120
If WinExist(winTitle)
{
    Sleep, 5000
}

; Choose install location
; C:\Program Files (x86)\Guild Wars (Default)
WinWait, %winTitle%,, 15
If WinExist(winTitle)
{
    ; Proceed with defaults
    WinActivate
    Send {Enter} ; OK
}

winTitle = ahk_class ArenaNet_Dx_Window_Class ahk_exe Gw.exe

; Game Window
WinWait, %winTitle%,, 1200
If WinExist(winTitle)
{
    Sleep, 2000
    WinClose
    FileCreateShortcut, %programFilesx86%\Guild Wars\Gw.exe, %programData%\Microsoft\Windows\Start Menu\Programs\Guild Wars\Guild Wars.lnk
}

Exit