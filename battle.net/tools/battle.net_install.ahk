#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
;SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
;SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode, 2

WinWait, "Battle.net Setup ahk_class Blizzard Bootstrapper",, 15

If WinExist("Battle.net Setup ahk_class Blizzard Bootstrapper")
{
    WinActivate
    Send {Enter}
}

ExitApp