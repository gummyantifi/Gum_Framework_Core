local eWeaponAttachPoint ={WEAPON_ATTACH_POINT_INVALID = -1,	WEAPON_ATTACH_POINT_HAND_PRIMARY = 0,    WEAPON_ATTACH_POINT_PISTOL_R = 2,    WEAPON_ATTACH_POINT_PISTOL_L = 3,    WEAPON_ATTACH_POINT_KNIFE = 4,    WEAPON_ATTACH_POINT_LASSO = 5,    WEAPON_ATTACH_POINT_THROWER = 6,    WEAPON_ATTACH_POINT_BOW = 7,    WEAPON_ATTACH_POINT_BOW_ALTERNATE = 8,    WEAPON_ATTACH_POINT_RIFLE = 9,    WEAPON_ATTACH_POINT_RIFLE_ALTERNATE = 10,    WEAPON_ATTACH_POINT_LANTERN = 11,    WEAPON_ATTACH_POINT_TEMP_LANTERN = 12,    WEAPON_ATTACH_POINT_MELEE = 13,    WEAPON_ATTACH_POINT_HIP = 14,    WEAPON_ATTACH_POINT_BOOT = 15,    WEAPON_ATTACH_POINT_BACK = 16,    WEAPON_ATTACH_POINT_FRONT = 17,    WEAPON_ATTACH_POINT_SHOULDERSLING = 18,    WEAPON_ATTACH_POINT_LEFTBREAST = 19,    WEAPON_ATTACH_POINT_RIGHTBREAST = 20,    WEAPON_ATTACH_POINT_LEFTARMPIT = 21,    WEAPON_ATTACH_POINT_RIGHTARMPIT = 22,    WEAPON_ATTACH_POINT_LEFTARMPIT_RIFLE = 23,    WEAPON_ATTACH_POINT_LEFTARMPIT_BOW = 25,    WEAPON_ATTACH_POINT_RIGHT_HAND_EXTRA = 26,    WEAPON_ATTACH_POINT_LEFT_HAND_EXTRA = 27,    WEAPON_ATTACH_POINT_RIGHT_HAND_AUX = 28,};
local ammo_list = {	{0x38854A3B,"AMMO_ARROW"}, {0x38854A3B, "AMMO_REPEATER_SPLIT_POINT"}, {0x38854A3B,"AMMO_BOLAS"}, {0x5B6ABDF8,"AMMO_ARROW_DYNAMITE"},	{0xD19E0045,"AMMO_ARROW_FIRE"},	{0xD62A5A6C,"AMMO_ARROW_POISON"},	{0x3250353B,"AMMO_ARROW_IMPROVED"},	{0x9BD3BBB,"AMMO_ARROW_SMALL_GAME"},	{0xBB8A699D,"AMMO_DYNAMITE"},	{0xDC91634B,"AMMO_DYNAMITE_VOLATILE"},	{0x6AB063DE,"AMMO_MOLOTOV"},	{0xF8FB3AC1,"AMMO_MOLOTOV_VOLATILE"},	{0x80766738,"AMMO_PISTOL"},	{0xF1A91F32,"AMMO_PISTOL_EXPRESS"},	{0x331B008B,"AMMO_PISTOL_EXPRESS_EXPLOSIVE"},	{0x46F7AA64,"AMMO_PISTOL_HIGH_VELOCITY"},	{0xAD60BB5F,"AMMO_PISTOL_SPLIT_POINT"},	{0x5E490BAA,"AMMO_REPEATER"},	{0x197A9C10,"AMMO_REPEATER_EXPRESS"},	{0x2390F9C2,"AMMO_REPEATER_EXPRESS_EXPLOSIVE"},	{0x4FFBFA8C,"AMMO_REPEATER_HIGH_VELOCITY"},	{0x4CE87556,"AMMO_REVOLVER"},	{0x3C932F5C,"AMMO_REVOLVER_EXPRESS"},	{0xAFD00F7F,"AMMO_REVOLVER_EXPRESS_EXPLOSIVE"},	{0x129C46F,"AMMO_REVOLVER_HIGH_VELOCITY"},	{0x9C6310D4,"AMMO_REVOLVER_SPLIT_POINT"},	{0xBAFF5180,"AMMO_RIFLE"},	{0x2CE404A4,"AMMO_RIFLE_EXPRESS"},	{0x9116173,"AMMO_RIFLE_EXPRESS_EXPLOSIVE"},	{0xF76DC763,"AMMO_RIFLE_HIGH_VELOCITY"},	{0xC1711828,"AMMO_RIFLE_SPLIT_POINT"},	{0xB7DB96B8,"AMMO_RIFLE_VARMINT"},	{0x58B272F9,"AMMO_SHOTGUN"},	{0xC71EE56D,"AMMO_SHOTGUN_BUCKSHOT_INCENDIARY"},	{0x3450D03C,"AMMO_SHOTGUN_SLUG"},	{0x4BB641AD,"AMMO_SHOTGUN_EXPRESS_EXPLOSIVE"},	{0xCFE15715,"AMMO_THROWING_KNIVES"},	{0xB846FB5B,"AMMO_THROWING_KNIVES_IMPROVED"},	{0x9AE0598E,"AMMO_THROWING_KNIVES_POISON"},	{0xB09A8B19,"AMMO_TOMAHAWK"},	{0x7B87DF4F,"AMMO_TOMAHAWK_HOMING"},	{0x4F384312,"AMMO_TOMAHAWK_IMPROVED"}};
local inventory_table = {}
local weapon_table = {}
local weapon_first_used = false
local weapon_second_used = false
local rifle_first_used = false
local rifle_second_used = false
local dropped_items = {}
local dropped_items_entity = {}
local active = false
local buttons_prompt = GetRandomIntInRange(0, 0xffffff)
local condition_level = {}
local money_state = 0
local gold_state = 0
local new_ammo_table = {}
local storage_table = {}
local size = 0
local backup_save_throw = 0
local is_last_ammo = false
local logged_true = true
local id_container = 0
local equip_spam = false
local speed = 0
local count_in_inventory = 0.0
local can_save = false
local slot1 = ""
local slot2 = ""
local slot3 = ""
local slot4 = ""
local slot5 = ""

function Button_Prompt()
	Citizen.CreateThread(function()
		local str = Config.Language[0].text
		PickItemGround = Citizen.InvokeNative(0x04F97DE45A519419)
		PromptSetControlAction(PickItemGround, 0x27D1C284)
		str = CreateVarString(10, 'LITERAL_STRING', str)
		PromptSetText(PickItemGround, str)
		PromptSetEnabled(PickItemGround, true)
		PromptSetVisible(PickItemGround, true)
		PromptSetHoldMode(PickItemGround, true)
		PromptSetGroup(PickItemGround, buttons_prompt)
		PromptRegisterEnd(PickItemGround)
	end)
end

function Show_Items(bool)
    SetNuiFocus(bool, bool)
    guiEnabled = bool
    SendNUIMessage({
        type = "inventory_table",
        status = bool,
		table_for_json = inventory_table,
		wtable_for_json = weapon_table,
		max_limit_i = Config.Max_Items,
		max_limit_w = Config.Max_Weapons,
		money = money_state,
		gold = gold_state,
	})
end

function Show_Other(bool, open, storage)
	id_container = open
    SetNuiFocus(bool, bool)
    guiEnabled = bool
    SendNUIMessage({
        type = "container_table",
        status = bool,
		table_for_json = inventory_table,
		wtable_for_json = weapon_table,
		max_limit_i = Config.Max_Items,
		max_limit_w = Config.Max_Weapons,
		money = money_state,
		gold = gold_state,
		id_con = open,
		strg_tbl = storage,
		size = size,
	})
end

RegisterNetEvent('gum_inventory:reset_inventory')
AddEventHandler('gum_inventory:reset_inventory', function()
	inventory_table = {}
	weapon_table = {}
	weapon_first_used = false
	weapon_second_used = false
	rifle_first_used = false
	rifle_second_used = false
	dropped_items = {}
	dropped_items_entity = {}
	condition_level = {}
	money_state = 0
	gold_state = 0
	new_ammo_table = {}
	storage_table = {}
	size = 0
	backup_save_throw = 0
	is_last_ammo = false
	TriggerServerEvent("gum_inventory:clear_inventory")
	RemoveAllWeapons()
end)

RegisterNetEvent('gum_inventory:get_storage')
AddEventHandler('gum_inventory:get_storage', function(storage, itm, wpn, id, sizes)
	storage_table = {}
	Citizen.Wait(0)
	size = sizes
	for k,v in pairs(storage) do
		if v.item == 'gold' then
			if v.count == nil then
				table.insert(storage_table, {weapon=false, label=Config.Language[1].text, item="gold", count=0, limit=0})
			else
				table.insert(storage_table, {weapon=false, label=Config.Language[1].text, item="gold", count=(math.floor(v.count*10)/10), limit=0})
			end
		end
		if v.item == 'money' then
			if v.count == nil then
				table.insert(storage_table, {weapon=false, label=Config.Language[2].text, item="money", count=0, limit=0})
			else
				table.insert(storage_table, {weapon=false, label=Config.Language[2].text, item="money", count=(math.floor(v.count*10)/10), limit=0})
			end
		end
		if v.name == nil then
			for k2,v2 in pairs(itm) do
				if v.item == v2.item then
					table.insert(storage_table, {weapon=false, label=v2.label, item=v.item, count=v.count, limit=v2.limit})
				end
			end
		else
			for k2,v2 in pairs(wpn) do
				if v.name == v2.item then
					table.insert(storage_table, {weapon=true, label=v2.label, item=v.item, count=v.name, limit=1})
				end
			end
		end
	end
	Show_Other(true, id, storage_table, money_state, size, gold_state)
end)

RegisterNetEvent('gum_inventory:refresh_storage')
AddEventHandler('gum_inventory:refresh_storage', function(storage, itm, wpn,id)
	storage_table = {}
	for k,v in pairs(storage) do
		if v.item == 'money' then
			table.insert(storage_table, {weapon=false, label=Config.Language[2].text, item="money", count=v.count, limit=0})
		end
		if v.item == 'gold' then
			table.insert(storage_table, {weapon=false, label=Config.Language[1].text, item="gold", count=v.count, limit=0})
		end
		if v.name == nil then
			for k2,v2 in pairs(itm) do
				if v.item == v2.item then
					table.insert(storage_table, {weapon=false, label=v2.label, item=v.item, count=v.count, limit=v2.limit})
				end
			end
		else
			for k2,v2 in pairs(wpn) do
				if v.name == v2.item then
					table.insert(storage_table, {weapon=true, label=v2.label, item=v.item, count=v.name, limit=1})
				end
			end
		end
	end
	Citizen.Wait(100)
	Show_Other(true, id, storage_table, money_state, size)
end)
RegisterNUICallback('hotbar_set', function(data, cb)
	if (tonumber(data.slot) == 1) then
		slot1 = data.item
	elseif (tonumber(data.slot) == 2) then
		slot2 = data.item
	elseif (tonumber(data.slot) == 3) then
		slot3 = data.item
	elseif (tonumber(data.slot) == 4) then
		slot4 = data.item
	elseif (tonumber(data.slot) == 5) then
		slot5 = data.item
	end
end)

