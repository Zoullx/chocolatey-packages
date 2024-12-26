#Warn ; Enable warnings to assist with detecting common errors.

#include "%A_ScriptDir%\..\..\findtext\tools\Lib\FindText.ahk"

SetTitleMatchMode 1 ; A windows's title must start with the specified WinTitle to be a match.
SetControlDelay 0
SetWorkingDir A_ScriptDir ; Ensures a consistent starting directory.

; Get AppData Env Var
appData := EnvGet("AppData")

; Delete the left over AppData
if (DirExist(appData "\Guild Wars 2")) {
    DirDelete appData "\Guild Wars 2", true
}

winTitle := "ahk_class ArenaNet ahk_exe Gw2.exe"

; Loading Installer
; Wait until the Guild Wars 2 Installer is found
WinWait(winTitle)
if WinExist(winTitle) {
    WinActivate
}

installText :=
    "|<>*192$65.03UUE0tw3kTb7q8aNlyTlzC7gxQn3wzbyQ7Mzty7tzDwt6sznt7nyTtnBsTbnDbwznb/wTDiDDtzbC6wSS0STnzCSAwwwwwwbqQyMntnstn700yoD13U040E"

; Start install
if (FindText(&outputX := "wait", &outputY := -1, 0, 0, 0, 0, 0.4, 0.4, installText)) {
    Sleep 1000
    Send "{Tab}"
    Send "{Tab}"
    Send "{Tab}"
    Send "{Tab}"
    Send "{Tab}"
    Send "{Tab}"
    Send "{Tab}"
    Send "{Tab}"
    Send "{Enter}" ; Install
}

; Choose install location window has a different title
winTitle := "ahk_class #32770 ahk_exe Gw2.exe"

; Choose install location
; C:\Program Files (x86)\Guild Wars 2 (Default)
WinWait(winTitle)
if WinExist(winTitle) {
    ; Proceed with defaults
    WinActivate
    Sleep 1000
    ; Hitting Enter on the Install button causes the installation folder to appear twice
    ; Cancel out of the first one to avoid an error if both get accepted
    Send "{Esc}"
    Sleep 1000
    Send "{Enter}" ; OK
}

; Launcher windows have a different title
winTitle := "ahk_class ArenaNet ahk_exe Gw2-64.exe"

WinWait(winTitle)
if WinExist(winTitle) {
    WinActivate
}

loginText :=
    "|<>*124$61.0zkDw5y07UFzllssznVwszlwMyTtsyQTtyAzjwwDCDszYTzySXb7wTmD0zDMnnyDt7szbi9tz7wXwznrUwynwNyTtvsSTMyQTDwxyCDCCD3byST607UTs7w07nU"

; Start install
; This will cause a wait for downloads to finish and for the game launcher to open
if (FindText(&outputX := "wait", &outputY := -1, 0, 0, 0, 0, 0.4, 0.4, loginText)) {
    Sleep 1000
    WinClose
}

ExitApp