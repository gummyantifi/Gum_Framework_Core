local PlayerTable = {}
TriggerEvent("gum_menu:getData",function(call)
    MenuData = call
end)
local reload_data = 0
local again = false
local count_char = 0
local can_have = 0

RegisterCommand('character', function()
    exports['gum_notify']:DisplayLeftNotification("Character selection", "You switch character wait 10 second.", 'character', 5000)
    RemoveAllPedWeapons(PlayerPedId(), false, true)
    local GetCoords = GetEntityCoords(PlayerPedId())
    local GetHeading = GetEntityHeading(PlayerPedId())
    local coords_save = {x= tonumber(string.format("%.2f", GetCoords.x)), y=tonumber(string.format("%.2f", GetCoords.y)), z=tonumber(string.format("%.2f", GetCoords.z)), heading=tonumber(string.format("%.2f", GetHeading))}
    TriggerServerEvent("gumCore:save_coords", coords_save)
    Citizen.Wait(100)
    exports['gum_character']:loading(true)
    SendNUIMessage({
        type = "volume_stop",
        status = false,
    })
    Citizen.Wait(1000)
    SetEntityCoords(PlayerPedId(), 1407.5758056640625, -1139.779541015625, 75.34298706054688)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.InvokeNative(0x4CC5F2FC1332577F, GetHashKey("HUD_CTX_INFINITE_AMMO"))
        Citizen.InvokeNative(0x4CC5F2FC1332577F, GetHashKey("HUD_CTX_SHARP_SHOOTER_EVENT"))
        Citizen.InvokeNative(0x4CC5F2FC1332577F ,GetHashKey("HUD_CTX_RESTING_BY_FIRE"))
        Citizen.InvokeNative(0x4CC5F2FC1332577F ,GetHashKey("HUD_CTX_INFO_CARD"))
        Citizen.InvokeNative(0x4CC5F2FC1332577F ,GetHashKey("HUD_CTX_GOLD_CURRENCY_CHANGE"))

        Citizen.InvokeNative(0xD4EE21B7CC7FD350, false)
        Citizen.InvokeNative(0x50C803A4CD5932C5, false)
        Citizen.Wait(500)
    end
end)

RegisterNetEvent('gum_character:del_old')
AddEventHandler('gum_character:del_old', function(table, tableuser)
    DeletePed(character_1)
    DeletePed(character_2)
    DeletePed(character_3)
    DeletePed(character_4)
end)