RegisterNUICallback('transfer_to_storage', function(data, cb)
	Show_Other(false, data.container_id, storage_table, size)
	if data.item == "money" then
		TriggerEvent("guminputs:getInput", Config.Language[2].text, Config.Language[4].text, function(cb)
			local count_money = tonumber(cb)
			if count_money ~= nil then
				if count_money ~= 'close' and count_money > 0 and data.count >= count_money then
					TriggerServerEvent("gum_inventory:transfer_money_to_storage", "money", count_money, data.container_id)
				else
					Show_Other(true, data.container_id, storage_table, money_state, size)
				end
			else
				Show_Other(true, data.container_id, storage_table, money_state, size)
			end
		end)
	elseif data.item == "gold" then
		TriggerEvent("guminputs:getInput", Config.Language[3].text, Config.Language[5].text, function(cb)
			local count_gold = tonumber(cb)
			if count_gold ~= nil then
				if count_gold ~= 'close' and count_gold > 0 and data.count >= count_gold then
					TriggerServerEvent("gum_inventory:transfer_gold_to_storage", "gold", count_gold, data.container_id)
				else
					Show_Other(true, data.container_id, storage_table, money_state, size)
				end
			else
				Show_Other(true, data.container_id, storage_table, money_state, size)
			end
		end)
	else
		if data.size <= data.size+size then
			if data.weapon == false then
				TriggerEvent("guminputs:getInput", Config.Language[3].text, Config.Language[6].text, function(cb)
					local count_item = tonumber(cb)
					if count_item ~= nil then
						if count_item ~= 'close' and count_item > 0 and data.count >= count_item then
							if tonumber(size) >= tonumber(data.size)+tonumber(count_item*data.limit) then
								TriggerServerEvent("gum_inventory:transfer_item_to_storage", data.item, count_item, data.container_id)
							else
								Show_Other(true, data.container_id, storage_table, money_state, size)
								exports['gum_notify']:DisplayLeftNotification(Config.Language[10].text, Config.Language[8].text, 'pistol', 2000)
							end
						else
							Show_Other(true, data.container_id, storage_table, money_state, size)
						end
					else
						Show_Other(true, data.container_id, storage_table, money_state, size)
					end
				end)
			else
				if data.used == 1 then
					Show_Other(true, data.container_id, storage_table, money_state, size)
					exports['gum_notify']:DisplayLeftNotification(Config.Language[10].text, Config.Language[7].text, 'pistol', 2000)
				else
					TriggerServerEvent("gum_inventory:transfer_weapon_to_storage", data.id, data.item, data.container_id)
				end
			end
		else
			Show_Other(true, data.container_id, storage_table, money_state, size)
			exports['gum_notify']:DisplayLeftNotification(Config.Language[10].text, Config.Language[8].text, 'pistol', 2000)
		end
	end
end)

RegisterNUICallback('transfer_from_storage', function(data, cb)
	Show_Other(false, data.container_id, storage_table, size)
	if data.item == "money" then
		TriggerEvent("guminputs:getInput", Config.Language[3].text, Config.Language[4].text, function(cb)
			local count_money = tonumber(cb)
			if count_money ~= nil then
				if count_money ~= 'close' and count_money > 0 and tonumber(data.count) >= tonumber(count_money) then
					TriggerServerEvent("gum_inventory:transfer_money_from_storage", data.item, count_money, data.container_id)
				else
					Show_Other(true, data.container_id, storage_table, money_state, size)
				end
			else
				Show_Other(true, data.container_id, storage_table, money_state, size)
			end
		end)
	elseif data.item == "gold" then
		TriggerEvent("guminputs:getInput", Config.Language[3].text, Config.Language[5].text, function(cb)
			local count_gold = tonumber(cb)
			if count_gold ~= nil then
				if count_gold ~= 'close' and count_gold > 0 and tonumber(data.count) >= tonumber(count_gold) then
					TriggerServerEvent("gum_inventory:transfer_gold_from_storage", data.item, count_gold, data.container_id)
				else
					Show_Other(true, data.container_id, storage_table, money_state, size)
				end
			else
				Show_Other(true, data.container_id, storage_table, money_state, size)
			end
		end)
	else
		if data.weapon == false then
			TriggerEvent("guminputs:getInput", Config.Language[3].text, Config.Language[6].text, function(cb)
				local count_item = tonumber(cb)
				if count_item ~= nil then
					if count_item ~= 'close' and tonumber(count_item) > 0 and tonumber(data.count) >= tonumber(count_item) and Config.Max_Items >= tonumber(count_in_inventory+count_item*data.limit) then
						TriggerServerEvent("gum_inventory:transfer_item_from_storage", data.item, count_item, data.container_id)
					else
						Show_Other(true, data.container_id, storage_table, money_state, size)
					end
				else
					Show_Other(true, data.container_id, storage_table, money_state, size)
				end
			end)
		else
			if data.used == 1 then
				Show_Other(true, data.container_id, storage_table, money_state, size)
				exports['gum_notify']:DisplayLeftNotification(Config.Language[10].text, Config.Language[7].text, 'pistol', 2000)
			else
				TriggerServerEvent("gum_inventory:transfer_weapon_from_storage", data.item, data.container_id)
			end
		end
	end
end)

RegisterCommand("inv", function(source, args, rawCommand)
	Show_Items(true)
end)

-- RegisterCommand("locker_update", function(source, args, rawCommand)
-- 	TriggerServerEvent("gumCore:updatestorage", GetPlayerServerId(PlayerId()), args[1], args[2])
-- end)

-- RegisterCommand("locker_open", function(source, args, rawCommand)
--  	TriggerServerEvent("gumCore:openstorage", GetPlayerServerId(PlayerId()), args[1])
-- end)

-- RegisterCommand("locker_create", function(source, args, rawCommand)
-- 	TriggerServerEvent("gumCore:registerstorage", GetPlayerServerId(PlayerId()), args[1], args[2])
-- end)

RegisterNetEvent("gum:SelectedCharacter")
AddEventHandler("gum:SelectedCharacter", function(charid)
	Citizen.CreateThread(function()
		Citizen.Wait(100)
		TriggerServerEvent("gum_inventory:get_items")
		Citizen.Wait(500)
		TriggerServerEvent("gum_inventory:get_money")
		Citizen.Wait(3000)
		equip_weapon_login()
		Button_Prompt()
	end)
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(2000)
			if can_save == true and logged_true == true then
				local _, wepHash = GetCurrentPedWeapon(PlayerPedId(), true, 0, true)
				local ammo_type_weapon = ""
				local weaponEntityIndex = GetCurrentPedWeaponEntityIndex(PlayerPedId())
				local sended = false
				for k,v in pairs (new_ammo_table) do
					new_ammo_table[k] = nil
				end
				Citizen.Wait(0)
				for k,v in pairs(ammo_list) do
					if GetHashKey('GROUP_REPEATER') == GetWeapontypeGroup(wepHash) then					ammo_type_weapon = "REPEATER"					elseif GetHashKey('GROUP_SHOTGUN') == GetWeapontypeGroup(wepHash) then						ammo_type_weapon = "SHOTGUN"					elseif GetHashKey('GROUP_SNIPER') == GetWeapontypeGroup(wepHash) then						ammo_type_weapon = "RIFLE"
					elseif GetHashKey('GROUP_RIFLE') == GetWeapontypeGroup(wepHash) then					ammo_type_weapon = "RIFLE"				
					elseif GetHashKey('GROUP_REVOLVER') == GetWeapontypeGroup(wepHash) then					ammo_type_weapon = "REVOLVER"		elseif GetHashKey('GROUP_PISTOL') == GetWeapontypeGroup(wepHash) then					ammo_type_weapon = "PISTOL"elseif GetHashKey('GROUP_BOW') == GetWeapontypeGroup(wepHash) then					ammo_type_weapon = "ARROW"				elseif 1548507267 == GetWeapontypeGroup(wepHash) then					ammo_type_weapon = "THROWWABLE"				end
					if ammo_type_weapon ~= "" then
						if ammo_type_weapon ~= "THROWWABLE" then
							if string.match(v[2], ammo_type_weapon)  then
								for key,value in pairs(weapon_table) do
									if v[2] == "AMMO_RIFLE_VARMINT" then
										if value.used == 1 and wepHash == GetHashKey(value.name) and GetPedAmmoByType(PlayerPedId(), GetHashKey("AMMO_22")) ~= 0 then
											SetPedAmmoByType(PlayerPedId(), GetHashKey("AMMO_22"), GetPedAmmoByType(PlayerPedId(), GetHashKey("AMMO_22")))
											new_ammo_table["AMMO_22"] = GetPedAmmoByType(PlayerPedId(), GetHashKey("AMMO_22"))
										end
									else
										if value.used == 1 and wepHash == GetHashKey(value.name) and GetPedAmmoByType(PlayerPedId(), GetHashKey(v[2])) ~= 0 then
											SetPedAmmoByType(PlayerPedId(), GetHashKey(v[2]), GetPedAmmoByType(PlayerPedId(), GetHashKey(v[2])))
											new_ammo_table[v[2]] = GetPedAmmoByType(PlayerPedId(), GetHashKey(v[2]))
										end
									end
								end
							end
						end
						if ammo_type_weapon == "THROWWABLE" then
							for key,value in pairs(weapon_table) do
								if value.used == 1 and wepHash == GetHashKey(value.name) then
									if GetPedAmmoByType(PlayerPedId(), GetHashKey(v[2])) ~= 0 then
										if GetHashKey(v[2]) == GetPedAmmoTypeFromWeapon(PlayerPedId(), wepHash) then
											SetPedAmmoByType(PlayerPedId(), GetHashKey(v[2]), GetPedAmmoByType(PlayerPedId(), GetHashKey(v[2])))
											new_ammo_table[v[2]] = GetPedAmmoByType(PlayerPedId(), GetHashKey(v[2]))
											throwabble_id = v[2]
										end
									end
								end
							end
						end
					end
				end
				for k,v in pairs(ammo_list) do
					if GetHashKey('GROUP_REPEATER') == GetWeapontypeGroup(wepHash) then					ammo_type_weapon = "REPEATER"					elseif GetHashKey('GROUP_SHOTGUN') == GetWeapontypeGroup(wepHash) then						ammo_type_weapon = "SHOTGUN"					elseif GetHashKey('GROUP_SNIPER') == GetWeapontypeGroup(wepHash) then						ammo_type_weapon = "RIFLE"
					elseif GetHashKey('GROUP_RIFLE') == GetWeapontypeGroup(wepHash) then					ammo_type_weapon = "RIFLE"	
					elseif GetHashKey('GROUP_REVOLVER') == GetWeapontypeGroup(wepHash) then					ammo_type_weapon = "REVOLVER"		elseif GetHashKey('GROUP_PISTOL') == GetWeapontypeGroup(wepHash) then					ammo_type_weapon = "PISTOL"elseif GetHashKey('GROUP_BOW') == GetWeapontypeGroup(wepHash) then					ammo_type_weapon = "ARROW"				elseif 1548507267 == GetWeapontypeGroup(wepHash) then					ammo_type_weapon = "THROWWABLE"				end
					if ammo_type_weapon ~= "" then
						for key,value in pairs(weapon_table) do
							if value.used == 1 then
								if ammo_type_weapon ~= "THROWWABLE" then
									if (weaponEntityIndex ~= 0 and wepHash == GetHashKey(value.name)) then
										if not sended then
											sended = true
											if condition_level[value.id] ~= nil then
												if condition_level[value.id]+0.0001 <= 1.0 then
													condition_level[value.id] = condition_level[value.id]+0.0001
												end
												local weaponEntityIndex = GetCurrentPedWeaponEntityIndex(PlayerPedId())
												Citizen.InvokeNative(0xA7A57E89E965D839, weaponEntityIndex, tonumber(condition_level[value.id]))
												Citizen.InvokeNative(0x812CE61DEBCAB948, weaponEntityIndex, tonumber(condition_level[value.id]), 0)
												TriggerServerEvent("gum_inventory:save_ammo", value.name, new_ammo_table, condition_level[value.id])
											end
										end
									end
								end
								if ammo_type_weapon == "THROWWABLE" then
									if GetHashKey(value.name) == wepHash then
										if not sended then
											sended = true
											if new_ammo_table[throwabble_id] ~= backup_save_throw and is_last_ammo == false then
												backup_save_throw = new_ammo_table[throwabble_id]
												TriggerServerEvent("gum_inventory:save_ammo", value.name, new_ammo_table, 0.0)
											end
										end
									end
								end
								if ammo_type_weapon == "BOW" then
									if GetHashKey(value.name) == wepHash  then
										if not sended then
											sended = true
											TriggerServerEvent("gum_inventory:save_ammo", value.name, new_ammo_table, 0.0)
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end)
end)



