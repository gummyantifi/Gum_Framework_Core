local hud = false
RegisterCommand("hud", function(source, args, rawCommand)
	if hud == true then
        hud = false
	else
        hud = true
	end
end)
RegisterCommand("prog_test", function(source, args, rawCommand)
    exports.gum_status2:DisplayProgressBar(15000)
end)
exports('DisplayProgressBar', function(time)
    local timer = (time / 100)
    local DisplayElemet = 0
    while DisplayElemet < 100 do
        SendNUIMessage({progress=true, time=DisplayElemet})
        DisplayElemet = DisplayElemet + 1
        Wait(timer)
        if DisplayElemet > 99 then
            SendNUIMessage({progress=false})
        end
    end
end)
RegisterNetEvent("gum:SelectedCharacter")
AddEventHandler("gum:SelectedCharacter", function(charid)
    Citizen.CreateThread(function()
        hud = true
    end)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        Citizen.InvokeNative(0x4CC5F2FC1332577F, GetHashKey("HUD_CTX_INFINITE_AMMO"))
        Citizen.InvokeNative(0x4CC5F2FC1332577F, GetHashKey("HUD_CTX_SHARP_SHOOTER_EVENT"))
        Citizen.InvokeNative(0x4CC5F2FC1332577F ,GetHashKey("HUD_CTX_RESTING_BY_FIRE"))
        Citizen.InvokeNative(0x4CC5F2FC1332577F ,GetHashKey("HUD_CTX_INFO_CARD"))
        Citizen.InvokeNative(0x4CC5F2FC1332577F ,GetHashKey("HUD_CTX_GOLD_CURRENCY_CHANGE"))

        Citizen.InvokeNative(0xD4EE21B7CC7FD350, false)
        Citizen.InvokeNative(0x50C803A4CD5932C5, false)

        if GetMount(PlayerPedId()) ~= 0 then
            onhorse = true
        else
            onhorse = false
        end
        
        local myhealth = GetEntityHealth(PlayerPedId())
        local mystamina = Citizen.InvokeNative(0x36731AC041289BB1, PlayerPedId(), 1)
        local myhunger = exports["gum_metabolism"]:getHunger()
        local mythirst = exports["gum_metabolism"]:getThirst()
        local horsestamina = Citizen.InvokeNative(0x36731AC041289BB1, GetMount(PlayerPedId()), 1)
        local horsehealth = Citizen.InvokeNative(0x36731AC041289BB1, GetMount(PlayerPedId()), 0)
        if myhealth == false then
            myhealth = 0
        end
        if mystamina == false then
            mystamina = 0
        end
        if hud == true then
            if IsCinematicCamRendering() == 1 then
                SendNUIMessage({show=false, health=myhealth, thirst=math.floor(mythirst), hunger=math.floor(myhunger), stamina=mystamina, on_horse=false, horse_stamina=horsestamina, horse_health=horsehealth })
            else
                SendNUIMessage({show=true, health=myhealth, thirst=math.floor(mythirst), hunger=math.floor(myhunger), stamina=mystamina, on_horse=onhorse, horse_stamina=horsestamina, horse_health=horsehealth })
            end
        else
            SendNUIMessage({show=false, health=myhealth, thirst=math.floor(mythirst), hunger=math.floor(myhunger), stamina=mystamina, on_horse=false, horse_stamina=horsestamina, horse_health=horsehealth })
        end
    end
end)

