; #NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
; #NoTrayIcon
#Warn ; Enable warnings to assist with detecting common errors.

#include <FindText>

SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetTitleMatchMode, 1 ; A windows's title must start with the specified WinTitle to be a match.
SetControlDelay 0
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.

winTitle = ahk_class ArenaNet_Dialog_Class ahk_exe Gw.exe

; Loading Uninstaller
; Wait until the Guild Wars Uninstaller is found
; Activate to make sure that it's on top when the actual uninstaller opens
WinWait, %winTitle%
If WinExist(winTitle)
{
    WinActivate
}

uninstallText:="|<>*98$132.k03k000D000000000000wDk03k000D000000000000wDk03k000D000000000000wDk03k000D000000000000wDk03k00000000000w0000wDk03k00000000000w0000wDk03k00000000000w0000wDk03k00000000000w0000wDk03kwzkD3nz0Dz3zkDz0wDk03kwzkD3nz0Dz3zkDz0wDk03kzzwD3zzkzznznzzkwDk03kzzwD3zzkzznznzzkwDk03kz0wD3w3kw3kw3k3kwDk03kz0wD3w3kw3kw3k3kwDk03kw0wD3k3kz00w0DzkwDk03kw0wD3k3kz00w0DzkwDk03kw0wD3k3kDz0w3zzkwDk03kw0wD3k3kDz0w3zzkwDw03kw0wD3k3k03kw3k3kwDw03kw0wD3k3k03kw3k3kwDw0D0w0wD3k3kw3kw3k3kwDw0D0w0wD3k3kw3kw3k3kwDzzz0w0wD3k3kzzkznzzkwDzzz0w0wD3k3kzzkznzzkwD3zk0w0wD3k3kDz0DkznkwD3zk0w0wD3k3kDz0DkznkwDU"

; Uninstall Guild Wars
If (uninstallOk:=FindText("wait", -1,,,,,,, uninstallText))
{
    Sleep, 1000
    Send {Tab} ; Switch from Reinstall to Uninstall
    Send {Enter} ; Uninstall
}

; Window title changes for the confirmation window
winTitle = ahk_class #32770 ahk_exe Gw.exe

; Uninstall Successful
; Confirm uninstallation
WinWait, %winTitle%
If WinExist(winTitle)
{
    Sleep, 1000
    Send {Enter} ; OK
}

ExitApp