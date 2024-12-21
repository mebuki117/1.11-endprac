#NoEnv
#SingleInstance force

; Delay / Wait Settings
global keydelay := 70
global worldgenkeydelay := 500
global worldquitkeydelay := 300
global worldgenwait := 5000
global loadwait := 800
global commanddelay := 70
global commandinputdelay := 300
global altcommanddelay := 600
global perchcommanddelay := 1000

; Hotkey Settings
global Resethotkey := "*K"
global ResetinMainMenuhotkey := "*I"

; Commands
global ow_command := ["give @p bed", "give @p bed", "give @p bed", "give @p bed", "give @p bed", "give @p bed", "give @p shield", "setblock ~ ~ ~ end_portal"]
global end_command := ["tp @p 0 70 0 0 0"]
global alt_command := ["execute @p ~ ~ ~ fill 0 ~-3 -1 0 ~-3 -2 minecraft:end_stone", "execute @p ~ ~ ~ fill 0 ~-2 1 0 ~-4 2 minecraft:end_stone", "tp @p 0 65 -6 0 0"]
global perch_command := ["gamemode 0", "entitydata @e[type=ender_dragon] {{}DragonPhase:2{}}"]



; Do Not Edit
SetKeyDelay, % keydelay

WorldGen() {
    ControlSend,, {Blind}{Enter}
    Sleep, % worldgenkeydelay
    ControlSend,, {Blind}{Tab 3}{Enter}{Tab 3}{Enter 2}{Tab 2}{Enter}
    Sleep, % worldgenwait

    SendCommands(ow_command)
    Sleep, % loadwait
    SendCommands(end_command)
    Sleep, % altcommanddelay
    SendCommands(alt_command)
    Sleep, % perchcommanddelay
    SendCommands(perch_command)
}

WorldGenFromMainMenu() {
    ControlSend,, {Blind}{Tab}
    WorldGen()
}

WorldQuit() {
    ControlSend,, {Blind}{ESC}{Tab}{Enter}{Tab}
}
  
ResetGen() {
    WorldQuit()
    Sleep, % worldquitkeydelay
    WorldGen()
}

SendCommands(commands) {
    Loop, % commands.Length() {
        ControlSend,, {Blind}{/}
        SendInput, % commands[A_Index]
        Sleep, % commandinputdelay
        SendInput, {Enter}
        Sleep, % commanddelay
    }
}

#If WinActive("Minecraft") && (WinActive("ahk_exe javaw.exe") || WinActive("ahk_exe java.exe"))
    Hotkey, %Resethotkey%, ResetGen
    Hotkey, %ResetinMainMenuhotkey%, WorldGenFromMainMenu