local active_buttons_create_select = false
local active_buttons_create_make = true
local buttons_prompt = GetRandomIntInRange(0, 0xffffff)
local buttons_prompt_2 = GetRandomIntInRange(0, 0xffffff)
local heading = -83.32
local z_position = 239.35
local Skin_Table = {}
local Clothe_Table = {}
local Beard_Table = {}
local Hair_Table = {}
local zoom = 50.0
local hair_write = -1
local beard_write = -1
local HeadCategory = 1
local HeadTexture = 1
local BodyTexture = 1
local LegsTexture = 1
local Gauntlet_set = 0
local Accesori_set = 0
local HeadType = 0
local BodyType = 1
local LegsType = 0
local HeadSize = 0
local EyeBrowH = 0
local EyeBrowW = 0
local EyeBrowD = 0
local EarsH = 0
local EarsW = 0
local EarsD = 0
local EarsL = 0
local EyeLidH = 0
local EyeLidW = 0
local EyeD = 0
local EyeAng = 0
local EyeDis = 0
local EyeH = 0
local NoseW = 0
local NoseS = 0
local NoseH = 0
local NoseAng = 0
local NoseC = 0
local NoseDis = 0
local CheekBonesH = 0
local CheekBonesW = 0
local CheekBonesD = 0
local MouthW = 0
local MouthD = 0
local MouthX = 0
local MouthY = 0
local ULiphH = 0
local ULiphW = 0
local ULiphD = 0
local LLiphH = 0
local LLiphW = 0
local LLiphD = 0
local JawH = 0
local JawW = 0
local JawD = 0
local ChinH = 0
local ChinW = 0
local ChinD = 0
local Beard = -1
local Hair = -1
local Body = 1
local Waist = 1
local Eyes = 1
local Scale = 100
local current_texture_settings = Config.texture_types["male"]
local textureId = -1
local is_overlay_change_active = false
local scars_enable = 0
local scars_texture = 1
local scars_opacity = 10
local blush_enable = 0
local blush_texture = 1
local blush_opacity = 10
local blush_color_1 = 0.0
local shadow_enable = 0
local shadow_color_1 = 0
local shadow_color_2 = 0
local shadow_color_3 = 0
local shadow_texture = 1
local shadow_opacity = 10
local eyeliners_enable = 0
local eyeliners_color_1 = 0
local eyeliners_color_2 = 0
local eyeliners_color_3 = 0
local eyeliners_texture = 1
local eyeliners_opacity = 10
local lipsticks_enable = 0
local lipsticks_color_1 = 0
local lipsticks_color_2 = 0
local lipsticks_color_3 = 0
local lipsticks_texture = 1
local lipsticks_opacity = 10
local spots_enable = 0
local spots_texture = 1
local spots_opacity = 10
local disc_enable = 0
local disc_texture = 1
local disc_opacity = 10
local complex_enable = 0
local complex_texture = 1
local complex_opacity = 10
local acne_visibility = 0
local acne_texture = 1
local acne_opacity = 10
local ageing_enable = 0
local ageing_texture = 1
local ageing_opacity = 10
local freckles_enable = 0
local freckles_texture = 1
local freckles_opacity = 10
local moles_enable = 0
local moles_texture = 1
local moles_opacity = 10
local eyebrows_enable = 0
local eyebrows_texture = 1
local eyebrows_opacity = 10
local eyebrows_color_1 = 0
local beardstabble_enable = 0
local beardstabble_texture = 1
local beardstabble_opacity = 10
local beardstabble_color_1 = 0
local HatsTable= {}
local EyewearTable = {}
local ScarftTable = {}
local MaskTable = {}
local NecktieTable = {}
local ShirtTable = {}
local SuspenderTable = {}
local VestTable = {}
local CoatTable = {}
local ClosedCoatTable = {}
local PonchoTable = {}
local CloakTable = {}
local GloveTable = {}
local RRingTable = {}
local SpatsTable = {}
local LRingTable = {}
local LoadoutsTable = {}
local BraceletTable = {}
local GunbeltTable = {}
local GunbeltAcsTable = {}
local BeltsTable = {}
local BucklesTable = {}
local LHolsterTable = {}
local SkirtTable = {}
local RHolsterTable = {}
local PantTable = {}
local ChapTable = {}
local BootTable = {}
local SpurTable = {}
local SatchelTable = {}
local GauntletTable = {}
local AccesorieTable  = {}
local Coord_Table = {}
local Satchel_set = 0
local hats_set = 0
local eyewear_set = 0
local Scarf_set = 0
local GunbeltAcs_set = 0
local Mask_set = 0
local Spat_set = 0
local Necktie_set = 0
local Shirt_set = 0
local Skirt_set = 0
local Suspender_set = 0
local Vest_set = 0
local Coat_set = 0
local CCoat_set = 0
local Poncho_set = 0
local Loadouts_set = 0
local Cloak_set = 0
local Glove_set = 0
local RRing_set = 0
local LRing_set = 0
local Bracelet_set = 0
local Gunbelt_set = 0
local Belt_set = 0
local Buckles_set = 0
local LHolster_set = 0
local Pant_set = 0
local Chap_set = 0
local Boot_set = 0
local Spur_set = 0
local have_character = true
local firstname = ""
local lastname = ""
local isDead = false
local reload_data = 0
local is_loaded_character = false
TriggerEvent("gum_menu:getData",function(call)
    MenuData = call
end)

RegisterNetEvent('gum_character:check_char')
AddEventHandler('gum_character:check_char', function(have)
    have_character = have
end)

RegisterNetEvent('gum_character:selected_char')
AddEventHandler('gum_character:selected_char', function()
    is_loaded_character = true
end)

RegisterNetEvent('gum_character:send_data_back')
AddEventHandler('gum_character:send_data_back', function(skin_table_receive, outfit_table_receive, coord_table_receive, isdeaded, update, new_char)
    Skin_Table = skin_table_receive
    Clothe_Table = outfit_table_receive
    Coord_Table = coord_table_receive
    isDead = isdeaded
    Citizen.Wait(0)
    if update == true then
        SetEntityCoords(PlayerPedId(), Coord_Table.x, Coord_Table.y, Coord_Table.z-1.0)
        FreezeEntityPosition(PlayerPedId(), true)
        SetEntityVisible(PlayerPedId(), false)
        Data_Character_Load(true)
        Citizen.InvokeNative(0xF808475FA571D823, true)
        Citizen.InvokeNative(0xBF25EB89375A37AD, 5, GetHashKey("PLAYER"), GetHashKey("PLAYER"))
        FreezeEntityPosition(PlayerPedId(), false)
        Citizen.Wait(1000)
        while is_loaded_character == false do
            Citizen.Wait(200)
        end
        startanim("script_rc@bch2@leadout@rsc_6", "wakeup_slow_charles", -1, 0)
        Citizen.Wait(100)
        exports['gum_character']:loading(false)
        SetEntityVisible(PlayerPedId(), true)
        SendNUIMessage({
            type = "volume_stop",
            status = true,
        })
        reload_scars()
        Citizen.Wait(200)
        local GetCoords = GetEntityCoords(PlayerPedId())
        if GetDistanceBetweenCoords(GetCoords.x, GetCoords.y, GetCoords.z, 2946.486328125, -2084.0859375, 49.65571594238281, false) < 10.0 then
            SetEntityCoords(PlayerPedId(), 1258.91, -1291.45, 75.66-1.0)
        end
        TriggerServerEvent("gum_character:send_save_func")
        TriggerEvent("gum_inventory:can_save")
    end
end)


exports('loading', function(state)
    SendNUIMessage({
        type = "loading_info",
        status = state,
    })
end)


RegisterCommand('db', function()
    local stamina = Citizen.InvokeNative(0x36731AC041289BB1, PlayerPedId(), 1) --health
    local health = Citizen.InvokeNative(0x36731AC041289BB1, PlayerPedId(), 0) --health
    if stamina ~= nil and stamina ~= false and health ~= nil and health ~= false then
        if tonumber(stamina) >= 49 and tonumber(health) >= 49 then
            ReloadCloth()
        end
    end
end)
RegisterCommand('dbs', function()
    Data_Character_Load(nil, true)
end)
function Make_Data(gender)
    if gender == Config.Language[175].text then
        Skin_Table["sex"] = "mp_male"
        for k,v in pairs(Config_2.Clothes) do
            if v.ped_type == "male" and v.is_multiplayer == true and v.category_hashname == "hair" then
                table.insert(Hair_Table, {hash = v.hash, category_hash = v.category_hash, cat = v.hash_dec_signed})
            end
            if v.ped_type == "male" and v.is_multiplayer == true and tonumber(v.category_hash) == tonumber('0xF8016BCA') then
                table.insert(Beard_Table, {hash = v.hash, category_hash = v.category_hash, cat = v.hash_dec_signed})
            end
        end
    else
        Skin_Table["sex"] = "mp_female"
        for k,v in pairs(Config_2.Clothes) do
            if v["ped_type"] == "female" and v["is_multiplayer"] == true and v.category_hashname == "hair" then
                table.insert(Hair_Table, {hash = v.hash, category_hash = v.category_hash, cat = v.hash_dec_signed})
            end
        end
    end

    Skin_Table["HeadType"] = 0
    Skin_Table["BodyType"] = 0
    Skin_Table["LegsType"] = 0
    Skin_Table["Nation"] = 0

    Skin_Table["HeadSize"] = 0.0

    Skin_Table["EyeBrowH"] = 0.0
    Skin_Table["EyeBrowW"] = 0.0
    Skin_Table["EyeBrowD"] = 0.0

    Skin_Table["EarsH"] = 0.0
    Skin_Table["EarsW"] = 0.0
    Skin_Table["EarsD"] = 0.0
    Skin_Table["EarsL"] = 0.0

    Skin_Table["EyeLidH"] = 0.0
    Skin_Table["EyeLidW"] = 0.0

    Skin_Table["EyeD"] = 0.0
    Skin_Table["EyeAng"] = 0.0
    Skin_Table["EyeDis"] = 0.0
    Skin_Table["EyeH"] = 0.0

    Skin_Table["NoseW"] = 0.0
    Skin_Table["NoseS"] = 0.0
    Skin_Table["NoseH"] = 0.0
    Skin_Table["NoseAng"] = 0.0
    Skin_Table["NoseC"] = 0.0
    Skin_Table["NoseDis"] = 0.0

    Skin_Table["CheekBonesH"] = 0.0
    Skin_Table["CheekBonesW"] = 0.0
    Skin_Table["CheekBonesD"] = 0.0

    Skin_Table["MouthW"] = 0.0
    Skin_Table["MouthD"] = 0.0
    Skin_Table["MouthX"] = 0.0
    Skin_Table["MouthY"] = 0.0

    Skin_Table["ULiphH"] = 0.0
    Skin_Table["ULiphW"] = 0.0
    Skin_Table["ULiphD"] = 0.0

    Skin_Table["LLiphH"] = 0.0
    Skin_Table["LLiphW"] = 0.0
    Skin_Table["LLiphD"] = 0.0

    Skin_Table["JawH"] = 0.0
    Skin_Table["JawW"] = 0.0
    Skin_Table["JawD"] = 0.0

    Skin_Table["ChinH"] = 0.0
    Skin_Table["ChinW"] = 0.0
    Skin_Table["ChinD"] = 0.0

    Skin_Table["Beard"] = -1
    Skin_Table["Hair"] = -1
    Skin_Table["Body"] = 0
    Skin_Table["Waist"] = 0
    Skin_Table["Eyes"] = 0
    Skin_Table["Scale"] = 1.0

    Skin_Table["scars_visibility"] = 0
    Skin_Table["scars_tx_id"] = 1
    Skin_Table["scars_opacity"] = 0

    Skin_Table["spots_visibility"] = 0
    Skin_Table["spots_tx_id"] = 1
    Skin_Table["spots_opacity"] = 0

    Skin_Table["disc_visibility"] = 0
    Skin_Table["disc_tx_id"] = 1
    Skin_Table["disc_opacity"] = 0

    Skin_Table["complex_visibility"] = 0
    Skin_Table["complex_tx_id"] = 1
    Skin_Table["complex_opacity"] = 0

    Skin_Table["acne_visibility"] = 0
    Skin_Table["acne_tx_id"] = 1
    Skin_Table["acne_opacity"] = 0

    Skin_Table["ageing_visibility"] = 0
    Skin_Table["ageing_tx_id"] = 1
    Skin_Table["ageing_opacity"] = 0

    Skin_Table["freckles_visibility"] = 0
    Skin_Table["freckles_tx_id"] = 1
    Skin_Table["freckles_opacity"] = 0

    Skin_Table["moles_visibility"] = 0
    Skin_Table["moles_tx_id"] = 1
    Skin_Table["moles_opacity"] = 0

    Skin_Table["eyebrows_visibility"] = 0
    Skin_Table["eyebrows_tx_id"] = 1
    Skin_Table["eyebrows_opacity"] = 0.0
    Skin_Table["eyebrows_color"] = 0

    Skin_Table["lipsticks_visibility"] = 0
    Skin_Table["lipsticks_tx_id"] = 1
    Skin_Table["lipsticks_opacity"] = 0.0
    Skin_Table["lipsticks_color_1"] = 0
    Skin_Table["lipsticks_color_2"] = 0
    Skin_Table["lipsticks_color_3"] = 0

    Skin_Table["shadows_visibility"] = 0
    Skin_Table["shadows_opacity"] = 0.0
    Skin_Table["shadows_tx_id"] = 1
    Skin_Table["shadows_color_1"] = 0
    Skin_Table["shadows_color_2"] = 0
    Skin_Table["shadows_color_3"] = 0

    Skin_Table["beardstabble_visibility"] = 0
    Skin_Table["beardstabble_opacity"] = 0.0
    Skin_Table["beardstabble_tx_id"] = 1
    Skin_Table["beardstabble_color_1"] = 0

    Skin_Table["eyeliners_visibility"] = 0
    Skin_Table["eyeliners_opacity"] = 0.0
    Skin_Table["eyeliners_tx_id"] = 1
    Skin_Table["eyeliners_color_1"] = 0
    Skin_Table["eyeliners_color_2"] = 0
    Skin_Table["eyeliners_color_3"] = 0

    Skin_Table["blush_visibility"] = 0
    Skin_Table["blush_opacity"] = 0.0
    Skin_Table["blush_tx_id"] = 1
    Skin_Table["blush_color_1"] = 0

    Clothe_Table["Hat"] = -1
    Clothe_Table["EyeWear"] = -1
    Clothe_Table["Mask"] = -1
    Clothe_Table["NeckWear"] = -1
    Clothe_Table["NeckTies"] = -1
    Clothe_Table["Shirt"] = -1
    Clothe_Table["Suspender"] = -1
    Clothe_Table["Vest"] = -1
    Clothe_Table["Coat"] = -1
    Clothe_Table["Poncho"] = -1
    Clothe_Table["Cloak"] = -1
    Clothe_Table["Glove"] = -1
    Clothe_Table["RingRh"] = -1
    Clothe_Table["RingLh"] = -1
    Clothe_Table["Bracelet"] = -1
    Clothe_Table["Gunbelt"] = -1
    Clothe_Table["Belt"] = -1
    Clothe_Table["Buckle"] = -1
    Clothe_Table["Holster"] = -1
    Clothe_Table["Pant"] = -1
    Clothe_Table["Skirt"] = -1
    Clothe_Table["Chap"] = -1
    Clothe_Table["Boots"] = -1
    Clothe_Table["Spurs"] = -1
    Clothe_Table["Spats"] = -1
    Clothe_Table["GunbeltAccs"] = -1
    Clothe_Table["Gauntlets"] = -1
    Clothe_Table["Loadouts"] = -1
    Clothe_Table["Accessories"] = -1
    Clothe_Table["Satchels"] = -1
    Clothe_Table["CoatClosed"] = -1
end

function Button_Prompt()
	Citizen.CreateThread(function()
        local str = ''..Config.Language[167].text..''
        ChangeCharPrompt = Citizen.InvokeNative(0x04F97DE45A519419)
        PromptSetControlAction(ChangeCharPrompt, 0x27D1C284)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(ChangeCharPrompt, str)
        PromptSetEnabled(ChangeCharPrompt, true)
        PromptSetVisible(ChangeCharPrompt, true)
        PromptSetHoldMode(ChangeCharPrompt, true)
        PromptSetGroup(ChangeCharPrompt, buttons_prompt)
        PromptRegisterEnd(ChangeCharPrompt)
	end)
    Citizen.CreateThread(function()
        local str = ''..Config.Language[168].text..''
        SelectPrompt = Citizen.InvokeNative(0x04F97DE45A519419)
        PromptSetControlAction(SelectPrompt, 0x0522B243)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(SelectPrompt, str)
        PromptSetEnabled(SelectPrompt, true)
        PromptSetVisible(SelectPrompt, true)
        PromptSetHoldMode(SelectPrompt, true)
        PromptSetGroup(SelectPrompt, buttons_prompt)
        PromptRegisterEnd(SelectPrompt)
	end)
end
function Button_Prompt_2()
	Citizen.CreateThread(function()
		local str = ''..Config.Language[169].text..''
		RotateLPrompt = PromptRegisterBegin()
		PromptSetControlAction(RotateLPrompt, 0x20190AB4)
		str = CreateVarString(10, 'LITERAL_STRING', str)
		PromptSetText(RotateLPrompt, str)
		PromptSetEnabled(RotateLPrompt, true)
		PromptSetVisible(RotateLPrompt, true)
		PromptSetHoldMode(RotateLPrompt, true)
        PromptSetGroup(RotateLPrompt, buttons_prompt_2)
		PromptRegisterEnd(RotateLPrompt)
	end)
	Citizen.CreateThread(function()
		local str = ''..Config.Language[170].text..''
		RotateRPrompt = PromptRegisterBegin()
		PromptSetControlAction(RotateRPrompt, 0xDEB34313)
		str = CreateVarString(10, 'LITERAL_STRING', str)
		PromptSetText(RotateRPrompt, str)
		PromptSetEnabled(RotateRPrompt, true)
		PromptSetVisible(RotateRPrompt, true)
		PromptSetHoldMode(RotateRPrompt, true)
        PromptSetGroup(RotateRPrompt, buttons_prompt_2)
		PromptRegisterEnd(RotateRPrompt)
	end)
    Citizen.CreateThread(function()
		local str = ''..Config.Language[171].text..''
		UpPrompt = Citizen.InvokeNative(0x04F97DE45A519419)
		PromptSetControlAction(UpPrompt, 0x05CA7C52)
		str = CreateVarString(10, 'LITERAL_STRING', str)
		PromptSetText(UpPrompt, str)
		PromptSetEnabled(UpPrompt, true)
		PromptSetVisible(UpPrompt, true)
		PromptSetHoldMode(UpPrompt, true)
		PromptSetGroup(UpPrompt, buttons_prompt_2)
		PromptRegisterEnd(UpPrompt)
	end)
	Citizen.CreateThread(function()
		local str = ''..Config.Language[172].text..''
		DownPrompt = Citizen.InvokeNative(0x04F97DE45A519419)
		PromptSetControlAction(DownPrompt, 0x6319DB71)
		str = CreateVarString(10, 'LITERAL_STRING', str)
		PromptSetText(DownPrompt, str)
		PromptSetEnabled(DownPrompt, true)
		PromptSetVisible(DownPrompt, true)
		PromptSetHoldMode(DownPrompt, true)
		PromptSetGroup(DownPrompt, buttons_prompt_2)
		PromptRegisterEnd(DownPrompt)
	end)
    Citizen.CreateThread(function()
        local str = ''..Config.Language[173].text..''
        Zoom1Prompt = PromptRegisterBegin()
        PromptSetControlAction(Zoom1Prompt, 0xE885EF16)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(Zoom1Prompt, str)
        PromptSetEnabled(Zoom1Prompt, true)
        PromptSetVisible(Zoom1Prompt, true)
        PromptSetHoldMode(Zoom1Prompt, true)
        PromptSetGroup(Zoom1Prompt, buttons_prompt_2)
        PromptRegisterEnd(Zoom1Prompt)
    end)
    Citizen.CreateThread(function()
        local str = ''..Config.Language[174].text..''
        Zoom2Prompt = PromptRegisterBegin()
        PromptSetControlAction(Zoom2Prompt, 0x2277FAE9)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(Zoom2Prompt, str)
        PromptSetEnabled(Zoom2Prompt, true)
        PromptSetVisible(Zoom2Prompt, true)
        PromptSetHoldMode(Zoom2Prompt, true)
        PromptSetGroup(Zoom2Prompt, buttons_prompt_2)
        PromptRegisterEnd(Zoom2Prompt)
    end)
end
RegisterNetEvent('gum_character:send_character')
AddEventHandler('gum_character:send_character', function()
    TriggerServerEvent("gum_character:check_character")
end)