RegisterNetEvent('gum_inventory:cleaning_weapons')
AddEventHandler('gum_inventory:cleaning_weapons', function()
    local ped = PlayerPedId()
    local cloth_clean = CreateObject(GetHashKey('s_balledragcloth01x'), GetEntityCoords(PlayerPedId()), false, true, false, false, true)
    local retval, weaponHash = GetCurrentPedWeapon(PlayerPedId(), false, weaponHash, false)
    local model = GetWeapontypeGroup(weaponHash)
	local weaponEntityIndex = GetCurrentPedWeaponEntityIndex(PlayerPedId())
	local object = GetObjectIndexFromEntityIndex(GetCurrentPedWeaponEntityIndex(PlayerPedId(),0))
    if model == 416676503 or model == -1101297303 then
        TriggerEvent("gum_inventory:CloseInv");
        Citizen.InvokeNative(0x72F52AA2D2B172CC,  PlayerPedId(), 1242464081, cloth_clean, GetHashKey("CLOTH"), GetHashKey("SHORTARM_CLEAN_ENTER"), 1, 0, -1.0)   
		for key,value in pairs(weapon_table) do
			if value.used == 1 then
				if weaponHash == GetHashKey(value.name)  then
					TriggerServerEvent("gum_inventory:save_cleaning", value.name, condition_level)
					Citizen.Wait(5000)
					condition_level[value.id] = 0.0
					condition_level[value.id] = 0.0
					Citizen.InvokeNative(0xA7A57E89E965D839, weaponEntityIndex, tonumber(condition_level[value.id]))
					Citizen.InvokeNative(0x812CE61DEBCAB948, weaponEntityIndex, tonumber(condition_level[value.id]), 0)
				end
			end
		end
    else
        TriggerEvent("gum_inventory:CloseInv");
        Citizen.InvokeNative(0x72F52AA2D2B172CC,  PlayerPedId(), 1242464081, cloth_clean, GetHashKey("CLOTH"), GetHashKey("LONGARM_CLEAN_ENTER"), 1, 0, -1.0)   
		for key,value in pairs(weapon_table) do
			if value.used == 1 then
				if weaponHash == GetHashKey(value.name)  then
					TriggerServerEvent("gum_inventory:save_cleaning", value.name, condition_level)
					Citizen.Wait(5000)
					condition_level[value.id] = 0.0
					condition_level[value.id] = 0.0
					Citizen.InvokeNative(0xA7A57E89E965D839, weaponEntityIndex, tonumber(condition_level[value.id]))
					Citizen.InvokeNative(0x812CE61DEBCAB948, weaponEntityIndex, tonumber(condition_level[value.id]), 0)
				end
			end
		end
    end
end)

RegisterNetEvent('gum_inventory:CloseInv')
AddEventHandler('gum_inventory:CloseInv', function()
	Show_Items(false, false)
	SetNuiFocus(false, false)
	guiEnabled = false
end)

function LoadModel(model)
	local timer = 0
	if not IsModelInCdimage(model) then
		return false
	end
	RequestModel(model)
	while not HasModelLoaded(model) and timer > 300 do
		timer = timer+1
		Wait(0)
	end
	return true
end

RegisterNetEvent('gum_inventory:reload_weap')
AddEventHandler('gum_inventory:reload_weap', function()
	RemoveAllWeapons()
	Citizen.Wait(500)
	for k,v in pairs(weapon_table) do
		if v.used == 1 then
			if Citizen.InvokeNative(0xD955FEE4B87AFA07, GetHashKey(v.name)) then
				if Citizen.InvokeNative(0xDDC64F5E31EEDAB6, GetHashKey(v.name)) or Citizen.InvokeNative(0xC212F1D05A8232BB, GetHashKey(v.name)) then
					if weapon_first_used ~= false and weapon_second_used == false then
						LoadWeaponChar(v.name, false)
						LoadCompAndAmmo(json.decode(v.ammo), json.decode(v.comps))
						SetDirtToWeapon(v.id, v.conditionlevel)
						weapon_second_used = v.name
					end
					if weapon_first_used == false and weapon_second_used == false then
						LoadWeaponChar(v.name, true)
						LoadCompAndAmmo(json.decode(v.ammo), json.decode(v.comps))
						SetDirtToWeapon(v.id, v.conditionlevel)
						weapon_first_used = v.name
					end
				end
			else
				if not Citizen.InvokeNative(0x0556E9D2ECF39D01, GetHashKey(v.name)) then
					if not Citizen.InvokeNative(0x30E7C16B12DA8211, GetHashKey(v.name)) then
						LoadWeaponChar(v.name)
					else
						Citizen.InvokeNative(0x5E3BDDBCB83F3D84, PlayerPedId(), GetHashKey(v.name), 0, false, true, true, 1.0)
						SetCurrentPedWeapon(PlayerPedId(),GetHashKey(v.name), true)
					end
					LoadCompAndAmmo(json.decode(v.ammo), json.decode(v.comps))
					SetDirtToWeapon(v.id, v.conditionlevel)
					if "weapon_melee_davy_lantern" == v.name then
						Citizen.InvokeNative(0xADF692B254977C0C, PlayerPedId(), GetHashKey('weapon_melee_davy_lantern'), 0, 12, 0, 0);
					else
						Citizen.InvokeNative(0xFCCC886EDE3C63EC, PlayerPedId(), false, true, true)
					end
				end
			end
			if Citizen.InvokeNative(0x0556E9D2ECF39D01, GetHashKey(v.name)) then
				if rifle_first_used ~= false and rifle_second_used == false then
					LoadWeaponChar(v.name)
					LoadCompAndAmmo(json.decode(v.ammo), json.decode(v.comps))
					SetDirtToWeapon(v.id, v.conditionlevel)
					rifle_second_used = v.name
				end
				if rifle_first_used == false and rifle_second_used == false then
					LoadWeaponChar(v.name)
					LoadCompAndAmmo(json.decode(v.ammo), json.decode(v.comps))
					SetDirtToWeapon(v.id, v.conditionlevel)
					rifle_first_used = v.name
				end
			end
		end
	end
end)

function equip_weapon_login()
	local login_continue = false
	RemoveAllWeapons()
	Citizen.Wait(500)
	addWardrobeInventoryItem("CLOTHING_ITEM_M_OFFHAND_000_TINT_004", 0xF20B6B4A);
	addWardrobeInventoryItem("UPGRADE_OFFHAND_HOLSTER", 0x39E57B01);
	for k,v in pairs(weapon_table) do
		if v.used == 1 then
			if Citizen.InvokeNative(0xD955FEE4B87AFA07, GetHashKey(v.name)) then
				if Citizen.InvokeNative(0xDDC64F5E31EEDAB6, GetHashKey(v.name)) or Citizen.InvokeNative(0xC212F1D05A8232BB, GetHashKey(v.name)) then
					if weapon_first_used ~= false and weapon_second_used == false then
						LoadWeaponChar(v.name, true)
						LoadCompAndAmmo(json.decode(v.ammo), json.decode(v.comps))
						SetDirtToWeapon(v.id, v.conditionlevel)
						weapon_second_used = v.name
					end
					if weapon_first_used == false and weapon_second_used == false then
						LoadWeaponChar(v.name, false)
						LoadCompAndAmmo(json.decode(v.ammo), json.decode(v.comps))
						SetDirtToWeapon(v.id, v.conditionlevel)
						weapon_first_used = v.name
					end
				end
			else
				if not Citizen.InvokeNative(0x0556E9D2ECF39D01, GetHashKey(v.name)) then
					if not Citizen.InvokeNative(0x30E7C16B12DA8211, GetHashKey(v.name)) then
						LoadWeaponChar(v.name)
					else
						Citizen.InvokeNative(0x5E3BDDBCB83F3D84, PlayerPedId(), GetHashKey(v.name), 0, false, true, true, 1.0)
						SetCurrentPedWeapon(PlayerPedId(),GetHashKey(v.name), true)
					end
					LoadCompAndAmmo(json.decode(v.ammo), json.decode(v.comps))
					SetDirtToWeapon(v.id, v.conditionlevel)
					if "weapon_melee_davy_lantern" == v.name then
						Citizen.InvokeNative(0xADF692B254977C0C, PlayerPedId(), GetHashKey('weapon_melee_davy_lantern'), 0, 12, 0, 0);
					else
						Citizen.InvokeNative(0xFCCC886EDE3C63EC, PlayerPedId(), false, true, true)
					end
				end
			end
			if Citizen.InvokeNative(0x0556E9D2ECF39D01, GetHashKey(v.name)) then
				if rifle_first_used ~= false and rifle_second_used == false then
					LoadWeaponChar(v.name)
					LoadCompAndAmmo(json.decode(v.ammo), json.decode(v.comps))
					SetDirtToWeapon(v.id, v.conditionlevel)
					rifle_second_used = v.name
				end
				if rifle_first_used == false and rifle_second_used == false then
					LoadWeaponChar(v.name)
					LoadCompAndAmmo(json.decode(v.ammo), json.decode(v.comps))
					SetDirtToWeapon(v.id, v.conditionlevel)
					rifle_first_used = v.name
				end
			end
		end
	end
	RemoveAllWeapons()
	Citizen.Wait(500)
	for k,v in pairs(weapon_table) do
		if v.used == 1 then
			if Citizen.InvokeNative(0xD955FEE4B87AFA07, GetHashKey(v.name)) then
				if Citizen.InvokeNative(0xDDC64F5E31EEDAB6, GetHashKey(v.name)) or Citizen.InvokeNative(0xC212F1D05A8232BB, GetHashKey(v.name)) then
					if weapon_first_used ~= false and weapon_second_used == false then
						LoadWeaponChar(v.name, false)
						LoadCompAndAmmo(json.decode(v.ammo), json.decode(v.comps))
						SetDirtToWeapon(v.id, v.conditionlevel)
						weapon_second_used = v.name
					end
					if weapon_first_used == false and weapon_second_used == false then
						LoadWeaponChar(v.name, true)
						LoadCompAndAmmo(json.decode(v.ammo), json.decode(v.comps))
						SetDirtToWeapon(v.id, v.conditionlevel)
						weapon_first_used = v.name
					end
				end
			else
				if not Citizen.InvokeNative(0x0556E9D2ECF39D01, GetHashKey(v.name)) then
					if not Citizen.InvokeNative(0x30E7C16B12DA8211, GetHashKey(v.name)) then
						LoadWeaponChar(v.name)
					else
						Citizen.InvokeNative(0x5E3BDDBCB83F3D84, PlayerPedId(), GetHashKey(v.name), 0, false, true, true, 1.0)
						SetCurrentPedWeapon(PlayerPedId(),GetHashKey(v.name), true)
					end
					LoadCompAndAmmo(json.decode(v.ammo), json.decode(v.comps))
					SetDirtToWeapon(v.id, v.conditionlevel)
					if "weapon_melee_davy_lantern" == v.name then
						Citizen.InvokeNative(0xADF692B254977C0C, PlayerPedId(), GetHashKey('weapon_melee_davy_lantern'), 0, 12, 0, 0);
					else
						Citizen.InvokeNative(0xFCCC886EDE3C63EC, PlayerPedId(), false, true, true)
					end
				end
			end
			if Citizen.InvokeNative(0x0556E9D2ECF39D01, GetHashKey(v.name)) then
				if rifle_first_used ~= false and rifle_second_used == false then
					LoadWeaponChar(v.name)
					LoadCompAndAmmo(json.decode(v.ammo), json.decode(v.comps))
					SetDirtToWeapon(v.id, v.conditionlevel)
					rifle_second_used = v.name
				end
				if rifle_first_used == false and rifle_second_used == false then
					LoadWeaponChar(v.name)
					LoadCompAndAmmo(json.decode(v.ammo), json.decode(v.comps))
					SetDirtToWeapon(v.id, v.conditionlevel)
					rifle_first_used = v.name
				end
			end
		end
		if k == #weapon_table then
			login_continue = true
		end
	end
	if #weapon_table == 0 then
		login_continue = true
	end
	while login_continue == false do
		Citizen.Wait(50)
	end
	Citizen.Wait(1000)
	if weapon_second_used ~= false and weapon_first_used ~= false then
		GiveWeaponToPed_2(PlayerPedId(), GetHashKey(weapon_second_used), 0, true,true, 3, false, 0.5, 1.0, 752097756, false,0, false);
		GiveWeaponToPed_2(PlayerPedId(), GetHashKey(weapon_first_used), 0, true, true, 2, false, 0.5, 1.0, 752097756, false, 0, false);
	end
	Citizen.InvokeNative(0xFCCC886EDE3C63EC, PlayerPedId(), false, true, true)
	Citizen.Wait(500)
	TriggerEvent("gum_character:selected_char")
	logged_true = true
	can_save = true
