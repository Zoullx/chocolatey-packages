; #NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
; #NoTrayIcon
#Warn ; Enable warnings to assist with detecting common errors.

#include <FindText>

SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetTitleMatchMode, 1 ; A windows's title must start with the specified WinTitle to be a match.
SetControlDelay 0
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.

; Get AppData Env Var
EnvGet, appData, AppData

; Delete the left over AppData
FileRemoveDir, %appData%\Guild Wars 2, 1

winTitle = ahk_class ArenaNet ahk_exe Gw2.exe

; Loading Installer
; Wait until the Guild Wars 2 Installer is found
WinWait, %winTitle%
If WinExist(winTitle)
{
    WinActivate
}

installText:="|<>*196$64.0712U1ns7UySTMmNb7tz7tsxbfbMTbwzbdqDyTVyTnySXQTtyntzjtvBsTbnDbyzbiLsyTQyTvySwPlts1tzjtvlbbbjbbqybjaAyQzCSvk0TO7UVs0208"

; Start install
If (FindText("wait", -1,,,,,,, installText))
{
    Sleep, 1000
    Send {Tab}
    Send {Tab}
    Send {Tab}
    Send {Tab}
    Send {Tab}
    Send {Tab}
    Send {Tab}
    Send {Tab}
    Send {Enter} ; Install
}

; Choose install location window has a different title
winTitle = ahk_class #32770 ahk_exe Gw2.exe

; Choose install location
; C:\Program Files (x86)\Guild Wars 2 (Default)
WinWait, %winTitle%
If WinExist(winTitle)
{
    ; Proceed with defaults
    WinActivate
    Sleep, 1000
    ; Hitting Enter on the Install button causes the installation folder to appear twice
    ; Cancel out of the first one to avoid an error if both get accepted
    Send {Esc}
    Sleep, 1000
    Send {Enter} ; OK
}

; Launcher windows have a different title
winTitle = ahk_class ArenaNet ahk_exe Gw2-64.exe

WinWait, %winTitle%
If WinExist(winTitle)
{
    WinActivate
}

loginText:="|<>*141$61.0zkDw5y07UFzllssznVwwzlwsyTtsySTtzAzjwwDDDszaTzySXbbwTmDUzDMnnyDt7tzbi9tz7wnwznrUwynyNyTtvsSTMyQTDwxyCDCCT7byST60DkTs7w07nU"

; Start install
; This will cause a wait for downloads to finish and for the game launcher to open
If (FindText("wait", -1,,,,,,, loginText))
{
    Sleep, 1000
    WinClose
}

ExitApp