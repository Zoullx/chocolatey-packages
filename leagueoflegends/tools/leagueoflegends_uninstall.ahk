#Warn ; Enable warnings to assist with detecting common errors.

SetTitleMatchMode 1 ; A windows's title must start with the specified WinTitle to be a match.
SetControlDelay 0
SetWorkingDir A_ScriptDir ; Ensures a consistent starting directory.

winTitle := "ahk_class ScreenManagerWindowClass ahk_exe RiotClientServices.exe"

; Uninstall finished
WinWait(winTitle,, 15)
If WinExist(winTitle)
{
    Sleep 2000
    WinClose
}

Exit