RegisterNetEvent('gum_character:select_char')
AddEventHandler('gum_character:select_char', function(table, tableuser)
    SetEntityCoords(PlayerPedId(), 1407.5758056640625, -1139.779541015625, 75.34298706054688)
    Citizen.Wait(2000)
    NetworkClockTimeOverride(08, 00, 00, 0, true)
    PlayerTable = table
    can_have = tableuser.chars
    for k,v in pairs(PlayerTable) do
        count_char = k
    end
    for k,v in pairs(PlayerTable) do
        if k == 1 then
            reload_data = 0
            local spawn_id = json.decode(v.skinPlayer).sex
            while not HasModelLoaded(GetHashKey(spawn_id)) do
                Wait(0)
                modelrequest( GetHashKey(spawn_id) )
            end
            character_1 = CreatePed(GetHashKey(spawn_id), 1408.5572509765625, -1149.430908203125, 75.20068725585938, false, false, 0, 0)
            FreezeEntityPosition(character_1, true)
            SetEntityHeading(character_1, -14.50)
            Ped_Data_Load(character_1, json.decode(v.skinPlayer), json.decode(v.compPlayer), k)
        end
        if k == 2 then
            reload_data = 0
            local spawn_id = json.decode(v.skinPlayer).sex
            while not HasModelLoaded(GetHashKey(spawn_id)) do
                Wait(0)
                modelrequest( GetHashKey(spawn_id) )
            end
            character_2 = CreatePed(GetHashKey(spawn_id), 1411.1339111328125, -1149.3594970703125, 74.78067016601562, false, false, 0, 0)
            FreezeEntityPosition(character_2, true)
            SetEntityHeading(character_2, 34.50)
            Ped_Data_Load(character_2, json.decode(v.skinPlayer), json.decode(v.compPlayer), k)
        end
        if k == 3 then
            reload_data = 0
            local spawn_id = json.decode(v.skinPlayer).sex
            while not HasModelLoaded(GetHashKey(spawn_id)) do
                Wait(0)
                modelrequest( GetHashKey(spawn_id) )
            end
            character_3 = CreatePed(GetHashKey(spawn_id), 1407.4609375, -1148.5867919921875, 74.88335418701172, false, false, 0, 0)
            FreezeEntityPosition(character_3, true)
            SetEntityHeading(character_3, -37.76)
            Ped_Data_Load(character_3, json.decode(v.skinPlayer), json.decode(v.compPlayer), k)
        end
        if k == 4 then
            reload_data = 0
            local spawn_id = json.decode(v.skinPlayer).sex
            while not HasModelLoaded(GetHashKey(spawn_id)) do
                Wait(0)
                modelrequest( GetHashKey(spawn_id) )
            end
            character_4 = CreatePed(GetHashKey(spawn_id), 1406.1318359375, -1147.7061767578125, 74.78675079345703, false, false, 0, 0)
            FreezeEntityPosition(character_4, true)
            SetEntityHeading(character_4, -35.76)
            Ped_Data_Load(character_4, json.decode(v.skinPlayer), json.decode(v.compPlayer), k)
        end
    end
    Citizen.Wait(100)
    playAnim(character_1, 'script_mp@photo_studio@sit_on_crate@male', 'idle_m02', -1, 1)
    playAnim(character_2, 'script_mp@photo_studio@sit_on_crate@male', 'idle_m04', -1, 1)
    playAnim(character_3, 'script_mp@photostudio@dog@male', 'idle_m02', -1, 1)
    playAnim(character_4, 'script_mp@photostudio@dog@male', 'idle_m06', -1, 1)
    Citizen.Wait(500)
    exports['gum_character']:loading(false) 
    SetNuiFocus(true, true)
    for k,v in pairs(PlayerTable) do
        if k == 1 then
            if json.decode(v.skinPlayer).sex == "mp_female" then
                sex = "Female"
            else
                sex = "Male"
            end
            SendNUIMessage({
                type = "character_info",
                status = true,
                char = 1,
                money = v.money,
                gold = v.gold,
                job = v.job,
                first = v.firstname,
                last = v.lastname,
                sex = sex, 
                table = PlayerTable,
                countchar = count_char,
            })
        end
    end

    StartCam(1408.50, -1145.73, 76.60, -175.99, 35.0)
end)

RegisterNUICallback('switch_char', function(data, cb)
    if tonumber(data.char) == 1 then
        SwitchCam(1408.50, -1145.73, 76.60, -175.99, 35.0)
    elseif tonumber(data.char) == 2 then
        SwitchCam(1408.50, -1145.73, 76.17, -146.14, 35.0)
    elseif tonumber(data.char) == 3 then
        SwitchCam(1408.50, -1145.73, 75.87, 165.05, 35.0)
    elseif tonumber(data.char) == 4 then
        SwitchCam(1408.50, -1145.73, 76.40, 137.18, 35.0)
    end
end)

RegisterNUICallback('select_char', function(data, cb)
    N_0x69d65e89ffd72313(false)
    SetNuiFocus(false, false)
    DoScreenFadeOut(500)
    Citizen.Wait(500)
    exports['gum_character']:loading(true)
    for k,v in pairs(PlayerTable) do
        if k == tonumber(data.char) then
            TriggerServerEvent("gum_character:select_char", v.charidentifier, json.decode(v.skinPlayer), json.decode(v.compPlayer), json.decode(v.coords), v.isdead)      
        end
    end
    SendNUIMessage({
        type = "character_info",
        status = false,
    })
    EndCam()
    Citizen.Wait(500)
    DeletePed(character_1)
    DeletePed(character_2)
    DeletePed(character_3)
    DeletePed(character_4)
    DoScreenFadeIn(500)
end)

RegisterNUICallback('make_new', function(data, cb)
    if tonumber(can_have) > tonumber(count_char) then
        TriggerEvent('gum_character:del_old')
        N_0x69d65e89ffd72313(false)
        SetNuiFocus(false, false)
        SendNUIMessage({
            type = "character_info",
            status = false,
        })
        TriggerEvent('gum_character:make_character')
    else
        exports['gum_notify']:DisplayLeftNotification("Character selection", "You cant make character, becouse you have max limit.", 'character', 2000)
    end
end)


