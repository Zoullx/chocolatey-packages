#Warn ; Enable warnings to assist with detecting common errors.

#include <FindText>

SetTitleMatchMode 1 ; A windows's title must start with the specified WinTitle to be a match.
SetControlDelay 0
SetWorkingDir A_ScriptDir ; Ensures a consistent starting directory.

winTitle := "ahk_class #32770 ahk_exe Gw2-64.exe"

; Are you sure you want to uninstall window
; Wait until the Guild Wars 2 Uninstaller is found
WinWait(winTitle)

areYouSureText :=
    "|<>*150$63.40000000000k000000000+CQ8b4EAWQtFYUZYW24H9F8w58YEMWFvt40d4W0YG8F8k3AYE4WFY53UEsS3Xm700020000000001U000000U"

; Are you sure you want to uninstall
if (FindText(&outputX := "wait", &outputY := -1, 0, 0, 0, 0, 0.4, 0.4, areYouSureText)) {
    Sleep 1000
    ControlSend "{Enter}" ; Yes
}

; Wait for the new window with the same name to show back up
WinWait(winTitle)

uninstallSuccessfulText :=
    "|<>*145$99.V0400U2E00000070A800040G0000000U1VDYyBvmEAWCQsliFA9YaG42G24H698EW9V8YWMVmEMWEVtX4FA94YEYGG0YG4824W9l8YW4WGE4WMlUEYF/l4YHbSG3XlnbCQVtU"

; Are you sure you want to uninstall
if (FindText(&outputX := "wait", &outputY := -1, 0, 0, 0, 0, 0.4, 0.4, uninstallSuccessfulText)) {
    Sleep 1000
    ControlSend "{Enter}" ; OK
}

ExitApp