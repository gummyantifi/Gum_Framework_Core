local buttons_prompt = GetRandomIntInRange(0, 0xffffff)
local active = false
local spam_protect = false

RegisterNetEvent("gum:SelectedCharacter")
AddEventHandler("gum:SelectedCharacter", function(charid)
	Citizen.CreateThread(function()
		Button_Prompt()
		TriggerEvent('gum:ExecuteServerCallBack','gum_bank:get_borrow', function(date) 
			if date ~= 0 and date ~= nil then
				TriggerServerEvent("gum_bank:remove_borrow")
			end
		end)
		for k,v in pairs(Config.Locations) do		
			local blips = N_0x554d9d53f696d002(1664425300, v.x, v.y, v.z)
			SetBlipSprite(blips, -2128054417, 1)
			SetBlipScale(blips, 1.5)
			Citizen.InvokeNative(0x9CB1A1623062F402, blips, "Bank")
		end
		while true do
			local coords = GetEntityCoords(PlayerPedId())
			for k,v in pairs(Config.Locations) do
				if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, v.x, v.y, v.z, false) < 15 then
					if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, v.x, v.y, v.z, false) < 1.5 then
						if active == false then
							local item_name = CreateVarString(10, 'LITERAL_STRING', "Bank")
							PromptSetActiveGroupThisFrame(buttons_prompt, item_name)
						end
						if Citizen.InvokeNative(0x305C8DCD79DA8B0F, 0, 0x27D1C284) then
							TriggerServerEvent("gum_bank:get_bank_city", k)
						end
					end
				end
			end
			Citizen.Wait(10)
		end
	end)
end)

RegisterNetEvent("gum_bank:get_bank")
AddEventHandler("gum_bank:get_bank", function(city)
	TriggerEvent('gum:ExecuteServerCallBack','gum_bank:get_bank', function(name, lastname, money, gold) 
		SetNuiFocus(true, true)
		SendNUIMessage({
			type = "open_bank",
			city = city,
			firstname = name,
			lastname = lastname,
			money = math.floor(money*10)/10,
			gold = math.floor(gold*10)/10,
		})
	end)
end)

RegisterNetEvent("gum_bank:update")
AddEventHandler("gum_bank:update", function(city, name, lastname, money, gold)
	SendNUIMessage({
		type = "open_bank",
		city = city,
		firstname = name,
		lastname = lastname,
		money = math.floor(money*10)/10,
		gold = math.floor(gold*10)/10,
	})
end)

function Button_Prompt()
	Citizen.CreateThread(function()
        local str = "Otevřít"
        OpenBTPrompt = Citizen.InvokeNative(0x04F97DE45A519419)
        PromptSetControlAction(OpenBTPrompt, 0x27D1C284)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(OpenBTPrompt, str)
        PromptSetEnabled(OpenBTPrompt, true)
        PromptSetVisible(OpenBTPrompt, true)
        PromptSetHoldMode(OpenBTPrompt, true)
        PromptSetGroup(OpenBTPrompt, buttons_prompt)
        PromptRegisterEnd(OpenBTPrompt)
	end)
end

RegisterNUICallback('exit', function(data, cb)
    SetNuiFocus(false, false)
end)

RegisterNUICallback('add_money', function(data, cb)
	if spam_protect == false then
		if tonumber(data.value) >= 0 then
			spam_protect = true
			TriggerServerEvent("gum_bank:addmoney", data.city, data.value, data.havem, data.haveg)
			Citizen.Wait(1000)
			spam_protect = false
		else
			exports['gum_notify']:DisplayLeftNotification("Bank", "Špatná hodnota", 'money', 3000)
		end
	else
		exports['gum_notify']:DisplayLeftNotification("Bank", "Nemůžeš to spamovat.", 'money', 3000)
	end
end)

RegisterNUICallback('take_money', function(data, cb)
	if spam_protect == false then
		if tonumber(data.value) >= 0 then
			spam_protect = true
			TriggerServerEvent("gum_bank:takemoney", data.city, data.value, data.havem, data.haveg)
			Citizen.Wait(1000)
			spam_protect = false
		else
			exports['gum_notify']:DisplayLeftNotification("Bank", "Špatná hodnota", 'money', 3000)
		end
	else
		exports['gum_notify']:DisplayLeftNotification("Bank", "Nemůžeš to spamovat.", 'money', 3000)
	end
end)
RegisterNUICallback('add_gold', function(data, cb)
	if spam_protect == false then
		if tonumber(data.value) >= 0 then
			spam_protect = true
			TriggerServerEvent("gum_bank:addgold", data.city, data.value, data.havem, data.haveg)
			Citizen.Wait(1000)
			spam_protect = false
		else
			exports['gum_notify']:DisplayLeftNotification("Bank", "Špatná hodnota", 'money', 3000)
		end
	else
		exports['gum_notify']:DisplayLeftNotification("Bank", "Nemůžeš to spamovat.", 'money', 3000)
	end
end)
RegisterNUICallback('take_gold', function(data, cb)
	if spam_protect == false then
		if tonumber(data.value) >= 0 then
			spam_protect = true
			TriggerServerEvent("gum_bank:takegold", data.city, data.value, data.havem, data.haveg)
			Citizen.Wait(1000)
			spam_protect = false
		else
			exports['gum_notify']:DisplayLeftNotification("Bank", "Špatná hodnota", 'money', 3000)
		end
	else
		exports['gum_notify']:DisplayLeftNotification("Bank", "Nemůžeš to spamovat.", 'money', 3000)
	end
end)

RegisterNUICallback('borrow_info', function(data, cb)
	exports['gum_notify']:DisplayLeftNotification("Bank", "You can borrow money </br> Minimal value is 10$ </br> Maximal value is 50$</br></br>After you borrow money automaticaly every day you get down 5% from borrow value", 'money', 5000)
end)

RegisterNUICallback('borrow_money', function(data, cb)
	if spam_protect == false then
		spam_protect = true
		if type(data.value) ~= "number" then
			exports['gum_notify']:DisplayLeftNotification("Bank", "Musíš zadat číselnou hodnotu", 'money', 3000)
			spam_protect = false
			return false
		end
		if tonumber(data.value) <= 50 and tonumber(data.value) >= 10 then 
			TriggerServerEvent("gum_bank:borrow_money_now", data.value, data.add, (data.value+data.add)/100*5, data.city)
		end
		Citizen.Wait(2000)
		spam_protect = false
	else
		exports['gum_notify']:DisplayLeftNotification("Bank", "Nemůžeš to spamovat.", 'money', 3000)
	end
end)

RegisterNUICallback('set_read', function(data, cb)
	TriggerServerEvent("gum_mail:set_read", data.id)
end)