function StartCam(x,y,z, heading, zoom)
    Citizen.InvokeNative(0x17E0198B3882C2CB, PlayerPedId())
    DestroyAllCams(true)
    camera = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", x,y,z, -10.0, 00.00, heading, zoom, true, 0)
    SetCamActive(camera,true)
    RenderScriptCams(true, true, 500, true, true)
end

function SwitchCam(x,y,z, heading, zoom)
    SetCamParams(camera, x,y,z, -10.0, 0.0, heading, zoom, 1500, 1, 3, 1)
end
function EndCam()
    RenderScriptCams(false, true, 1000, true, false)
    DestroyCam(camera, false)
    camera = nil
    DestroyAllCams(true)
    Citizen.InvokeNative(0xD0AFAFF5A51D72F7, PlayerPedId())
end


function playAnim(ped, dict,name, time, flag)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(100)
    end
    TaskPlayAnim(ped, dict, name, 1.0, 1.0, time, flag, 0, false, 0, false, 0, false)  
end

function modelrequest(model)
    Citizen.CreateThread(function()
        RequestModel(model)
    end)
end

function Reload_Func(pos)
    for k,v in pairs(PlayerTable) do
        if k == tonumber(pos) and tonumber(pos) == 1 then
            local spawn_id = json.decode(v.skinPlayer).sex
            while not HasModelLoaded(GetHashKey(spawn_id)) do
                Wait(0)
                modelrequest( GetHashKey(spawn_id) )
            end
            character_1 = CreatePed(GetHashKey(spawn_id), 1408.5572509765625, -1149.430908203125, 75.20068725585938, false, false, 0, 0)
            FreezeEntityPosition(character_1, true)
            SetEntityHeading(character_1, -14.50)
            Ped_Data_Load(character_1, json.decode(v.skinPlayer), json.decode(v.compPlayer), k)
        end
        if k == tonumber(pos) and tonumber(pos) == 2 then
            local spawn_id = json.decode(v.skinPlayer).sex
            while not HasModelLoaded(GetHashKey(spawn_id)) do
                Wait(0)
                modelrequest( GetHashKey(spawn_id) )
            end
            character_2 = CreatePed(GetHashKey(spawn_id), 1411.1339111328125, -1149.3594970703125, 74.78067016601562, false, false, 0, 0)
            FreezeEntityPosition(character_2, true)
            SetEntityHeading(character_2, 34.50)
            Ped_Data_Load(character_2, json.decode(v.skinPlayer), json.decode(v.compPlayer), k)
        end
        if k == tonumber(pos) and tonumber(pos) == 3 then
            local spawn_id = json.decode(v.skinPlayer).sex
            while not HasModelLoaded(GetHashKey(spawn_id)) do
                Wait(0)
                modelrequest( GetHashKey(spawn_id) )
            end
            character_3 = CreatePed(GetHashKey(spawn_id), 1407.4609375, -1148.5867919921875, 74.88335418701172, false, false, 0, 0)
            FreezeEntityPosition(character_3, true)
            SetEntityHeading(character_3, -27.76)
            Ped_Data_Load(character_3, json.decode(v.skinPlayer), json.decode(v.compPlayer), k)
        end
        if k == tonumber(pos) and tonumber(pos) == 4 then
            local spawn_id = json.decode(v.skinPlayer).sex
            while not HasModelLoaded(GetHashKey(spawn_id)) do
                Wait(0)
                modelrequest( GetHashKey(spawn_id) )
            end
            character_4 = CreatePed(GetHashKey(spawn_id), 1406.1318359375, -1147.7061767578125, 74.78675079345703, false, false, 0, 0)
            FreezeEntityPosition(character_4, true)
            SetEntityHeading(character_4, -85.76)
            Ped_Data_Load(character_4, json.decode(v.skinPlayer), json.decode(v.compPlayer), k)
        end
    end
end

function Has_Body_Loaded(ped, type, hash_for_load, text)
    local timeout = 0
    while Citizen.InvokeNative(0xFB4891BD7578CDC1, ped, type) == false and timeout < 5 do
        if timeout == 4 then
            again = true
        end
        timeout = timeout+1
        Citizen.InvokeNative(0xD710A5007C2AC539, ped, type, 0)
        Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, hash_for_load, false, true, true)
        Citizen.Wait(0)
    end
    Citizen.InvokeNative(0xCC8CA3E88256E58F, ped, 0, 1, 1, 1, false);
    return true
