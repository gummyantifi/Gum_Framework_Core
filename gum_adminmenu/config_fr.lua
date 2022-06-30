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
    [1] = {text = "Annonce Serveur"},
    [2] = {text = "Inventaire"},
    [3] = {text = "Personnel"},
    [4] = {text = "Menu de gestion Personnel"},
    [5] = {text = "Liste des joueurs"},
    [6] = {text = "Liste avec tous les joueurs"},
    [7] = {text = "Liste d'Items"},
    [8] = {text = "Menu Admin"},
    [9] = {text = "Après avoir appuyer sur [Enter] vous obtiendrez l'item"},
    [10] = {text = "No clip"},
    [11] = {text = "Téléportation au point de repère"},
    [12] = {text = "Retour à la dernière position"},
    [13] = {text = "Commande /n"},
    [14] = {text = "Commande /tpw"},
    [15] = {text = "Commande /tpb"},
    [16] = {text = "Commande /an TEXT"},
    [17] = {text = "Kick Joueur"},
    [18] = {text = "Bannir Joueur"},
    [19] = {text = "Freeze Joueur"},
    [20] = {text = "Ressuciter Joueur"},
    [21] = {text = "Se téléporter à un joueur"},
    [22] = {text = "Téléporter un joueur"},
    [23] = {text = "Spec un joueur"},
    [24] = {text = "Kick du serveur"},
    [25] = {text = "Donner un objet"},
    [26] = {text = "Donner de l'argent"},
    [27] = {text = "Accepter"},
    [28] = {text = "Raison du kick"},
    [29] = {text = "Raison du ban"},
    [30] = {text = "Format de la date : 2021-08-16 10:00:00"},
    [31] = {text = "ID item"},
    [32] = {text = "Nombre d'items"},
    [33] = {text = "Nombre"},
    [34] = {text = "Message"},
    [35] = {text = "Z/S - Avancer/Reculer, Espace/Shift - Monter/Descendre, Page Up/Page Down/Molette Souris - Vitesse, Q - mod Absolut, H - Désactiver la direction de la caméra, , R - Afficher / Masquer"},
    [36] = {text = "Z/S - Avancer/Reculer, Espace/Shift - Monter/Descendre, Page Up/Page Down/Molette Souris - Vitesse, Q - mod Absolut, H - Désactiver la direction de la caméra, , R - Afficher / Masquer"},
    [37] = {text = "Coords"},
    [38] = {text = "Z/S - Avancer/Reculer, Espace/Shift - Monter/Descendre, Page Up/Page Down/Molette Souris - Vitesse, Q - mod Absolut"}
    
}

Config.WebHookEnable = false
Config.WebhookURL = ""