RegisterNetEvent('gum_character:make_character')
AddEventHandler('gum_character:make_character', function()
    TriggerEvent("gum_character:del_old")
    Citizen.InvokeNative(0x17E0198B3882C2CB, PlayerPedId())
    Button_Prompt()
    Button_Prompt_2()
    Citizen.Wait(500)
    Citizen.InvokeNative(0x9E211A378F95C97C, 183712523)
    Citizen.InvokeNative(0x9E211A378F95C97C, -1699673416)
    Citizen.InvokeNative(0x9E211A378F95C97C, 1679934574)
    Citizen.Wait(1500)
    SetEntityCoords(PlayerPedId(), -563.77, -3776.49, 238.56)
    Citizen.Wait(1000)
    SelectChar()
    StartCam(-560.51, -3776.08, 239.35, -90.00, 50.0)
    SetClockTime(12, 00, 00)
    SetEntityCoords(PlayerPedId(), -563.77, -3776.49, 238.56)
    have_character = false
end)


Citizen.CreateThread(function()
    Citizen.Wait(1000)
    TriggerServerEvent("gum_character:check_character")
    Citizen.Wait(3000)
    if not have_character then
        Citizen.InvokeNative(0x17E0198B3882C2CB, PlayerPedId())
        Button_Prompt()
        Button_Prompt_2()
        Citizen.Wait(500)
        Citizen.InvokeNative(0x9E211A378F95C97C, 183712523)
        Citizen.InvokeNative(0x9E211A378F95C97C, -1699673416)
        Citizen.InvokeNative(0x9E211A378F95C97C, 1679934574)
        Citizen.Wait(1500)
        SelectChar()
        Citizen.Wait(1500)
        DeletePed(PedFemale)
        DeletePed(PedMale)
        SelectChar()
        Citizen.Wait(1500)
        DeletePed(PedFemale)
        DeletePed(PedMale)
        Citizen.Wait(1500)
        SelectChar()
        Citizen.Wait(1500)
        DeletePed(PedFemale)
        DeletePed(PedMale)
        Citizen.Wait(1500)
        SetEntityCoords(PlayerPedId(), -563.77, -3776.49, 238.56)
        SelectChar()
        exports['gum_character']:loading(false) 
        TriggerEvent("gum_inventory:reset_inventory")
        StartCam(-560.51, -3776.08, 239.35, -90.00, 50.0)
        SetClockTime(12, 00, 00)
        SetEntityCoords(PlayerPedId(), -563.77, -3776.49, 238.56)
    else
        SetEntityCoords(PlayerPedId(), 270.33380126953125, -4076.84521484375, 215.644775390625)
        -- SetEntityCoords(PlayerPedId(), Coord_Table.x, Coord_Table.y, Coord_Table.z-1.0)
        -- FreezeEntityPosition(PlayerPedId(), true)
        -- SetEntityVisible(PlayerPedId(), false)
        -- Data_Character_Load()
        -- Citizen.InvokeNative(0xF808475FA571D823, true)
        -- Citizen.InvokeNative(0xBF25EB89375A37AD, 5, GetHashKey("PLAYER"), GetHashKey("PLAYER"))
        -- if Config.WalkFaceStyle then
        --     TriggerEvent("gum_walkingfacestyle:active")
        -- end
        -- FreezeEntityPosition(PlayerPedId(), false)
        -- Citizen.Wait(1000)
        -- playAnim("script_rc@bch2@leadout@rsc_6", "wakeup_slow_charles", -1, 0)
        -- Citizen.Wait(200)
        -- exports['gum_character']:loading(false) 
        -- SetEntityVisible(PlayerPedId(), true)
        -- Citizen.Wait(500)
        -- if Config.WalkFaceStyle then
        --     TriggerEvent("gum_walkingfacestyle:active")
        -- end
        -- local GetCoords = GetEntityCoords(PlayerPedId())
        -- if GetDistanceBetweenCoords(GetCoords.x, GetCoords.y, GetCoords.z, 2946.486328125, -2084.0859375, 49.65571594238281, false) < 10.0 then
        --     SetEntityCoords(PlayerPedId(), 2723.339599609375, -1446.4417724609375, 46.32297897338867-1.0)
        -- end
        -- TriggerServerEvent("gum_character:send_save_func")
    end
end)



function startanim(dict,name, time, flag)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(500)
    end
    TaskPlayAnim(PlayerPedId(), dict, name, 1.0, 1.0, time, flag, 0, true, 0, false, 0, false)  
end

local male_selected = false
local spawm_protect = false
local char_text = ""
local set_dead = false
local TimeToRespawn = Config.TimeToRespawn
local cam = nil
local angleY = 0.0
local angleZ = 0.0

RegisterNetEvent("gum:SelectedCharacter")
AddEventHandler("gum:SelectedCharacter", function(charid)
    Citizen.CreateThread(function()
        while true do 
            Citizen.Wait(1000)
            if IsEntityDead(PlayerPedId()) then
                if not set_dead then
                    set_dead = true
                    TimeToRespawn = Config.TimeToRespawn
                    Citizen.InvokeNative(0xD63FE3AF9FB3D53F, true)
                    Citizen.InvokeNative(0x1B3DA717B9AFF828, true)
                    ExecuteCommand("hud")
                    StartDeathCam()
                end
                if set_dead then
                    exports["spawnmanager"].setAutoSpawn(false)
                    TimeToRespawn = TimeToRespawn-1
                end
            else
                Citizen.InvokeNative(0x25ACFC650B65C538, PlayerPedId(), Skin_Table["Scale"])
                Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
            end
        end
    end)
end)
function StartDeathCam()
    Citizen.CreateThread(function()
        ClearFocus()
        local playerPed = PlayerPedId()
        cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", GetEntityCoords(playerPed), 0, 0, 0, GetGameplayCamFov())
        SetCamActive(cam, true)
        RenderScriptCams(true, true, 1000, true, false)
    end)
end

RegisterNetEvent("gum:SelectedCharacter")
AddEventHandler("gum:SelectedCharacter", function(charid)
    Citizen.CreateThread(function()
        while true do 
            optimalization = 1000
            if isDead then
                SetEntityHealth(PlayerPedId(), 0.0)
                isDead = true
            end
            if IsEntityDead(PlayerPedId()) then
                carrier = Citizen.InvokeNative(0x09B83E68DE004CD4, PlayerPedId());
                optimalization = 5 
                if (cam and IsEntityDead(PlayerPedId())) then
                    ProcessCamControls()
                end
                if isDead == false then
                    TriggerServerEvent("gum_character:dead_state", true)
                    isDead = true
                end
                local GetCoords = GetEntityCoords(PlayerPedId())
                if carrier then
                    DrawText3D(GetCoords.x,GetCoords.y,GetCoords.z+0.20, "Právě tě někdo nese. Nemůžeš vstát.")
                else
                    if TimeToRespawn <= 0 then
                        DrawText3D(GetCoords.x,GetCoords.y,GetCoords.z+0.20, "Stiskni [ R ] pro oživení a PK.")
                        if Citizen.InvokeNative(0x91AEF906BCA88877, 0, 0x27D1C284) then
                            TriggerEvent("gum_character:revive_player", PlayerPedId(), 0)
                            TriggerServerEvent("gum_doctor:log_send")
                            Citizen.Wait(2000)
                        end
                    else
                        DrawText3D(GetCoords.x,GetCoords.y,GetCoords.z+0.20, "Oživit se můžeš za "..TimeToRespawn.." s \n [ W ][ A ][ S ][ D ] Pohyb kamerou")
                    end
                end
            else
                optimalization = 2000 
                spawned = false
            end
            Citizen.Wait(optimalization)
        end
    end)
end)

RegisterNetEvent('gum_character:revive_player')
AddEventHandler('gum_character:revive_player', function(id, where)
    if tonumber(where) == 0 then
        for k,v in pairs(Config.RespawnCoords) do
            local GetCoords = GetEntityCoords(PlayerPedId())
            if GetDistanceBetweenCoords(GetCoords.x, GetCoords.y, GetCoords.z, v.x, v.y, v.z, false) < 1000.0 and set_dead == true then
                TriggerServerEvent("gum_character:dead_state", false)
                isDead = false
                set_dead = false
                SetEntityCoords(PlayerPedId(), v.x, v.y, v.z)
                FreezeEntityPosition(ped, true)
                EndDeathCam()
                NetworkSetInSpectatorMode(false, GetPlayerPed(PlayerPedId()))

                local pl = Citizen.InvokeNative(0x217E9DC48139933D)
                local ped = Citizen.InvokeNative(0x275F255ED201B937, pl)
                Citizen.InvokeNative(0x71BC8E838B9C6035, ped)
                Citizen.InvokeNative(0x0E3F4AF2D63491FB)
                TimeToRespawn = Config.TimeToRespawn
                ExecuteCommand("hud")
                Citizen.Wait(3000)
                FreezeEntityPosition(ped, false)
                Citizen.InvokeNative(0xF808475FA571D823, true)
                Citizen.InvokeNative(0xBF25EB89375A37AD, 5, GetHashKey("PLAYER"), GetHashKey("PLAYER"))
                spawned = true
            end
        end
        Citizen.Wait(500)
        for k,v in pairs(Config.RespawnCoords) do
            local GetCoords = GetEntityCoords(PlayerPedId())
            if GetDistanceBetweenCoords(GetCoords.x, GetCoords.y, GetCoords.z, v.x, v.y, v.z, false) < 3000.0 and set_dead == true and not spawned then
                TriggerServerEvent("gum_character:dead_state", false)
                isDead = false
                set_dead = false
                SetEntityCoords(PlayerPedId(), v.x, v.y, v.z)
                FreezeEntityPosition(ped, true)
                EndDeathCam()
                NetworkSetInSpectatorMode(false, GetPlayerPed(PlayerPedId()))

                local pl = Citizen.InvokeNative(0x217E9DC48139933D)
                local ped = Citizen.InvokeNative(0x275F255ED201B937, pl)
                Citizen.InvokeNative(0x71BC8E838B9C6035, ped)
                Citizen.InvokeNative(0x0E3F4AF2D63491FB)
                TimeToRespawn = Config.TimeToRespawn
                ExecuteCommand("hud")
                Citizen.Wait(3000)
                FreezeEntityPosition(ped, false)
                Citizen.InvokeNative(0xBF25EB89375A37AD, 5, GetHashKey("PLAYER"), GetHashKey("PLAYER"))
                spawned = true
            end
        end
    else
        TriggerServerEvent("gum_character:dead_state", false)
        isDead = false
        EndDeathCam()
        NetworkSetInSpectatorMode(false, GetPlayerPed(PlayerPedId()))
        local pl = Citizen.InvokeNative(0x217E9DC48139933D)
        local ped = Citizen.InvokeNative(0x275F255ED201B937, pl)
        FreezeEntityPosition(ped, false)
        Citizen.InvokeNative(0x71BC8E838B9C6035, ped)
        Citizen.InvokeNative(0x0E3F4AF2D63491FB)
        Citizen.InvokeNative(0xF808475FA571D823, true)
        set_dead = false
        TimeToRespawn = Config.TimeToRespawn
        ExecuteCommand("hud")
        Citizen.InvokeNative(0xBF25EB89375A37AD, 5, GetHashKey("PLAYER"), GetHashKey("PLAYER"))
    end
end)

function EndDeathCam()
    Citizen.CreateThread(function()
        NetworkSetInSpectatorMode(false, PlayerPedId())
        ClearFocus()
        RenderScriptCams(false, false, 0, true, false)
        DestroyCam(cam, false)
        cam = nil
    end)
end

function ProcessCamControls()
    Citizen.CreateThread(function()
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local newPos = ProcessNewPosition()
        SetCamCoord(cam, newPos.x, newPos.y, newPos.z)
        PointCamAtCoord(cam, playerCoords.x, playerCoords.y, playerCoords.z + 0.5)
    end)
end

function ProcessNewPosition()
    local mouseX = 0.0
    local mouseY = 0.0
    if (IsInputDisabled(0)) then
        mouseX = GetDisabledControlNormal(1, 0x4D8FB4C1) * 1.5
        mouseY = GetDisabledControlNormal(1, 0xFDA83190) * 1.5
    else
        mouseX = GetDisabledControlNormal(1, 0x4D8FB4C1) * 0.5
        mouseY = GetDisabledControlNormal(1, 0xFDA83190) * 0.5
    end
    angleZ = angleZ - mouseX
    angleY = angleY + mouseY

    if (angleY > 89.0) then angleY = 89.0 elseif (angleY < -89.0) then angleY = -89.0 end
    local pCoords = GetEntityCoords(PlayerPedId())
    local behindCam = {
        x = pCoords.x + ((Cos(angleZ) * Cos(angleY)) + (Cos(angleY) * Cos(angleZ))) / 2 * (3.0 + 0.5),
        y = pCoords.y + ((Sin(angleZ) * Cos(angleY)) + (Cos(angleY) * Sin(angleZ))) / 2 * (3.0 + 0.5),
        z = pCoords.z + ((Sin(angleY))) * (3.0 + 0.5)
    }
    local rayHandle = StartShapeTestRay(pCoords.x, pCoords.y, pCoords.z + 0.5, behindCam.x, behindCam.y, behindCam.z, -1, PlayerPedId(), 0)
    local a, hitBool, hitCoords, surfaceNormal, entityHit = GetShapeTestResult(rayHandle)

    local maxRadius = 3.0
    if (hitBool and Vdist(pCoords.x, pCoords.y, pCoords.z + 0.5, hitCoords) < 3.0 + 0.5) then
        maxRadius = Vdist(pCoords.x, pCoords.y, pCoords.z + 0.5, hitCoords)
    end

    local offset = {
        x = ((Cos(angleZ) * Cos(angleY)) + (Cos(angleY) * Cos(angleZ))) / 2 * maxRadius,
        y = ((Sin(angleZ) * Cos(angleY)) + (Cos(angleY) * Sin(angleZ))) / 2 * maxRadius,
        z = ((Sin(angleY))) * maxRadius
    }

    local pos = {
        x = pCoords.x + offset.x,
        y = pCoords.y + offset.y,
        z = pCoords.z + offset.z
    }

    return pos
end



Citizen.CreateThread(function()
    while true do
        if not have_character then
            local UpScrollMouse = {`INPUT_CREATOR_LT`, `INPUT_PREV_WEAPON`}
            local DownScrollMouse = {`INPUT_CREATOR_RT`, `INPUT_NEXT_WEAPON`}
            DrawLightWithRange(tonumber(string.format("%.2f", -562.88)), tonumber(string.format("%.2f", -3782.36)), tonumber(string.format("%.2f", 240.49)), 255, 255, 255, tonumber(string.format("%.2f", 10.0)), tonumber(string.format("%.2f", 150.0)))
            DrawLightWithRange(tonumber(string.format("%.2f", -559.25)), tonumber(string.format("%.2f", -3776.16)), tonumber(string.format("%.2f", 240.49)), 255, 255, 255, tonumber(string.format("%.2f", 10.0)), tonumber(string.format("%.2f", 150.0)))
            opt = 5
            if active_buttons_create_select == false then
                local create_char = CreateVarString(10, 'LITERAL_STRING', ""..Config.Language[177].text.." "..char_text.."")
                PromptSetActiveGroupThisFrame(buttons_prompt, create_char)
            end
            if Citizen.InvokeNative(0x91AEF906BCA88877, 0, 0x27D1C284) then
                if not spawm_protect then
                    spawm_protect = true
                    if male_selected == false then
                        male_selected = true
                        char_text = Config.Language[175].text
                        StartCam(-560.05, -3775.77, 239.35, -90.00, 50.0)
                    else
                        male_selected = false
                        char_text = Config.Language[176].text
                        StartCam(-560.05, -3776.57, 239.35, -90.00, 50.0)
                    end
                    Citizen.Wait(500)
                    spawm_protect = false
                end
            end
            if Citizen.InvokeNative(0x91AEF906BCA88877, 0, 0x0522B243) then
                if not spawm_protect then
                    if char_text ~= "" then
                        spawm_protect = true
                        DeletePed(PedFemale)
                        DeletePed(PedMale)
                        TakeCharacter(char_text)
                        SetEntityCoords(PlayerPedId(), -563.77, -3776.49, 238.56)
                        active_buttons_create_select = true
                        active_buttons_create_make = false
                        Citizen.Wait(500)
                        Make_Data(char_text)
                        -- load_all_data_clothes(char_text)
                        Citizen.Wait(500)
                        --Open_Basic_Menu()
                        TriggerEvent("gum_creator:new_char", char_text)
                    else
                        exports['gum_notify']:DisplayLeftNotification(""..Config.Language[1].text.."", ""..Config.Language[183].text.."", 'character', 2000)
                    end
                end
            end
            ---MAKE CHARACTER
            DisableControlAction(0, 0x3076E97C, true)
            DisableControlAction(0, 0xCC1075A7, true)
            if active_buttons_create_make == false then
                local create_char = CreateVarString(10, 'LITERAL_STRING', Config.Language[1].text)
                PromptSetActiveGroupThisFrame(buttons_prompt_2, create_char)
            end
        else
            opt = 2000
        end
        Citizen.Wait(opt)
    end
end)
RegisterNUICallback('up_key', function(data, cb)
    if z_position <= 240.0 then
        z_position = z_position+0.05
        StartCam(-561.86, -3782.36, z_position, 88.00, zoom)
    end
end)

RegisterNUICallback('down_key', function(data, cb)
    if z_position >= 237.70 then
        z_position = z_position-0.05
        StartCam(-561.86, -3782.36, z_position, 88.00, zoom)
    end
end)

RegisterNUICallback('left_key', function(data, cb)
    heading = heading-6.0
    SetEntityHeading(PlayerPedId(), heading)
end)
RegisterNUICallback('right_key', function(data, cb)
    heading = heading+6.0
    SetEntityHeading(PlayerPedId(), heading)
end)
RegisterNUICallback('zoom_key', function(data, cb)
    zoom = zoom-5.0
    StartCam(-561.86, -3782.36, z_position, 88.00, zoom)
end)
RegisterNUICallback('unzoom_key', function(data, cb)
    zoom = zoom+5.0
    StartCam(-561.86, -3782.36, z_position, 88.00, zoom)
end)

