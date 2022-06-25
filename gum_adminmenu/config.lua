Config = {}

Config.OneSync = true
Config.MaxSpeed = 10.0
Config.MinSpeed = 0.1
Config.SpeedIncrement = 0.1
Config.Speed = 0.1

Config.RelativeMode = true
Config.FollowCam = true

-- Configurable controls
Config.ToggleControl        = `INPUT_PHOTO_MODE_PC`                     -- F6
Config.IncreaseSpeedControl = {`INPUT_CREATOR_LT`, `INPUT_PREV_WEAPON`} -- Page Up, Middle Wheel Up
Config.DecreaseSpeedControl = {`INPUT_CREATOR_RT`, `INPUT_NEXT_WEAPON`} -- Page Down, Middle Wheel Down
Config.UpControl            = `INPUT_JUMP`                              -- Spacebar
Config.DownControl          = `INPUT_SPRINT`                            -- Shift
Config.ForwardControl       = `INPUT_MOVE_UP_ONLY`                      -- W
Config.BackwardControl      = `INPUT_MOVE_DOWN_ONLY`                    -- S
Config.LeftControl          = `INPUT_MOVE_LEFT_ONLY`                    -- A
Config.RightControl         = `INPUT_MOVE_RIGHT_ONLY`                   -- D
Config.ToggleModeControl    = `INPUT_COVER`                             -- Q
Config.FollowCamControl     = `INPUT_MULTIPLAYER_PREDATOR_ABILITY`      -- H

Config.Language = {
    [1] = {text = "Server announce"},
    [2] = {text = "Inventory"},
    [3] = {text = "Personal"},
    [4] = {text = "Menu for personal activity"},
    [5] = {text = "List players"},
    [6] = {text = "List with all players"},
    [7] = {text = "Item list"},
    [8] = {text = "Admin menu"},
    [9] = {text = "After press [ENTER] you get item"},
    [10] = {text = "No clip"},
    [11] = {text = "Teleport on waypoint"},
    [12] = {text = "Teleport back"},
    [13] = {text = "Command /n"},
    [14] = {text = "Command /tpw"},
    [15] = {text = "Command /tpb"},
    [16] = {text = "Command /an TEXT"},
    [17] = {text = "Kick player"},
    [18] = {text = "Ban player"},
    [19] = {text = "Freeze player"},
    [20] = {text = "Revive player"},
    [21] = {text = "Go to on player"},
    [22] = {text = "Bring to me"},
    [23] = {text = "Spectate player"},
    [24] = {text = "Kick from server"},
    [25] = {text = "Give item"},
    [26] = {text = "Give money"},
    [27] = {text = "Accept"},
    [28] = {text = "Why hes get kick"},
    [29] = {text = "Why he get ban"},
    [30] = {text = "Format date : 2021-08-16 10:00:00"},
    [31] = {text = "ID item"},
    [32] = {text = "Count items"},
    [33] = {text = "Count"},
    [34] = {text = "Message"},
    [35] = {text = "W/S - Pohyb, Spacebar/Shift - Nahoru/Dolů, Page Up/Page Down/Mouse Wheel - Změna rychlosti, Q - Absolutní mod, H - Vypnout směr kamery, , R - Ukázat/Skrýt se"},
    [36] = {text = "W/S - Pohyb, Spacebar/Shift - Nahoru/Dolů, Page Up/Page Down/Mouse Wheel - Změna rychlosti, Q - Absolutní mód, H - Zapnout směr kamery, , R - Ukázat/Skrýt se"},
    [37] = {text = "Coords"},
    [38] = {text = "W/S - Pohyb, Spacebar/Shift - Nahoru/Dolů, Page Up/Page Down/Mouse Wheel - Změna rychlosti, Q - Relativní mód, R - Ukázat/Skrýt se"}
    
}

Config.WebHookEnable = false
Config.WebhookURL = ""