#NoEnv
#NoTrayIcon
#Warn ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetTitleMatchMode, 1 ; A windows's title must start with the specified WinTitle to be a match.
SetControlDelay 0 
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.

winTitle = ahk_class Rockstar Games Launcher Installer ahk_exe Rockstar-Games-Launcher.exe

Sleep, 13000

WinWait, %winTitle%,, 120
If WinExist(winTitle)
{
    ; Select a Language
    ; English by default, unless otherwise stated
    WinActivate
    WinGetPos,,, Width, Height
    ContinueXPos := Width * 0.89
    ContinueYPos := Height * 0.89
    ControlClick, x%ContinueXPos% y%ContinueYPos%, %winTitle% ; Continue
    Sleep, 1500
}

WinWait, %winTitle%,, 15
If WinExist(winTitle)
{
    WinActivate
    WinGetPos,,, Width, Height
    ContinueXPos := Width * 0.89
    ContinueYPos := Height * 0.89
    ; Accept components and component licenses
    ControlClick, x%ContinueXPos% y%ContinueYPos%, %winTitle% ; Continue
    Sleep, 2000
}

WinWait, %winTitle%,, 15
If WinExist(winTitle)
{
    WinActivate
    WinGetPos,,, Width, Height
    AcceptXPos := Width * 0.105
    AcceptYPos := Height * 0.8
    ContinueXPos := Width * 0.89
    ContinueYPos := Height * 0.89
    ; Accept Rockstar License Agreement
    MouseClick, left, %AcceptXPos%, %AcceptYPos% ; Accept License
    Sleep, 500
    ControlClick, x%ContinueXPos% y%ContinueYPos%, %winTitle% ; Continue
    Sleep, 1500
}

WinWait, %winTitle%,, 15
If WinExist(winTitle)
{
    WinActivate
    WinGetPos,,, Width, Height
    ContinueXPos := Width * 0.89
    ContinueYPos := Height * 0.89
    ; Choose install location and add Desktop Shortcut
    ControlClick, x%ContinueXPos% y%ContinueYPos%, %winTitle% ; Continue (w/ defaults)
}

; Wait for redistributables and launcher setup
WinWait, %winTitle%,, 15
Sleep, 10000

WinWait, %winTitle%,, 15
If WinExist(winTitle)
{
    WinActivate
    WinGetPos,,, Width, Height
    DontRunXPos := Width * 0.107
    DontRunYPos := Height * 0.612
    ContinueXPos := Width * 0.89
    ContinueYPos := Height * 0.89
    ; Finalize installation
    MouseClick, left, %DontRunXPos%, %DontRunYPos% ; Don't run on install close
    Sleep, 500
    ControlClick, x%ContinueXPos% y%ContinueYPos%, %winTitle% ; Close
}

Exit