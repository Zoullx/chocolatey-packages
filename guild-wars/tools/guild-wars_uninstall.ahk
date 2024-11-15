#Warn ; Enable warnings to assist with detecting common errors.

#include <FindText>

SetTitleMatchMode 1 ; A windows's title must start with the specified WinTitle to be a match.
SetControlDelay 0
SetWorkingDir A_ScriptDir ; Ensures a consistent starting directory.

winTitle := "ahk_class ArenaNet_Dialog_Class ahk_exe Gw.exe"

; Loading Uninstaller
; Wait until the Guild Wars Uninstaller is found
WinWait(winTitle)

uninstallText :=
"|<>*98$66.UA03000000nUA03000000nUA00000600nUA00000600nUArXBsTDXsnUAznDwzjjwnUAsnCAlaAAnUAknAAs63wnUAknAAT6DwnkAknAA1aAAnkMknAAlaAAnzsknAAzbjwnDUknAAT3bgnU"

; Uninstall Guild Wars
if (FindText(&outputX := "wait", &outputY := -1, 0, 0, 0, 0, 0.4, 0.4, uninstallText)) {
    Sleep 1000
    ControlSend "{Tab}" ; Switch from Reinstall to Uninstall
    ControlSend "{Enter}" ; Uninstall
}

; Window title changes for the confirmation window
winTitle := "ahk_class #32770 ahk_exe Gw.exe"

; Uninstall Successful
; Confirm uninstallation
WinWait(winTitle)
if WinExist(winTitle) {
    Sleep 1000
    ControlSend "{Enter}" ; OK
}

ExitApp