end

RegisterNUICallback('show_weapon', function(data, cb)
  local ped = PlayerPedId()
  local weapon_type = ""
  local _, weapon_hash = GetCurrentPedWeapon(ped, true, 0, true)
  if GetHashKey('GROUP_REPEATER') == GetWeapontypeGroup(weapon_hash) then
		weapon_type = "LONGARM"
	elseif GetHashKey('GROUP_SHOTGUN') == GetWeapontypeGroup(weapon_hash) then
		weapon_type = "LONGARM"
	elseif GetHashKey('GROUP_HEAVY') == GetWeapontypeGroup(weapon_hash) then
		weapon_type = "LONGARM"
	elseif GetHashKey('GROUP_RIFLE') == GetWeapontypeGroup(weapon_hash) then
		weapon_type = "LONGARM"
	elseif GetHashKey('GROUP_SNIPER') == GetWeapontypeGroup(weapon_hash) then
		weapon_type = "LONGARM"
	elseif GetHashKey('GROUP_REVOLVER') == GetWeapontypeGroup(weapon_hash) then
		weapon_type = "SHORTARM"
	elseif GetHashKey('GROUP_PISTOL') == GetWeapontypeGroup(weapon_hash) then
		weapon_type = "SHORTARM"
	end

	if weapon_type ~= "" then
  		TaskItemInteraction(PlayerPedId(), weapon_hash, GetHashKey(""..weapon_type.."_HOLD"), 1, 0, 0)
		  Show_Items(false, false)
		  SetNuiFocus(false, false)
		  guiEnabled = false
	else
		exports['gum_notify']:DisplayLeftNotification(Config.Language[10].text, Config.Language[11].text, 'pistol', 2000)
	end
end)

RegisterNUICallback('put_clothe', function(data, cb)
	if tonumber(data.clothe) == 1 then--Klobouk
		ExecuteCommand("klobouk")
	elseif tonumber(data.clothe) == 2 then--Brýle
		ExecuteCommand("bryle")
	elseif tonumber(data.clothe) == 3 then--Masku
		ExecuteCommand("maska")
	elseif tonumber(data.clothe) == 4 then--Bandana
		ExecuteCommand("bandana")
	elseif tonumber(data.clothe) == 5 then--Kravata,šátek
		ExecuteCommand("satek")
		ExecuteCommand("kravata")
	elseif tonumber(data.clothe) == 6 then--Plášť pončo
		ExecuteCommand("plast")
		ExecuteCommand("poncho")
	elseif tonumber(data.clothe) == 7 then--Košile
		ExecuteCommand("kosile")
	elseif tonumber(data.clothe) == 8 then--Vesta
		ExecuteCommand("vesta")
	elseif tonumber(data.clothe) == 9 then--kabát
		ExecuteCommand("kabat")
	elseif tonumber(data.clothe) == 10 then--Pásy,Doplnky,Brašny
		ExecuteCommand("brasny")
		ExecuteCommand("pasy")
	elseif tonumber(data.clothe) == 11 then--Prsteny
		ExecuteCommand("prsteny")
	elseif tonumber(data.clothe) == 12 then--Rukavice
		ExecuteCommand("rukavice")
	elseif tonumber(data.clothe) == 13 then--Nátepníky
		ExecuteCommand("natepniky")
	elseif tonumber(data.clothe) == 14 then--Belt
		ExecuteCommand("opasek")
		ExecuteCommand("pdoplnek")
		ExecuteCommand("pouzdro")
		ExecuteCommand("druhepouzdro")
	elseif tonumber(data.clothe) == 15 then--Kšandy
		ExecuteCommand("ksandy")
	elseif tonumber(data.clothe) == 16 then--Kalhoty,Chaps,Kšandy
		ExecuteCommand("kalhoty")
		ExecuteCommand("chaps")
		ExecuteCommand("kamase")
		ExecuteCommand("sukne")
	elseif tonumber(data.clothe) == 17 then--Boty
		ExecuteCommand("boty")
		ExecuteCommand("ostruhy")
	end
end)

function RemoveAllWeapons()
	for k,v in pairs(weapon_table) do
		RemoveWeaponFromPed(PlayerPedId(), GetHashKey(v.name))
	end
	weapon_first_used = false
	weapon_second_used = false
	rifle_first_used = false
	rifle_second_used = false
end

RegisterNUICallback('use_UseWeapon', function(data, cb)
	can_save = false
	if equip_spam == false then
		equip_spam = true
		for k,v in pairs(weapon_table) do
			if v.used == 1 and tonumber(data.id) == v.id then
				if v.name == weapon_first_used and data.model == weapon_first_used then
					TriggerServerEvent("gum_inventory:send_state_weapon", data.id, 0)
					RemoveWeaponFromPed(PlayerPedId(), GetHashKey(data.model))
					weapon_first_used = false
					equip_spam = false
					exports['gum_notify']:DisplayLeftNotification(Config.Language[10].text, ""..Config.Language[20].text.."", 'bag', 1000)
					return false
				elseif v.name == weapon_second_used and data.model == weapon_second_used then
					TriggerServerEvent("gum_inventory:send_state_weapon", data.id, 0)
					RemoveWeaponFromPed(PlayerPedId(), GetHashKey(data.model))
					weapon_second_used = false
					equip_spam = false
					exports['gum_notify']:DisplayLeftNotification(Config.Language[10].text, ""..Config.Language[19].text.."", 'bag', 1000)
					return false
				elseif v.name == rifle_first_used and data.model == rifle_first_used then
					RemoveWeaponFromPed(PlayerPedId(), GetHashKey(data.model))
					TriggerServerEvent("gum_inventory:send_state_weapon", data.id, 0)
					rifle_first_used = false
					equip_spam = false
					exports['gum_notify']:DisplayLeftNotification(Config.Language[10].text, ""..Config.Language[22].text.."", 'bag', 1000)
					return false
				elseif v.name == rifle_second_used and data.model == rifle_second_used then
					TriggerServerEvent("gum_inventory:send_state_weapon", data.id, 0)
					RemoveWeaponFromPed(PlayerPedId(), GetHashKey(data.model))
					rifle_second_used = false
					equip_spam = false
					exports['gum_notify']:DisplayLeftNotification(Config.Language[10].text, ""..Config.Language[23].text.."", 'bag', 1000)
					return false
				else
					if data.model == v.name and tonumber(data.id) == v.id then
						TriggerServerEvent("gum_inventory:send_state_weapon", data.id, 0)
						RemoveWeaponFromPed(PlayerPedId(), GetHashKey(data.model))
						equip_spam = false
						exports['gum_notify']:DisplayLeftNotification(Config.Language[10].text, ""..Config.Language[21].text.."", 'bag', 1000)
						return false
					end
				end
			end
		end
		for k,v in pairs(weapon_table) do
			if v.name == data.model and v.used == 0 and tonumber(data.id) == v.id then
				if Citizen.InvokeNative(0xD955FEE4B87AFA07, GetHashKey(v.name)) then
					if Citizen.InvokeNative(0xDDC64F5E31EEDAB6, GetHashKey(v.name)) or Citizen.InvokeNative(0xC212F1D05A8232BB, GetHashKey(v.name)) or Citizen.InvokeNative(0xC75386174ECE95D5, GetHashKey(v.name)) then
						if weapon_first_used == false then
							LoadWeaponChar(v.name, false)
							LoadCompAndAmmo(json.decode(v.ammo), json.decode(v.comps))
							SetDirtToWeapon(v.id, v.conditionlevel)
							Citizen.InvokeNative(0xFCCC886EDE3C63EC, PlayerPedId(), false, true, true)
							TriggerServerEvent("gum_inventory:send_state_weapon", data.id, 1)
							weapon_first_used = v.name
							exports['gum_notify']:DisplayLeftNotification(Config.Language[10].text, ""..Config.Language[12].text.."", 'bag', 1000)
						elseif weapon_second_used == false then
							LoadWeaponChar(v.name, true)
							LoadCompAndAmmo(json.decode(v.ammo), json.decode(v.comps))
							SetDirtToWeapon(v.id, v.conditionlevel)
							Citizen.InvokeNative(0xFCCC886EDE3C63EC, PlayerPedId(), false, true, true)
							TriggerServerEvent("gum_inventory:send_state_weapon", data.id, 1)
							weapon_second_used = v.name
							exports['gum_notify']:DisplayLeftNotification(Config.Language[10].text, ""..Config.Language[13].text.."", 'bag', 1000)
						end
					end
				else
					if not Citizen.InvokeNative(0x0556E9D2ECF39D01, GetHashKey(v.name)) then
						if not Citizen.InvokeNative(0x30E7C16B12DA8211, GetHashKey(v.name)) then
							LoadWeaponChar(v.name)
						else
							Citizen.InvokeNative(0x5E3BDDBCB83F3D84, PlayerPedId(), GetHashKey(v.name), 0, false, true, true, 1.0)
							SetCurrentPedWeapon(PlayerPedId(),GetHashKey(v.name), true)
						end
						LoadCompAndAmmo(json.decode(v.ammo), json.decode(v.comps))
						SetDirtToWeapon(v.id, v.conditionlevel)
						Citizen.InvokeNative(0xFCCC886EDE3C63EC, PlayerPedId(), false, true, true)
						TriggerServerEvent("gum_inventory:send_state_weapon", data.id, 1)
						exports['gum_notify']:DisplayLeftNotification(Config.Language[10].text, ""..Config.Language[18].text.."", 'bag', 1000)
					end
				end
				if Citizen.InvokeNative(0x0556E9D2ECF39D01, GetHashKey(v.name)) then
					if rifle_first_used == false then
						LoadWeaponChar(v.name)
						LoadCompAndAmmo(json.decode(v.ammo), json.decode(v.comps))
						SetDirtToWeapon(v.id, v.conditionlevel)
						Citizen.InvokeNative(0xFCCC886EDE3C63EC, PlayerPedId(), false, true, true)
						TriggerServerEvent("gum_inventory:send_state_weapon", data.id, 1)
						rifle_first_used = v.name
						exports['gum_notify']:DisplayLeftNotification(Config.Language[10].text, ""..Config.Language[15].text.."", 'bag', 1000)
					elseif rifle_second_used == false then
						LoadWeaponChar(v.name)
						LoadCompAndAmmo(json.decode(v.ammo), json.decode(v.comps))
						SetDirtToWeapon(v.id, v.conditionlevel)
						Citizen.InvokeNative(0xFCCC886EDE3C63EC, PlayerPedId(), false, true, true)
						TriggerServerEvent("gum_inventory:send_state_weapon", data.id, 1)
						rifle_second_used = v.name
						exports['gum_notify']:DisplayLeftNotification(Config.Language[10].text, ""..Config.Language[16].text.."", 'bag', 1000)
					end
				end
			end
		end
		equip_spam = false
	end
	can_save = true
end)