function Open_Basic_Menu()
    FreezeEntityPosition(PlayerPedId(), true)
	MenuData.CloseAll()
    local elements = {
        {label = "<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"..Config.Language[2].text.."</b>", value = "nothing", type = 'normal', desc = '<img src="https://redwestrp.eu/images/creator/creator_aperace.png">'},
		{label = ""..Config.Language[3].text.."", value = 'basic', desc = '<img src="https://redwestrp.eu/images/creator/creator_aperace.png">'},
		{label = ""..Config.Language[4].text.."", value = 'face', desc = '<img src="https://redwestrp.eu/images/creator/creator_heritage.png">'},
		{label = ""..Config.Language[5].text.."", value = 'color', desc = '<img src="https://redwestrp.eu/images/creator/creator_colors.png">'},
		{label = ""..Config.Language[6].text.."", value = 'body', desc = '<img src="https://redwestrp.eu/images/creator/creator_body.png">'},
        {label = ""..Config.Language[7].text.."", value = hair_write, type = 'slider', min = -1, max = #Hair_Table, desc = '<img src="https://redwestrp.eu/images/creator/creator_hairs.png">'},
        {label = ""..Config.Language[8].text.."", value = beard_write, type = 'slider', min = -1, max = #Beard_Table, desc = '<img src="https://redwestrp.eu/images/creator/creator_beard.png">'},
		{label = ""..Config.Language[9].text.."", value = 'clothe', desc = '<img src="https://redwestrp.eu/images/creator/creator_clohes.png">'},
        {label = "<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"..Config.Language[10].text.."</b>", value = "nothing", type = 'normal', desc = '<img src="https://redwestrp.eu/images/creator/creator_aperace.png">'},
		{label = ""..Config.Language[11].text.." "..firstname.." "..lastname.."", value = 'nameset', desc = '<img src="https://redwestrp.eu/images/creator/creator_names.png">'},
		{label = ""..Config.Language[12].text.."", value = 'save'},  
    }
   	MenuData.Open('default', GetCurrentResourceName(), 'gum_character',
	{
		title    = ''..Config.Language[13].text..'',
		subtext    = ''..Config.Language[14].text..'',
		align    = 'bottom-left',
		elements = elements,
	},
	function(data, menu)
        if (data.current.value) == "basic" then
            Open_Basic()
        end
        if (data.current.value) == "face" then
            Open_Face()
        end
        if (data.current.value) == "color" then
            Open_ColorFace()
        end
        if (data.current.value) == "body" then
            Open_Body()
        end
        if (data.current.value) == "clothe" then
            Open_Clothe()
        end
        if (data.current.value) == "nameset" then
            TriggerEvent("guminputs:getInput", ""..Config.Language[15].text.."", ""..Config.Language[16].text.."", function(cb)
                local firstname_cb = tostring(cb)
                if firstname_cb ~= "close" then
                    firstname = firstname_cb
                    Citizen.Wait(1000)
                    TriggerEvent("guminputs:getInput", ""..Config.Language[15].text.."", ""..Config.Language[17].text.."", function(cb)
                        local lastname_cb = tostring(cb)
                        if lastname_cb ~= "close" then
                            lastname = lastname_cb
                            MenuData.CloseAll()
                            Open_Basic_Menu()
                        else
                            Open_Basic_Menu()
                        end
                        return true
                    end)
                else
                    Open_Basic_Menu()
                end
                return true
            end)
        end
        if (data.current.value) == "save" then
            if firstname ~= "" and lastname ~= "" and Skin_Table["Eyes"] ~= 0 and Skin_Table["BodyType"] ~= 0 and Skin_Table["HeadType"] ~= 0 and Skin_Table["LegsType"] ~= 0 and Skin_Table["Nation"] ~= 0 then
                have_character = true
                coords_table_save = {x=Config.SpawnCoords[1], y=Config.SpawnCoords[2], z=Config.SpawnCoords[3], heading=Config.SpawnCoords[4]}
                TriggerServerEvent("gum_character:save_character", firstname, lastname, Skin_Table, Clothe_Table, coords_table_save)
                exports['gum_character']:loading(true) 
                MenuData.CloseAll()
                N_0x69d65e89ffd72313(false)
                TriggerEvent("gum_character:del_old")
                FreezeEntityPosition(PlayerPedId(), true)
                SetEntityCoords(PlayerPedId(), Config.SpawnCoords[1], Config.SpawnCoords[2], Config.SpawnCoords[3])
                SetEntityHeading(PlayerPedId(), Config.SpawnCoords[4])
                Citizen.Wait(1000)
                FreezeEntityPosition(PlayerPedId(), false)
                EndCam()
                Citizen.InvokeNative(0xD0AFAFF5A51D72F7, PlayerPedId())
                Citizen.InvokeNative(0xF808475FA571D823, true)
                Citizen.InvokeNative(0xBF25EB89375A37AD, 5, GetHashKey("PLAYER"), GetHashKey("PLAYER"))
                TriggerEvent("gum_status:start_status")
                SetEntityCoords(PlayerPedId(), Config.SpawnCoords[1], Config.SpawnCoords[2], Config.SpawnCoords[3])
            else
                if Skin_Table["Eyes"] == 0 then
                    exports['gum_notify']:DisplayLeftNotification(""..Config.Language[1].text.."", ""..Config.Language[184].text.."", 'character', 2000)
                elseif Skin_Table["BodyType"] == 0 then
                    exports['gum_notify']:DisplayLeftNotification(""..Config.Language[1].text.."", ""..Config.Language[185].text.."", 'character', 2000)
                elseif Skin_Table["Nation"] == 0 then
                    exports['gum_notify']:DisplayLeftNotification(""..Config.Language[1].text.."", ""..Config.Language[186].text.."", 'character', 2000)
                elseif Skin_Table["HeadType"] == 0 then
                    exports['gum_notify']:DisplayLeftNotification(""..Config.Language[1].text.."", ""..Config.Language[187].text.."", 'character', 2000)
                elseif Skin_Table["LegsType"] == 0 then
                    exports['gum_notify']:DisplayLeftNotification(""..Config.Language[1].text.."", ""..Config.Language[188].text.."", 'character', 2000)
                else
                    exports['gum_notify']:DisplayLeftNotification(""..Config.Language[1].text.."", ""..Config.Language[189].text.."", 'character', 2000)
                end
            end
        end
	end,
	function(data, menu)
	end,
	function(data, menu)
        if (data.current.label) == ""..Config.Language[7].text.."" then
            if tonumber(data.current.value) == -1 then
                Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x864B03AE, 0)
                Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0);
                Skin_Table["Hair"] = -1
            else
                for i,v in pairs(Hair_Table) do
                    if i == data.current.value+2 then
                        local hash = v.hash
                        hair_write = data.current.value
                        Skin_Table["Hair"] = tonumber(hash)
                        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash), true,true,true)
                        Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
                    end
                end
            end
        end
        if (data.current.label) == ""..Config.Language[8].text.."" then
            if tonumber(data.current.value) == -1 then
                Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xF8016BCA, 0)
                Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0);
                Skin_Table["Beard"] = -1
            else
                for i,v in pairs(Beard_Table) do
                    if i == data.current.value+2 then
                        local hash = v.hash
                        beard_write = data.current.value
                        Skin_Table["Beard"] = tonumber(hash)
                        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash), true,true,true)
                        Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
                    end
                end
            end
        end
	end)
end

function Open_Clothe()
	MenuData.CloseAll()
    local elements = {
        {label = ""..Config.Language[18].text.."", value = hats_set, type = 'slider', min = 0, max = #HatsTable, desc = '<img src="https://redwestrp.eu/images/creator/clothe_hat.png">'},
        {label = ""..Config.Language[19].text.."", value = eyewear_set, type = 'slider', min = 0, max = #EyewearTable, desc = '<img src="https://redwestrp.eu/images/creator/clothe_glass.png">'},
        {label = ""..Config.Language[20].text.."", value = Scarf_set, type = 'slider', min = 0, max = #ScarftTable, desc = '<img src="https://redwestrp.eu/images/creator/clothe_scarf.png">'},
        {label = ""..Config.Language[21].text.."", value = Mask_set, type = 'slider', min = 0, max = #MaskTable, desc = '<img src="https://redwestrp.eu/images/creator/clothe_mask.png">'},
        {label = ""..Config.Language[22].text.."", value = Necktie_set, type = 'slider', min = 0, max = #NecktieTable, desc = '<img src="https://redwestrp.eu/images/creator/clothe_necktie.png">'},
        {label = ""..Config.Language[23].text.."", value = Shirt_set, type = 'slider', min = 0, max = #ShirtTable, desc = '<img src="https://redwestrp.eu/images/creator/clothe_shirt.png">'},
        {label = ""..Config.Language[24].text.."", value = Suspender_set, type = 'slider', min = 0, max = #SuspenderTable, desc = '<img src="https://redwestrp.eu/images/creator/clothe_suspenders.png">'},
        {label = ""..Config.Language[48].text.."", value = Vest_set, type = 'slider', min = 0, max = #VestTable, desc = '<img src="https://redwestrp.eu/images/creator/clothe_vest.png">'},
        {label = ""..Config.Language[25].text.."", value = Coat_set, type = 'slider', min = 0, max = #CoatTable, desc = '<img src="https://redwestrp.eu/images/creator/clothe_coat.png">'},
        {label = ""..Config.Language[26].text.."", value = CCoat_set, type = 'slider', min = 0, max = #ClosedCoatTable, desc = '<img src="https://redwestrp.eu/images/creator/clothe_coat.png">'},
        {label = ""..Config.Language[27].text.."", value = Poncho_set, type = 'slider', min = 0, max = #PonchoTable, desc = '<img src="https://redwestrp.eu/images/creator/clothe_poncho.png">'},
        {label = ""..Config.Language[28].text.."", value = Cloak_set, type = 'slider', min = 0, max = #CloakTable, desc = '<img src="https://redwestrp.eu/images/creator/clothe_cloak.png">'},
        {label = ""..Config.Language[29].text.."", value = Glove_set, type = 'slider', min = 0, max = #GloveTable, desc = '<img src="https://redwestrp.eu/images/creator/clothe_gloves.png">'},
        {label = ""..Config.Language[30].text.."", value = RRing_set, type = 'slider', min = 0, max = #RRingTable, desc = '<img src="https://redwestrp.eu/images/creator/clothe_ring.png">'},
        {label = ""..Config.Language[31].text.."", value = LRing_set, type = 'slider', min = 0, max = #LRingTable, desc = '<img src="https://redwestrp.eu/images/creator/clothe_ring.png">'},
        {label = ""..Config.Language[32].text.."", value = Bracelet_set, type = 'slider', min = 0, max = #BraceletTable, desc = '<img src="https://redwestrp.eu/images/creator/clothe_bracelets.png">'},
        {label = ""..Config.Language[33].text.."", value = Gunbelt_set, type = 'slider', min = 0, max = #GunbeltTable, desc = '<img src="https://redwestrp.eu/images/creator/clothe_gunbelt.png">'},
        {label = ""..Config.Language[34].text.."", value = GunbeltAcs_set, type = 'slider', min = 0, max = #GunbeltAcsTable, desc = '<img src="https://redwestrp.eu/images/creator/clothe_gaccessories.png">'},
        {label = ""..Config.Language[35].text.."", value = Belt_set, type = 'slider', min = 0, max = #BeltsTable, desc = '<img src="https://redwestrp.eu/images/creator/clothe_belt.png">'},
        {label = ""..Config.Language[36].text.."", value = Buckles_set, type = 'slider', min = 0, max = #BucklesTable, desc = '<img src="https://redwestrp.eu/images/creator/clothe_buckle.png">'},
        {label = ""..Config.Language[37].text.."", value = LHolster_set, type = 'slider', min = 0, max = #LHolsterTable, desc = '<img src="https://redwestrp.eu/images/creator/clothe_holster.png">'},
        {label = ""..Config.Language[38].text.."", value = Pant_set, type = 'slider', min = 0, max = #PantTable, desc = '<img src="https://redwestrp.eu/images/creator/clothe_pants.png">'},
        {label = ""..Config.Language[39].text.."", value = Spat_set, type = 'slider', min = 0, max = #SpatsTable, desc = '<img src="https://redwestrp.eu/images/creator/clothe_spats.png">'},
        {label = ""..Config.Language[40].text.."", value = Skirt_set, type = 'slider', min = 0, max = #SkirtTable, desc = '<img src="https://redwestrp.eu/images/creator/clothe_skirt.png">'},
        {label = ""..Config.Language[41].text.."", value = Chap_set, type = 'slider', min = 0, max = #ChapTable, desc = '<img src="https://redwestrp.eu/images/creator/clothe_chaps.png">'},
        {label = ""..Config.Language[42].text.."", value = Boot_set, type = 'slider', min = 0, max = #BootTable, desc = '<img src="https://redwestrp.eu/images/creator/clothe_boots.png">'},
        {label = ""..Config.Language[43].text.."", value = Spur_set, type = 'slider', min = 0, max = #SpurTable, desc = '<img src="https://redwestrp.eu/images/creator/clothe_spurs.png">'},
        {label = ""..Config.Language[44].text.."", value = Gauntlet_set, type = 'slider', min = 0, max = #GauntletTable, desc = '<img src="https://redwestrp.eu/images/creator/clothe_gauntlet.png">'},
        {label = ""..Config.Language[45].text.."", value = Accesori_set, type = 'slider', min = 0, max = #AccesorieTable, desc = '<img src="https://redwestrp.eu/images/creator/clothe_accessories.png">'},
        {label = ""..Config.Language[46].text.."", value = Satchel_set, type = 'slider', min = 0, max = #SatchelTable, desc = '<img src="https://redwestrp.eu/images/creator/clothe_satchel.png">'},
        {label = ""..Config.Language[47].text.."", value = Loadouts_set, type = 'slider', min = 0, max = #LoadoutsTable, desc = '<img src="https://redwestrp.eu/images/creator/clothe_loadouts.png">'},
    }
   	MenuData.Open('default', GetCurrentResourceName(), 'gum_character',
	{
		title    = ''..Config.Language[9].text..'',
		subtext    = '',
		align    = 'bottom-left',
		elements = elements,
	},
	function(data, menu)
        --Save function
    end,
	function(data, menu)
        Open_Basic_Menu()
	end,
	function(data, menu)
        if (data.current.label) == ""..Config.Language[18].text.."" then
            if data.current.value == 0 then
                Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x9925C067, 0)
                Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0)
                Clothe_Table["Hat"] = -1
                hats_set = 0
                check_hairs()
            else
                hats_set = data.current.value
                hash = (HatsTable[data.current.value].hash)
                Clothe_Table["Hat"] = tonumber(hash)
                Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash), true,true,true)
                check_hairs()
            end
		end
        
        if (data.current.label) == ""..Config.Language[47].text.."" then
            if data.current.value == 0 then
                Loadouts_set = 0
                Clothe_Table["Loadouts"] = -1
                Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x83887E88, 0)
                Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0)
            else
                Loadouts_set = data.current.value
                hash = (LoadoutsTable[data.current.value].hash)
                Clothe_Table["Loadouts"] = tonumber(hash)
                Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash), true,true,true)
            end
		end
        if (data.current.label) == ""..Config.Language[19].text.."" then
            if data.current.value == 0 then
                eyewear_set = 0
                Clothe_Table["EyeWear"] = -1
                Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x5E47CA6, 0)
                Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0)
            else
                eyewear_set = data.current.value
                hash = (EyewearTable[data.current.value].hash)
                Clothe_Table["EyeWear"] = tonumber(hash)
                Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash), true,true,true)
            end
		end
        if (data.current.label) == ""..Config.Language[20].text.."" then
            if data.current.value == 0 then
                Scarf_set = 0
                Clothe_Table["NeckWear"] = -1
                Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x5FC29285, 0)
                Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0)
            else
                Scarf_set = data.current.value
                hash = (ScarftTable[data.current.value].hash)
                Clothe_Table["NeckWear"] = tonumber(hash)
                Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash), true,true,true)
            end
        end
        if (data.current.label) == ""..Config.Language[21].text.."" then
            if data.current.value == 0 then
                Mask_set = 0
                Clothe_Table["Mask"] = -1
                Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x7505EF42, 0)
                Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0)
                check_hairs()
            else
                Mask_set = data.current.value
                hash = (MaskTable[data.current.value].hash)
                Clothe_Table["Mask"] = tonumber(hash)
                Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash), true,true,true)
                check_hairs()
            end
        end
        if (data.current.label) == ""..Config.Language[22].text.."" then
            if data.current.value == 0 then
                Necktie_set = 0
                Clothe_Table["NeckTies"] = -1
                Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x7A96FACA, 0)
                Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0)
            else
                Necktie_set = data.current.value
                hash = (NecktieTable[data.current.value].hash)
                Clothe_Table["NeckTies"] = tonumber(hash)
                Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash), true,true,true)
            end
        end
        if (data.current.label) == ""..Config.Language[23].text.."" then
            if data.current.value == 0 then
                Shirt_set = 0
                Clothe_Table["Shirt"] = -1
                Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x2026C46D, 0)
                Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0)
            else
                Shirt_set = data.current.value
                hash = (ShirtTable[data.current.value].hash)
                Clothe_Table["Shirt"] = tonumber(hash)
                Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash), true,true,true)
            end
        end
        if (data.current.label) == ""..Config.Language[24].text.."" then
            if data.current.value == 0 then
                Suspender_set = 0
                Clothe_Table["Suspender"] = -1
                Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x877A2CF7, 0)
                Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0)
            else
                Suspender_set = data.current.value
                hash = (SuspenderTable[data.current.value].hash)
                Clothe_Table["Suspender"] = tonumber(hash)
                Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash), true,true,true)
            end
        end
        if (data.current.label) == ""..Config.Language[48].text.."" then
            if data.current.value == 0 then
                Vest_set = 0
                Clothe_Table["Vest"] = -1
                Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x485EE834, 0)
                Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0)
            else
                Vest_set = data.current.value
                hash = (VestTable[data.current.value].hash)
                Clothe_Table["Vest"] = tonumber(hash)
                Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash), true,true,true)
            end
        end
        if (data.current.label) == ""..Config.Language[25].text.."" then
            if data.current.value == 0 then
                Coat_set = 0
                Clothe_Table["Coat"] = -1
                Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xE06D30CE, 0)
                Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0)
            else
                Coat_set = data.current.value
                Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x662AC34, 0)
                hash = (CoatTable[data.current.value].hash)
                Clothe_Table["Coat"] = tonumber(hash)
                Clothe_Table["CoatClosed"] = -1
                Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash), true,true,true)
                Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0)
            end
        end
        if (data.current.label) == ""..Config.Language[26].text.."" then
            if data.current.value == 0 then
                CCoat_set = 0
                Clothe_Table["CoatClosed"] = -1
                Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x662AC34, 0)
                Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0)
            else
                CCoat_set = data.current.value
                Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xE06D30CE, 0)
                hash = (ClosedCoatTable[data.current.value].hash)
                Clothe_Table["CoatClosed"] = tonumber(hash)
                Clothe_Table["Coat"] = -1
                Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash), true,true,true)
                Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0)
            end
        end
        if (data.current.label) == ""..Config.Language[27].text.."" then
            if data.current.value == 0 then
                Poncho_set = 0
                Clothe_Table["Poncho"] = -1
                Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xAF14310B, 0)
                Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0)
            else
                Poncho_set = data.current.value
                hash = (PonchoTable[data.current.value].hash)
                Clothe_Table["Poncho"] = tonumber(hash)
                Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash), true,true,true)
            end
        end
        if (data.current.label) == ""..Config.Language[28].text.."" then
            if data.current.value == 0 then
                Cloak_set = 0
                Clothe_Table["Cloak"] = -1
                Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x3C1A74CD, 0)
                Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0)
            else
                Cloak_set = data.current.value
                hash = (CloakTable[data.current.value].hash)
                Clothe_Table["Cloak"] = tonumber(hash)
                Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash), true,true,true)
            end
        end
        if (data.current.label) == ""..Config.Language[46].text.."" then
            if data.current.value == 0 then
                Satchel_set = 0
                Clothe_Table["Satchel"] = -1
                Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x94504D26, 0)
                Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0)
            else
                Satchel_set = data.current.value
                hash = (SatchelTable[data.current.value].hash)
                Clothe_Table["Satchel"] = tonumber(hash)
                Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash), true,true,true)
            end
        end
        if (data.current.label) == ""..Config.Language[29].text.."" then
            if data.current.value == 0 then
                Glove_set = 0
                Clothe_Table["Glove"] = -1
                Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xEABE0032, 0)
                Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0)
            else
                Glove_set = data.current.value
                hash = (GloveTable[data.current.value].hash)
                Clothe_Table["Glove"] = tonumber(hash)
                Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash), true,true,true)
            end
        end
         if (data.current.label) == ""..Config.Language[30].text.."" then
            if data.current.value == 0 then
                RRing_set = 0
                Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x7A6BBD0B, 0)
                Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0)
                Clothe_Table["RingRh"] = -1
            else
                RRing_set = data.current.value
                hash = (RRingTable[data.current.value].hash)
                Clothe_Table["RingRh"] = tonumber(hash)
                Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash), true,true,true)
            end
        end
        if (data.current.label) == ""..Config.Language[31].text.."" then
            if data.current.value == 0 then
                LRing_set = 0
                Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xF16A1D23, 0)
                Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0)
                Clothe_Table["RingLh"] = -1
            else
                LRing_set = data.current.value
                hash = (LRingTable[data.current.value].hash)
                Clothe_Table["RingLh"] = tonumber(hash)
                Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash), true,true,true)
            end
        end
        if (data.current.label) == ""..Config.Language[32].text.."" then
            if data.current.value == 0 then
                Bracelet_set = 0
                Clothe_Table["Bracelet"] = -1
                Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x7BC10759, 0)
                Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0)
            else
                Bracelet_set = data.current.value
                hash = (BraceletTable[data.current.value].hash)
                Clothe_Table["Bracelet"] = tonumber(hash)
                Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash), true,true,true)
            end
        end
        if (data.current.label) == ""..Config.Language[33].text.."" then
            if data.current.value == 0 then
                Gunbelt_set = 0
                Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x9B2C8B89, 0)
                Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0)
                Clothe_Table["Gunbelt"] = -1
            else
                Gunbelt_set = data.current.value
                hash = (GunbeltTable[data.current.value].hash)
                Clothe_Table["Gunbelt"] = tonumber(hash)
                Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash), true,true,true)
            end
        end
        if (data.current.label) == ""..Config.Language[34].text.."" then
            if data.current.value == 0 then
                GunbeltAcs_set = 0
                Clothe_Table["GunbeltAccs"] = -1
                Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xF1542D11, 0)
                Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0)
            else
                GunbeltAcs_set = data.current.value
                hash = (GunbeltAcsTable[data.current.value].hash)
                Clothe_Table["GunbeltAccs"] = tonumber(hash)
                Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash), true,true,true)
            end
		end
        if (data.current.label) == ""..Config.Language[35].text.."" then
            if data.current.value == 0 then
                Belt_set = 0
                Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xA6D134C6, 0)
                Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0)
                Clothe_Table["Belt"] = -1
            else
                Belt_set = data.current.value
                hash = (BeltsTable[data.current.value].hash)
                Clothe_Table["Belt"] = tonumber(hash)
                Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash), true,true,true)
            end
        end
        if (data.current.label) == ""..Config.Language[36].text.."" then
            if data.current.value == 0 then
                Buckles_set = 0
                Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xFAE9107F, 0)
                Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0)
                Clothe_Table["Buckle"] = -1
            else
                Buckles_set = data.current.value
                hash = (BucklesTable[data.current.value].hash)
                Clothe_Table["Buckle"] = tonumber(hash)
                Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash), true,true,true)
            end
        end
        if (data.current.label) == ""..Config.Language[37].text.."" then
            if data.current.value == 0 then
                LHolster_set = 0
                Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xB6B6122D, 0)
                Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0)
                Clothe_Table["Holster"] = -1
            else
                LHolster_set = data.current.value
                hash = (LHolsterTable[data.current.value].hash)
                Clothe_Table["Holster"] = tonumber(hash)
                Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash), true,true,true)
            end
        end
        if (data.current.label) == ""..Config.Language[38].text.."" then
            if data.current.value == 0 then
                Pant_set = 0
                Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x1D4C528A, 0)
                Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0)
                Clothe_Table["Pant"] = -1
            else
                Skirt_set = 0
                Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xA0E3AB7F, 0)
                Clothe_Table["Skirt"] = -1
                
                Pant_set = data.current.value
                hash = (PantTable[data.current.value].hash)
                Clothe_Table["Pant"] = tonumber(hash)
                Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash), true,true,true)
            end
        end

        if (data.current.label) == ""..Config.Language[40].text.."" then
            if data.current.value == 0 then
                if IsPedMale(PlayerPedId()) then
                    Skirt_set = 0
                    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xA0E3AB7F, 0)
                    Clothe_Table["Skirt"] = -1
                else
                    Skirt_set = 0
                    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xA0E3AB7F, 0)
                    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0)
                    Clothe_Table["Skirt"] = -1
                end
            else
                Pant_set = 0
                Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x1D4C528A, 0)
                Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0)
                Clothe_Table["Pant"] = -1
                
                Skirt_set = data.current.value
                hash = (SkirtTable[data.current.value].hash)
                Clothe_Table["Skirt"] = tonumber(hash)
                Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash), true,true,true)
            end
        end
        
        if (data.current.label) == ""..Config.Language[39].text.."" then
            if data.current.value == 0 then
                Spat_set = 0
                Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x514ADCEA, 0)
                Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0)
                Clothe_Table["Spats"] = -1
            else
                Spat_set = data.current.value
                hash = (SpatsTable[data.current.value].hash)
                Clothe_Table["Spats"] = tonumber(hash)
                Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash), true,true,true)
            end
        end
        if (data.current.label) == ""..Config.Language[41].text.."" then
            if data.current.value == 0 then
                Chap_set = 0
                Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x3107499B, 0)
                Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0)
                Clothe_Table["Chap"] = -1
            else
                Chap_set = data.current.value
                hash = (ChapTable[data.current.value].hash)
                Clothe_Table["Chap"] = tonumber(hash)
                Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash), true,true,true)
            end
        end
        if (data.current.label) == ""..Config.Language[42].text.."" then
            if data.current.value == 0 then
                Boot_set = 0
                Clothe_Table["Boots"] = -1
                Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x777EC6EF, 0)
                Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0)
            else
                Boot_set = data.current.value
                hash = (BootTable[data.current.value].hash)
                Clothe_Table["Boots"] = tonumber(hash)
                Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash), true,true,true)
            end
        end
        if (data.current.label) == ""..Config.Language[43].text.."" then
            if data.current.value == 0 then
                Spur_set = 0
                Clothe_Table["Spurs"] = -1
                Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x18729F39, 0)
                Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0)
            else
                Spur_set = data.current.value
                hash = (SpurTable[data.current.value].hash)
                Clothe_Table["Spurs"] = tonumber(hash)
                Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash), true,true,true)
            end
        end
        if (data.current.label) == ""..Config.Language[44].text.."" then
            if data.current.value == 0 then
                Gauntlet_set = 0
                Clothe_Table["Gauntlets"] = -1
                Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x91CE9B20, 0)
                Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0)
            else
                Gauntlet_set = data.current.value
                hash = (GauntletTable[data.current.value].hash)
                Clothe_Table["Gauntlets"] = tonumber(hash)
                Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash), true,true,true)
            end
        end
        if (data.current.label) == ""..Config.Language[45].text.."" then
            if data.current.value == 0 then
                Accesori_set = 0
                Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x79D7DF96, 0)
                Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0)
                Clothe_Table["Accessories"] = -1
            else
                Accesori_set = data.current.value
                hash = (AccesorieTable[data.current.value].hash)
                Clothe_Table["Accessories"] = tonumber(hash)
                Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash), true,true,true)
            end
        end
    end)
