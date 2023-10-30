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

uninstallText:="|<>*98$66.UA03000000nUA03000000nUA00000600nUA00000600nUArXBsTDXsnUAznDwzjjwnUAsnCAlaAAnUAknAAs63wnUAknAAT6DwnkAknAA1aAAnkMknAAlaAAnzsknAAzbjwnDUknAAT3bgnU"

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