function LoadWeaponChar(name, dual)
	while wep_load ~= GetHashKey(name) do
		_, wep_load = GetCurrentPedWeapon(PlayerPedId(), true, 0, true)
		if dual == false then
			givePlayerWeapon(name, 2);
		end
		if dual == true then
			givePlayerWeapon(name, 3);
		end
		if dual == nil then
			Citizen.InvokeNative(0x5E3BDDBCB83F3D84, PlayerPedId(), GetHashKey(name), 0, false, true, true, 1.0)
		end
		SetCurrentPedWeapon(PlayerPedId(),GetHashKey(name), true)
		Citizen.Wait(300)
	end
	wep_load = nil
end

function LoadCompAndAmmo(ammo, comps)
	TriggerEvent("gum_weapons:load_components", comps)
	for k2,v2 in pairs(ammo) do
		SetPedAmmoByType(PlayerPedId(), GetHashKey(k2), v2);
	end
end

function SetDirtToWeapon(wpId, wpCondition)
	local weaponEntityIndex = GetCurrentPedWeaponEntityIndex(PlayerPedId())
	Citizen.InvokeNative(0xA7A57E89E965D839, weaponEntityIndex, tonumber(wpCondition))
	Citizen.InvokeNative(0x812CE61DEBCAB948, weaponEntityIndex, tonumber(wpCondition), 0)
	condition_level[wpId] = tonumber(wpCondition)
	Citizen.Wait(1000)
end

RegisterNetEvent('gum_inventory:remove_wepo')
AddEventHandler('gum_inventory:remove_wepo', function(model)
	if rifle_first_used == model then
		rifle_first_used = false
	end
	if rifle_second_used == model then
		rifle_second_used = false
	end
	if weapon_first_used == model then
		weapon_first_used = false
	end
	if weapon_second_used == model then
		weapon_second_used = false
	end
	RemoveWeaponFromPed(PlayerPedId(), GetHashKey(model))
end)

RegisterNetEvent('gum_inventory:send_list_money')
AddEventHandler('gum_inventory:send_list_money', function(money, gold)
	money_state = money
	gold_state = gold
end)
RegisterNetEvent('gum_inventory:send_list_inventory')
AddEventHandler('gum_inventory:send_list_inventory', function(table, wtable, ttable, wptable)
	count_in_inventory = 0.0
	for k,v in pairs(table) do
		count_in_inventory = v.count*v.limit+count_in_inventory
	end
	if count_in_inventory >= 45 then
		speed = 1.6
	elseif count_in_inventory >= 42 then
		speed = 1.7
	elseif count_in_inventory >= 39 then
		speed = 1.8
	elseif count_in_inventory >= 35 then
		speed = 1.9
	elseif count_in_inventory >= 30 then
		speed = 2.1
	elseif count_in_inventory >= 27 then
		speed = 2.2
	else
		speed = 0.0
	end

	inventory_table = table
	weapon_table = wtable
	itm_table = ttable

	wp_table = wptable
	for k,v in pairs(weapon_table) do
		if v.used == 1 then
			for k2,v2 in pairs(json.decode(v.ammo)) do
				SetPedAmmoByType(PlayerPedId(), GetHashKey(k2), v2);
			end
		end
	end
end)

AddEventHandler('onResourceStop', function(resourceName)
	if (GetCurrentResourceName() == resourceName) then
		for k,v in pairs(dropped_items_entity) do
            DeleteEntity(v.entity)
        end
	end
end)

local _item = 0
local _count = 0
local _id = 0
Citizen.CreateThread(function()
	while true do
		for k,v in pairs(dropped_items_entity) do
			local coords_p = GetEntityCoords(PlayerPedId())
			local coords_i = GetEntityCoords(v.entity)
			local distance = GetDistanceBetweenCoords(coords_p.x, coords_p.y, coords_p.z, coords_i.x, coords_i.y, coords_i.z, false)
			if (2.0 > distance) then
				if (v.item.."_"..v.count.."_"..v.id ~= _item.."_".._count.."_".._id) then
					for k,v in pairs(dropped_items_entity) do
						DeleteEntity(v.entity)
					end
					Citizen.Wait(500)
					_item = v.item 
					_count = v.count
					_id = v.id
					TriggerServerEvent("gum_inventory:check_drops_1")
				end
			end
		end
		Citizen.Wait(100)
	end
end)

Citizen.CreateThread(function()
	TriggerServerEvent("gum_inventory:check_drops_1")
	while true do
		is_last_ammo = false
		if Citizen.InvokeNative(0x305C8DCD79DA8B0F, 0, 0x4CC0E2FE) then
			Show_Items(true)
		end
		if Citizen.InvokeNative(0x305C8DCD79DA8B0F, 0, 0x52D29063) then
			if weapon_first_used ~= false and weapon_second_used ~= false then
				Citizen.InvokeNative(0x5E3BDDBCB83F3D84, PlayerPedId(), GetHashKey(weapon_first_used), 0, 1, 1, 2, 0, 0.5, 1.0, GetHashKey('ADD_REASON_DEFAULT'), 0, 0.0, false)
				Citizen.InvokeNative(0x5E3BDDBCB83F3D84, PlayerPedId(), GetHashKey(weapon_second_used), 0, 1, 1, 3, 1, 0.5, 1.0, GetHashKey('ADD_REASON_DEFAULT'), 1, 0.0, false)
				Citizen.InvokeNative(0xADF692B254977C0C, PlayerPedId(), GetHashKey(weapon_first_used), 0, 0, 0, 0);
				Citizen.InvokeNative(0xADF692B254977C0C, PlayerPedId(), GetHashKey(weapon_second_used), 0, 1, 0, 0);
			end
		end
		for k,v in pairs(dropped_items_entity) do
			local coords_p = GetEntityCoords(PlayerPedId())
			local coords_i = GetEntityCoords(v.entity)
			local distance = GetDistanceBetweenCoords(coords_p.x, coords_p.y, coords_p.z, coords_i.x, coords_i.y, coords_i.z, false)
			local closestPlayer, closestDistance, playerid, tgt1 = GetClosestPlayer()
			if (1.0 > distance) and (closestDistance >= 2.0 or closestDistance == -1) then
				if (v.item.."_"..v.count.."_".._id == _item.."_".._count.."_".._id) then
					if active == false then
						if v.weapon == false then 
							if v.item ~= "money" and v.item ~= "gold" then
								for key,value in pairs(itm_table) do
									if value.item == v.item then
										local item_name = CreateVarString(10, 'LITERAL_STRING', ""..Config.Language[24].text.." : "..v.count.."x "..value.label.."")
										PromptSetActiveGroupThisFrame(buttons_prompt, item_name)
									end
								end
							else
								if v.item == "money" then
									local item_name = CreateVarString(10, 'LITERAL_STRING', ""..Config.Language[26].text.." : "..v.count.."$")
									PromptSetActiveGroupThisFrame(buttons_prompt, item_name)
								else
									if v.item == "gold" then
										local item_name = CreateVarString(10, 'LITERAL_STRING', ""..Config.Language[25].text.." : "..v.count.."G")
										PromptSetActiveGroupThisFrame(buttons_prompt, item_name)
									end
								end
							end
						else
							for key,value in pairs(wp_table) do
								if value.item == v.weapon_model then
									local item_name = CreateVarString(10, 'LITERAL_STRING', ""..Config.Language[27].text.." : "..value.label)
									PromptSetActiveGroupThisFrame(buttons_prompt, item_name)
								end
							end
						end
						if Citizen.InvokeNative(0x305C8DCD79DA8B0F, 0, 0x27D1C284) then
							if v.weapon == false then 
								if v.item ~= "money" and v.item ~= "gold" then
									if Citizen.InvokeNative(0x305C8DCD79DA8B0F, 0, 0x27D1C284) then
										local table_pl = {}
										for k,v in pairs(GetPlayers()) do
											local mycoords = GetEntityCoords(PlayerPedId())
											local targetCoords = GetEntityCoords(GetPlayerPed(v))
											local distance = GetDistanceBetweenCoords(mycoords.x, mycoords.y, mycoords.z, targetCoords.x, targetCoords.y, targetCoords.z, false)
											if (20.0 > distance) then
												if GetPlayerServerId(PlayerId()) ~= GetPlayerServerId(v) then
													table.insert(table_pl, {name=GetPlayerName(v), id=GetPlayerServerId(v)})
												end
											end
										end
										Citizen.Wait(0)
										TriggerServerEvent("gum_inventory:drop_update", v.id, table_pl)
										playAnim("mech_pickup@fish_bag@pickup_handheld", "pickup", 2000, 1)
										RequestControl(v.entity)
										Citizen.Wait(500)
										DeleteEntity(v.entity)
										table.remove(dropped_items_entity, k)
										TriggerServerEvent("gumCore:addItem", GetPlayerServerId(PlayerId()), v.item, v.count)
										Citizen.Wait(1000)
									end
								else
									if v.item == "money" then
										local table_pl = {}
										for k,v in pairs(GetPlayers()) do
											local mycoords = GetEntityCoords(PlayerPedId())
											local targetCoords = GetEntityCoords(GetPlayerPed(v))
											local distance = GetDistanceBetweenCoords(mycoords.x, mycoords.y, mycoords.z, targetCoords.x, targetCoords.y, targetCoords.z, false)
											if (20.0 > distance) then
												if GetPlayerServerId(PlayerId()) ~= GetPlayerServerId(v) then
													table.insert(table_pl, {name=GetPlayerName(v), id=GetPlayerServerId(v)})
												end
											end
										end
										Citizen.Wait(0)
										TriggerServerEvent("gum_inventory:drop_update", v.id, table_pl)
										playAnim("mech_pickup@fish_bag@pickup_handheld", "pickup", 2000, 1)
										RequestControl(v.entity)
										Citizen.Wait(500)
										DeleteEntity(v.entity)
										table.remove(dropped_items_entity, k)
										TriggerServerEvent("gum_inventory:drop_give_money", v.count)
										Citizen.Wait(1000)
									else
										local table_pl = {}
										for k,v in pairs(GetPlayers()) do
											local mycoords = GetEntityCoords(PlayerPedId())
											local targetCoords = GetEntityCoords(GetPlayerPed(v))
											local distance = GetDistanceBetweenCoords(mycoords.x, mycoords.y, mycoords.z, targetCoords.x, targetCoords.y, targetCoords.z, false)
											if (20.0 > distance) then
												if GetPlayerServerId(PlayerId()) ~= GetPlayerServerId(v) then
													table.insert(table_pl, {name=GetPlayerName(v), id=GetPlayerServerId(v)})
												end
											end
										end
										Citizen.Wait(0)
										TriggerServerEvent("gum_inventory:drop_update", v.id, table_pl)
										playAnim("mech_pickup@fish_bag@pickup_handheld", "pickup", 2000, 1)
										RequestControl(v.entity)
										Citizen.Wait(500)
										DeleteEntity(v.entity)
										table.remove(dropped_items_entity, k)
										TriggerServerEvent("gum_inventory:drop_give_gold", v.count)
										Citizen.Wait(1000)
									end
								end
							else
								local table_pl = {}
								for k,v in pairs(GetPlayers()) do
									local mycoords = GetEntityCoords(PlayerPedId())
									local targetCoords = GetEntityCoords(GetPlayerPed(v))
									local distance = GetDistanceBetweenCoords(mycoords.x, mycoords.y, mycoords.z, targetCoords.x, targetCoords.y, targetCoords.z, false)
									if (20.0 > distance) then
										if GetPlayerServerId(PlayerId()) ~= GetPlayerServerId(v) then
											table.insert(table_pl, {name=GetPlayerName(v), id=GetPlayerServerId(v)})
										end
									end
								end
								Citizen.Wait(0)
								TriggerServerEvent("gum_inventory:drop_update", v.id, table_pl)
								playAnim("mech_pickup@fish_bag@pickup_handheld", "pickup", 2000, 1)
								RequestControl(v.entity)
								Citizen.Wait(500)
								DeleteEntity(v.entity)
								table.remove(dropped_items_entity, k)
								TriggerServerEvent("gumCore:giveWeapon_dropped", GetPlayerServerId(PlayerId()), v.item)
								Show_Items(false, false)
								SetNuiFocus(false, false)
								guiEnabled = false
								Citizen.Wait(1000)
							end
						end
					end
				end
			end
		end
		local _, wepHash = GetCurrentPedWeapon(PlayerPedId(), true, 0, true)
		if GetHashKey('weapon_melee_davy_lantern') == wepHash  then
			if Citizen.InvokeNative(0x305C8DCD79DA8B0F, 0, 0x53296B75) then
				if Citizen.InvokeNative(0x305C8DCD79DA8B0F, 0, 0x53296B75) then
					GiveWeaponToPed_2(PlayerPedId(), GetHashKey('weapon_melee_davy_lantern'), 0, true,true, 12, false, 0.5, 1.0, 752097756, false,0, false);
					Citizen.InvokeNative(0xADF692B254977C0C, PlayerPedId(), GetHashKey('weapon_melee_davy_lantern'), 0, 12, 0, 0);
				end
			end
		end
		for key,value in pairs(weapon_table) do
			if value.used == 1 then
				local _, wepHash = GetCurrentPedWeapon(PlayerPedId(), true, 0, true)
				if GetHashKey(value.name) == wepHash then
					if string.find(value.name, "THROWN")  then
						if GetAmmoInPedWeapon(PlayerPedId(),wepHash) == 1 then
							is_last_ammo = true
							if Citizen.InvokeNative(0x305C8DCD79DA8B0F, 0, 0x07CE1E61) then
								new_ammo_table = {}
								TriggerServerEvent("gum_inventory:save_ammo", value.name, new_ammo_table, 0.0)
							end
						end
					end
				end
			end
		end
		Citizen.Wait(10)
	end
end)