end


function check_hairs()
    if Skin_Table["sex"] == "mp_male" then
        for key,value in pairs(Skin_Table) do
            if key == "Beard" then
                for k,v in pairs(Beard_Table) do
                    if value == v.cat then
                        local hash_beard_c = '0x010D6AC7'--Male
                        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash_beard_c), true,true,true)
                        Citizen.Wait(5)
                        local hash_beard_m = v.hash
                        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash_beard_m), true,true,true)
                        Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0)
                    end
                end
            end
            if key == "Hair" then
                for k,v in pairs(Hair_Table) do
                    if value == v.cat then
                        local hash_hair_c = '0x24BC8E37'--Male
                        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash_hair_c), true,true,true)
                        Citizen.Wait(5)
                        local hash_hair_m = v.hash
                        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash_hair_m), true,true,true)
                        Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0)
                    end
                end
            end
        end
    else
        for key,value in pairs(Skin_Table) do
            if key == "Hair" then
                for k,v in pairs(Hair_Table) do
                    if value == v.cat then
                        local hash_hair_ch = '0x09977086'--Female
                        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash_hair_ch), true,true,true)
                        Citizen.Wait(50)
                        local hash_hair_fm = v.hash
                        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash_hair_fm), true,true,true)
                        Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0)
                    end
                end
            end
        end
    end
end
function Open_Face()
	MenuData.CloseAll()
    local elements = {
        {label = ""..Config.Language[49].text.."", value = HeadSize, type = 'slider', min = -10, max = 10, desc = '<img src="https://redwestrp.eu/images/creator/creator_propotion.png">'},
        {label = "<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"..Config.Language[50].text.." </b>", value = "nothing", type = 'normal', desc = '<img src="https://redwestrp.eu/images/creator/creator_eyes.png">'},

        {label = ""..Config.Language[51].text.."", value = Eyes, type = 'slider', min = 1, max = 14, desc = '<img src="https://redwestrp.eu/images/creator/creator_eyes.png">'},
        {label = ""..Config.Language[52].text.."", value = EyeBrowH, type = 'slider', min = -10, max = 10, desc = '<img src="https://redwestrp.eu/images/creator/creator_eyes.png">'},
        {label = ""..Config.Language[53].text.."", value = EyeBrowW, type = 'slider', min = -10, max = 10, desc = '<img src="https://redwestrp.eu/images/creator/creator_eyes.png">'},
        {label = ""..Config.Language[54].text.."", value = EyeBrowD, type = 'slider', min = -10, max = 10, desc = '<img src="https://redwestrp.eu/images/creator/creator_eyes.png">'},
        {label = ""..Config.Language[55].text.."", value = EyeLidH, type = 'slider', min = -10, max = 10, desc = '<img src="https://redwestrp.eu/images/creator/creator_eyes.png">'},
        {label = ""..Config.Language[56].text.."", value = EyeLidW, type = 'slider', min = -10, max = 10, desc = '<img src="https://redwestrp.eu/images/creator/creator_eyes.png">'},
        {label = ""..Config.Language[57].text.."", value = EyeD, type = 'slider', min = -10, max = 10, desc = '<img src="https://redwestrp.eu/images/creator/creator_eyes.png">'},
        {label = ""..Config.Language[58].text.."", value = EyeAng, type = 'slider', min = -10, max = 10, desc = '<img src="https://redwestrp.eu/images/creator/creator_eyes.png">'},
        {label = ""..Config.Language[59].text.."", value = EyeDis, type = 'slider', min = -10, max = 10, desc = '<img src="https://redwestrp.eu/images/creator/creator_eyes.png">'},
        {label = ""..Config.Language[60].text.."", value = EyeH, type = 'slider', min = -10, max = 10, desc = '<img src="https://redwestrp.eu/images/creator/creator_eyes.png">'},
        {label = "<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"..Config.Language[61].text.."</b>", value = "nothing", type = 'normal', desc = '<img src="https://redwestrp.eu/images/creator/creator_ears.png">'},
        {label = ""..Config.Language[62].text.."", value = EarsH, type = 'slider', min = -10, max = 10, desc = '<img src="https://redwestrp.eu/images/creator/creator_ears.png">'},
        {label = ""..Config.Language[63].text.."", value = EarsW, type = 'slider', min = -10, max = 10, desc = '<img src="https://redwestrp.eu/images/creator/creator_ears.png">'},
        {label = ""..Config.Language[64].text.."", value = EarsD, type = 'slider', min = -10, max = 10, desc = '<img src="https://redwestrp.eu/images/creator/creator_ears.png">'},
        {label = ""..Config.Language[65].text.."", value = EarsL, type = 'slider', min = -10, max = 10, desc = '<img src="https://redwestrp.eu/images/creator/creator_ears.png">'},

        {label = "<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"..Config.Language[66].text.."</b>", value = "nothing", type = 'normal', desc = '<img src="https://redwestrp.eu/images/creator/creator_nose.png">'},
        {label = ""..Config.Language[67].text.."", value = NoseW, type = 'slider', min = -10, max = 10, desc = '<img src="https://redwestrp.eu/images/creator/creator_nose.png">'},
        {label = ""..Config.Language[68].text.."", value = NoseS, type = 'slider', min = -10, max = 10, desc = '<img src="https://redwestrp.eu/images/creator/creator_nose.png">'},
        {label = ""..Config.Language[69].text.."", value = NoseH, type = 'slider', min = -10, max = 10, desc = '<img src="https://redwestrp.eu/images/creator/creator_nose.png">'},
        {label = ""..Config.Language[70].text.."", value = NoseAng, type = 'slider', min = -10, max = 10, desc = '<img src="https://redwestrp.eu/images/creator/creator_nose.png">'},
        {label = ""..Config.Language[71].text.."", value = NoseC, type = 'slider', min = -10, max = 10, desc = '<img src="https://redwestrp.eu/images/creator/creator_nose.png">'},
        {label = ""..Config.Language[72].text.."", value = NoseDis, type = 'slider', min = -10, max = 10, desc = '<img src="https://redwestrp.eu/images/creator/creator_nose.png">'},

        {label = "<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"..Config.Language[73].text.."</b>", value = "nothing", type = 'normal', desc = '<img src="https://redwestrp.eu/images/creator/creator_cheeks.png">'},
        {label = ""..Config.Language[74].text.."", value = CheekBonesH, type = 'slider', min = -10, max = 10, desc = '<img src="https://redwestrp.eu/images/creator/creator_cheeks.png">'},
        {label = ""..Config.Language[75].text.."", value = CheekBonesW, type = 'slider', min = -10, max = 10, desc = '<img src="https://redwestrp.eu/images/creator/creator_cheeks.png">'},
        {label = ""..Config.Language[76].text.."", value = CheekBonesD, type = 'slider', min = -10, max = 10, desc = '<img src="https://redwestrp.eu/images/creator/creator_cheeks.png">'},

        {label = "<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"..Config.Language[77].text.."</b>", value = "nothing", type = 'normal', desc = '<img src="https://redwestrp.eu/images/creator/creator_mounth.png">'},
        {label = ""..Config.Language[78].text.."", value = MouthW, type = 'slider', min = -10, max = 10, desc = '<img src="https://redwestrp.eu/images/creator/creator_mounth.png">'},
        {label = ""..Config.Language[79].text.."", value = MouthD, type = 'slider', min = -10, max = 10, desc = '<img src="https://redwestrp.eu/images/creator/creator_mounth.png">'},
        {label = ""..Config.Language[80].text.."", value = MouthX, type = 'slider', min = -10, max = 10, desc = '<img src="https://redwestrp.eu/images/creator/creator_mounth.png">'},
        {label = ""..Config.Language[81].text.."", value = MouthY, type = 'slider', min = -10, max = 10, desc = '<img src="https://redwestrp.eu/images/creator/creator_mounth.png">'},

        {label = "<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"..Config.Language[82].text.."</b>", value = "nothing", type = 'normal', desc = '<img src="https://redwestrp.eu/images/creator/creator_mounth.png">'},
        {label = ""..Config.Language[83].text.."", value = ULiphH, type = 'slider', min = -10, max = 10, desc = '<img src="https://redwestrp.eu/images/creator/creator_mounth.png">'},
        {label = ""..Config.Language[84].text.."", value = ULiphW, type = 'slider', min = -10, max = 10, desc = '<img src="https://redwestrp.eu/images/creator/creator_mounth.png">'},
        {label = ""..Config.Language[85].text.."", value = ULiphD, type = 'slider', min = -10, max = 10, desc = '<img src="https://redwestrp.eu/images/creator/creator_mounth.png">'},
        {label = ""..Config.Language[86].text.."", value = LLiphH, type = 'slider', min = -10, max = 10, desc = '<img src="https://redwestrp.eu/images/creator/creator_mounth.png">'},
        {label = ""..Config.Language[87].text.."", value = LLiphW, type = 'slider', min = -10, max = 10, desc = '<img src="https://redwestrp.eu/images/creator/creator_mounth.png">'},
        {label = ""..Config.Language[88].text.."", value = LLiphD, type = 'slider', min = -10, max = 10, desc = '<img src="https://redwestrp.eu/images/creator/creator_mounth.png">'},

        {label = "<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"..Config.Language[89].text.."</b>", value = "nothing", type = 'normal', desc = '<img src="https://redwestrp.eu/images/creator/creator_jaw.png">'},
        {label = ""..Config.Language[90].text.."", value = JawH, type = 'slider', min = -10, max = 10, desc = '<img src="https://redwestrp.eu/images/creator/creator_jaw.png">'},
        {label = ""..Config.Language[91].text.."", value = JawW, type = 'slider', min = -10, max = 10, desc = '<img src="https://redwestrp.eu/images/creator/creator_jaw.png">'},
        {label = ""..Config.Language[92].text.."", value = JawD, type = 'slider', min = -10, max = 10, desc = '<img src="https://redwestrp.eu/images/creator/creator_jaw.png">'},

        {label = "<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"..Config.Language[93].text.."</b>", value = "nothing", type = 'normal', desc = '<img src="https://redwestrp.eu/images/creator/creator_beard.png">'},
        {label = ""..Config.Language[94].text.."", value = ChinH, type = 'slider', min = -10, max = 10, desc = '<img src="https://redwestrp.eu/images/creator/creator_beard.png">'},
        {label = ""..Config.Language[95].text.."", value = ChinW, type = 'slider', min = -10, max = 10, desc = '<img src="https://redwestrp.eu/images/creator/creator_beard.png">'},
        {label = ""..Config.Language[96].text.."", value = ChinD, type = 'slider', min = -10, max = 10, desc = '<img src="https://redwestrp.eu/images/creator/creator_beard.png">'},
    }
   	MenuData.Open('default', GetCurrentResourceName(), 'gum_character',
	{
		title    = ''..Config.Language[4].text..'',
		subtext    = '',
		align    = 'bottom-left',
		elements = elements,
	},
	function(data, menu)
        if (data.current.value) == "face" then
            Open_Face()
        end
	end,
	function(data, menu)
        Open_Basic_Menu()
	end,
	function(data, menu)
        if data.current.label == ""..Config.Language[94].text.."" then
            ChinH = data.current.value
            Skin_Table["ChinH"] = data.current.value/10
            Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x3C0F, data.current.value/10);
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
        end
        if data.current.label == ""..Config.Language[95].text.."" then
            ChinW = data.current.value
            Skin_Table["ChinW"] = data.current.value/10
            Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0xC3B2, data.current.value/10);
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
        end
        if data.current.label == ""..Config.Language[96].text.."" then
            ChinD = data.current.value
            Skin_Table["ChinD"] = data.current.value/10
            Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0xE323, data.current.value/10);
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
        end
        if data.current.label == ""..Config.Language[90].text.."" then
            JawH = data.current.value
            Skin_Table["JawH"] = data.current.value/10
            Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x8D0A, data.current.value/10);
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
        end
        if data.current.label == ""..Config.Language[91].text.."" then
            JawW = data.current.value
            Skin_Table["JawW"] = data.current.value/10
            Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0xEBAE, data.current.value/10);
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
        end
        if data.current.label == ""..Config.Language[92].text.."" then
            JawD = data.current.value
            Skin_Table["JawD"] = data.current.value/10
            Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x1DF6, data.current.value/10);
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
        end
        if data.current.label == ""..Config.Language[83].text.."" then
            ULiphH = data.current.value
            Skin_Table["ULiphH"] = data.current.value/10
            Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x1A00, data.current.value/10);
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
        end
        if data.current.label == ""..Config.Language[84].text.."" then
            ULiphW = data.current.value
            Skin_Table["ULiphW"] = data.current.value/10
            Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x91C1, data.current.value/10);
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
        end
        if data.current.label == ""..Config.Language[85].text.."" then
            ULiphD = data.current.value
            Skin_Table["ULiphD"] = data.current.value/10
            Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0xC375, data.current.value/10);
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
        end
        if data.current.label == ""..Config.Language[86].text.."" then
            LLiphH = data.current.value
            Skin_Table["LLiphH"] = data.current.value/10
            Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0xBB4D, data.current.value/10);
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
        end
        if data.current.label == ""..Config.Language[87].text.."" then
            LLiphW = data.current.value
            Skin_Table["LLiphW"] = data.current.value/10
            Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0xB0B0, data.current.value/10);
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
        end
        if data.current.label == ""..Config.Language[88].text.."" then
            LLiphD = data.current.value
            Skin_Table["LLiphD"] = data.current.value/10
            Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x5D16, data.current.value/10);
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
        end
        if data.current.label == ""..Config.Language[78].text.."" then
            MouthW = data.current.value
            Skin_Table["MouthW"] = data.current.value/10
            Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0xF065, data.current.value/10);
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
        end
        if data.current.label == ""..Config.Language[79].text.."" then
            MouthD = data.current.value
            Skin_Table["MouthD"] = data.current.value/10
            Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0xAA69, data.current.value/10);
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
        end
        if data.current.label == ""..Config.Language[80].text.."" then
            MouthX = data.current.value
            Skin_Table["MouthX"] = data.current.value/10
            Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x7AC3, data.current.value/10);
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
        end
        if data.current.label == ""..Config.Language[81].text.."" then
            MouthY = data.current.value
            Skin_Table["MouthY"] = data.current.value/10
            Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x410D, data.current.value/10);
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
        end
        if data.current.label == ""..Config.Language[74].text.."" then
            CheekBonesH = data.current.value
            Skin_Table["CheekBonesH"] = data.current.value/10
            Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x6A0B, data.current.value/10);
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
        end
        if data.current.label == ""..Config.Language[75].text.."" then
            CheekBonesW = data.current.value
            Skin_Table["CheekBonesW"] = data.current.value/10
            Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0xABCF, data.current.value/10);
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
        end
        if data.current.label == ""..Config.Language[76].text.."" then
            CheekBonesD = data.current.value
            Skin_Table["CheekBonesD"] = data.current.value/10
            Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x358D, data.current.value/10);
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
        end
        if data.current.label == ""..Config.Language[67].text.."" then
            NoseW = data.current.value
            Skin_Table["NoseW"] = data.current.value/10
            Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x6E7F, data.current.value/10);
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
        end
        if data.current.label == ""..Config.Language[68].text.."" then
            NoseS = data.current.value
            Skin_Table["NoseS"] = data.current.value/10
            Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x3471, data.current.value/10);
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
        end
        if data.current.label == ""..Config.Language[69].text.."" then
            NoseH = data.current.value
            Skin_Table["NoseH"] = data.current.value/10
            Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x03F5, data.current.value/10);
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
        end
        if data.current.label == ""..Config.Language[70].text.."" then
            NoseAng = data.current.value
            Skin_Table["NoseAng"] = data.current.value/10
            Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x34B1, data.current.value/10);
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
        end
        if data.current.label == ""..Config.Language[71].text.."" then
            NoseC = data.current.value
            Skin_Table["NoseC"] = data.current.value/10
            Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0xF156, data.current.value/10);
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
        end
        if data.current.label == ""..Config.Language[72].text.."" then
            NoseDis = data.current.value
            Skin_Table["NoseDis"] = data.current.value/10
            Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x561E, data.current.value/10);
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
        end
        if data.current.label == ""..Config.Language[51].text.."" then
            if char_text == Config.Language[175].text then
                for k,v in pairs(Eyes_Male) do
                    Eyes = data.current.value
                    Skin_Table["Eyes"] = v[data.current.value]
                    Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), v[data.current.value], true, true, true);
                end
            else
                for k,v in pairs(Eyes_Female) do
                    Eyes = data.current.value
                    Skin_Table["Eyes"] = v[data.current.value]
                    Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), v[data.current.value], true, true, true);
                end
            end
        end
        if data.current.label == ""..Config.Language[49].text.."" then
            HeadSize = data.current.value
            Skin_Table["HeadSize"] = data.current.value/10
            Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x84D6, data.current.value/10);
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
        end
        if data.current.label == ""..Config.Language[52].text.."" then
            EyeBrowH = data.current.value
            Skin_Table["EyeBrowH"] = data.current.value/10
            Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x3303, data.current.value/10);
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
        end
        if data.current.label == ""..Config.Language[53].text.."" then
            EyeBrowW = data.current.value
            Skin_Table["EyeBrowW"] = data.current.value/10
            Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x2FF9, data.current.value/10);
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
        end
        if data.current.label == ""..Config.Language[54].text.."" then
            EyeBrowD = data.current.value
            Skin_Table["EyeBrowD"] = data.current.value/10
            Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x4AD1, data.current.value/10);
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
        end
        if data.current.label == ""..Config.Language[55].text.."" then
            EyeLidH = data.current.value
            Skin_Table["EyeLidH"] = data.current.value/10
            Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x8B2B, data.current.value/10);
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
        end
        if data.current.label == ""..Config.Language[56].text.."" then
            EyeLidW = data.current.value
            Skin_Table["EyeLidW"] = data.current.value/10
            Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x1B6B, data.current.value/10);
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
        end
        if data.current.label == ""..Config.Language[57].text.."" then
            EyeD = data.current.value
            Skin_Table["EyeD"] = data.current.value/10
            Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0xEE44, data.current.value/10)
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
        end
        if data.current.label == ""..Config.Language[58].text.."" then
            EyeAng = data.current.value
            Skin_Table["EyeAng"] = data.current.value/10
            Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0xD266, data.current.value/10)
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
        end
        if data.current.label == ""..Config.Language[59].text.."" then
            EyeDis = data.current.value
            Skin_Table["EyeDis"] = data.current.value/10
            Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0xA54E, data.current.value/10)
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
        end
        if data.current.label == ""..Config.Language[60].text.."" then
            EyeH = data.current.value
            Skin_Table["EyeH"] = data.current.value/10
            Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0xDDFB, data.current.value/10)
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
        end

        if data.current.label == ""..Config.Language[62].text.."" then
            EarsH = data.current.value
            Skin_Table["EarsH"] = data.current.value/10
            Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0xC04F, data.current.value/10)
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
        end
        if data.current.label == ""..Config.Language[63].text.."" then
            EarsW = data.current.value
            Skin_Table["EarsW"] = data.current.value/10
            Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0xB6CE, data.current.value/10)
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
        end
        if data.current.label == ""..Config.Language[64].text.."" then
            EarsD = data.current.value
            Skin_Table["EarsD"] = data.current.value/10
            Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x2844, data.current.value/10)
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
        end
        if data.current.label == ""..Config.Language[65].text.."" then
            EarsL = data.current.value
            Skin_Table["EarsL"] = data.current.value/10
            Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0xED30, data.current.value/10)
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
        end
	end)