end

function Has_Body_Loaded_Clothe(ped, type, hash_for_load, text)
    local timeout = 0
    while Citizen.InvokeNative(0xFB4891BD7578CDC1, ped, type) == false and timeout < 5 do
        timeout = timeout+1
        if timeout == 4 then
            again = true
        end
        Citizen.InvokeNative(0xD710A5007C2AC539, ped, type, 0)
        Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, hash_for_load, true, true, true)
        Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, hash_for_load, false, true, true)
        -- Citizen.InvokeNative(0x704C908E9C405136, ped)
        -- Citizen.InvokeNative(0xAAB86462966168CE, ped, 1)
        Citizen.Wait(50)
        Citizen.InvokeNative(0xCC8CA3E88256E58F, ped, 0, 1, 1, 1, false);
    end
    return true
end

function Ped_Data_Load(ppid, Skin_Table, Clothe_Table, key)
    reload_data = reload_data+1
    again = false
    SetModelPed(pped, Skin_Table["sex"])
    Has_Body_Loaded(ppid, 0xB3966C9, Skin_Table["Body"], "Body")
    Has_Body_Loaded(ppid, 0x378AD10C, Skin_Table["HeadType"], "Head")
    Has_Body_Loaded(ppid, 0x823687F5, Skin_Table["LegsType"], "Legs")
    Citizen.Wait(0)
    Citizen.InvokeNative(0xCC8CA3E88256E58F, ped, 0, 1, 1, 1, false);
    Citizen.Wait(0)
    for i=1,6 do
        if Skin_Table["Nation"] == i then
            for k,v in pairs(Config.DefaultChar["Male"][i]) do
                if k == "Heads" then
                    for x,y in pairs(v) do
                        if x == 1 then
                            local hash = ("0x"..y)
                            HeadCategory = i
                            Citizen.InvokeNative(0xD3A7B003ED343FD9, ppid, tonumber(hash), true, true, true)
                        end
                    end
                end
            end
        end
    end
    Citizen.InvokeNative(0xCC8CA3E88256E58F, ppid, 0, 1, 1, 1, false);
    Citizen.Wait(0)
    Citizen.InvokeNative(0xD3A7B003ED343FD9, ppid, Skin_Table["Body"], false, true, true)
    Citizen.InvokeNative(0xD3A7B003ED343FD9, ppid, Skin_Table["HeadType"], false, true, true)
    Citizen.InvokeNative(0xD3A7B003ED343FD9, ppid, Skin_Table["BodyType"], false, true, true);
    Citizen.InvokeNative(0xD3A7B003ED343FD9, ppid, Skin_Table["Waist"], false, true, true);
    Citizen.InvokeNative(0xCC8CA3E88256E58F, ppid, 0, 1, 1, 1, false);
    Citizen.Wait(0)
    if Skin_Table["Eyes"] ~= -1 then
        Has_Body_Loaded(ppid, 0xEA24B45E, Skin_Table["Eyes"], "EYES")
    end
    if Skin_Table["Hair"] ~= -1 then
        Has_Body_Loaded_Clothe(ppid, 0x864B03AE, Skin_Table["Hair"], "HAIR")
    end
    if Skin_Table["Beard"] ~= -1 then
        Has_Body_Loaded_Clothe(ppid, 0xF8016BCA, Skin_Table["Beard"], "BEARD")
    end
    Citizen.Wait(0)
    Citizen.InvokeNative(0xD3A7B003ED343FD9, ppid, Skin_Table["BodyType"], false, true, true);
    Citizen.InvokeNative(0xD3A7B003ED343FD9, ppid, Skin_Table["Waist"], false, true, true);
    Citizen.InvokeNative(0xCC8CA3E88256E58F, ppid, 0, 1, 1, 1, false);
 
    if Clothe_Table["Hat"] ~= -1 then
        Has_Body_Loaded_Clothe(ppid,0x9925C067, Clothe_Table["Hat"], "HAT")
    end
    if Clothe_Table["EyeWear"] ~= -1 then
        Has_Body_Loaded_Clothe(ppid,0x5E47CA6, Clothe_Table["EyeWear"], "EyeWear")
    end
    if Clothe_Table["Mask"] ~= -1 then
        Has_Body_Loaded_Clothe(ppid,0x7505EF42, Clothe_Table["Mask"], "Mask")
    end
    if Clothe_Table["NeckWear"] ~= -1 then
        Has_Body_Loaded_Clothe(ppid,0x5FC29285, Clothe_Table["NeckWear"], "NeckWear")
    end
    if Clothe_Table["Suspender"] ~= -1 then
        Has_Body_Loaded_Clothe(ppid,0x877A2CF7, Clothe_Table["Suspender"], "Suspender")
    end
    if Clothe_Table["NeckTies"] ~= -1 then
        Has_Body_Loaded_Clothe(ppid,0x7A96FACA, Clothe_Table["NeckTies"], "NeckTies")
    end
    if Clothe_Table["Shirt"] ~= -1 then
        Has_Body_Loaded_Clothe(ppid,0x2026C46D, Clothe_Table["Shirt"], "Shirt")
    end
    if Clothe_Table["Vest"] ~= -1 then
        Has_Body_Loaded_Clothe(ppid,0x485EE834, Clothe_Table["Vest"], "Vest")
    end
    if Clothe_Table["Coat"] ~= -1 then
        Has_Body_Loaded_Clothe(ppid,0xE06D30CE, Clothe_Table["Coat"], "Coat")
    end
    if Clothe_Table["CoatClosed"] ~= -1 then
        Has_Body_Loaded_Clothe(ppid,0x662AC34, Clothe_Table["CoatClosed"], "CoatClosed")
    end
    if Clothe_Table["Poncho"] ~= -1 then
        Has_Body_Loaded_Clothe(ppid,0xAF14310B, Clothe_Table["Poncho"], "Poncho")
    end
    if Clothe_Table["Cloak"] ~= -1 then
        Has_Body_Loaded_Clothe(ppid,0x3C1A74CD, Clothe_Table["Cloak"], "Cloak")
    end
    if Clothe_Table["Glove"] ~= -1 then
        Has_Body_Loaded_Clothe(ppid,0xEABE0032, Clothe_Table["Glove"], "Glove")
    end
    if Clothe_Table["RingRh"] ~= -1 then
        Has_Body_Loaded_Clothe(ppid,0x7A6BBD0B, Clothe_Table["RingRh"], "RingRh")
    end
    if Clothe_Table["RingLh"] ~= -1 then
        Has_Body_Loaded_Clothe(ppid,0xF16A1D23, Clothe_Table["RingLh"], "RingLh")
    end
    if Clothe_Table["Bracelet"] ~= -1 then
        Has_Body_Loaded_Clothe(ppid,0x7BC10759, Clothe_Table["Bracelet"], "Bracelet")
    end
    if Clothe_Table["Buckle"] ~= -1 then
        Has_Body_Loaded_Clothe(ppid,0xFAE9107F, Clothe_Table["Buckle"], "Buckle")
    end
    if Clothe_Table["Chap"] ~= -1 then
        Has_Body_Loaded_Clothe(ppid,0x3107499B, Clothe_Table["Chap"], "Chap")
    end
    if Clothe_Table["Skirt"] ~= -1 then
        Has_Body_Loaded_Clothe(ppid,0xA0E3AB7F, Clothe_Table["Skirt"], "Skirt")
    end
    if Clothe_Table["Pant"] == -1 then
        Has_Body_Loaded_Clothe(ppid,0x823687F5, Skin_Table["LegsType"], "Legs")
    else
        Has_Body_Loaded_Clothe(ppid,0x1D4C528A, Clothe_Table["Pant"], "Pant")
    end
    if Clothe_Table["Boots"] ~= -1 then
        Has_Body_Loaded_Clothe(ppid,0x777EC6EF, Clothe_Table["Boots"], "Boots")
    end 
    if Clothe_Table["Spurs"] ~= -1 then
        Has_Body_Loaded_Clothe(ppid,0x18729F39, Clothe_Table["Spurs"], "Spurs")
    end
    if Clothe_Table["Spats"] ~= -1 then
        Has_Body_Loaded_Clothe(ppid,0x514ADCEA, Clothe_Table["Spats"], "Spats")
    end
    if Clothe_Table["Gauntlets"] ~= -1 then
        Has_Body_Loaded_Clothe(ppid,0x91CE9B20, Clothe_Table["Gauntlets"], "Gauntlets")
    end
    if Clothe_Table["Loadouts"] ~= -1 then
        Has_Body_Loaded_Clothe(ppid,0x83887E88, Clothe_Table["Loadouts"], "Loadouts")
    end
    if Clothe_Table["Accessories"] ~= -1 then
        Has_Body_Loaded_Clothe(ppid,0x79D7DF96, Clothe_Table["Accessories"], "Accessories")
    end
    if Clothe_Table["Belt"] ~= -1 then
        Has_Body_Loaded_Clothe(ppid,0xA6D134C6, Clothe_Table["Belt"], "Belt")
    end
    if Clothe_Table["Gunbelt"] ~= -1 then
        Has_Body_Loaded_Clothe(ppid,0x9B2C8B89, Clothe_Table["Gunbelt"], "Gunbelt")
    end
    if Clothe_Table["GunbeltAccs"] ~= -1 then
        Has_Body_Loaded_Clothe(ppid,0xF1542D11, Clothe_Table["GunbeltAccs"], "GunbeltAccs")
    end
    if Clothe_Table["Satchels"] ~= -1 then
        Has_Body_Loaded_Clothe(ppid,0x94504D26, Clothe_Table["Satchels"], "Satchels")
    end
    if Clothe_Table["Holster"] ~= -1 then
        Has_Body_Loaded_Clothe(ppid,0xB6B6122D, Clothe_Table["Holster"], "Holster")
    end
    if Skin_Table["Teeth"] ~= -1 and Skin_Table["Teeth"] ~= nil then
        Has_Body_Loaded_Clothe(ppid,0xB6B6122D, Skin_Table["Teeth"], "Teeth")
    end
    Citizen.InvokeNative(0xD710A5007C2AC539, ppid, 0x3F1F01E5, 0)
    Citizen.InvokeNative(0xD710A5007C2AC539, ppid, 0xDA0E2C55, 0)
    Citizen.InvokeNative(0x704C908E9C405136, ppid)
    Citizen.InvokeNative(0xCC8CA3E88256E58F, ppid, 0, 1, 1, 1, false);
    Citizen.Wait(0)
    Citizen.InvokeNative(0x25ACFC650B65C538, ppid, Skin_Table["Scale"])
    Citizen.InvokeNative(0xCC8CA3E88256E58F, ppid, 0, 1, 1, 1, false);
    Citizen.Wait(0)
    Citizen.InvokeNative(0x5653AB26C82938CF, ppid, 0x84D6, Skin_Table["HeadSize"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, ppid, 0x3303, Skin_Table["EyeBrowH"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, ppid, 0x2FF9, Skin_Table["EyeBrowW"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, ppid, 0x4AD1, Skin_Table["EyeBrowD"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, ppid, 0xC04F, Skin_Table["EarsH"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, ppid, 0xB6CE, Skin_Table["EarsW"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, ppid, 0x2844, Skin_Table["EarsD"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, ppid, 0xED30, Skin_Table["EarsL"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, ppid, 0x8B2B, Skin_Table["EyeLidH"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, ppid, 0x1B6B, Skin_Table["EyeLidW"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, ppid, 0xEE44, Skin_Table["EyeD"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, ppid, 0xD266, Skin_Table["EyeAng"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, ppid, 0xA54E, Skin_Table["EyeDis"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, ppid, 0xDDFB, Skin_Table["EyeH"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, ppid, 0x6E7F, Skin_Table["NoseW"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, ppid, 0x3471, Skin_Table["NoseS"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, ppid, 0x03F5, Skin_Table["NoseH"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, ppid, 0x34B1, Skin_Table["NoseAng"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, ppid, 0xF156, Skin_Table["NoseC"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, ppid, 0x561E, Skin_Table["NoseDis"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, ppid, 0x6A0B, Skin_Table["CheekBonesH"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, ppid, 0xABCF, Skin_Table["CheekBonesW"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, ppid, 0x358D, Skin_Table["CheekBonesD"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, ppid, 0xF065, Skin_Table["MouthW"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, ppid, 0xAA69, Skin_Table["MouthD"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, ppid, 0x7AC3, Skin_Table["MouthX"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, ppid, 0x410D, Skin_Table["MouthY"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, ppid, 0x1A00, Skin_Table["ULiphH"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, ppid, 0x91C1, Skin_Table["ULiphW"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, ppid, 0xC375, Skin_Table["ULiphD"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, ppid, 0xBB4D, Skin_Table["LLiphH"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, ppid, 0xB0B0, Skin_Table["LLiphW"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, ppid, 0x5D16, Skin_Table["LLiphD"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, ppid, 0x8D0A, Skin_Table["JawH"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, ppid, 0xEBAE, Skin_Table["JawW"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, ppid, 0x1DF6, Skin_Table["JawD"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, ppid, 0x3C0F, Skin_Table["ChinH"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, ppid, 0xC3B2, Skin_Table["ChinW"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, ppid, 0xE323, Skin_Table["ChinD"]);
    Citizen.Wait(0)
    if Skin_Table["scars_visibility"] ~= nil and Skin_Table["scars_tx_id"] ~= nil  and Skin_Table["scars_opacity"] ~= nil then
        TriggerEvent("gum_characters:colors", "scars", Skin_Table["scars_visibility"], Skin_Table["scars_tx_id"], 0, 0, 1, 1.0, 0, 1, 0,0,0,1,Skin_Table["scars_opacity"])
    end
    if Skin_Table["spots_visibility"] ~= nil and Skin_Table["spots_tx_id"] ~= nil  and Skin_Table["spots_opacity"] ~= nil then
        TriggerEvent("gum_characters:colors", "spots", Skin_Table["spots_visibility"], Skin_Table["spots_tx_id"], 0, 0, 1, 1.0, 0, 1, 0,0,0,1,Skin_Table["spots_opacity"])
    end
    if Skin_Table["disc_visibility"] ~= nil and Skin_Table["disc_tx_id"] ~= nil  and Skin_Table["disc_opacity"] ~= nil then
        TriggerEvent("gum_characters:colors", "disc", Skin_Table["disc_visibility"], Skin_Table["disc_tx_id"], 0, 0, 1, 1.0, 0, 1, 0,0,0,1,Skin_Table["disc_opacity"])
    end
    if Skin_Table["complex_visibility"] ~= nil and Skin_Table["complex_tx_id"] ~= nil  and Skin_Table["complex_opacity"] ~= nil then
        TriggerEvent("gum_characters:colors", "complex", Skin_Table["complex_visibility"], Skin_Table["complex_tx_id"], 0, 0, 1, 1.0, 0, 1, 0,0,0,1,Skin_Table["complex_opacity"])
    end
    if Skin_Table["acne_visibility"] ~= nil and Skin_Table["acne_tx_id"] ~= nil  and Skin_Table["acne_opacity"] ~= nil then
        TriggerEvent("gum_characters:colors", "acne", Skin_Table["acne_visibility"], Skin_Table["acne_tx_id"], 0, 0, 1, 1.0, 0, 1, 0,0,0,1,Skin_Table["acne_opacity"])
    end
    if Skin_Table["ageing_visibility"] ~= nil and Skin_Table["ageing_tx_id"] ~= nil  and Skin_Table["ageing_opacity"] ~= nil then
        TriggerEvent("gum_characters:colors", "ageing", Skin_Table["ageing_visibility"], Skin_Table["ageing_tx_id"], 0, 0, 1, 1.0, 0, 1, 0,0,0,1,Skin_Table["ageing_opacity"])
    end
    if Skin_Table["freckles_visibility"] ~= nil and Skin_Table["freckles_tx_id"] ~= nil  and Skin_Table["freckles_opacity"] ~= nil then
        TriggerEvent("gum_characters:colors", "freckles", Skin_Table["freckles_visibility"], Skin_Table["freckles_tx_id"], 0, 0, 1, 1.0, 0, 1, 0,0,0,1,Skin_Table["freckles_opacity"])
    end
    if Skin_Table["moles_visibility"] ~= nil and Skin_Table["moles_tx_id"] ~= nil  and Skin_Table["moles_opacity"] ~= nil then
        TriggerEvent("gum_characters:colors", "moles", Skin_Table["moles_visibility"], Skin_Table["moles_tx_id"], 0, 0, 1, 1.0, 0, 1, 0,0,0,1,Skin_Table["moles_opacity"])
    end
    if Skin_Table["eyebrows_visibility"] ~= nil and Skin_Table["eyebrows_tx_id"] ~= nil  and Skin_Table["eyebrows_opacity"] ~= nil then
        TriggerEvent("gum_characters:colors", "eyebrows", Skin_Table["eyebrows_visibility"], Skin_Table["eyebrows_tx_id"], 1, 0, 0, 1.0, 0, 1, Skin_Table["eyebrows_color"],0,0,1,Skin_Table["eyebrows_opacity"])
    end
    if Skin_Table["blush_visibility"] ~= nil and Skin_Table["blush_tx_id"] ~= nil  and Skin_Table["blush_opacity"] ~= nil then
        TriggerEvent("gum_characters:colors", "blush", Skin_Table["blush_visibility"], Skin_Table["blush_tx_id"], 1, 0, 0, 1.0, 0, 1, Skin_Table["blush_color_1"],0,0,1,Skin_Table["blush_opacity"])
    end
    if Skin_Table["eyeliners_visibility"] ~= nil and Skin_Table["eyeliners_tx_id"] ~= nil  and Skin_Table["eyeliners_opacity"] ~= nil then
        TriggerEvent("gum_characters:colors", "eyeliners", Skin_Table["eyeliners_visibility"], 1, 1, 0, 0, 1.0, 0, 1, Skin_Table["eyeliners_color_1"],0,0,Skin_Table["eyeliners_tx_id"],Skin_Table["eyeliners_opacity"])
    end
    if Skin_Table["lipsticks_visibility"] ~= nil and Skin_Table["lipsticks_tx_id"] ~= nil  and Skin_Table["lipsticks_opacity"] ~= nil then
        TriggerEvent("gum_characters:colors", "lipsticks", Skin_Table["lipsticks_visibility"], 1, 1, 0, 0, 1.0, 0, 1, Skin_Table["lipsticks_color_1"],Skin_Table["lipsticks_color_2"],Skin_Table["lipsticks_color_3"], Skin_Table["lipsticks_tx_id"], Skin_Table["lipsticks_opacity"])
    end
    if Skin_Table["shadows_visibility"] ~= nil and Skin_Table["shadows_tx_id"] ~= nil  and Skin_Table["shadows_opacity"] ~= nil then
        TriggerEvent("gum_characters:colors", "shadows", Skin_Table["shadows_visibility"], 1, 1, 0, 0, 1.0, 0, 1, Skin_Table["shadows_color_1"],Skin_Table["shadows_color_2"],Skin_Table["shadows_color_3"],Skin_Table["shadows_tx_id"],Skin_Table["shadows_opacity"])
    end
    if Skin_Table["beardstabble_visibility"] ~= nil and Skin_Table["beardstabble_tx_id"] ~= nil  and Skin_Table["beardstabble_opacity"] ~= nil then
        TriggerEvent("gum_characters:colors", "beardstabble", Skin_Table["beardstabble_visibility"], 1, 1, 0, 0, 1.0, 0, 1, Skin_Table["beardstabble_color_1"],Skin_Table["beardstabble_color_2"],Skin_Table["beardstabble_color_3"],Skin_Table["beardstabble_tx_id"],Skin_Table["beardstabble_opacity"])
    end
    Citizen.InvokeNative(0xCC8CA3E88256E58F, ppid, 0, 1, 1, 1, false)
    Citizen.InvokeNative(0xD3A7B003ED343FD9, ppid, Skin_Table["HeadType"], false, true, true)
    Citizen.InvokeNative(0xD3A7B003ED343FD9, ppid, Skin_Table["BodyType"], false, true, true)
    Citizen.InvokeNative(0xCC8CA3E88256E58F, ppid, 0, 1, 1, 1, false);
    Citizen.Wait(0)

    if again == true and tonumber(reload_data) <= 20 then
        DeletePed(ppid)
        Reload_Func(key)
    end
end


AddEventHandler('onResourceStop', function(resourceName)
	if (GetCurrentResourceName() == resourceName) then
        N_0x69d65e89ffd72313(false)
        DeleteEntity(character_1)
        DeleteEntity(character_2)
        DeleteEntity(character_3)
        DeleteEntity(character_4)
	end
end)

function SetModelPed(pped, name)
	local model = GetHashKey(name)

	if not IsModelValid(model) then
        return
    end
	PerformRequest(model)

	if HasModelLoaded(model) then
		Citizen.InvokeNative(0x283978A15512B2FE, pped, true)
		SetModelAsNoLongerNeeded(model)
	end
end