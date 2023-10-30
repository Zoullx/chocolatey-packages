; #NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
; #NoTrayIcon
#Warn ; Enable warnings to assist with detecting common errors.

#include <FindText>

SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetTitleMatchMode, 1 ; A windows's title must start with the specified WinTitle to be a match.
SetControlDelay 0
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.

EnvGet, programFilesx86, ProgramFiles(x86)
EnvGet, programData, ProgramData

winTitle = ahk_class ArenaNet_Dialog_Class ahk_exe GwSetup.exe

; Loading Installer
; Wait until the Guild Wars Installer is found
; Activate to make sure that it's on top when the actual installer opens
WinWait, %winTitle%
If WinExist(winTitle)
{
    WinActivate
}

okText:="|<>*120$34.3z0A0kDw0k33kw30wD3kA3nk3kkwD0D33kk0AAw300knkA033z0k0ADw300kwkA033n0k0AAD300kkwD0D30kw0wA30wD0k33kw30A3z0A0wDw0k3s"

; Choose install location
; C:\Program Files (x86)\Guild Wars (Default)
If (okOk:=FindText("wait", -1,,,,,,, okText))
{
    Sleep, 1000
    Send {Enter} ; OK
}

; Download windows have the same title as above
; Game window has a different title
winTitle = ahk_class ArenaNet_Dx_Window_Class ahk_exe Gw.exe

; Game Window
; This will cause a wait for downloads to finish and for the game window to open
WinWait, %winTitle%
If WinExist(winTitle)
{
    Sleep, 2000
    WinClose
    FileCreateShortcut, %programFilesx86%\Guild Wars\Gw.exe, %programData%\Microsoft\Windows\Start Menu\Programs\Guild Wars\Guild Wars.lnk
}

ExitApp