end

RegisterNetEvent("gum:SelectedCharacter")
AddEventHandler("gum:SelectedCharacter", function(charid)
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(150)
            if is_overlay_change_active then  
                local ped = PlayerPedId()
                if Skin_Table["sex"] == "mp_male" then
                    current_texture_settings = Config.texture_types["male"]
                else
                    current_texture_settings = Config.texture_types["female"]
                end          
                if textureId ~= -1 then
                    Citizen.InvokeNative(0xB63B9178D0F58D82,textureId)  -- reset texture
                    Citizen.InvokeNative(0x6BEFAA907B076859,textureId)  -- remove texture
                end
                if Skin_Table["sex"] == "mp_male" then
                    if HeadCategory == 1 then
                        CharTypeWhat = GetHashKey("mp_head_mr1_sc08_c0_000_ab")
                    elseif HeadCategory == 2 then
                        CharTypeWhat = GetHashKey("mp_head_mr1_sc02_c0_000_ab")
                    elseif HeadCategory == 3 then
                        CharTypeWhat = GetHashKey("mp_head_mr1_sc03_c0_000_ab")
                    elseif HeadCategory == 4 then
                        CharTypeWhat = GetHashKey("MP_head_fr1_sc01_c0_000_ab")
                    elseif HeadCategory == 5 then
                        CharTypeWhat = GetHashKey("mp_head_mr1_sc04_c0_000_ab")
                    elseif HeadCategory == 6 then
                        CharTypeWhat = GetHashKey("mp_head_fr1_sc05_c0_000_ab")
                    end
                else
                    if HeadCategory == 1 then
                        CharTypeWhat = GetHashKey("mp_head_fr1_sc08_c0_000_ab")
                    elseif HeadCategory == 2 then
                        CharTypeWhat = GetHashKey("mp_head_fr1_sc02_c0_000_ab")
                    elseif HeadCategory == 3 then
                        CharTypeWhat = GetHashKey("mp_head_fr1_sc03_c0_000_ab")
                    elseif HeadCategory == 4 then
                        CharTypeWhat = GetHashKey("mp_head_fr1_sc05_c0_000_ab")
                    elseif HeadCategory == 5 then
                        CharTypeWhat = GetHashKey("mp_head_fr1_sc01_c0_000_ab")
                    elseif HeadCategory == 6 then
                        CharTypeWhat = GetHashKey("mp_head_fr1_sc04_c0_000_ab")
                    end
                end
                textureId = Citizen.InvokeNative(0xC5E7204F322E49EB, CharTypeWhat, current_texture_settings.normal, current_texture_settings.material)
                for k,v in pairs(Config.overlay_all_layers) do
                    if v.visibility ~= 0 then
                        local overlay_id = Citizen.InvokeNative(0x86BB5FF45F193A02,textureId, v.tx_id , v.tx_normal, v.tx_material, v.tx_color_type, v.tx_opacity,v.tx_unk)
                        if v.tx_color_type == 0 then
                            Citizen.InvokeNative(0x1ED8588524AC9BE1,textureId,overlay_id,v.palette);    -- apply palette
                            Citizen.InvokeNative(0x2DF59FFE6FFD6044,textureId,overlay_id,v.palette_color_primary,v.palette_color_secondary,v.palette_color_tertiary)  -- apply palette colours
                        end
                        Citizen.InvokeNative(0x3329AAE2882FC8E4,textureId,overlay_id, v.var);  -- apply overlay variant
                        Citizen.InvokeNative(0x6C76BC24F8BB709A,textureId,overlay_id, v.opacity); -- apply overlay opacity
                    end
                end
                while not Citizen.InvokeNative(0x31DC8D3F216D8509,textureId) do  -- wait till texture fully loaded
                    Citizen.Wait(0)
                end
                Citizen.InvokeNative(0x0B46E25761519058,ped,`heads`,textureId)  -- apply texture to current component in category "heads"
                Citizen.InvokeNative(0x92DAABA2C1C10B0E,textureId)      -- update texture
                Citizen.InvokeNative(0xCC8CA3E88256E58F,ped, 0, 1, 1, 1, false);  -- refresh ped components
                is_overlay_change_active = false
            end
        end
    end)
end)


RegisterNetEvent('gum_characters:colors')
AddEventHandler('gum_characters:colors', function(name,visibility,tx_id,tx_normal,tx_material,tx_color_type,tx_opacity,tx_unk,palette_id,palette_color_primary,palette_color_secondary,palette_color_tertiary,var,opacity)
    for k,v in pairs(Config.overlay_all_layers) do
        if v.name==name then
            v.visibility = visibility
            if visibility ~= 0 then
                v.tx_normal = tx_normal
                v.tx_material = tx_material
                v.tx_color_type = tx_color_type
                v.tx_opacity =  tx_opacity
                v.tx_unk =  tx_unk
                if tx_color_type == 0 then
                    v.palette = Config.color_palettes[palette_id][1]
                    v.palette_color_primary = palette_color_primary
                    v.palette_color_secondary = palette_color_secondary
                    v.palette_color_tertiary = palette_color_tertiary
                end
                if name == "shadows" or name == "eyeliners" or name == "lipsticks" then
                    v.var = var
                    v.tx_id = Config.overlays_info[name][1].id
                else
                    v.var = 0 
                    v.tx_id = Config.overlays_info[name][tx_id].id
                end
                v.opacity = opacity
            end
        end
    end
    is_overlay_change_active = true
end)


function Open_Body()
	MenuData.CloseAll()
    local elements = {
        {label = ""..Config.Language[97].text.."", value = BodyType, type = 'slider', min = 1, max = 6, desc = '<img src="https://redwestrp.eu/images/creator/creator_body.png">'},
        {label = ""..Config.Language[98].text.."", value = Waist, type = 'slider', min = 1, max = 21, desc = '<img src="https://redwestrp.eu/images/creator/creator_body.png">'},
        {label = ""..Config.Language[99].text.."", value = Scale, type = 'slider', min = 90, max = 110, desc = '<img src="https://redwestrp.eu/images/creator/creator_body.png">'},
    }
   	MenuData.Open('default', GetCurrentResourceName(), 'gum_character',
	{
		title    = ''..Config.Language[6].text..'',
		subtext    = '',
		align    = 'bottom-left',
		elements = elements,
	},
	function(data, menu)
        if (data.current.value) == "face" then
            Open_Face()
        end
	end,
	function(data, menu)
        Open_Basic_Menu()
	end,
	function(data, menu)
        if data.current.label == ""..Config.Language[97].text.."" then
            for k,v in pairs(Body_Type) do
                BodyType = data.current.value
                Citizen.InvokeNative(0x1902C4CFCC5BE57C, PlayerPedId(), v[data.current.value])
                Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
                Skin_Table["BodyType"] = v[data.current.value]
            end
        end
        if data.current.label == ""..Config.Language[98].text.."" then
            for k,v in pairs(Waist_Type) do
                Waist = data.current.value
                Citizen.InvokeNative(0x1902C4CFCC5BE57C, PlayerPedId(), v[data.current.value])
                Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
                Skin_Table["Waist"] = v[data.current.value]
            end
        end
        if data.current.label == ""..Config.Language[99].text.."" then
            Scale = data.current.value
            Citizen.InvokeNative(0x25ACFC650B65C538, PlayerPedId(), data.current.value/100)
            Skin_Table["Scale"] = data.current.value/100
        end
	end)
end