Citizen.CreateThread(function()
	local player_prompt
	local player_prompt2
	while true do
		local combat_stance = IsPedInMeleeCombat(PlayerPedId())
		if slot1 ~= "" then
			DisableControlAction(0, 0x1CE6D9EB, true)
			if Citizen.InvokeNative(0x305C8DCD79DA8B0F, 0, 0x1CE6D9EB) then
				for k,v in pairs(inventory_table) do
					if v.item == slot1 then
						TriggerServerEvent("gum:use", slot1)
					end
				end
			end
		end
		if slot2 ~= "" then
			DisableControlAction(0, 0x4F49CC4C, true)
			if Citizen.InvokeNative(0x305C8DCD79DA8B0F, 0, 0x4F49CC4C) then
				for k,v in pairs(inventory_table) do
					if v.item == slot2 then
						TriggerServerEvent("gum:use", slot2)
					end
				end
			end
		end
		if slot3 ~= "" then
			DisableControlAction(0, 0x8F9F9E58, true)
			if Citizen.InvokeNative(0x305C8DCD79DA8B0F, 0, 0x8F9F9E58) then
				for k,v in pairs(inventory_table) do
					if v.item == slot3 then
						TriggerServerEvent("gum:use", slot3)
					end
				end
			end
		end
		if slot4 ~= "" then
			DisableControlAction(0, 0xAB62E997, true)
			if Citizen.InvokeNative(0x305C8DCD79DA8B0F, 0, 0xAB62E997) then
				for k,v in pairs(inventory_table) do
					if v.item == slot4 then
						TriggerServerEvent("gum:use", slot4)
					end
				end
			end
		end
		if slot5 ~= "" then
			DisableControlAction(0, 0xA1FDE2A6, true)
			if Citizen.InvokeNative(0x305C8DCD79DA8B0F, 0, 0xA1FDE2A6) then
				for k,v in pairs(inventory_table) do
					if v.item == slot5 then
						TriggerServerEvent("gum:use", slot5)
					end
				end
			end
		end
		DisableControlAction(0, 0xE2B557A3, true)
		DisableControlAction(0, 0x1C826362, true)
		DisableControlAction(0, 0x7E75F4DC, true)
		cant_target = false
		local isTargetting, targetEntity = GetPlayerTargetEntity(PlayerId())
		local closestPlayer, closestDistance, playerid, tgt1 = GetClosestPlayer()
		local coords = GetEntityCoords(tgt1, true)
		local holding = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
		if isTargetting and tgt1 == targetEntity and cant_target == false and holding == false then
			SetPedNameDebug(tgt1, playerid)
			SetPedPromptName(tgt1, playerid)
			for k,v in pairs(GetPlayers()) do
				local mycoords = GetEntityCoords(PlayerPedId())
				local targetCoords = GetEntityCoords(GetPlayerPed(v))
				local distance = GetDistanceBetweenCoords(mycoords.x, mycoords.y, mycoords.z, targetCoords.x, targetCoords.y, targetCoords.z, false)
				if (10.0 > distance) then
					DrawText3D(targetCoords.x,targetCoords.y,targetCoords.z+0.40, ""..GetPlayerServerId(v).."")
				end
			end

			if player_prompt then
				player_prompt:delete()
			end
			if player_prompt2 then
				player_prompt2:delete()
			end
			if combat_stance == false and not IsEntityDead(tgt1) then
				local promptGroup = PromptGetGroupIdForTargetEntity(tgt1)
				player_prompt = Uiprompt:new(`INPUT_CONTEXT_X`, ""..Config.Language[28].text.."", promptGroup)
				player_prompt2 = Uiprompt:new(`INPUT_INTERACT_OPTION1`, ""..Config.Language[29].text.."", promptGroup)
				player_prompt:setHoldMode(true)
				player_prompt2:setHoldMode(true)
				if Citizen.InvokeNative(0x305C8DCD79DA8B0F, 0, `INPUT_INTERACT_OPTION1`) then
					TriggerServerEvent("gum_inventory:give_slap", playerid)
					Citizen.Wait(2000)
				end
				if Citizen.InvokeNative(0x305C8DCD79DA8B0F, 0, `INPUT_CONTEXT_X`) then
					TriggerServerEvent("gum_inventory:give_hand", playerid)
					Citizen.Wait(2000)
				end
			end
		end
		if tonumber(speed) ~= 0 then
			SetPedMaxMoveBlendRatio(PlayerPedId(), speed)
		end
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('gum_inventory:send_slap')
AddEventHandler('gum_inventory:send_slap', function(who, random, take_or_give)
	local closestPlayer, closestDistance, playerid, tgt1 = GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 2.5 then
		if tonumber(who) == tonumber(playerid) then
			TaskTurnPedToFaceEntity(PlayerPedId(), tgt1, 2000)
			Citizen.Wait(2000)
			if tonumber(random) == 1 then
				if take_or_give then
					playAnim("mech_melee@unarmed@posse@ambient@healthy@noncombat", "slap_front_drunk_vs_drunk_heavy_v1_att", 4000, 1)
				else
					playAnim("mech_melee@unarmed@posse@ambient@healthy@noncombat", "slap_front_drunk_vs_drunk_heavy_v1_vic", 5500, 1)
				end
			elseif tonumber(random) == 2 then
				if take_or_give then
					playAnim("mech_melee@unarmed@posse@ambient@healthy@noncombat", "slap_front_drunk_vs_drunk_medium_v1_att", 4000, 1)
				else
					playAnim("mech_melee@unarmed@posse@ambient@healthy@noncombat", "slap_front_drunk_vs_drunk_medium_v1_vic", 6000, 1)
				end
			elseif tonumber(random) == 3 then
				if take_or_give then
					playAnim("mech_melee@unarmed@posse@ambient@healthy@noncombat", "slap_front_sober_vs_drunk_heavy_v1_att", 4000, 1)
				else
					playAnim("mech_melee@unarmed@posse@ambient@healthy@noncombat", "slap_front_sober_vs_drunk_heavy_v1_vic", 6000, 1)
				end
			elseif tonumber(random) == 4 then
				if take_or_give then
					playAnim("mech_melee@unarmed@posse@ambient@healthy@noncombat", "slap_front_sober_vs_drunk_medium_v1_att", 4000, 1)
				else
					playAnim("mech_melee@unarmed@posse@ambient@healthy@noncombat", "slap_front_sober_vs_drunk_medium_v1_vic", 5000, 1)
				end
			elseif tonumber(random) == 5 then
				if take_or_give then
					playAnim("mech_melee@unarmed@posse@ambient@healthy@noncombat", "slap_front_drunk_vs_drunk_heavy_v3_att", 6000, 1)
				else
					playAnim("mech_melee@unarmed@posse@ambient@healthy@noncombat", "slap_front_drunk_vs_drunk_heavy_v3_vic", 4000, 1)
				end
			elseif tonumber(random) == 6 then	
				if take_or_give then
					playAnim("mech_melee@unarmed@posse@ambient@healthy@noncombat", "slap_front_sober_vs_drunk_light_v1_att", 3000, 1)
				else
					Citizen.Wait(100)
					playAnim("mech_melee@unarmed@posse@ambient@healthy@noncombat", "slap_front_sober_vs_drunk_light_v1_vic", 4000, 1)
				end
			elseif tonumber(random) == 7 then
				if take_or_give then
					playAnim("mech_melee@unarmed@posse@ambient@healthy@noncombat", "slap_front_sober_vs_drunk_light_v2_att", 4000, 1)
				else
					playAnim("mech_melee@unarmed@posse@ambient@healthy@noncombat", "slap_front_sober_vs_drunk_light_v2_vic", 4000, 1)
				end
			end
		end
	end
end)


RegisterNetEvent('gum_inventory:send_hand')
AddEventHandler('gum_inventory:send_hand', function(who, take_or_give)
	local closestPlayer, closestDistance, playerid, tgt1 = GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 2.5 then
		if tonumber(who) == tonumber(playerid) then
			TaskTurnPedToFaceEntity(PlayerPedId(), tgt1, 2000)
			Citizen.Wait(1500)
			FreezeEntityPosition(PlayerPedId(), true)
			Citizen.Wait(500)
			if take_or_give then
				SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId())-17.0)
				playAnim2("script_story@ind1@leadin@int", "greet_f_player", 800, 1)
			else
				SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId())-17.0)
				playAnim2("script_story@ind1@leadin@int", "greet_f_player", 800, 1)
			end
			Citizen.Wait(100)
			FreezeEntityPosition(PlayerPedId(), false)
		end
	end
end)

RegisterNetEvent('gum_inventory:update_list_inventory')
AddEventHandler('gum_inventory:update_list_inventory', function(table, name, count, update_full,ttable,wptable)
	inventory_table = {}
	inventory_table = table
	itm_table = ttable
	wp_table = wptable
	count_in_inventory = 0.0
	for k,v in pairs(table) do
		count_in_inventory = v.count*v.limit+count_in_inventory
	end
	if count_in_inventory >= 45 then
		speed = 1.6
	elseif count_in_inventory >= 42 then
		speed = 1.7
	elseif count_in_inventory >= 39 then
		speed = 1.8
	elseif count_in_inventory >= 35 then
		speed = 1.9
	elseif count_in_inventory >= 30 then
		speed = 2.1
	elseif count_in_inventory >= 27 then
		speed = 2.2
	else
		speed = 0.0
	end

	if update_full == true then
		SendNUIMessage({
			type = "inventory_update",
			update = update_full,
			table_for_json = inventory_table,
			wtable_for_json = weapon_table,
			money = money_state,
			gold = gold_state,
		})
	else
		SendNUIMessage({
			type = "inventory_update",
			update = update_full,
			iditem = name,
			idcount = count,
			table_for_json = inventory_table,
			wtable_for_json = weapon_table,
			money = money_state,
			gold = gold_state,
		})
	end
end)

RegisterNUICallback('use_item', function(data, cb)
	if id_container == 0 then
		TriggerServerEvent("gum:use", data.item)
	end
end)

