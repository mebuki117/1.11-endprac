#NoEnv
#SingleInstance force

; Delay / Wait Settings
global keydelay := 100
global worldgenkeydelay := 500
global worldquitloaddelay := 300
global worldgenwait := 5000
global loadwait := 1000  ; demension load wait
global commanddelay := 100
global commandinputdelay := 300
global altcommanddelay := 600  ; delay for end commands to alt command
global perchcommanddelay := 1000  ; delay for alt command to perch command

; Hotkey Settings
global Resethotkey := "*K"
global ResetinMainMenuhotkey := "*I"
global PerchCommandhotkey := "*P"
global AltCommandhotkey := "*L"

; Auto Commands
global ow_command := ["give @p bed", "give @p bed", "give @p bed", "give @p bed", "give @p bed", "give @p bed", "give @p shield", "setblock ~ ~ ~ end_portal"]
global end_command := ["tp @p 0 70 0 0 0"]
global alt_command := ["fill 0 ~-3 -1 0 ~-3 -2 minecraft:end_stone", "fill 0 ~-2 1 0 ~-4 2 minecraft:end_stone", "tp @p 0 65 -6 0 0", "gamemode 0"]
global perch_command := ["entitydata @e[type=ender_dragon] {{}DragonPhase:2{}}"]

; Self Commands
global self_alt_command := ["kill @e[type=minecraft:area_effect_cloud]"]
global self_perch_command := ["entitydata @e[type=ender_dragon] {{}DragonPhase:2{}}"]


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
    Sleep, % worldquitloaddelay
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

AltCommand() {
    SendCommands(self_alt_command)
}

PerchCommand() {
    SendCommands(self_perch_command)
}

#If WinActive("Minecraft") && (WinActive("ahk_exe javaw.exe") || WinActive("ahk_exe java.exe"))
    Hotkey, %Resethotkey%, ResetGen
    Hotkey, %ResetinMainMenuhotkey%, WorldGenFromMainMenu
    Hotkey, %PerchCommandhotkey%, PerchCommand
    Hotkey, %AltCommandhotkey%, AltCommand