function Open_ColorFace()
	MenuData.CloseAll()
    local elements = {
        {label = "<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"..Config.Language[100].text.."</b>", value = "nothing", type = 'normal'},
        {label = ""..Config.Language[101].text.."", value = scars_enable, type = 'slider', min = 0, max = 1},
        {label = ""..Config.Language[102].text.."", value = scars_texture, type = 'slider', min = 1, max = 16},
        {label = ""..Config.Language[103].text.."", value = scars_opacity, type = 'slider', min = 0, max = 10},

        {label = "<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"..Config.Language[104].text.."</b>", value = "nothing", type = 'normal'},
        {label = ""..Config.Language[105].text.."", value = spots_enable, type = 'slider', min = 0, max = 1},
        {label = ""..Config.Language[106].text.."", value = spots_texture, type = 'slider', min = 1, max = 16},
        {label = ""..Config.Language[107].text.."", value = spots_opacity, type = 'slider', min = 0, max = 10},

        {label = "<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"..Config.Language[108].text.."</b>", value = "nothing", type = 'normal'},
        {label = ""..Config.Language[109].text.."", value = disc_enable, type = 'slider', min = 0, max = 1},
        {label = ""..Config.Language[110].text.."", value = disc_texture, type = 'slider', min = 1, max = 16},
        {label = ""..Config.Language[111].text.."", value = disc_opacity, type = 'slider', min = 0, max = 10},

        {label = "<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"..Config.Language[112].text.."</b>", value = "nothing", type = 'normal'},
        {label = ""..Config.Language[113].text.."", value = complex_enable, type = 'slider', min = 0, max = 1},
        {label = ""..Config.Language[114].text.."", value = complex_texture, type = 'slider', min = 1, max = 30},
        {label = ""..Config.Language[115].text.."", value = complex_opacity, type = 'slider', min = 0, max = 10},
 
        {label = "<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"..Config.Language[116].text.."</b>", value = "nothing", type = 'normal'},
        {label = ""..Config.Language[117].text.."", value = acne_visibility, type = 'slider', min = 0, max = 1},
        {label = ""..Config.Language[118].text.."", value = acne_texture, type = 'slider', min = 1, max = 1},
        {label = ""..Config.Language[119].text.."", value = acne_opacity, type = 'slider', min = 0, max = 10},

        {label = "<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"..Config.Language[120].text.."</b>", value = "nothing", type = 'normal'},
        {label = ""..Config.Language[121].text.."", value = ageing_enable, type = 'slider', min = 0, max = 1},
        {label = ""..Config.Language[122].text.."", value = ageing_enable, type = 'slider', min = 1, max = 25},
        {label = ""..Config.Language[123].text.."", value = ageing_enable, type = 'slider', min = 0, max = 10},

        {label = "<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"..Config.Language[124].text.."</b>", value = "nothing", type = 'normal'},
        {label = ""..Config.Language[125].text.."", value = freckles_enable, type = 'slider', min = 0, max = 1},
        {label = ""..Config.Language[126].text.."", value = freckles_texture, type = 'slider', min = 1, max = 15},
        {label = ""..Config.Language[127].text.."", value = freckles_opacity, type = 'slider', min = 0, max = 10},

        {label = "<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"..Config.Language[128].text.."</b>", value = "nothing", type = 'normal'},
        {label = ""..Config.Language[129].text.."", value = moles_enable, type = 'slider', min = 0, max = 1},
        {label = ""..Config.Language[130].text.."", value = moles_texture, type = 'slider', min = 1, max = 16},
        {label = ""..Config.Language[131].text.."", value = moles_opacity, type = 'slider', min = 0, max = 10},

        {label = "<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"..Config.Language[132].text.."</b>", value = "nothing", type = 'normal'},
        {label = ""..Config.Language[133].text.."", value = eyebrows_enable, type = 'slider', min = 0, max = 1},
        {label = ""..Config.Language[134].text.."", value = eyebrows_texture, type = 'slider', min = 1, max = 24},
        {label = ""..Config.Language[135].text.."", value = eyebrows_opacity, type = 'slider', min = 0, max = 10},
        {label = ""..Config.Language[136].text.."", value = eyebrows_color_1, type = 'slider', min = 0, max = 255},

        {label = "<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"..Config.Language[137].text.."</b>", value = "nothing", type = 'normal'},
        {label = ""..Config.Language[138].text.."", value = lipsticks_enable, type = 'slider', min = 0, max = 1},
        {label = ""..Config.Language[139].text.."", value = lipsticks_texture, type = 'slider', min = 1, max = 7},
        {label = ""..Config.Language[140].text.."", value = lipsticks_opacity, type = 'slider', min = 0, max = 10},
        {label = ""..Config.Language[141].text.."", value = lipsticks_color_1, type = 'slider', min = 0, max = 255},
        {label = ""..Config.Language[142].text.."", value = lipsticks_color_2, type = 'slider', min = 0, max = 255},
        {label = ""..Config.Language[143].text.."", value = lipsticks_color_3, type = 'slider', min = 0, max = 255},

        {label = "<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"..Config.Language[144].text.."</b>", value = "nothing", type = 'normal'},
        {label = ""..Config.Language[145].text.."", value = shadow_enable, type = 'slider', min = 0, max = 1},
        {label = ""..Config.Language[146].text.."", value = shadow_texture, type = 'slider', min = 1, max = 5},
        {label = ""..Config.Language[147].text.."", value = shadow_opacity, type = 'slider', min = 0, max = 10},
        {label = ""..Config.Language[148].text.."", value = shadow_color_1, type = 'slider', min = 0, max = 255},
        {label = ""..Config.Language[149].text.."", value = shadow_color_2, type = 'slider', min = 0, max = 255},
        {label = ""..Config.Language[150].text.."", value = shadow_color_3, type = 'slider', min = 0, max = 255},

        {label = "<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"..Config.Language[151].text.."</b>", value = "nothing", type = 'normal'},
        {label = ""..Config.Language[152].text.."", value = eyeliners_enable, type = 'slider', min = 0, max = 1},
        {label = ""..Config.Language[153].text.."", value = eyeliners_texture, type = 'slider', min = 1, max = 7},
        {label = ""..Config.Language[154].text.."", value = eyeliners_opacity, type = 'slider', min = 0, max = 10},
        {label = ""..Config.Language[155].text.."", value = eyeliners_color_1, type = 'slider', min = 0, max = 255},

        {label = "<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"..Config.Language[158].text.."</b>", value = "nothing", type = 'normal'},
        {label = ""..Config.Language[159].text.."", value = blush_enable, type = 'slider', min = 0, max = 1},
        {label = ""..Config.Language[160].text.."", value = blush_texture, type = 'slider', min = 1, max = 4},
        {label = ""..Config.Language[161].text.."", value = blush_opacity, type = 'slider', min = 0, max = 10},
        {label = ""..Config.Language[162].text.."", value = blush_color_1, type = 'slider', min = 0, max = 255},

        {label = "<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"..Config.Language[178].text.."</b>", value = "nothing", type = 'normal'},
        {label = ""..Config.Language[179].text.."", value = beardstabble_enable, type = 'slider', min = 0, max = 1},
        {label = ""..Config.Language[180].text.."", value = beardstabble_texture, type = 'slider', min = 1, max = 1},
        {label = ""..Config.Language[181].text.."", value = beardstabble_opacity, type = 'slider', min = 0, max = 10},
        {label = ""..Config.Language[182].text.."", value = beardstabble_color_1, type = 'slider', min = 0, max = 255},
      }
   	MenuData.Open('default', GetCurrentResourceName(), 'gum_character',
	{
		title    = ''..Config.Language[5].text..'',
		subtext    = '',
		align    = 'bottom-left',
		elements = elements,
	},
	function(data, menu)
	end,
	function(data, menu)
        Open_Basic_Menu()
	end,
	function(data, menu)
        if(data.current.label) == ""..Config.Language[179].text.."" then
            beardstabble_enable = data.current.value
            TriggerEvent("gum_characters:colors", "beardstabble",beardstabble_enable, beardstabble_texture,1,0,0,1.0,0,1,beardstabble_color_1,0,0,1,beardstabble_opacity/10)
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
            Skin_Table["beardstabble_visibility"] = beardstabble_enable
        end
        if(data.current.label) == ""..Config.Language[180].text.."" then
            beardstabble_texture = data.current.value
            TriggerEvent("gum_characters:colors", "beardstabble",beardstabble_enable,beardstabble_texture,1,0,0,1.0,0,1,beardstabble_color_1,0,0,1,beardstabble_opacity/10)
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
            Skin_Table["beardstabble_tx_id"] = beardstabble_texture
        end
        if(data.current.label) ==  ""..Config.Language[181].text.."" then
            beardstabble_opacity = data.current.value
            TriggerEvent("gum_characters:colors", "beardstabble",beardstabble_enable,beardstabble_texture,1,0,0,1.0,0,1,beardstabble_color_1,0,0,1,beardstabble_opacity/10)
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
            Skin_Table["beardstabble_opacity"] = beardstabble_opacity/10
		end
        if(data.current.label) == ""..Config.Language[182].text.."" then
            beardstabble_color_1 = data.current.value
            TriggerEvent("gum_characters:colors", "beardstabble",beardstabble_enable,beardstabble_texture,1,0,0,1.0,0,1,beardstabble_color_1,0,0,1,beardstabble_opacity/10)
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
            Skin_Table["beardstabble_color_1"] = beardstabble_color_1
		end


        if data.current.label == ""..Config.Language[101].text.."" then
            scars_visibility = data.current.value
            TriggerEvent("gum_characters:colors", "scars", scars_visibility, scars_texture, 0, 0, 1, 1.0, 0, 0, 0, 0, 0, 1, scars_opacity/10);
            Skin_Table["scars_visibility"] = scars_visibility
        end
        if data.current.label == ""..Config.Language[102].text.."" then
            scars_texture = data.current.value
            TriggerEvent("gum_characters:colors", "scars", scars_visibility, scars_texture, 0, 0, 1, 1.0, 0, 0, 0, 0, 0, 1, scars_opacity/10);
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
            Skin_Table["scars_tx_id"] = scars_texture
        end
        if data.current.label == ""..Config.Language[103].text.."" then
            scars_opacity = data.current.value
            TriggerEvent("gum_characters:colors", "scars", scars_visibility, scars_texture, 0, 0, 1, 1.0, 0, 0, 0, 0, 0, 1, scars_opacity/10);
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
            Skin_Table["scars_opacity"] = scars_opacity/10
        end
        if data.current.label == ""..Config.Language[105].text.."" then
            spots_visibility = data.current.value
            TriggerEvent("gum_characters:colors", "spots", spots_visibility, spots_texture, 0, 0, 1, 1.0, 0, 0, 0, 0, 0, 1, spots_opacity/10);
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
            Skin_Table["spots_visibility"] = spots_visibility
        end
        if data.current.label == ""..Config.Language[106].text.."" then
            spots_texture = data.current.value
            TriggerEvent("gum_characters:colors", "spots", spots_visibility, spots_texture, 0, 0, 1, 1.0, 0, 0, 0, 0, 0, 1, spots_opacity/10);
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
            Skin_Table["spots_tx_id"] = spots_texture
        end
        if data.current.label == ""..Config.Language[107].text.."" then
            spots_opacity = data.current.value
            TriggerEvent("gum_characters:colors", "spots", spots_visibility, spots_texture, 0, 0, 1, 1.0, 0, 0, 0, 0, 0, 1, spots_opacity/10);
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
            Skin_Table["spots_opacity"] = spots_opacity/10
        end
        if data.current.label == ""..Config.Language[109].text.."" then
            disc_visibility = data.current.value
            TriggerEvent("gum_characters:colors", "disc", disc_visibility, disc_texture, 0, 0, 1, 1.0, 0, 0, 0, 0, 0, 1, disc_opacity/10);
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
            Skin_Table["disc_visibility"] = disc_visibility
        end
        if data.current.label == ""..Config.Language[110].text.."" then
            disc_texture = data.current.value
            TriggerEvent("gum_characters:colors", "disc", disc_visibility, disc_texture, 0, 0, 1, 1.0, 0, 0, 0, 0, 0, 1, disc_opacity/10);
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
            Skin_Table["disc_tx_id"] = disc_texture
        end
        if data.current.label == ""..Config.Language[111].text.."" then
            disc_opacity = data.current.value
            TriggerEvent("gum_characters:colors", "disc", disc_visibility, disc_texture, 0, 0, 1, 1.0, 0, 0, 0, 0, 0, 1, disc_opacity/10);
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
            Skin_Table["disc_opacity"] = disc_opacity/10
        end
        if data.current.label == ""..Config.Language[117].text.."" then
            acne_visibility = data.current.value
            TriggerEvent("gum_characters:colors", "acne", acne_visibility, acne_texture, 0, 0, 1, 1.0, 0, 0, 0, 0, 0, 1, acne_opacity/10);
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
            Skin_Table["acne_visibility"] = acne_visibility
        end
        if data.current.label == ""..Config.Language[118].text.."" then
            acne_texture = data.current.value
            TriggerEvent("gum_characters:colors", "acne", acne_visibility, acne_texture, 0, 0, 1, 1.0, 0, 0, 0, 0, 0, 1, acne_opacity/10);
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
            Skin_Table["acne_tx_id"] = acne_texture
        end
        if data.current.label == ""..Config.Language[119].text.."" then
            acne_opacity = data.current.value
            TriggerEvent("gum_characters:colors", "acne", acne_visibility, acne_texture, 0, 0, 1, 1.0, 0, 0, 0, 0, 0, 1, acne_opacity/10);
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
            Skin_Table["acne_opacity"] = acne_opacity/10
        end
        if data.current.label == ""..Config.Language[121].text.."" then
            ageing_visibility = data.current.value
            TriggerEvent("gum_characters:colors", "ageing", ageing_visibility, ageing_texture, 0, 0, 1, 1.0, 0, 0, 0, 0, 0, 1, ageing_opacity/10);
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
            Skin_Table["ageing_visibility"] = ageing_visibility
        end
        if data.current.label == ""..Config.Language[122].text.."" then
            ageing_texture = data.current.value
            TriggerEvent("gum_characters:colors", "ageing", ageing_visibility, ageing_texture, 0, 0, 1, 1.0, 0, 0, 0, 0, 0, 1, ageing_opacity/10);
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
            Skin_Table["ageing_tx_id"] = ageing_texture
        end
        if data.current.label == ""..Config.Language[123].text.."" then
            ageing_opacity = data.current.value
            TriggerEvent("gum_characters:colors", "ageing", ageing_visibility, ageing_texture, 0, 0, 1, 1.0, 0, 0, 0, 0, 0, 1, ageing_opacity/10);
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
            Skin_Table["ageing_opacity"] = ageing_opacity/10
        end

       if data.current.label == ""..Config.Language[125].text.."" then
            freckles_visibility = data.current.value
            TriggerEvent("gum_characters:colors", "freckles", freckles_visibility, freckles_texture, 0, 0, 1, 1.0, 0, 0, 0, 0, 0, 1, freckles_opacity/10);
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
            Skin_Table["freckles_visibility"] = freckles_visibility
        end
        if data.current.label == ""..Config.Language[126].text.."" then
            freckles_texture = data.current.value
            TriggerEvent("gum_characters:colors", "freckles", freckles_visibility, freckles_texture, 0, 0, 1, 1.0, 0, 0, 0, 0, 0, 1, freckles_opacity/10);
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
            Skin_Table["freckles_tx_id"] = freckles_texture
        end
        if data.current.label == ""..Config.Language[127].text.."" then
            freckles_opacity = data.current.value
            TriggerEvent("gum_characters:colors", "freckles", freckles_visibility, freckles_texture, 0, 0, 1, 1.0, 0, 0, 0, 0, 0, 1, freckles_opacity/10);
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
            Skin_Table["freckles_opacity"] = freckles_opacity/10
        end
       if data.current.label == ""..Config.Language[129].text.."" then
            moles_visibility = data.current.value
            TriggerEvent("gum_characters:colors", "moles", moles_visibility, moles_texture, 0, 0, 1, 1.0, 0, 0, 0, 0, 0, 1, moles_opacity/10);
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
            Skin_Table["moles_visibility"] = moles_visibility
        end
        if data.current.label == ""..Config.Language[130].text.."" then
            moles_texture = data.current.value
            TriggerEvent("gum_characters:colors", "moles", moles_visibility, moles_texture, 0, 0, 1, 1.0, 0, 0, 0, 0, 0, 1, moles_opacity/10);
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
            Skin_Table["moles_tx_id"] = moles_texture
        end
        if data.current.label == ""..Config.Language[131].text.."" then
            moles_opacity = data.current.value
            TriggerEvent("gum_characters:colors", "moles", moles_visibility, moles_texture, 0, 0, 1, 1.0, 0, 0, 0, 0, 0, 1, moles_opacity/10);
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
            Skin_Table["moles_opacity"] = moles_opacity/10
        end
      if data.current.label == ""..Config.Language[113].text.."" then
            complex_visibility = data.current.value
            TriggerEvent("gum_characters:colors", "complex", complex_visibility, complex_texture, 0, 0, 1, 1.0, 0, 0, 0, 0, 0, 1, complex_opacity/10);
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
            Skin_Table["complex_visibility"] = complex_visibility
        end
        if data.current.label == ""..Config.Language[114].text.."" then
            complex_texture = data.current.value
            TriggerEvent("gum_characters:colors", "complex", complex_visibility, complex_texture, 0, 0, 1, 1.0, 0, 0, 0, 0, 0, 1, complex_opacity/10);
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
            Skin_Table["complex_tx_id"] = complex_texture
        end
        if data.current.label == ""..Config.Language[115].text.."" then
            complex_opacity = data.current.value
            TriggerEvent("gum_characters:colors", "complex", complex_visibility, complex_texture, 0, 0, 1, 1.0, 0, 0, 0, 0, 0, 1, complex_opacity/10);
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
            Skin_Table["complex_opacity"] = complex_opacity/10
        end
        if(data.current.label) == ""..Config.Language[133].text.."" then
            eyebrows_enable = data.current.value
            TriggerEvent("gum_characters:colors", "eyebrows",eyebrows_enable, eyebrows_texture,1,0,0,1.0,0,1,eyebrows_color_1,0,0,1,eyebrows_opacity/10)
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
            Skin_Table["eyebrows_visibility"] = eyebrows_enable
        end
        if(data.current.label) == ""..Config.Language[134].text.."" then
            eyebrows_texture = data.current.value
            TriggerEvent("gum_characters:colors", "eyebrows",eyebrows_enable,eyebrows_texture,1,0,0,1.0,0,1,eyebrows_color_1,0,0,1,eyebrows_opacity/10)
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
            Skin_Table["eyebrows_tx_id"] = eyebrows_texture
        end
        if(data.current.label) == ""..Config.Language[135].text.."" then
            eyebrows_opacity = data.current.value
            TriggerEvent("gum_characters:colors", "eyebrows",eyebrows_enable,eyebrows_texture,1,0,0,1.0,0,1,eyebrows_color_1,0,0,1,eyebrows_opacity/10)
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
            Skin_Table["eyebrows_opacity"] = eyebrows_opacity/10
		end
        if(data.current.label) == ""..Config.Language[136].text.."" then
            eyebrows_color_1 = data.current.value
            TriggerEvent("gum_characters:colors", "eyebrows",eyebrows_enable,eyebrows_texture,1,0,0,1.0,0,1,eyebrows_color_1,0,0,1,eyebrows_opacity/10)
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
            Skin_Table["eyebrows_color"] = eyebrows_color_1
        end
         if(data.current.label) == ""..Config.Language[159].text.."" then
            blush_enable = data.current.value
            TriggerEvent("gum_characters:colors", "blush",blush_enable, blush_texture,1,0,0,1.0,0,1,blush_color_1,0,0,1,blush_opacity/10)
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
            Skin_Table["blush_visibility"] = blush_enable
        end
        if(data.current.label) == ""..Config.Language[160].text.."" then
            blush_texture = data.current.value
            TriggerEvent("gum_characters:colors", "blush",blush_enable,blush_texture,1,0,0,1.0,0,1,blush_color_1,0,0,1,blush_opacity/10)
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
            Skin_Table["blush_tx_id"] = blush_texture
        end
        if(data.current.label) == ""..Config.Language[161].text.."" then
            blush_opacity = data.current.value
            TriggerEvent("gum_characters:colors", "blush",blush_enable,blush_texture,1,0,0,1.0,0,1,blush_color_1,0,0,1,blush_opacity/10)
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
            Skin_Table["blush_opacity"] = blush_opacity/10
		end
        if(data.current.label) == ""..Config.Language[162].text.."" then
            blush_color_1 = data.current.value
            TriggerEvent("gum_characters:colors", "blush",blush_enable,blush_texture,1,0,0,1.0,0,1,blush_color_1,0,0,1,blush_opacity/10)
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
            Skin_Table["blush_color_1"] = blush_color_1
		end
       if(data.current.label) == ""..Config.Language[152].text.."" then
            eyeliners_enable = data.current.value
            TriggerEvent("gum_characters:colors", "eyeliners",eyeliners_enable, 1,1,0,0,1.0,0,1,eyeliners_color_1,0,0,eyeliners_texture,eyeliners_opacity/10)
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
            Skin_Table["eyeliners_visibility"] = eyeliners_enable
        end
        if(data.current.label) == ""..Config.Language[153].text.."" then
            eyeliners_texture = data.current.value
            TriggerEvent("gum_characters:colors", "eyeliners",eyeliners_enable,1,1,0,0,1.0,0,1,eyeliners_color_1,0,0,eyeliners_texture,eyeliners_opacity/10)
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
            Skin_Table["eyeliners_tx_id"] = eyeliners_texture
        end
        if(data.current.label) == ""..Config.Language[154].text.."" then
            eyeliners_opacity = data.current.value
            TriggerEvent("gum_characters:colors", "eyeliners",eyeliners_enable,1,1,0,0,1.0,0,1,eyeliners_color_1,0,0,eyeliners_texture,eyeliners_opacity/10)
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
            Skin_Table["eyeliners_opacity"] = eyeliners_opacity/10
		end
        if(data.current.label) == ""..Config.Language[155].text.."" then
            eyeliners_color_1 = data.current.value
            TriggerEvent("gum_characters:colors", "eyeliners",eyeliners_enable,1,1,0,0,1.0,0,1,eyeliners_color_1,0,0,eyeliners_texture,eyeliners_opacity/10)
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
            Skin_Table["eyeliners_color_1"] = eyeliners_color_1
        end
        
        if(data.current.label) == ""..Config.Language[138].text.."" then
            lipsticks_enable = data.current.value
            TriggerEvent("gum_characters:colors", "lipsticks",lipsticks_enable,1,1,0,0,1.0,0,1,lipsticks_color_1,lipsticks_color_2,lipsticks_color_3,lipsticks_texture,lipsticks_opacity/10)
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
            Skin_Table["lipsticks_visibility"] = lipsticks_enable
        end
        if(data.current.label) == ""..Config.Language[139].text.."" then
            lipsticks_texture = data.current.value
            TriggerEvent("gum_characters:colors", "lipsticks",lipsticks_enable,1,1,0,0,1.0,0,1,lipsticks_color_1,lipsticks_color_2,lipsticks_color_3,lipsticks_texture,lipsticks_opacity/10)
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
            Skin_Table["lipsticks_tx_id"] = lipsticks_texture
        end
        if(data.current.label) == ""..Config.Language[140].text.."" then
            lipsticks_opacity = data.current.value
            TriggerEvent("gum_characters:colors", "lipsticks",lipsticks_enable,1,1,0,0,1.0,0,1,lipsticks_color_1,lipsticks_color_2,lipsticks_color_3,lipsticks_texture,lipsticks_opacity/10)
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
            Skin_Table["lipsticks_opacity"] = lipsticks_opacity/10
        end
        if(data.current.label) == ""..Config.Language[141].text.."" then
            lipsticks_color_1 = data.current.value
            TriggerEvent("gum_characters:colors", "lipsticks",lipsticks_enable,1,1,0,0,1.0,0,1,lipsticks_color_1,lipsticks_color_2,lipsticks_color_3,lipsticks_texture,lipsticks_opacity/10)
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
            Skin_Table["lipsticks_color_1"] = lipsticks_color_1
        end
        if(data.current.label) == ""..Config.Language[142].text.."" then
            lipsticks_color_2 = data.current.value
            TriggerEvent("gum_characters:colors", "lipsticks",lipsticks_enable,1,1,0,0,1.0,0,1,lipsticks_color_1,lipsticks_color_2,lipsticks_color_3,lipsticks_texture,lipsticks_opacity/10)
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
            Skin_Table["lipsticks_color_2"] = lipsticks_color_2
        end
        if(data.current.label) == ""..Config.Language[143].text.."" then
            lipsticks_color_3 = data.current.value
            TriggerEvent("gum_characters:colors", "lipsticks",lipsticks_enable,1,1,0,0,1.0,0,1,lipsticks_color_1,lipsticks_color_2,lipsticks_color_3,lipsticks_texture,lipsticks_opacity/10)
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
            Skin_Table["lipsticks_color_3"] = lipsticks_color_3
        end

        if(data.current.label) == ""..Config.Language[145].text.."" then
            shadow_enable = data.current.value
            TriggerEvent("gum_characters:colors", "shadows",shadow_enable,1,1,0,0,1.0,0,1,shadow_color_1,shadow_color_2,shadow_color_3,shadow_texture,shadow_opacity/10)
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
            Skin_Table["shadows_visibility"] = shadow_enable
        end
        if(data.current.label) == ""..Config.Language[146].text.."" then
            shadow_texture = data.current.value
            TriggerEvent("gum_characters:colors", "shadows",shadow_enable,1,1,0,0,1.0,0,1,shadow_color_1,shadow_color_2,shadow_color_3,shadow_texture,shadow_opacity/10)
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
            Skin_Table["shadows_tx_id"] = shadow_texture
        end
        if(data.current.label) == ""..Config.Language[147].text.."" then
            shadow_opacity = data.current.value
            TriggerEvent("gum_characters:colors", "shadows",shadow_enable,1,1,0,0,1.0,0,1,shadow_color_1,shadow_color_2,shadow_color_3,shadow_texture,shadow_opacity/10)
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
            Skin_Table["shadows_opacity"] = shadow_opacity/10
		end
        if(data.current.label) == ""..Config.Language[148].text.."" then
            shadow_color_1 = data.current.value
            TriggerEvent("gum_characters:colors", "shadows",shadow_enable,1,1,0,0,1.0,0,1,shadow_color_1,shadow_color_2,shadow_color_3,shadow_texture,shadow_opacity/10)
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
            Skin_Table["shadows_color_1"] = shadow_color_1
		end
        if(data.current.label) == ""..Config.Language[149].text.."" then
            shadow_color_2 = data.current.value
            TriggerEvent("gum_characters:colors", "shadows",shadow_enable,1,1,0,0,1.0,0,1,shadow_color_1,shadow_color_2,shadow_color_3,shadow_texture,shadow_opacity/10)
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
            Skin_Table["shadows_color_2"] = shadow_color_2
		end
        if(data.current.label) == ""..Config.Language[150].text.."" then
            shadow_color_3 = data.current.value
            TriggerEvent("gum_characters:colors", "shadows",shadow_enable,1,1,0,0,1.0,0,1,shadow_color_1,shadow_color_2,shadow_color_3,shadow_texture,shadow_opacity/10)
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
            Skin_Table["shadows_color_3"] = shadow_color_3
		end

	end)
end

function Open_Basic()
	MenuData.CloseAll()
    local elements = {
        {label = ""..Config.Language[163].text.."", value = HeadCategory, type = 'slider', min = 1, max = 6, desc = '<img src="https://redwestrp.eu/images/creator/creator_aperace.png">'},
        {label = ""..Config.Language[164].text.."", value = HeadTexture, type = 'slider', min = 1, max = 12, desc = '<img src="https://redwestrp.eu/images/creator/creator_aperace.png">'},
        {label = ""..Config.Language[165].text.."", value = BodyTexture, type = 'slider', min = 1, max = 5, desc = '<img src="https://redwestrp.eu/images/creator/creator_aperace.png">'},
        {label = ""..Config.Language[166].text.."", value = LegsTexture, type = 'slider', min = 1, max = 5, desc = '<img src="https://redwestrp.eu/images/creator/creator_aperace.png">'},
    }
   	MenuData.Open('default', GetCurrentResourceName(), 'gum_character',
	{
		title    = ''..Config.Language[3].text..'',
		subtext    = '',
		align    = 'bottom-left',
		elements = elements,
	},
	function(data, menu)
	end,
	function(data, menu)
        Open_Basic_Menu()
	end,
	function(data, menu)
        if data.current.label == ""..Config.Language[163].text.."" then
            if head_type ~= data.current.value then
                head_type = data.current.value
                Style_Head_Type("Heads", data.current.value, char_text)
                Skin_Table["Nation"] = data.current.value
            end
            if HeadCategory ~= data.current.value then
                HeadCategory = data.current.value
            end
            --Style_Head_Texture("Heads", data.current.value, char_text, head_type)
            --Style_Body_Texture("Body", data.current.value, char_text, head_type)
            --Style_Legs_Texture("Legs", data.current.value, char_text, head_type)
        end
        if data.current.label == ""..Config.Language[164].text.."" then
            HeadTexture = data.current.value
            Style_Head_Texture("Heads", data.current.value, char_text, head_type)
        end
        if data.current.label == ""..Config.Language[165].text.."" then
            BodyTexture = data.current.value
            Style_Body_Texture("Body", data.current.value, char_text, head_type)
        end
        if data.current.label == ""..Config.Language[166].text.."" then
            LegsTexture = data.current.value
            Style_Legs_Texture("Legs", data.current.value, char_text, head_type)
        end
	end)
end

function Style_Head_Type(what_type, number_val, gender) 
    if gender == Config.Language[175].text then
        for k,v in pairs(Config.DefaultChar["Male"][number_val]) do
            if k == what_type then
                for x,y in pairs(v) do
                    if x == 1 then
                        local hash = ("0x"..y)
                        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash), true, true, true)
                        Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
                    end
                end
            end
        end
    else
        for k,v in pairs(Config.DefaultChar["Female"][number_val]) do
            if k == what_type then
                for x,y in pairs(v) do
                    if x == 1 then
                        local hash = ("0x"..y)
                        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash), true, true, true)
                        Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
                    end
                end
            end
        end
    end
end

function Style_Head_Texture(what_type, number_val, gender, head_type) 
    if gender == Config.Language[175].text then
        for k,v in pairs(Config.DefaultChar["Male"][head_type]) do
            if k == what_type then
                for x,y in pairs(v) do
                    if x == number_val then
                        local hash = ("0x"..y)
                        Skin_Table["HeadType"] = tonumber(hash)
                        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash), true, true, true)
                        Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
                    end
                end
            end
        end
    else
        for k,v in pairs(Config.DefaultChar["Female"][head_type]) do
            if k == what_type then
                for x,y in pairs(v) do
                    if x == number_val then
                        local hash_2 = ("0x"..y)
                        Skin_Table["HeadType"] = tonumber(hash_2)
                        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash_2), true, true, true)
                        Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
                    end
                end
            end
        end
    end
end


function Style_Body_Texture(what_type, number_val, gender, head_type) 
    if gender == Config.Language[175].text then
        for k,v in pairs(Config.DefaultChar["Male"][head_type]) do
            if k == what_type then
                for x,y in pairs(v) do
                    if x == number_val then
                        local hash = ("0x"..y)
                        Skin_Table["Body"] = tonumber(hash)
                        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash), true, true, true)
                        Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
                    end
                end
            end
        end
    else
        for k,v in pairs(Config.DefaultChar["Female"][head_type]) do
            if k == what_type then
                for x,y in pairs(v) do
                    if x == number_val then
                        local hash = ("0x"..y)
                        Skin_Table["Body"] = tonumber(hash)
                        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash), true, true, true)
                        Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
                    end
                end
            end
        end
    end
end

function Style_Legs_Texture(what_type, number_val, gender, head_type) 
    if gender == Config.Language[175].text then
        for k,v in pairs(Config.DefaultChar["Male"][head_type]) do
            if k == what_type then
                for x,y in pairs(v) do
                    if x == number_val then
                        local hash = ("0x"..y)
                        Skin_Table["LegsType"] = tonumber(hash)
                        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash), true, true, true)
                        Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
                    end
                end
            end
        end
    else
        for k,v in pairs(Config.DefaultChar["Female"][head_type]) do
            if k == what_type then
                for x,y in pairs(v) do
                    if x == number_val then
                        local hash = ("0x"..y)
                        Skin_Table["LegsType"] = tonumber(hash)
                        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash), true, true, true)
                        Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
                    end
                end
            end
        end
    end
end

function SelectChar()
    Citizen.CreateThread(function()
        local ModelFemale = "mp_female"
        while not HasModelLoaded( ModelFemale ) do
            Wait(10)
            Citizen.CreateThread(function()
                RequestModel( ModelFemale )
            end)
        end
        PedFemale = CreatePed(GetHashKey("mp_female"), -558.43, -3776.65, 237.7, 93.2, false, true, true, true)
        while not DoesEntityExist(PedFemale) do
            Wait(500)
        end
        local ModelMale = "mp_male"
        while not HasModelLoaded(ModelMale) do
            Wait(10)
            Citizen.CreateThread(function()
                RequestModel(ModelMale)
            end)
        end
        PedMale = CreatePed(GetHashKey("mp_male"), -558.52, -3775.6, 237.7, 93.2, false, true, true, true)
        while not DoesEntityExist(PedMale) do
            Wait(500)
        end

        Citizen.InvokeNative(0x283978A15512B2FE, PedFemale, true)
        ApplyDefaultSkinCanaryEdition(PedFemale)
        Citizen.InvokeNative(0x283978A15512B2FE, PedMale, true)
        ApplyDefaultSkinCanaryEdition(PedMale)
    end)