RegisterNUICallback('give_checked_item', function(data, cb)
	if data.is == "item" then
		if data.item ~= "money" and data.item ~= "gold" then
			if tonumber(data.count) >= 1 then
				for k,v in pairs(inventory_table) do
					if v.item == data.item then 
						if v.count >= tonumber(data.count) then
							Show_Items(false, false)
							SetNuiFocus(false, false)
							guiEnabled = false
							TriggerServerEvent("gum_inventory:turn_ped", data.id)
							TriggerServerEvent("gumCore:subItem", GetPlayerServerId(PlayerId()), data.item, data.count)
							TriggerServerEvent("gumCore:addItem", tonumber(data.id), data.item, data.count, GetPlayerServerId(PlayerId()))
							-- Citizen.Wait(1000)
							-- TriggerServerEvent("gumCore:giveItem", data.id, data.item, data.count, GetPlayerServerId(PlayerId()))
						else
							exports['gum_notify']:DisplayLeftNotification(Config.Language[10].text, ""..Config.Language[30].text.."", 'bag', 2000)
						end
					end
				end
			else
				exports['gum_notify']:DisplayLeftNotification(Config.Language[10].text, ""..Config.Language[31].text.."", 'bag', 2000)
			end
		else
			if data.item == "money" then
				TriggerServerEvent("gum_inventory:turn_ped", data.id)
				TriggerServerEvent("gum_inventory:give_money", data.id, data.count, GetPlayerServerId(PlayerId()))
				Show_Items(false, false)
				SetNuiFocus(false, false)
				guiEnabled = false
			else
				TriggerServerEvent("gum_inventory:turn_ped", data.id)
				TriggerServerEvent("gum_inventory:give_gold", data.id, data.count, GetPlayerServerId(PlayerId()))
				Show_Items(false, false)
				SetNuiFocus(false, false)
				guiEnabled = false
			end
		end
	else
		for k,v in pairs(weapon_table) do
			if tonumber(data.item) == tonumber(v.id) then
				if v.used == 0 then
					TriggerServerEvent("gum_inventory:turn_ped", data.id)
					TriggerServerEvent("gumCore:giveWeapon", GetPlayerServerId(PlayerId()), data.item, data.id)
					Show_Items(false, false)
					SetNuiFocus(false, false)
					guiEnabled = false
				else
					exports['gum_notify']:DisplayLeftNotification(Config.Language[10].text, ""..Config.Language[32].text.."", 'bag', 2000)
				end
			end
		end

	end
end)

RegisterNetEvent('gum_inventory:turn_client')
AddEventHandler('gum_inventory:turn_client', function(who, manipulation)
	if tonumber(manipulation) == 1 then
		local closestPlayer, closestDistance, playerid, tgt1 = GetClosestPlayer()
		if closestPlayer ~= -1 and closestDistance <= 5.0 then
			if tonumber(who) == tonumber(playerid) then
				TaskTurnPedToFaceEntity(PlayerPedId(), tgt1, 3000)
				Citizen.Wait(2000)
				playAnim("mech_butcher", "small_rat_give_player", 2500, 25)
			end
		end
	else
		local closestPlayer, closestDistance, playerid, tgt1 = GetClosestPlayer()
		if closestPlayer ~= -1 and closestDistance <= 5.0 then
			if tonumber(who) == tonumber(playerid) then
				TaskTurnPedToFaceEntity(PlayerPedId(), tgt1, 2500)
				Citizen.Wait(3200)
				playAnim("mech_inventory@item@pocketwatch@unarmed@base", "holster", 1500, 25)
			end
		end
	end
end)

RegisterNUICallback('give_item', function(data, cb)
	Citizen.Wait(50)
	local player_table = {}
	for k,v in pairs(GetPlayers()) do
		local mycoords = GetEntityCoords(PlayerPedId())
		local targetCoords = GetEntityCoords(GetPlayerPed(v))
		local distance = GetDistanceBetweenCoords(mycoords.x, mycoords.y, mycoords.z, targetCoords.x, targetCoords.y, targetCoords.z, false)
		if (5.0 > distance) then
			if GetPlayerServerId(PlayerId()) ~= GetPlayerServerId(v) then
				table.insert(player_table, {name=GetPlayerName(v), id=GetPlayerServerId(v)})
			end
		end
	end
	Citizen.Wait(0)
	SendNUIMessage({type = "playertable", table_p_for_json = player_table, item = data.item, count = data.count})
end)


RegisterNetEvent('gum_inventory:drop_list')
AddEventHandler('gum_inventory:drop_list', function(drop_list)
	for k,v in pairs(dropped_items_entity) do
		DeleteEntity(v.entity)
	end
	Citizen.Wait(500)
	if drop_list ~= false then
		dropped_items_entity = {}
		dropped_items = {}
		Citizen.Wait(5)
		for k,v in pairs(drop_list) do
			if v.weapon == true then
				dropped_item = CreateObject("mp005_s_posse_weaponslocker01x", v.x, v.y, v.z, false, false, false)
				PlaceObjectOnGroundProperly(dropped_item)
				FreezeEntityPosition(dropped_item, true)
				Citizen.InvokeNative(0x7DFB49BCDB73089A, dropped_item, true)
				table.insert(dropped_items_entity, {id=v.id, entity=dropped_item, x=v.x ,y=v.y, z=v.z, item=v.item, count=v.count, weapon=v.weapon, weapon_model=v.weapon_model})
				SetEntityCollision(dropped_item, false, false)
			elseif v.weapon == false then
				if v.item == "money" then
					dropped_item = CreateObject("p_moneystack01x", v.x, v.y, v.z, false, false, false)
					PlaceObjectOnGroundProperly(dropped_item)
					FreezeEntityPosition(dropped_item, true)
					Citizen.InvokeNative(0x7DFB49BCDB73089A, dropped_item, true)
					table.insert(dropped_items_entity, {id=v.id, entity=dropped_item, x=v.x ,y=v.y, z=v.z, item=v.item, count=v.count, weapon=v.weapon, weapon_model=v.weapon_model})
					SetEntityCollision(dropped_item, false, false)
				else
					if v.item == "gold" then
						dropped_item = CreateObject("p_goldstack01x", v.x, v.y, v.z, false, false, false)
						PlaceObjectOnGroundProperly(dropped_item)
						FreezeEntityPosition(dropped_item, true)
						Citizen.InvokeNative(0x7DFB49BCDB73089A, dropped_item, true)
						table.insert(dropped_items_entity, {id=v.id, entity=dropped_item, x=v.x ,y=v.y, z=v.z, item=v.item, count=v.count, weapon=v.weapon, weapon_model=v.weapon_model})
						SetEntityCollision(dropped_item, false, false)
					else
						dropped_item = CreateObject("p_cs_dirtybag01x", v.x, v.y, v.z, false, false, false)
						PlaceObjectOnGroundProperly(dropped_item)
						FreezeEntityPosition(dropped_item, true)
						Citizen.InvokeNative(0x7DFB49BCDB73089A, dropped_item, true)
						table.insert(dropped_items_entity, {id=v.id, entity=dropped_item, x=v.x ,y=v.y, z=v.z, item=v.item, count=v.count, weapon=v.weapon, weapon_model=v.weapon_model})
						SetEntityCollision(dropped_item, false, false)
					end
				end
			end
		end
	end
end)


RegisterNUICallback('drop_item', function(data, cb)
	can_drop_near = false
	for k,v in pairs(dropped_items_entity) do
		local coords_p = GetEntityCoords(PlayerPedId())
		local coords_i = GetEntityCoords(v.entity)
		local distance = GetDistanceBetweenCoords(coords_p.x, coords_p.y, coords_p.z, coords_i.x, coords_i.y, coords_i.z, false)
		if (3.0 > distance) then
			can_drop_near = true
		end
	end
	Citizen.Wait(0)
	if can_drop_near == false then
		if data.is_weapon =="item" then
			if tonumber(data.count) >= 1 then
				if data.item ~= "money" and data.item ~= "gold" then
					for k,v in pairs(inventory_table) do
						if v.item == data.item then 
							if v.count >= tonumber(data.count) then
								TriggerServerEvent("gumCore:subItem", GetPlayerServerId(PlayerId()), data.item, data.count)
								local coords = GetEntityCoords(PlayerPedId(), true)
								table.insert(dropped_items, {x=coords.x ,y=coords.y, z=coords.z, item=data.item, count=data.count, weapon=false})
								playAnim("mech_pickup@firewood", "putdown", 3000, 1)
								Citizen.Wait(0)
								TriggerServerEvent("gum_inventory:upload_drops", dropped_items)
								dropped_items = {}
								Show_Items(false, false)
								SetNuiFocus(false, false)
								guiEnabled = false
							else
								exports['gum_notify']:DisplayLeftNotification(Config.Language[10].text, ""..Config.Language[33].text.."", 'bag', 2000)
							end
						end
					end
				else
					if data.item == "money" then
						if tonumber(money_state) >= tonumber(data.count) then
							TriggerServerEvent("gum_inventory:drop_money", data.count)
							local coords = GetEntityCoords(PlayerPedId(), true)
							table.insert(dropped_items, {x=coords.x ,y=coords.y, z=coords.z, item=data.item, count=data.count, weapon=false})
							playAnim("mech_pickup@firewood", "putdown", 3000, 1)
							Citizen.Wait(0)
							TriggerServerEvent("gum_inventory:upload_drops", dropped_items)
							dropped_items = {}
							Show_Items(false, false)
							SetNuiFocus(false, false)
							guiEnabled = false
						else
							exports['gum_notify']:DisplayLeftNotification(Config.Language[10].text, ""..Config.Language[34].text.."", 'bag', 2000)
						end
					else
						if tonumber(gold_state) >= tonumber(data.count) then
							TriggerServerEvent("gum_inventory:drop_gold", data.count)
							local coords = GetEntityCoords(PlayerPedId(), true)
							table.insert(dropped_items, {x=coords.x ,y=coords.y, z=coords.z, item=data.item, count=data.count, weapon=false})
							playAnim("mech_pickup@firewood", "putdown", 3000, 1)
							Citizen.Wait(0)
							TriggerServerEvent("gum_inventory:upload_drops", dropped_items)
							dropped_items = {}
							Show_Items(false, false)
							SetNuiFocus(false, false)
							guiEnabled = false
						else
							exports['gum_notify']:DisplayLeftNotification(Config.Language[10].text, ""..Config.Language[35].text.."", 'bag', 2000)
						end
					end
				end
			else
				exports['gum_notify']:DisplayLeftNotification(Config.Language[10].text, ""..Config.Language[31].text.."", 'bag', 2000)
			end
		else
			if tonumber(data.count) == 1 then
				for k,v in pairs(weapon_table) do
					if v.id == data.item then 
						if v.used == 0 then
							TriggerServerEvent("gumCore:subWeapon", GetPlayerServerId(PlayerId()), tonumber(data.item))
							local coords = GetEntityCoords(PlayerPedId(), true)
							table.insert(dropped_items, {x=coords.x ,y=coords.y, z=coords.z, item=data.item, count=data.count, weapon=true, weapon_model=v.name})
							playAnim("mech_pickup@firewood", "putdown", 3000, 1)
							Citizen.Wait(0)
							TriggerServerEvent("gum_inventory:upload_drops", dropped_items)
							dropped_items = {}
							Show_Items(false, false)
							SetNuiFocus(false, false)
							guiEnabled = false
						else
							exports['gum_notify']:DisplayLeftNotification(Config.Language[10].text, ""..Config.Language[36].text.."", 'bag', 2000)
						end
					end
				end
			else
				exports['gum_notify']:DisplayLeftNotification(Config.Language[10].text, ""..Config.Language[310].text.."", 'bag', 2000)
			end
		end
	else
		exports['gum_notify']:DisplayLeftNotification(Config.Language[10].text, ""..Config.Language[37].text.."", 'bag', 2000)
	end
end)