end
function SetModel(name)
	local model = GetHashKey(name)
	local player = PlayerId()
	
	if not IsModelValid(model) then
        return
    end
	PerformRequest(model)
	
	if HasModelLoaded(model) then
		Citizen.InvokeNative(0xED40380076A31506, player, model, false)
		Citizen.InvokeNative(0x283978A15512B2FE, PlayerPedId(), true)
		SetModelAsNoLongerNeeded(model)
	end
end

function SetClotheModel(name)
	local model = GetHashKey(name)
	local player = PlayerId()
	
	if not IsModelValid(model) then
        return
    end
	PerformRequest(model)
	
	if HasModelLoaded(model) then
		Citizen.InvokeNative(0xED40380076A31506, player, model, false)
		Citizen.InvokeNative(0x283978A15512B2FE, PlayerPedId(), true)
		SetModelAsNoLongerNeeded(model)
	end
end
function PerformRequest(hash)
    RequestModel(hash, 0)
    local bacon = 1
    while not Citizen.InvokeNative(0x1283B8B89DD5D1B6, hash) do
        Citizen.InvokeNative(0xFA28FE3A6246FC30, hash, 0)
        bacon = bacon + 1
        Citizen.Wait(50)
        if bacon >= 100 then break end
    end
end

function TakeCharacter(gender)
    Citizen.CreateThread(function()
        if gender == Config.Language[175].text then
            SetModel("mp_male")
            ApplyDefaultSkinCanaryEdition_2(PlayerPedId(), gender)
            Citizen.Wait(50)
            SetEntityCoords(PlayerPedId(), -563.37, -3782.20, 237.7)
            SetEntityHeading(PlayerPedId(), -89.36)
            StartCam(-561.86, -3782.36, 239.35, 88.00, 50.0)
            Citizen.InvokeNative(0x283978A15512B2FE, PlayerPedId(), true)
        else
            SetModel("mp_female")
            ApplyDefaultSkinCanaryEdition_2(PlayerPedId(), gender)
            Citizen.Wait(50)
            SetEntityCoords(PlayerPedId(), -563.37, -3782.20, 237.7)
            SetEntityHeading(PlayerPedId(), -89.36)
            StartCam(-561.86, -3782.36, 239.35, 88.00, 50.0)
            Citizen.InvokeNative(0x283978A15512B2FE, PlayerPedId(), true)
       end
    end)
end


function ApplyDefaultSkinCanaryEdition_2(ped, gender)
    DeletePed(PlayerPedId())
    if tostring(gender) == Config.Language[175].text then
        SetModel("mp_male")
        for k,v in pairs(Config.DefaultChar["Male"]) do
            if k == 1 then
                for x,y in pairs(v) do
                    Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), 612262189, true, true, true);
                    if x == "Heads" then
                        local hash = ("0x"..y[1])
                        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash), true, true, true)
                    end
                    if x == "Body" then
                        local hash = ("0x"..y[1])
                        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash), true, true, true)

                    end
                    if x == "Legs" then
                        local hash = ("0x"..y[1])
                        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash), true, true, true)

                    end
                    if x == "HeadTexture" then
                        local hash = ("0x"..y[1])
                        Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), tonumber(hash), 0)

                    end
                    Citizen.Wait(10)
                    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
                    while not Citizen.InvokeNative(0x31DC8D3F216D8509,tonumber(hash)) do
                        Citizen.Wait(0)
                    end
                end
            end
        end
        Citizen.Wait(100)
        Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    else
        SetModel("mp_female")
        for k,v in pairs(Config.DefaultChar["Female"]) do
            if k == 1 then
                for x,y in pairs(v) do
                    Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), 928002221, true, true, true);
                    if x == "Heads" then
                        local hash = ("0x"..y[1])
                        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash), true, true, true);
                    end
                    if x == "Body" then
                        local hash = ("0x"..y[1])
                        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash), true, true, true);
                    end
                    if x == "Legs" then
                        local hash = ("0x"..y[1])
                        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash), true, true, true);
                    end
                    if x == "HeadTexture" then
                        local hash = ("0x"..y[1])
                        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash), true, true, true);
                    end
                    Citizen.Wait(10)
                end
            end
        end
        Citizen.Wait(100)
        Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    end
end


function ApplyDefaultSkinCanaryEdition(ped)
    if IsPedMale(ped) then
        for k,v in pairs(Config.DefaultChar["Male"]) do
            if k == 1 then
                for x,y in pairs(v) do
                    Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, 612262189, true, true, true);
                    if x == "Body" then
                        local hash = ("0x"..y[1])
                        Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, tonumber(hash), true, true, true)
                    end
                    Citizen.Wait(100)
                    if x == "Legs" then
                        local hash = ("0x"..y[1])
                        Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, tonumber(hash), true, true, true)
                    end
                    Citizen.Wait(100)
                    if x == "Heads" then
                        local hash = ("0x"..y[1])
                        Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, tonumber(hash), true, true, true)
                    end
                    Citizen.Wait(100)
                    if x == "HeadTexture" then
                        local hash = ("0x"..y[1])
                        Citizen.InvokeNative(0xD710A5007C2AC539, ped, tonumber(hash), 0)
                        Citizen.Wait(50)
                    end
                    Citizen.Wait(100)
                    Citizen.InvokeNative(0xCC8CA3E88256E58F, ped, 0, 1, 1, 1, false)
                end
            end
        end
        Citizen.InvokeNative(0xCC8CA3E88256E58F, ped, 0, 1, 1, 1, false)
    else
        for k,v in pairs(Config.DefaultChar["Female"]) do
            if k == 1 then
                for x,y in pairs(v) do
                    Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, 928002221, true, true, true);
                    if x == "Body" then
                        local hash = ("0x"..y[1])
                        Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, tonumber(hash), true, true, true);
                    end
                    Citizen.Wait(100)
                    if x == "Legs" then
                        local hash = ("0x"..y[1])
                        Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, tonumber(hash), true, true, true);
                    end
                    Citizen.Wait(100)
                    if x == "Heads" then
                        local hash = ("0x"..y[1])
                        Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, tonumber(hash), true, true, true);
                    end
                    Citizen.Wait(100)
                    if x == "HeadTexture" then
                        local hash = ("0x"..y[1])
                        Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, tonumber(hash), true, true, true);
                    end
                    Citizen.Wait(100)
                end
            end
        end

        Citizen.InvokeNative(0xCC8CA3E88256E58F, ped, 0, 1, 1, 1, false)
    end

end

function StartCam(x,y,z, heading, zoom)
    Citizen.InvokeNative(0x17E0198B3882C2CB, PlayerPedId())
    DestroyAllCams(true)
    local camera_pos = GetObjectOffsetFromCoords(x,y,z ,0.0 ,1.0, 1.0, 1.0)
    camera = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", x,y,z, -10.0, 00.00, heading, zoom, true, 0)
    SetCamActive(camera,true)
    RenderScriptCams(true, true, 500, true, true)
end

function EndCam()
    RenderScriptCams(false, true, 1000, true, false)
    DestroyCam(camera, false)
    camera = nil
    DestroyAllCams(true)
    Citizen.InvokeNative(0xD0AFAFF5A51D72F7, PlayerPedId())
end

AddEventHandler('onResourceStop', function(resourceName)
	if (GetCurrentResourceName() == resourceName) then
        DeletePed(PedFemale)
        DeletePed(PedMale)
        MenuData.CloseAll()
        Citizen.InvokeNative(0x431E3AB760629B34, 183712523)
        Citizen.InvokeNative(0x431E3AB760629B34, -1699673416)
        Citizen.InvokeNative(0x431E3AB760629B34, 1679934574)
	end
end)

function CheckControls(func, pad, controls)
	if type(controls) == 'number' then
		return func(pad, controls)
	end

	for _, control in ipairs(controls) do
		if func(pad, control) then
			return true
		end
	end

	return false
end

Eyes_Male = {
    {
        612262189,
        1864171073,
        1552505114,
        46507404,
        4030267507,
        642477207,
        329402181,
        2501331517,
        2195072443,
        3096645940,
        3983864603,
        2739887825,
        2432743988,
        3065185688,
    }
}

Eyes_Female = {
    {
        928002221,
        3117725108,
        2273169671,
        2489772761,
        1647937151,
        3773694950,
        3450854762,
        3703470983,
        2836599857,
        625380794,
        869083847,
        3045109292,
        2210319017,
        2451302243,
    }
}

Body_Type = {
    {
        61606861,
        -1241887289,
        -369348190,
        32611963,
        -20262001,
        -369348190,
    }
}

Waist_Type = {
    {
        -2045421226,
        -1745814259,
        -325933489,
        -1065791927,
        -844699484,
        -1273449080,
        927185840,
        149872391,
        399015098,
        -644349862,
        1745919061,
        1004225511,
        1278600348,
        502499352,
        -2093198664,
        -1837436619,
        1736416063,
        2040610690,
        -1173634986,
        -867801909,
        1960266524,
    }
}


RegisterNetEvent("gum:SelectedCharacter")
AddEventHandler("gum:SelectedCharacter", function(charid)
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(5)
            DisableControlAction(0, 0x580C4473, true)
            DisableControlAction(0, 0xCF8A4ECA, true)
            Citizen.InvokeNative(0x8BC7C1F929D07BF3, 474191950)
            Citizen.InvokeNative(0xFEDFA97638D61D4A, 0.2)--NPCS
            Citizen.InvokeNative(0x1F91D44490E1EA0C, 0.0)--Vehicle
            Citizen.InvokeNative(0x606374EBFC27B133, 0.0)--Vehicle Npcs
            Mount_States()
        end
    end)
end)

function Mount_States()
    local pped = PlayerPedId()
    local playerHash = GetHashKey("PLAYER")

    if (IsControlPressed(0, 0xCEFD9220)) then
        Citizen.InvokeNative(0xBF25EB89375A37AD, 1, playerHash, playerHash);
        active_block = true
        Citizen.Wait(4000)
    end
    if (IsPedOnMount(pped) and IsPedInAnyVehicle(pped, false) and active_block == true) then
        Citizen.InvokeNative(0xBF25EB89375A37AD, 5, playerHash, playerHash)
        active_block = false
    elseif (active_block == true and (IsPedOnMount(pped) or IsPedInAnyVehicle(pped, false))) then
        if (IsPedInAnyVehicle(pped, false)) then
        elseif (GetPedInVehicleSeat(GetMount(pped), -1) == pped) then
            Citizen.InvokeNative(0xBF25EB89375A37AD, 5, playerHash, playerHash);
            active_block = false
        end
    else
        if active_block == true and not IsPedOnMount(pped) then
            Citizen.InvokeNative(0xBF25EB89375A37AD, 5, playerHash, playerHash)
            active_block = false
        end
    end
end

function HasBodyComponentsLoaded(type, hash_for_load, text)
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), type, 0)
    Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), hash_for_load, false, true, true)
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
    return true
end

function LoadModel(model)
	if IsModelInCdimage(model) then
		RequestModel(model)

		while not HasModelLoaded(model) do
			Wait(0)
		end

		return true
	else
		return false
	end
end

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

function Data_Character_Load(first, state)
    local model = GetHashKey(Skin_Table["sex"])
    RequestModel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(0)
    end
    SetPlayerModel(PlayerId(), model)
 
    -- SetModelPed(PlayerPedId(), Skin_Table["sex"])
    Citizen.Wait(1000)
    HasBodyComponentsLoaded(0xB3966C9, Skin_Table["Body"], "Body")
    HasBodyComponentsLoaded(0x378AD10C, Skin_Table["HeadType"], "Head")
    HasBodyComponentsLoaded(0x823687F5, Skin_Table["LegsType"], "Legs")
    Citizen.Wait(0)
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
    Citizen.Wait(0)
    for i=1,6 do
        if Skin_Table["Nation"] == i then
            for k,v in pairs(Config.DefaultChar["Male"][i]) do
                if k == "Heads" then
                    for x,y in pairs(v) do
                        if x == 1 then
                            local hash = ("0x"..y)
                            HeadCategory = i
                            Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash), true, true, true)
                        end
                    end
                end
            end
        end
    end
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
    Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), Skin_Table["Body"], false, true, true)
    Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), Skin_Table["HeadType"], false, true, true)
    Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), Skin_Table["BodyType"], false, true, true);
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
    Citizen.InvokeNative(0x1902C4CFCC5BE57C, PlayerPedId(), Skin_Table["Waist"], false, true, true);
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
    if Skin_Table["Eyes"] ~= -1 then
        HasBodyComponentsLoaded(0xEA24B45E, Skin_Table["Eyes"], "EYES")
    end
    if Skin_Table["Hair"] ~= -1 then
        HasBodyComponentsLoaded(0x864B03AE, Skin_Table["Hair"], "HAIR")
    end
    if Skin_Table["Beard"] ~= -1 then
        HasBodyComponentsLoaded(0xF8016BCA, Skin_Table["Beard"], "BEARD")
    end
    Citizen.InvokeNative(0x1902C4CFCC5BE57C, PlayerPedId(), Skin_Table["BodyType"], false, true, true);
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
    Citizen.InvokeNative(0x1902C4CFCC5BE57C, PlayerPedId(), Skin_Table["Waist"], false, true, true);
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
    if Clothe_Table["Hat"] ~= -1 then
        HasBodyComponentsLoaded(0x9925C067, Clothe_Table["Hat"], "HAT")
    end
    if Clothe_Table["EyeWear"] ~= -1 then
        HasBodyComponentsLoaded(0x5E47CA6, Clothe_Table["EyeWear"], "EyeWear")
    end
    if Clothe_Table["Mask"] ~= -1 then
        HasBodyComponentsLoaded(0x7505EF42, Clothe_Table["Mask"], "Mask")
    end
    if Clothe_Table["NeckWear"] ~= -1 then
        HasBodyComponentsLoaded(0x5FC29285, Clothe_Table["NeckWear"], "NeckWear")
    end
    if Clothe_Table["Suspender"] ~= -1 then
        HasBodyComponentsLoaded(0x877A2CF7, Clothe_Table["Suspender"], "Suspender")
    end
    if Clothe_Table["NeckTies"] ~= -1 then
        HasBodyComponentsLoaded(0x7A96FACA, Clothe_Table["NeckTies"], "NeckTies")
    end
    if Clothe_Table["Shirt"] ~= -1 then
        HasBodyComponentsLoaded(0x2026C46D, Clothe_Table["Shirt"], "Shirt")
    end
    if Clothe_Table["Vest"] ~= -1 then
        HasBodyComponentsLoaded(0x485EE834, Clothe_Table["Vest"], "Vest")
    end
    if Clothe_Table["Coat"] ~= -1 then
        HasBodyComponentsLoaded(0xE06D30CE, Clothe_Table["Coat"], "Coat")
    end
    if Clothe_Table["CoatClosed"] ~= -1 then
        HasBodyComponentsLoaded(0x662AC34, Clothe_Table["CoatClosed"], "CoatClosed")
    end
    if Clothe_Table["Poncho"] ~= -1 then
        HasBodyComponentsLoaded(0xAF14310B, Clothe_Table["Poncho"], "Poncho")
    end
    if Clothe_Table["Cloak"] ~= -1 then
        HasBodyComponentsLoaded(0x3C1A74CD, Clothe_Table["Cloak"], "Cloak")
    end
    if Clothe_Table["Glove"] ~= -1 then
        HasBodyComponentsLoaded(0xEABE0032, Clothe_Table["Glove"], "Glove")
    end
    if Clothe_Table["RingRh"] ~= -1 then
        HasBodyComponentsLoaded(0x7A6BBD0B, Clothe_Table["RingRh"], "RingRh")
    end
    if Clothe_Table["RingLh"] ~= -1 then
        HasBodyComponentsLoaded(0xF16A1D23, Clothe_Table["RingLh"], "RingLh")
    end
    if Clothe_Table["Bracelet"] ~= -1 then
        HasBodyComponentsLoaded(0x7BC10759, Clothe_Table["Bracelet"], "Bracelet")
    end
    if Clothe_Table["Buckle"] ~= -1 then
        HasBodyComponentsLoaded(0xFAE9107F, Clothe_Table["Buckle"], "Buckle")
    end
    if Clothe_Table["Chap"] ~= -1 then
        HasBodyComponentsLoaded(0x3107499B, Clothe_Table["Chap"], "Chap")
    end
    if Clothe_Table["Skirt"] ~= -1 then
        HasBodyComponentsLoaded(0xA0E3AB7F, Clothe_Table["Skirt"], "Skirt")
    end
    if Clothe_Table["Pant"] == -1 then
        HasBodyComponentsLoaded(0x823687F5, Skin_Table["LegsType"], "Legs")
    else
        HasBodyComponentsLoaded(0x1D4C528A, Clothe_Table["Pant"], "Pant")
    end
    if Clothe_Table["Boots"] ~= -1 then
        HasBodyComponentsLoaded(0x777EC6EF, Clothe_Table["Boots"], "Boots")
    end 
    if Clothe_Table["Spurs"] ~= -1 then
        HasBodyComponentsLoaded(0x18729F39, Clothe_Table["Spurs"], "Spurs")
    end
    if Clothe_Table["Spats"] ~= -1 then
        HasBodyComponentsLoaded(0x514ADCEA, Clothe_Table["Spats"], "Spats")
    end
    if Clothe_Table["Gauntlets"] ~= -1 then
        HasBodyComponentsLoaded(0x91CE9B20, Clothe_Table["Gauntlets"], "Gauntlets")
    end
    if Clothe_Table["Loadouts"] ~= -1 then
        HasBodyComponentsLoaded(0x83887E88, Clothe_Table["Loadouts"], "Loadouts")
    end
    if Clothe_Table["Accessories"] ~= -1 then
        HasBodyComponentsLoaded(0x79D7DF96, Clothe_Table["Accessories"], "Accessories")
    end
    if Clothe_Table["Belt"] ~= -1 then
        HasBodyComponentsLoaded(0xA6D134C6, Clothe_Table["Belt"], "Belt")
    end
    if Clothe_Table["Gunbelt"] ~= -1 then
        HasBodyComponentsLoaded(0x9B2C8B89, Clothe_Table["Gunbelt"], "Gunbelt")
    end
    if Clothe_Table["GunbeltAccs"] ~= -1 then
        HasBodyComponentsLoaded(0xF1542D11, Clothe_Table["GunbeltAccs"], "GunbeltAccs")
    end
    if Clothe_Table["Satchels"] ~= -1 then
        HasBodyComponentsLoaded(0x94504D26, Clothe_Table["Satchels"], "Satchels")
    end
    if Clothe_Table["Holster"] ~= -1 then
        HasBodyComponentsLoaded(0xB6B6122D, Clothe_Table["Holster"], "Holster")
    end
    if Skin_Table["Teeth"] ~= -1 and Skin_Table["Teeth"] ~= nil then
        HasBodyComponentsLoaded(0x96EDAE5C, Skin_Table["Teeth"], "Teeth")
    end
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x3F1F01E5, 0)
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xDA0E2C55, 0)
    Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
    Citizen.Wait(0)
    Citizen.InvokeNative(0x25ACFC650B65C538, PlayerPedId(), Skin_Table["Scale"])
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
    Citizen.Wait(0)
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x84D6, Skin_Table["HeadSize"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x3303, Skin_Table["EyeBrowH"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x2FF9, Skin_Table["EyeBrowW"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x4AD1, Skin_Table["EyeBrowD"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0xC04F, Skin_Table["EarsH"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0xB6CE, Skin_Table["EarsW"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x2844, Skin_Table["EarsD"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0xED30, Skin_Table["EarsL"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x8B2B, Skin_Table["EyeLidH"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x1B6B, Skin_Table["EyeLidW"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0xEE44, Skin_Table["EyeD"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0xD266, Skin_Table["EyeAng"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0xA54E, Skin_Table["EyeDis"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0xDDFB, Skin_Table["EyeH"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x6E7F, Skin_Table["NoseW"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x3471, Skin_Table["NoseS"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x03F5, Skin_Table["NoseH"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x34B1, Skin_Table["NoseAng"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0xF156, Skin_Table["NoseC"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x561E, Skin_Table["NoseDis"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x6A0B, Skin_Table["CheekBonesH"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0xABCF, Skin_Table["CheekBonesW"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x358D, Skin_Table["CheekBonesD"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0xF065, Skin_Table["MouthW"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0xAA69, Skin_Table["MouthD"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x7AC3, Skin_Table["MouthX"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x410D, Skin_Table["MouthY"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x1A00, Skin_Table["ULiphH"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x91C1, Skin_Table["ULiphW"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0xC375, Skin_Table["ULiphD"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0xBB4D, Skin_Table["LLiphH"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0xB0B0, Skin_Table["LLiphW"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x5D16, Skin_Table["LLiphD"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x8D0A, Skin_Table["JawH"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0xEBAE, Skin_Table["JawW"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x1DF6, Skin_Table["JawD"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x3C0F, Skin_Table["ChinH"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0xC3B2, Skin_Table["ChinW"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0xE323, Skin_Table["ChinD"]);
    Citizen.Wait(0)
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), Skin_Table["HeadType"], false, true, true)
    Citizen.InvokeNative(0x1902C4CFCC5BE57C, PlayerPedId(), Skin_Table["BodyType"], false, true, true);
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
    Citizen.InvokeNative(0x1902C4CFCC5BE57C, PlayerPedId(), Skin_Table["Waist"], false, true, true);
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
    Citizen.Wait(1000)
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xEA24B45E, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x864B03AE, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xF8016BCA, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x9925C067, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x5E47CA6, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x662AC34, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x5FC29285, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x7A96FACA, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x2026C46D, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x877A2CF7, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x485EE834, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xE06D30CE, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xAF14310B, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x3C1A74CD, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xEABE0032, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x7A6BBD0B, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xF16A1D23, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x7BC10759, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x9B2C8B89, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xA6D134C6, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xFAE9107F, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xB6B6122D, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x1D4C528A, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xA0E3AB7F, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x3107499B, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x777EC6EF, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x18729F39, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xF1542D11, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x514ADCEA, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x91CE9B20, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x83887E88, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x79D7DF96, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x94504D26, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x96EDAE5C, 0);

    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xB3966C9, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x378AD10C, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x823687F5, 0);
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0);
    Citizen.Wait(1000)
    Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Skin_Table["Body"],       true, true, false);
    Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Skin_Table["HeadType"],       true, true, false);
    Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Skin_Table["LegsType"],       true, true, false);
    Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Skin_Table["Eyes"],       true, true, false);
    Citizen.Wait(1000)
    if Skin_Table["Teeth"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Skin_Table["Teeth"],       true, true, false);
    end
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0);
    Citizen.Wait(0)
    if Skin_Table["Beard"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Skin_Table["Beard"],       true, true, false);
    end
    if Skin_Table["Hair"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Skin_Table["Hair"],       true, true, false);
    end
    if Clothe_Table["Hat"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Clothe_Table["Hat"],       true, true, false);
    end
    if Clothe_Table["EyeWear"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Clothe_Table["EyeWear"],   true, true, false);
    end
    if Clothe_Table["Mask"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Clothe_Table["Mask"],      true, true, false);
    end
    if Clothe_Table["NeckWear"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Clothe_Table["NeckWear"],  true, true, false);
    end
    if Clothe_Table["Suspender"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Clothe_Table["Suspender"], true, true, false);
    end
    if Clothe_Table["NeckTies"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Clothe_Table["NeckTies"],  true, true, false);
    end
    if Clothe_Table["Shirt"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Clothe_Table["Shirt"],     true, true, false);
    end
    if Clothe_Table["Vest"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Clothe_Table["Vest"],      true, true, false);
    end
    if Clothe_Table["Coat"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Clothe_Table["Coat"],      true, true, false);
    end
    if Clothe_Table["CoatClosed"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Clothe_Table["CoatClosed"],true, true, false);
    end
    if Clothe_Table["Poncho"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Clothe_Table["Poncho"],    true, true, false);
    end
    if Clothe_Table["Cloak"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Clothe_Table["Cloak"],     true, true, false);
    end
    if Clothe_Table["Glove"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Clothe_Table["Glove"],    true, true, false);
    end
    if Clothe_Table["RingRh"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Clothe_Table["RingRh"],   true, true, false);
    end
    if Clothe_Table["RingLh"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Clothe_Table["RingLh"],   true, true, false);
    end
    if Clothe_Table["Bracelet"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Clothe_Table["Bracelet"], true, true, false);
    end
    if Clothe_Table["Buckle"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Clothe_Table["Buckle"],   true, true, false);
    end
    if Clothe_Table["Chap"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Clothe_Table["Chap"],     true, true, false);
    end
    if Clothe_Table["Skirt"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Clothe_Table["Skirt"],    true, true, false);
    end
    if Clothe_Table["Pant"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Clothe_Table["Pant"],     true, true, false);
    end
    if Clothe_Table["Boots"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Clothe_Table["Boots"],    true, true, false);
    end
    if Clothe_Table["Spurs"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Clothe_Table["Spurs"],    true, true, false);
    end
    if Clothe_Table["Spats"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Clothe_Table["Spats"],   true, true, false);
    end
    if Clothe_Table["Gauntlets"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Clothe_Table["Gauntlets"],true, true, false);
    end
    if Clothe_Table["Loadouts"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Clothe_Table["Loadouts"], true, true, false);
    end
    if Clothe_Table["Accessories"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Clothe_Table["Accessories"],true, true, false);
    end
    if Clothe_Table["Belt"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Clothe_Table["Belt"], true, true, false);
    end
    if Clothe_Table["Gunbelt"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Clothe_Table["Gunbelt"], true, true, false);
    end
    if Clothe_Table["GunbeltAccs"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Clothe_Table["GunbeltAccs"], true, true, false);
    end
    if Clothe_Table["Satchels"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Clothe_Table["Satchels"], true, true, false);
    end
    if Clothe_Table["Holster"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Clothe_Table["Holster"], true, true, false);
    end
    if Clothe_Table["Teeth"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Skin_Table["Teeth"], true, true, false);
    end
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);

    Citizen.InvokeNative(0x1902C4CFCC5BE57C, PlayerPedId(), Skin_Table["Waist"])
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
    Citizen.InvokeNative(0x1902C4CFCC5BE57C, PlayerPedId(), Skin_Table["Waist"], false, true, true);
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
    reload_scars()
    if state == true then
        TriggerEvent("gum_inventory:reload_weap")
    end
    if Config.WalkFaceStyle then
        TriggerEvent("gum_walkingfacestyle:active")
    end
end

function ReloadCloth()
    print("HIDE : "..PlayerPedId())
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xEA24B45E, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x864B03AE, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xF8016BCA, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x9925C067, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x5E47CA6, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x662AC34, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x5FC29285, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x7A96FACA, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x2026C46D, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x877A2CF7, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x485EE834, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xE06D30CE, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xAF14310B, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x3C1A74CD, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xEABE0032, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x7A6BBD0B, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xF16A1D23, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x7BC10759, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x9B2C8B89, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xA6D134C6, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xFAE9107F, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xB6B6122D, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x1D4C528A, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xA0E3AB7F, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x3107499B, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x777EC6EF, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x18729F39, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xF1542D11, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x514ADCEA, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x91CE9B20, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x83887E88, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x79D7DF96, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x94504D26, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x96EDAE5C, 0);

    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xB3966C9, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x378AD10C, 0);
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x823687F5, 0);
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0);
    Citizen.Wait(500)
    Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Skin_Table["Body"],       true, true, false);
    Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Skin_Table["HeadType"],       true, true, false);
    Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Skin_Table["LegsType"],       true, true, false);
    Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Skin_Table["Eyes"],       true, true, false);
    print("SHOW")
    if Skin_Table["Teeth"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Skin_Table["Teeth"],       true, true, false);
    end
    if Skin_Table["Beard"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Skin_Table["Beard"],       true, true, false);
    end
    if Skin_Table["Hair"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Skin_Table["Hair"],       true, true, false);
    end
    if Clothe_Table["Hat"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Clothe_Table["Hat"],       true, true, false);
    end
    if Clothe_Table["EyeWear"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Clothe_Table["EyeWear"],   true, true, false);
    end
    if Clothe_Table["Mask"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Clothe_Table["Mask"],      true, true, false);
    end
    if Clothe_Table["NeckWear"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Clothe_Table["NeckWear"],  true, true, false);
    end
    if Clothe_Table["Suspender"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Clothe_Table["Suspender"], true, true, false);
    end
    if Clothe_Table["NeckTies"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Clothe_Table["NeckTies"],  true, true, false);
    end
    if Clothe_Table["Shirt"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Clothe_Table["Shirt"],     true, true, false);
    end
    if Clothe_Table["Vest"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Clothe_Table["Vest"],      true, true, false);
    end
    if Clothe_Table["Coat"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Clothe_Table["Coat"],      true, true, false);
    end
    if Clothe_Table["CoatClosed"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Clothe_Table["CoatClosed"],true, true, false);
    end
    if Clothe_Table["Poncho"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Clothe_Table["Poncho"],    true, true, false);
    end
    if Clothe_Table["Cloak"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Clothe_Table["Cloak"],     true, true, false);
    end
    if Clothe_Table["Glove"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Clothe_Table["Glove"],    true, true, false);
    end
    if Clothe_Table["RingRh"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Clothe_Table["RingRh"],   true, true, false);
    end
    if Clothe_Table["RingLh"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Clothe_Table["RingLh"],   true, true, false);
    end
    if Clothe_Table["Bracelet"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Clothe_Table["Bracelet"], true, true, false);
    end
    if Clothe_Table["Buckle"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Clothe_Table["Buckle"],   true, true, false);
    end
    if Clothe_Table["Chap"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Clothe_Table["Chap"],     true, true, false);
    end
    if Clothe_Table["Skirt"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Clothe_Table["Skirt"],    true, true, false);
    end
    if Clothe_Table["Pant"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Clothe_Table["Pant"],     true, true, false);
    end
    if Clothe_Table["Boots"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Clothe_Table["Boots"],    true, true, false);
    end
    if Clothe_Table["Spurs"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Clothe_Table["Spurs"],    true, true, false);
    end
    if Clothe_Table["Spats"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Clothe_Table["Spats"],   true, true, false);
    end
    if Clothe_Table["Gauntlets"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Clothe_Table["Gauntlets"],true, true, false);
    end
    if Clothe_Table["Loadouts"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Clothe_Table["Loadouts"], true, true, false);
    end
    if Clothe_Table["Accessories"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Clothe_Table["Accessories"],true, true, false);
    end
    if Clothe_Table["Belt"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Clothe_Table["Belt"], true, true, false);
    end
    if Clothe_Table["Gunbelt"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Clothe_Table["Gunbelt"], true, true, false);
    end
    if Clothe_Table["GunbeltAccs"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Clothe_Table["GunbeltAccs"], true, true, false);
    end
    if Clothe_Table["Satchels"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Clothe_Table["Satchels"], true, true, false);
    end
    if Clothe_Table["Holster"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Clothe_Table["Holster"], true, true, false);
    end
    if Clothe_Table["Teeth"] ~= -1 then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  Skin_Table["Teeth"], true, true, false);
    end
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x3F1F01E5, 0)
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xDA0E2C55, 0)
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0);
    Citizen.Wait(0)
    Citizen.InvokeNative(0x25ACFC650B65C538, PlayerPedId(), Skin_Table["Scale"])
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
    Citizen.Wait(0)
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x84D6, Skin_Table["HeadSize"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x3303, Skin_Table["EyeBrowH"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x2FF9, Skin_Table["EyeBrowW"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x4AD1, Skin_Table["EyeBrowD"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0xC04F, Skin_Table["EarsH"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0xB6CE, Skin_Table["EarsW"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x2844, Skin_Table["EarsD"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0xED30, Skin_Table["EarsL"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x8B2B, Skin_Table["EyeLidH"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x1B6B, Skin_Table["EyeLidW"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0xEE44, Skin_Table["EyeD"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0xD266, Skin_Table["EyeAng"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0xA54E, Skin_Table["EyeDis"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0xDDFB, Skin_Table["EyeH"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x6E7F, Skin_Table["NoseW"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x3471, Skin_Table["NoseS"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x03F5, Skin_Table["NoseH"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x34B1, Skin_Table["NoseAng"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0xF156, Skin_Table["NoseC"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x561E, Skin_Table["NoseDis"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x6A0B, Skin_Table["CheekBonesH"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0xABCF, Skin_Table["CheekBonesW"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x358D, Skin_Table["CheekBonesD"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0xF065, Skin_Table["MouthW"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0xAA69, Skin_Table["MouthD"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x7AC3, Skin_Table["MouthX"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x410D, Skin_Table["MouthY"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x1A00, Skin_Table["ULiphH"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x91C1, Skin_Table["ULiphW"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0xC375, Skin_Table["ULiphD"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0xBB4D, Skin_Table["LLiphH"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0xB0B0, Skin_Table["LLiphW"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x5D16, Skin_Table["LLiphD"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x8D0A, Skin_Table["JawH"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0xEBAE, Skin_Table["JawW"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x1DF6, Skin_Table["JawD"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0x3C0F, Skin_Table["ChinH"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0xC3B2, Skin_Table["ChinW"]);
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), 0xE323, Skin_Table["ChinD"]);
    Citizen.InvokeNative(0x1902C4CFCC5BE57C, PlayerPedId(), Skin_Table["BodyType"], false, true, true);
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
    Citizen.InvokeNative(0x1902C4CFCC5BE57C, PlayerPedId(), Skin_Table["Waist"], false, true, true);
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false);
    Citizen.Wait(0)
    reload_scars()
    if Config.WalkFaceStyle then
        TriggerEvent("gum_walkingfacestyle:active")
    end


end

function reload_scars()
    if Skin_Table["scars_visibility"] ~= nil and Skin_Table["scars_visibility"] ~= 0 and Skin_Table["scars_tx_id"] ~= nil  and Skin_Table["scars_opacity"] ~= nil then
        TriggerEvent("gum_characters:colors", "scars", Skin_Table["scars_visibility"], Skin_Table["scars_tx_id"], 0, 0, 1, 1.0, 0, 1, 0,0,0,1,Skin_Table["scars_opacity"])
    end
    if Skin_Table["spots_visibility"] ~= nil and Skin_Table["spots_visibility"] ~= 0 and Skin_Table["spots_tx_id"] ~= nil  and Skin_Table["spots_opacity"] ~= nil then
        TriggerEvent("gum_characters:colors", "spots", Skin_Table["spots_visibility"], Skin_Table["spots_tx_id"], 0, 0, 1, 1.0, 0, 1, 0,0,0,1,Skin_Table["spots_opacity"])
    end
    if Skin_Table["disc_visibility"] ~= nil and Skin_Table["disc_visibility"] ~= 0 and Skin_Table["disc_tx_id"] ~= nil  and Skin_Table["disc_opacity"] ~= nil then
        TriggerEvent("gum_characters:colors", "disc", Skin_Table["disc_visibility"], Skin_Table["disc_tx_id"], 0, 0, 1, 1.0, 0, 1, 0,0,0,1,Skin_Table["disc_opacity"])
    end
    if Skin_Table["complex_visibility"] ~= nil and Skin_Table["complex_visibility"] ~= 0 and Skin_Table["complex_tx_id"] ~= nil  and Skin_Table["complex_opacity"] ~= nil then
        TriggerEvent("gum_characters:colors", "complex", Skin_Table["complex_visibility"], Skin_Table["complex_tx_id"], 0, 0, 1, 1.0, 0, 1, 0,0,0,1,Skin_Table["complex_opacity"])
    end
    if Skin_Table["acne_visibility"] ~= nil and Skin_Table["acne_visibility"] ~= 0 and Skin_Table["acne_tx_id"] ~= nil  and Skin_Table["acne_opacity"] ~= nil then
        TriggerEvent("gum_characters:colors", "acne", Skin_Table["acne_visibility"], Skin_Table["acne_tx_id"], 0, 0, 1, 1.0, 0, 1, 0,0,0,1,Skin_Table["acne_opacity"])
    end
    if Skin_Table["ageing_visibility"] ~= nil and Skin_Table["ageing_visibility"] ~= 0 and Skin_Table["ageing_tx_id"] ~= nil  and Skin_Table["ageing_opacity"] ~= nil then
        TriggerEvent("gum_characters:colors", "ageing", Skin_Table["ageing_visibility"], Skin_Table["ageing_tx_id"], 0, 0, 1, 1.0, 0, 1, 0,0,0,1,Skin_Table["ageing_opacity"])
    end
    if Skin_Table["freckles_visibility"] ~= nil and Skin_Table["freckles_visibility"] ~= 0 and Skin_Table["freckles_tx_id"] ~= nil  and Skin_Table["freckles_opacity"] ~= nil then
        TriggerEvent("gum_characters:colors", "freckles", Skin_Table["freckles_visibility"], Skin_Table["freckles_tx_id"], 0, 0, 1, 1.0, 0, 1, 0,0,0,1,Skin_Table["freckles_opacity"])
    end
    if Skin_Table["moles_visibility"] ~= nil and Skin_Table["moles_visibility"] ~= 0 and Skin_Table["moles_tx_id"] ~= nil  and Skin_Table["moles_opacity"] ~= nil then
        TriggerEvent("gum_characters:colors", "moles", Skin_Table["moles_visibility"], Skin_Table["moles_tx_id"], 0, 0, 1, 1.0, 0, 1, 0,0,0,1,Skin_Table["moles_opacity"])
    end
    if Skin_Table["eyebrows_visibility"] ~= nil and Skin_Table["eyebrows_visibility"] ~= 0  and Skin_Table["eyebrows_tx_id"] ~= nil  and Skin_Table["eyebrows_opacity"] ~= nil then
        TriggerEvent("gum_characters:colors", "eyebrows", Skin_Table["eyebrows_visibility"], Skin_Table["eyebrows_tx_id"], 1, 0, 0, 1.0, 0, 1, Skin_Table["eyebrows_color"],0,0,1,Skin_Table["eyebrows_opacity"])
    end
    if Skin_Table["blush_visibility"] ~= nil and Skin_Table["blush_visibility"] ~= 0 and Skin_Table["blush_tx_id"] ~= nil  and Skin_Table["blush_opacity"] ~= nil then
        TriggerEvent("gum_characters:colors", "blush", Skin_Table["blush_visibility"], Skin_Table["blush_tx_id"], 1, 0, 0, 1.0, 0, 1, Skin_Table["blush_color_1"],0,0,1,Skin_Table["blush_opacity"])
    end
    if Skin_Table["eyeliners_visibility"] ~= nil and Skin_Table["eyeliners_visibility"] ~= 0 and Skin_Table["eyeliners_tx_id"] ~= nil  and Skin_Table["eyeliners_opacity"] ~= nil then
        TriggerEvent("gum_characters:colors", "eyeliners", Skin_Table["eyeliners_visibility"], 1, 1, 0, 0, 1.0, 0, 1, Skin_Table["eyeliners_color_1"],0,0,Skin_Table["eyeliners_tx_id"],Skin_Table["eyeliners_opacity"])
    end
    if Skin_Table["lipsticks_visibility"] ~= nil and Skin_Table["lipsticks_visibility"] ~= 0 and Skin_Table["lipsticks_tx_id"] ~= nil  and Skin_Table["lipsticks_opacity"] ~= nil then
        TriggerEvent("gum_characters:colors", "lipsticks", Skin_Table["lipsticks_visibility"], 1, 1, 0, 0, 1.0, 0, 1, Skin_Table["lipsticks_color_1"],Skin_Table["lipsticks_color_2"],Skin_Table["lipsticks_color_3"], Skin_Table["lipsticks_tx_id"], Skin_Table["lipsticks_opacity"])
    end
    if Skin_Table["shadows_visibility"] ~= nil and Skin_Table["shadows_visibility"] ~= 0 and Skin_Table["shadows_tx_id"] ~= nil  and Skin_Table["shadows_opacity"] ~= nil then
        TriggerEvent("gum_characters:colors", "shadows", Skin_Table["shadows_visibility"], 1, 1, 0, 0, 1.0, 0, 1, Skin_Table["shadows_color_1"],Skin_Table["shadows_color_2"],Skin_Table["shadows_color_3"],Skin_Table["shadows_tx_id"],Skin_Table["shadows_opacity"])
    end
    if Skin_Table["beardstabble_visibility"] ~= nil and Skin_Table["beardstabble_visibility"] ~= 0 and Skin_Table["beardstabble_tx_id"] ~= nil  and Skin_Table["beardstabble_opacity"] ~= nil then
        TriggerEvent("gum_characters:colors", "beardstabble", Skin_Table["beardstabble_visibility"], 1, 1, 0, 0, 1.0, 0, 1, Skin_Table["beardstabble_color_1"],Skin_Table["beardstabble_color_2"],Skin_Table["beardstabble_color_3"],Skin_Table["beardstabble_tx_id"],Skin_Table["beardstabble_opacity"])
    end
end

function DrawText3D(x, y, z, text)
	local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)
	local px,py,pz=table.unpack(GetGameplayCamCoord())  
	local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
	local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
	if onScreen then
		SetTextScale(0.30, 0.30)
		SetTextFontForCurrentCommand(6)
		SetTextColor(255, 255, 255, 255)
		SetTextCentre(1)
		SetTextDropshadow(1, 1, 0, 0, 200)
		DisplayText(str,_x,_y)
		local factor = (string.len(text)) / 225
		--DrawSprite("generic_textures", "hud_menu_4a", _x, _y+0.0125,0.015+ factor, 0.03, 0.1, 35, 35, 35, 190, 0)
		--DrawSprite("feeds", "toast_bg", _x, _y+0.0125,0.015+ factor, 0.03, 0.1, 100, 1, 1, 190, 0)
	end
end