RegisterNUICallback('exit', function(data, cb)
	if id_container ~= 0 then
		TriggerServerEvent("gumCore:closestorage", data.id)
		id_container = 0
	end
	Show_Items(false, false)
    SetNuiFocus(false, false)
    guiEnabled = false
end)

RegisterNetEvent('gum_inventory:close_storage')
AddEventHandler('gum_inventory:close_storage', function(id)
	TriggerServerEvent("gumCore:closestorage", id)
end)

function GetClosestPlayer()
    local players, closestDistance, closestPlayer = GetActivePlayers(), -1, -1
    local playerPed, playerId = PlayerPedId(), PlayerId()
    local coords, usePlayerPed = coords, false
    
    if coords then
        coords = vector3(coords.x, coords.y, coords.z)
    else
        usePlayerPed = true
        coords = GetEntityCoords(playerPed)
    end
    
    for i=1, #players, 1 do
        local tgt = GetPlayerPed(players[i])
        if not usePlayerPed or (usePlayerPed and players[i] ~= playerId) then

            local targetCoords = GetEntityCoords(tgt)
            local distance = #(coords - targetCoords)

            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = players[i]
                closestDistance = distance
                playerid = GetPlayerServerId(players[i])
                tgt1 = GetPlayerPed(players[i])
            end
        end
    end
    return closestPlayer, closestDistance,  playerid, tgt1
end

function GetPlayers()
	local players = {}
	for i = 0, 256 do
		if NetworkIsPlayerActive(i) then
			table.insert(players, i)
		end
	end
	return players
end

function RequestControl(entity)
	local type = GetEntityType(entity)

	if type < 1 or type > 3 then
		return
	end

	NetworkRequestControlOfEntity(entity)
end
function playAnim(dict,name, time, flag)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), dict, name, 8.0, 8.0, time, flag, 0, true, 0, false, 0, false)  
end
function playAnim2(dict,name, time, flag)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), dict, name, 1.0, 1.0, time, flag, 0, true, 0, false, 0, false)  
end

function DrawText3D(x, y, z, text)
	local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)
	local px,py,pz=table.unpack(GetGameplayCamCoord())  
	local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
	local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
	if onScreen then
		SetTextScale(0.30, 0.30)
		SetTextFontForCurrentCommand(0)
		SetTextColor(255, 255, 255, 255)
		SetTextCentre(1)
		SetTextDropshadow(1, 1, 0, 0, 200)
		DisplayText(str,_x,_y)
		local factor = (string.len(text)) / 225
		--DrawSprite("generic_textures", "hud_menu_4a", _x, _y+0.0125,0.015+ factor, 0.03, 0.1, 35, 35, 35, 190, 0)
		--DrawSprite("feeds", "toast_bg", _x, _y+0.0125,0.015+ factor, 0.03, 0.1, 100, 1, 1, 190, 0)
	end
end

function getGuidFromItemId(inventoryId, itemData, category, slotId) 
    local outItem = DataView.ArrayBuffer(8 * 13)
 
    if not itemData then
        itemData = 0
    end
 
    local success = Citizen.InvokeNative("0x886DFD3E185C8A89", inventoryId, itemData, category, slotId, outItem:Buffer()) --InventoryGetGuidFromItemid
    if success then
        return outItem:Buffer() --Seems to not return anythign diff. May need to pull from native above
    else
        return nil
    end
end
 
function addWardrobeInventoryItem(itemName, slotHash)
    local itemHash = GetHashKey(itemName)
    local addReason = GetHashKey("ADD_REASON_DEFAULT")
    local inventoryId = 1
 
    local isValid = Citizen.InvokeNative("0x6D5D51B188333FD1", itemHash, 0) --ItemdatabaseIsKeyValid
    if not isValid then
        return false
    end
 
    local characterItem = getGuidFromItemId(inventoryId, nil, GetHashKey("CHARACTER"), 0xA1212100)
    if not characterItem then
        return false
    end
 
    local wardrobeItem = getGuidFromItemId(inventoryId, characterItem, GetHashKey("WARDROBE"), 0x3DABBFA7)
    if not wardrobeItem then
        return false 
    end
 
    local itemData = DataView.ArrayBuffer(8 * 13)
 
    local isAdded = Citizen.InvokeNative("0xCB5D11F9508A928D", inventoryId, itemData:Buffer(), wardrobeItem, itemHash, slotHash, 1, addReason);
    if not isAdded then 
        return false
    end
 
    local equipped = Citizen.InvokeNative("0x734311E2852760D0", inventoryId, itemData:Buffer(), true);
    return equipped;
end
 
function givePlayerWeapon(weaponName, attachPoint)
    local addReason = GetHashKey("ADD_REASON_DEFAULT");
    local weaponHash = GetHashKey(weaponName);
 
    Citizen.InvokeNative("0x72D4CB5DB927009C", weaponHash, 0, true);
 
    Wait(1000)
    Citizen.InvokeNative("0x5E3BDDBCB83F3D84", PlayerPedId(), weaponHash, 1, true, false, attachPoint, true, 0.0, 0.0, addReason, true, 0.0, false);
end

--[[
    Default, and assumed, LUAI_MAXSHORTLEN is 40. To create a non internalized
    string always force the buffer to be greater than that value.
--]]
local _strblob = string.blob or function(length)
    return string.rep("\0", math.max(40 + 1, length))
end

--[[
    API:
        DataView::{Get | Set}Int8
        DataView::{Get | Set}Uint8
        DataView::{Get | Set}Int16
        DataView::{Get | Set}Uint16
        DataView::{Get | Set}Int32
        DataView::{Get | Set}Uint32
        DataView::{Get | Set}Int64
        DataView::{Get | Set}Uint64
        DataView::{Get | Set}LuaInt
        DataView::{Get | Set}UluaInt
        DataView::{Get | Set}LuaNum
        DataView::{Get | Set}Float32
        DataView::{Get | Set}Float64
        DataView::{Get | Set}String
            Parameters:
                Get: self, offset, endian (optional)
                Set: self, offset, value, endian (optional)
        DataView::{GetFixed | SetFixed}::Int
        DataView::{GetFixed | SetFixed}::Uint
        DataView::{GetFixed | SetFixed}::String
            Parameters:
                Get: offset, typelen, endian (optional)
                Set: offset, typelen, value, endian (optional)
    NOTES:
        (1) Endianness changed from JS API, defaults to little endian.
        (2) {Get|Set|Next} offsets are zero-based.
    EXAMPLES:
        local view = DataView.ArrayBuffer(512)
        if Citizen.InvokeNative(0x79923CD21BECE14E, 1, view:Buffer(), Citizen.ReturnResultAnyway()) then
            local dlc = {
                validCheck = view:GetInt64(0),
                weaponHash = view:GetInt32(8),
                val3 = view:GetInt64(16),
                weaponCost = view:GetInt64(24),
                ammoCost = view:GetInt64(32),
                ammoType = view:GetInt64(40),
                defaultClipSize = view:GetInt64(48),
                nameLabel = view:GetFixedString(56, 64),
                descLabel = view:GetFixedString(120, 64),
                simpleDesc = view:GetFixedString(184, 64),
                upperCaseName = view:GetFixedString(248, 64),
            }
        end
--]]
DataView = {
    EndBig = ">",
    EndLittle = "<",
    Types = {
        Int8 = { code = "i1", size = 1 },
        Uint8 = { code = "I1", size = 1 },
        Int16 = { code = "i2", size = 2 },
        Uint16 = { code = "I2", size = 2 },
        Int32 = { code = "i4", size = 4 },
        Uint32 = { code = "I4", size = 4 },
        Int64 = { code = "i8", size = 8 },
        Uint64 = { code = "I8", size = 8 },

        LuaInt = { code = "j", size = 8 }, -- a lua_Integer
        UluaInt = { code = "J", size = 8 }, -- a lua_Unsigned
        LuaNum = { code = "n", size = 8}, -- a lua_Number
        Float32 = { code = "f", size = 4 }, -- a float (native size)
        Float64 = { code = "d", size = 8 }, -- a double (native size)
        String = { code = "z", size = -1, }, -- zero terminated string
    },

    FixedTypes = {
        String = { code = "c", size = -1, }, -- a fixed-sized string with n bytes
        Int = { code = "i", size = -1, }, -- a signed int with n bytes
        Uint = { code = "I", size = -1, }, -- an unsigned int with n bytes
    },
}
DataView.__index = DataView

--[[ Is a dataview type at a specific offset still within buffer length --]]
local function _ib(o, l, t) return ((t.size < 0 and true) or (o + (t.size - 1) <= l)) end
local function _ef(big) return (big and DataView.EndBig) or DataView.EndLittle end

--[[ Helper function for setting fixed datatypes within a buffer --]]
local SetFixed = nil

--[[ Create an ArrayBuffer with a size in bytes --]]
function DataView.ArrayBuffer(length)
    return setmetatable({
        offset = 1, length = length, blob = _strblob(length)
    }, DataView)
end

--[[ Wrap a non-internalized string --]]
function DataView.Wrap(blob)
    return setmetatable({
        offset = 1, blob = blob, length = blob:len(),
    }, DataView)
end

function DataView:Buffer() return self.blob end
function DataView:ByteLength() return self.length end
function DataView:ByteOffset() return self.offset end
function DataView:SubView(offset)
    return setmetatable({
        offset = offset, blob = self.blob, length = self.length,
    }, DataView)
end

--[[ Create the API by using DataView.Types. --]]
for label,datatype in pairs(DataView.Types) do
    DataView["Get" .. label] = function(self, offset, endian)
        local o = self.offset + offset
        if _ib(o, self.length, datatype) then
            local v,_ = string.unpack(_ef(endian) .. datatype.code, self.blob, o)
            return v
        end
        return nil -- Out of bounds
    end

    DataView["Set" .. label] = function(self, offset, value, endian)
        local o = self.offset + offset
        if _ib(o, self.length, datatype) then
            return SetFixed(self, o, value, _ef(endian) .. datatype.code)
        end
        return self -- Out of bounds
    end

    -- Ensure cache is correct.
    if datatype.size >= 0 and string.packsize(datatype.code) ~= datatype.size then
        local msg = "Pack size of %s (%d) does not match cached length: (%d)"
        error(msg:format(label, string.packsize(fmt[#fmt]), datatype.size))
        return nil
    end
end

for label,datatype in pairs(DataView.FixedTypes) do
    DataView["GetFixed" .. label] = function(self, offset, typelen, endian)
        local o = self.offset + offset
        if o + (typelen - 1) <= self.length then
            local code = _ef(endian) .. "c" .. tostring(typelen)
            local v,_ = string.unpack(code, self.blob, o)
            return v
        end
        return nil -- Out of bounds
    end

    DataView["SetFixed" .. label] = function(self, offset, typelen, value, endian)
        local o = self.offset + offset
        if o + (typelen - 1) <= self.length then
            local code = _ef(endian) .. "c" .. tostring(typelen)
            return SetFixed(self, o, value, code)
        end
        return self
    end
end

--[[ Helper function for setting fixed datatypes within a buffer --]]
SetFixed = function(self, offset, value, code)
    local fmt = { }
    local values = { }

    -- All bytes prior to the offset
    if self.offset < offset then
        local size = offset - self.offset
        fmt[#fmt + 1] = "c" .. tostring(size)
        values[#values + 1] = self.blob:sub(self.offset, size)
    end

    fmt[#fmt + 1] = code
    values[#values + 1] = value

    -- All bytes after the value (offset + size) to the end of the buffer
    -- growing the buffer if needed.
    local ps = string.packsize(fmt[#fmt])
    if (offset + ps) <= self.length then
        local newoff = offset + ps
        local size = self.length - newoff + 1

        fmt[#fmt + 1] = "c" .. tostring(size)
        values[#values + 1] = self.blob:sub(newoff, self.length)
    end

    self.blob = string.pack(table.concat(fmt, ""), table.unpack(values))
    self.length = self.blob:len()
    return self
end
