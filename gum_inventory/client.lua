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
local bp_condition = {}
local money_state = 0
local gold_state = 0
local new_ammo_table = {}
local storage_table = {}
local size = 0
local backup_save_throw = 0
local is_last_ammo = false
local logged_true = true
local id_container = 0
local equip_spam = 0
local speed = 0
local count_in_inventory = 0.0
local can_save = false
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
RegisterNetEvent('gum_inventory:can_save')
AddEventHandler('gum_inventory:can_save', function()
	can_save = true
end)
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
	bp_condition = {}
	money_state = 0
	gold_state = 0
	new_ammo_table = {}
	storage_table = {}
	size = 0
	backup_save_throw = 0
	is_last_ammo = false
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
					if GetHashKey('GROUP_REPEATER') == GetWeapontypeGroup(wepHash) then					ammo_type_weapon = "REPEATER"				elseif GetHashKey('GROUP_SHOTGUN') == GetWeapontypeGroup(wepHash) then					ammo_type_weapon = "SHOTGUN"
					elseif GetHashKey('GROUP_RIFLE') == GetWeapontypeGroup(wepHash) then					ammo_type_weapon = "RIFLE"				elseif GetHashKey('GROUP_SNIPER') == GetWeapontypeGroup(wepHash) then					ammo_type_weapon = "SNIPER"
					elseif GetHashKey('GROUP_REVOLVER') == GetWeapontypeGroup(wepHash) then					ammo_type_weapon = "REVOLVER"		elseif GetHashKey('GROUP_PISTOL') == GetWeapontypeGroup(wepHash) then					ammo_type_weapon = "PISTOL"elseif GetHashKey('GROUP_BOW') == GetWeapontypeGroup(wepHash) then					ammo_type_weapon = "ARROW"				elseif 1548507267 == GetWeapontypeGroup(wepHash) then					ammo_type_weapon = "THROWWABLE"				end
					if ammo_type_weapon ~= "" then
						if ammo_type_weapon ~= "THROWWABLE" then
							if string.match(v[2], ammo_type_weapon)  then
								for key,value in pairs(weapon_table) do
									if value.used == 1 and wepHash == GetHashKey(value.name) and GetPedAmmoByType(PlayerPedId(), GetHashKey(v[2])) ~= 0 then
										SetPedAmmoByType(PlayerPedId(), GetHashKey(v[2]), GetPedAmmoByType(PlayerPedId(), GetHashKey(v[2])))
										new_ammo_table[v[2]] = GetPedAmmoByType(PlayerPedId(), GetHashKey(v[2]))
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
					if GetHashKey('GROUP_REPEATER') == GetWeapontypeGroup(wepHash) then					ammo_type_weapon = "REPEATER"				elseif GetHashKey('GROUP_SHOTGUN') == GetWeapontypeGroup(wepHash) then					ammo_type_weapon = "SHOTGUN"
					elseif GetHashKey('GROUP_RIFLE') == GetWeapontypeGroup(wepHash) then					ammo_type_weapon = "RIFLE"				elseif GetHashKey('GROUP_SNIPER') == GetWeapontypeGroup(wepHash) then					ammo_type_weapon = "SNIPER"
					elseif GetHashKey('GROUP_REVOLVER') == GetWeapontypeGroup(wepHash) then					ammo_type_weapon = "REVOLVER"		elseif GetHashKey('GROUP_PISTOL') == GetWeapontypeGroup(wepHash) then					ammo_type_weapon = "PISTOL"elseif GetHashKey('GROUP_BOW') == GetWeapontypeGroup(wepHash) then					ammo_type_weapon = "BOW"
					elseif 1548507267 == GetWeapontypeGroup(wepHash) then
						ammo_type_weapon = "THROWWABLE"
					end
					if ammo_type_weapon ~= "" then
						for key,value in pairs(weapon_table) do
							if value.used == 1 then
								if ammo_type_weapon ~= "THROWWABLE" then
									condition_level[value.id] = Citizen.InvokeNative(0x0D78E1097F89E637, weaponEntityIndex, Citizen.ResultAsFloat())
									if condition_level[value.id] ~= bp_condition[value.id] and (weaponEntityIndex ~= 0 and wepHash == GetHashKey(value.name)) then
										if not sended then
											sended = true
											bp_condition[value.id] = value.conditionlevel
											Citizen.InvokeNative(0xA7A57E89E965D839, weaponEntityIndex, bp_condition[value.id])
											Citizen.InvokeNative(0x812CE61DEBCAB948, weaponEntityIndex, bp_condition[value.id], 0)
											TriggerServerEvent("gum_inventory:save_ammo", value.name, new_ammo_table, condition_level[value.id])
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
    local object = GetObjectIndexFromEntityIndex(GetCurrentPedWeaponEntityIndex(PlayerPedId(),0))
    if model == 416676503 or model == -1101297303 then
        TriggerEvent("gum_inventory:CloseInv");
        Citizen.InvokeNative(0x72F52AA2D2B172CC,  PlayerPedId(), 1242464081, cloth_clean, GetHashKey("CLOTH"), GetHashKey("SHORTARM_CLEAN_ENTER"), 1, 0, -1.0)   
        Citizen.Wait(15000)
		for key,value in pairs(weapon_table) do
			if value.used == 1 then
				if weaponHash == GetHashKey(value.name)  then
					TriggerServerEvent("gum_inventory:save_cleaning", value.name, condition_level)
					value.conditionlevel = 0.0
					value.dirtlevel = 0.0
					Citizen.InvokeNative(0xA7A57E89E965D839,object,0.0,0)
					Citizen.InvokeNative(0x812CE61DEBCAB948,object,0.0,0)
				end
			end
		end
    else
        TriggerEvent("gum_inventory:CloseInv");
        Citizen.InvokeNative(0x72F52AA2D2B172CC,  PlayerPedId(), 1242464081, cloth_clean, GetHashKey("CLOTH"), GetHashKey("LONGARM_CLEAN_ENTER"), 1, 0, -1.0)   
        Citizen.Wait(15000)
		for key,value in pairs(weapon_table) do
			if value.used == 1 then
				if weaponHash == GetHashKey(value.name)  then
					TriggerServerEvent("gum_inventory:save_cleaning", value.name, condition_level)
					value.conditionlevel = 0.0
					value.dirtlevel = 0.0
					Citizen.InvokeNative(0xA7A57E89E965D839,object,0.0,0)
					Citizen.InvokeNative(0x812CE61DEBCAB948,object,0.0,0)
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

function equip_weapon_login()
	for k,v in pairs(weapon_table) do
		if v.used == 1 then
			if string.match(v.name, "REVOLVER")  then
				if weapon_first_used == false then
					weapon_first_used = v.name
					--Citizen.InvokeNative(0x5E3BDDBCB83F3D84, PlayerPedId(), GetHashKey(weapon_first_used), 0, false, true, true, 1.0)
					Citizen.InvokeNative(0xB282DC6EBD803C75, PlayerPedId(), GetHashKey(weapon_first_used), 0, true, 0);
					Citizen.Wait(10)
					for k2,v2 in pairs(json.decode(v.ammo)) do
						SetPedAmmoByType(PlayerPedId(), GetHashKey(k2), v2);
					end
					local comps_decoded = json.decode(v.comps)
					TriggerEvent("gum_weapons:load_components", comps_decoded)
					local load_dirt = 0
					local weaponEntityIndex = GetCurrentPedWeaponEntityIndex(PlayerPedId())
					while Citizen.InvokeNative(0x810E8AE9AFEA7E54, weaponEntityIndex, Citizen.ResultAsFloat()) ~= v.conditionlevel and load_dirt < 150 do
						load_dirt = load_dirt+1
						Citizen.InvokeNative(0xA7A57E89E965D839, weaponEntityIndex, tonumber(v.conditionlevel))
						Citizen.InvokeNative(0x812CE61DEBCAB948, weaponEntityIndex, tonumber(v.conditionlevel))
						Citizen.Wait(10)
					end
					bp_condition[v.id] = v.conditionlevel
					condition_level[v.id] = v.conditionlevel
					Citizen.Wait(1500)
					Citizen.InvokeNative(0xFCCC886EDE3C63EC, PlayerPedId(), false, true, true)
					Citizen.Wait(500)
				else
					if weapon_second_used == false then
						weapon_second_used = v.name
						--Citizen.InvokeNative(0x5E3BDDBCB83F3D84, PlayerPedId(), GetHashKey(weapon_second_used), 0, false, true, true, 1.0)
						Citizen.InvokeNative(0xB282DC6EBD803C75, PlayerPedId(), GetHashKey(weapon_second_used), 0, true, 0);
						Citizen.Wait(10)
						for k2,v2 in pairs(json.decode(v.ammo)) do
							SetPedAmmoByType(PlayerPedId(), GetHashKey(k2), v2);
						end
						local comps_decoded = json.decode(v.comps)
						TriggerEvent("gum_weapons:load_components", comps_decoded)			
						local load_dirt = 0
						local weaponEntityIndex = GetCurrentPedWeaponEntityIndex(PlayerPedId())
						while Citizen.InvokeNative(0x810E8AE9AFEA7E54, weaponEntityIndex, Citizen.ResultAsFloat()) ~= v.conditionlevel and load_dirt < 150 do
							load_dirt = load_dirt+1
							Citizen.InvokeNative(0xA7A57E89E965D839, weaponEntityIndex, tonumber(v.conditionlevel))
							Citizen.InvokeNative(0x812CE61DEBCAB948, weaponEntityIndex, tonumber(v.conditionlevel))
							Citizen.Wait(10)
						end
						bp_condition[v.id] = v.conditionlevel
						condition_level[v.id] = v.conditionlevel
						Citizen.Wait(1500)
						Citizen.InvokeNative(0xFCCC886EDE3C63EC, PlayerPedId(), false, true, true)
						Citizen.Wait(500)
					end
				end
			else
				if string.match(v.name, "revolver") then
					if weapon_first_used == false then
						weapon_first_used = v.name
						Citizen.InvokeNative(0xB282DC6EBD803C75, PlayerPedId(), GetHashKey(weapon_first_used), 0, true, 0);
						--Citizen.InvokeNative(0x5E3BDDBCB83F3D84, PlayerPedId(), GetHashKey(weapon_first_used), 0, false, true, true, 1.0)
						Citizen.Wait(10)
						for k2,v2 in pairs(json.decode(v.ammo)) do
							SetPedAmmoByType(PlayerPedId(), GetHashKey(k2), v2);
						end
						local comps_decoded = json.decode(v.comps)
						TriggerEvent("gum_weapons:load_components", comps_decoded)
						local load_dirt = 0
						local weaponEntityIndex = GetCurrentPedWeaponEntityIndex(PlayerPedId())
						while Citizen.InvokeNative(0x810E8AE9AFEA7E54, weaponEntityIndex, Citizen.ResultAsFloat()) ~= v.conditionlevel and load_dirt < 150 do
							load_dirt = load_dirt+1
							Citizen.InvokeNative(0xA7A57E89E965D839, weaponEntityIndex, tonumber(v.conditionlevel))
							Citizen.InvokeNative(0x812CE61DEBCAB948, weaponEntityIndex, tonumber(v.conditionlevel))
							Citizen.Wait(10)
						end
						bp_condition[v.id] = v.conditionlevel
						condition_level[v.id] = v.conditionlevel
						Citizen.Wait(1500)
						Citizen.InvokeNative(0xFCCC886EDE3C63EC, PlayerPedId(), false, true, true)
						Citizen.Wait(500)
					else
						if weapon_second_used == false then
							weapon_second_used = v.name
							Citizen.InvokeNative(0xB282DC6EBD803C75, PlayerPedId(), GetHashKey(weapon_second_used), 0, true, 0);
							--Citizen.InvokeNative(0x5E3BDDBCB83F3D84, PlayerPedId(), GetHashKey(weapon_second_used), 0, false, true, true, 1.0)
							Citizen.Wait(10)
							for k2,v2 in pairs(json.decode(v.ammo)) do
								SetPedAmmoByType(PlayerPedId(), GetHashKey(k2), v2);
							end
							local comps_decoded = json.decode(v.comps)
							TriggerEvent("gum_weapons:load_components", comps_decoded)
							local load_dirt = 0
							local weaponEntityIndex = GetCurrentPedWeaponEntityIndex(PlayerPedId())
							while Citizen.InvokeNative(0x810E8AE9AFEA7E54, weaponEntityIndex, Citizen.ResultAsFloat()) ~= v.conditionlevel and load_dirt < 150 do
								load_dirt = load_dirt+1
								Citizen.InvokeNative(0xA7A57E89E965D839, weaponEntityIndex, tonumber(v.conditionlevel))
								Citizen.InvokeNative(0x812CE61DEBCAB948, weaponEntityIndex, tonumber(v.conditionlevel))
								Citizen.Wait(10)
							end
							bp_condition[v.id] = v.conditionlevel
							condition_level[v.id] = v.conditionlevel
							Citizen.Wait(1500)
							Citizen.InvokeNative(0xFCCC886EDE3C63EC, PlayerPedId(), false, true, true)
							Citizen.Wait(500)
						end
					end
				end
				if string.match(v.name, "PISTOL") then
					if weapon_first_used == false then
						weapon_first_used = v.name
						Citizen.InvokeNative(0xB282DC6EBD803C75, PlayerPedId(), GetHashKey(weapon_first_used), 0, true, 0);
						--Citizen.InvokeNative(0x5E3BDDBCB83F3D84, PlayerPedId(), GetHashKey(weapon_first_used), 0, false, true, true, 1.0)
						Citizen.Wait(10)
						for k2,v2 in pairs(json.decode(v.ammo)) do
							SetPedAmmoByType(PlayerPedId(), GetHashKey(k2), v2);
						end
						local comps_decoded = json.decode(v.comps)
						TriggerEvent("gum_weapons:load_components", comps_decoded)
						local load_dirt = 0
						local weaponEntityIndex = GetCurrentPedWeaponEntityIndex(PlayerPedId())
						while Citizen.InvokeNative(0x810E8AE9AFEA7E54, weaponEntityIndex, Citizen.ResultAsFloat()) ~= v.conditionlevel and load_dirt < 150 do
							load_dirt = load_dirt+1
							Citizen.InvokeNative(0xA7A57E89E965D839, weaponEntityIndex, tonumber(v.conditionlevel))
							Citizen.InvokeNative(0x812CE61DEBCAB948, weaponEntityIndex, tonumber(v.conditionlevel))
							Citizen.Wait(10)
						end
						bp_condition[v.id] = v.conditionlevel
						condition_level[v.id] = v.conditionlevel
						Citizen.Wait(1500)
						Citizen.InvokeNative(0xFCCC886EDE3C63EC, PlayerPedId(), false, true, true)
						Citizen.Wait(500)
					else
						if weapon_second_used == false then
							weapon_second_used = v.name
							--Citizen.InvokeNative(0x5E3BDDBCB83F3D84, PlayerPedId(), GetHashKey(weapon_second_used), 0, false, true, true, 1.0)
							Citizen.InvokeNative(0xB282DC6EBD803C75, PlayerPedId(), GetHashKey(weapon_second_used), 0, true, 0);
							Citizen.Wait(500)
							for k2,v2 in pairs(json.decode(v.ammo)) do
								SetPedAmmoByType(PlayerPedId(), GetHashKey(k2), v2);
							end
							local comps_decoded = json.decode(v.comps)
							TriggerEvent("gum_weapons:load_components", comps_decoded)
							local load_dirt = 0
							local weaponEntityIndex = GetCurrentPedWeaponEntityIndex(PlayerPedId())
							while Citizen.InvokeNative(0x810E8AE9AFEA7E54, weaponEntityIndex, Citizen.ResultAsFloat()) ~= v.conditionlevel and load_dirt < 150 do
								load_dirt = load_dirt+1
								Citizen.InvokeNative(0xA7A57E89E965D839, weaponEntityIndex, tonumber(v.conditionlevel))
								Citizen.InvokeNative(0x812CE61DEBCAB948, weaponEntityIndex, tonumber(v.conditionlevel))
								Citizen.Wait(10)
							end
							bp_condition[v.id] = v.conditionlevel
							condition_level[v.id] = v.conditionlevel
							Citizen.Wait(1500)
							Citizen.InvokeNative(0xFCCC886EDE3C63EC, PlayerPedId(), false, true, true)
							Citizen.Wait(500)
						end
					end
				else
					if string.match(v.name, "pistol") then
						if weapon_first_used == false then
							weapon_first_used = v.name
							--Citizen.InvokeNative(0x5E3BDDBCB83F3D84, PlayerPedId(), GetHashKey(weapon_first_used), 0, false, true, true, 1.0)
							Citizen.InvokeNative(0xB282DC6EBD803C75, PlayerPedId(), GetHashKey(weapon_first_used), 0, true, 0);
							Citizen.Wait(10)
							for k2,v2 in pairs(json.decode(v.ammo)) do
								SetPedAmmoByType(PlayerPedId(), GetHashKey(k2), v2);
							end
							local comps_decoded = json.decode(v.comps)
							TriggerEvent("gum_weapons:load_components", comps_decoded)
							local load_dirt = 0
							local weaponEntityIndex = GetCurrentPedWeaponEntityIndex(PlayerPedId())
							while Citizen.InvokeNative(0x810E8AE9AFEA7E54, weaponEntityIndex, Citizen.ResultAsFloat()) ~= v.conditionlevel and load_dirt < 150 do
								load_dirt = load_dirt+1
								Citizen.InvokeNative(0xA7A57E89E965D839, weaponEntityIndex, tonumber(v.conditionlevel))
								Citizen.InvokeNative(0x812CE61DEBCAB948, weaponEntityIndex, tonumber(v.conditionlevel))
								Citizen.Wait(10)
							end
							bp_condition[v.id] = v.conditionlevel
							condition_level[v.id] = v.conditionlevel
							Citizen.Wait(1500)
							Citizen.InvokeNative(0xFCCC886EDE3C63EC, PlayerPedId(), false, true, true)
							Citizen.Wait(500)
						else
							if weapon_second_used == false then
								weapon_second_used = v.name
								--Citizen.InvokeNative(0x5E3BDDBCB83F3D84, PlayerPedId(), GetHashKey(weapon_second_used), 0, false, true, true, 1.0)
								Citizen.InvokeNative(0xB282DC6EBD803C75, PlayerPedId(), GetHashKey(weapon_second_used), 0, true, 0);
								Citizen.Wait(10)
								for k2,v2 in pairs(json.decode(v.ammo)) do
									SetPedAmmoByType(PlayerPedId(), GetHashKey(k2), v2);
								end
								local comps_decoded = json.decode(v.comps)
								TriggerEvent("gum_weapons:load_components", comps_decoded)
								local load_dirt = 0
								local weaponEntityIndex = GetCurrentPedWeaponEntityIndex(PlayerPedId())
								while Citizen.InvokeNative(0x810E8AE9AFEA7E54, weaponEntityIndex, Citizen.ResultAsFloat()) ~= v.conditionlevel and load_dirt < 150 do
									load_dirt = load_dirt+1
									Citizen.InvokeNative(0xA7A57E89E965D839, weaponEntityIndex, tonumber(v.conditionlevel))
									Citizen.InvokeNative(0x812CE61DEBCAB948, weaponEntityIndex, tonumber(v.conditionlevel))
									Citizen.Wait(10)
								end
								bp_condition[v.id] = v.conditionlevel
								condition_level[v.id] = v.conditionlevel
								Citizen.Wait(1500)
								Citizen.InvokeNative(0xFCCC886EDE3C63EC, PlayerPedId(), false, true, true)
								Citizen.Wait(500)
							end
						end
					else
						local weapon_what = "other"
						if GetHashKey('GROUP_REPEATER') == GetWeapontypeGroup(v.name) then
							weapon_what = "REPEATER"
						elseif GetHashKey('GROUP_SHOTGUN') == GetWeapontypeGroup(v.name) then
							weapon_what = "SHOTGUN"
						elseif GetHashKey('GROUP_RIFLE') == GetWeapontypeGroup(v.name) then
							weapon_what = "RIFLE"
						elseif GetHashKey('GROUP_SNIPER') == GetWeapontypeGroup(v.name) then
							weapon_what = "SNIPER"
						elseif GetHashKey('GROUP_BOW') == GetWeapontypeGroup(v.name) then
							weapon_what = "BOW"
						else
							weapon_what = "other"
						end
						if rifle_first_used == false and weapon_what ~= "other" then
							rifle_first_used = v.name
							Citizen.InvokeNative(0xB282DC6EBD803C75, PlayerPedId(), GetHashKey(rifle_first_used), 0, true, 0);
							--Citizen.InvokeNative(0x5E3BDDBCB83F3D84, PlayerPedId(), GetHashKey(rifle_first_used), 0, false, true, true, 1.0)
							Citizen.Wait(10)
							for k2,v2 in pairs(json.decode(v.ammo)) do
								SetPedAmmoByType(PlayerPedId(), GetHashKey(k2), v2);
							end
							local comps_decoded = json.decode(v.comps)
							TriggerEvent("gum_weapons:load_components", comps_decoded)
							local load_dirt = 0
							local weaponEntityIndex = GetCurrentPedWeaponEntityIndex(PlayerPedId())
							while Citizen.InvokeNative(0x810E8AE9AFEA7E54, weaponEntityIndex, Citizen.ResultAsFloat()) ~= v.conditionlevel and load_dirt < 150 do
								load_dirt = load_dirt+1
								Citizen.InvokeNative(0xA7A57E89E965D839, weaponEntityIndex, tonumber(v.conditionlevel))
								Citizen.InvokeNative(0x812CE61DEBCAB948, weaponEntityIndex, tonumber(v.conditionlevel))
								Citizen.Wait(10)
							end
							local comps_decoded = json.decode(v.comps)
							TriggerEvent("gum_weapons:load_components", comps_decoded)
							bp_condition[v.id] = v.conditionlevel
							condition_level[v.id] = v.conditionlevel
							Citizen.Wait(1500)
							Citizen.InvokeNative(0xFCCC886EDE3C63EC, PlayerPedId(), false, true, true)
							Citizen.Wait(500)
						else
							if rifle_second_used == false and weapon_what ~= "other" then
								rifle_second_used = v.name
								Citizen.InvokeNative(0xB282DC6EBD803C75, PlayerPedId(), GetHashKey(rifle_second_used), 0, true, 0);
								--Citizen.InvokeNative(0x5E3BDDBCB83F3D84, PlayerPedId(), GetHashKey(rifle_second_used), 0, false, true, true, 1.0)
								Citizen.Wait(10)
								for k2,v2 in pairs(json.decode(v.ammo)) do
									SetPedAmmoByType(PlayerPedId(), GetHashKey(k2), v2);
								end
								local comps_decoded = json.decode(v.comps)
								TriggerEvent("gum_weapons:load_components", comps_decoded)
								local load_dirt = 0
								local weaponEntityIndex = GetCurrentPedWeaponEntityIndex(PlayerPedId())
								while Citizen.InvokeNative(0x810E8AE9AFEA7E54, weaponEntityIndex, Citizen.ResultAsFloat()) ~= v.conditionlevel and load_dirt < 150 do
									load_dirt = load_dirt+1
									Citizen.InvokeNative(0xA7A57E89E965D839, weaponEntityIndex, tonumber(v.conditionlevel))
									Citizen.InvokeNative(0x812CE61DEBCAB948, weaponEntityIndex, tonumber(v.conditionlevel))
									Citizen.Wait(10)
								end
								bp_condition[v.id] = v.conditionlevel
								condition_level[v.id] = v.conditionlevel
								Citizen.Wait(1500)
								Citizen.InvokeNative(0xFCCC886EDE3C63EC, PlayerPedId(), false, true, true)
								Citizen.Wait(500)
							else
								if weapon_what == "other" then
									Citizen.InvokeNative(0xB282DC6EBD803C75, PlayerPedId(), GetHashKey(v.name), 0, true, 0);
									--Citizen.InvokeNative(0x5E3BDDBCB83F3D84, PlayerPedId(), GetHashKey(v.name), 0, false, true, true, 1.0);
									local comps_decoded = json.decode(v.comps)
									TriggerEvent("gum_weapons:load_components", comps_decoded)
									local weaponEntityIndex = GetCurrentPedWeaponEntityIndex(PlayerPedId())
									Citizen.InvokeNative(0xA7A57E89E965D839, weaponEntityIndex, tonumber(v.conditionlevel))
									Citizen.InvokeNative(0x812CE61DEBCAB948, weaponEntityIndex, tonumber(v.conditionlevel))
									Citizen.Wait(50)
									bp_condition[v.id] = v.conditionlevel
									condition_level[v.id] = v.conditionlevel
									Citizen.Wait(1000)
									if v.name == 'weapon_melee_davy_lantern' then
										GiveWeaponToPed_2(PlayerPedId(), GetHashKey('weapon_melee_davy_lantern'), 0, true,true, 12, false, 0.5, 1.0, 752097756, false,0, false);
										Citizen.InvokeNative(0xADF692B254977C0C, PlayerPedId(), GetHashKey('weapon_melee_davy_lantern'), 0, 12, 0, 0);
									end
									Citizen.Wait(1500)
									Citizen.InvokeNative(0xFCCC886EDE3C63EC, PlayerPedId(), false, true, true)
									Citizen.Wait(500)
								end
							end
						end
					end
				end
			end
		end
		Citizen.Wait(100)
	end
	RemoveAllWeapons()
	Citizen.Wait(2000)
	for k,v in pairs(weapon_table) do
		if v.used == 1 then
			if string.match(v.name, "REVOLVER")  then
				if weapon_first_used == false then
					weapon_first_used = v.name
					--Citizen.InvokeNative(0x5E3BDDBCB83F3D84, PlayerPedId(), GetHashKey(weapon_first_used), 0, false, true, true, 1.0)
					Citizen.InvokeNative(0xB282DC6EBD803C75, PlayerPedId(), GetHashKey(weapon_first_used), 0, true, 0);
					Citizen.Wait(10)
					for k2,v2 in pairs(json.decode(v.ammo)) do
						SetPedAmmoByType(PlayerPedId(), GetHashKey(k2), v2);
					end
					local comps_decoded = json.decode(v.comps)
					TriggerEvent("gum_weapons:load_components", comps_decoded)
					local load_dirt = 0
					local weaponEntityIndex = GetCurrentPedWeaponEntityIndex(PlayerPedId())
					while Citizen.InvokeNative(0x810E8AE9AFEA7E54, weaponEntityIndex, Citizen.ResultAsFloat()) ~= v.conditionlevel and load_dirt < 150 do
						load_dirt = load_dirt+1
						Citizen.InvokeNative(0xA7A57E89E965D839, weaponEntityIndex, tonumber(v.conditionlevel))
						Citizen.InvokeNative(0x812CE61DEBCAB948, weaponEntityIndex, tonumber(v.conditionlevel))
						Citizen.Wait(10)
					end
					bp_condition[v.id] = v.conditionlevel
					condition_level[v.id] = v.conditionlevel
					Citizen.Wait(1500)
					Citizen.InvokeNative(0xFCCC886EDE3C63EC, PlayerPedId(), false, true, true)
					Citizen.Wait(500)
				else
					if weapon_second_used == false then
						weapon_second_used = v.name
						--Citizen.InvokeNative(0x5E3BDDBCB83F3D84, PlayerPedId(), GetHashKey(weapon_second_used), 0, false, true, true, 1.0)
						Citizen.InvokeNative(0xB282DC6EBD803C75, PlayerPedId(), GetHashKey(weapon_second_used), 0, true, 0);
						Citizen.Wait(10)
						for k2,v2 in pairs(json.decode(v.ammo)) do
							SetPedAmmoByType(PlayerPedId(), GetHashKey(k2), v2);
						end
						local comps_decoded = json.decode(v.comps)
						TriggerEvent("gum_weapons:load_components", comps_decoded)			
						local load_dirt = 0
						local weaponEntityIndex = GetCurrentPedWeaponEntityIndex(PlayerPedId())
						while Citizen.InvokeNative(0x810E8AE9AFEA7E54, weaponEntityIndex, Citizen.ResultAsFloat()) ~= v.conditionlevel and load_dirt < 150 do
							load_dirt = load_dirt+1
							Citizen.InvokeNative(0xA7A57E89E965D839, weaponEntityIndex, tonumber(v.conditionlevel))
							Citizen.InvokeNative(0x812CE61DEBCAB948, weaponEntityIndex, tonumber(v.conditionlevel))
							Citizen.Wait(10)
						end
						bp_condition[v.id] = v.conditionlevel
						condition_level[v.id] = v.conditionlevel
						Citizen.Wait(1500)
						Citizen.InvokeNative(0xFCCC886EDE3C63EC, PlayerPedId(), false, true, true)
						Citizen.Wait(500)
					end
				end
			else
				if string.match(v.name, "revolver") then
					if weapon_first_used == false then
						weapon_first_used = v.name
						Citizen.InvokeNative(0xB282DC6EBD803C75, PlayerPedId(), GetHashKey(weapon_first_used), 0, true, 0);
						--Citizen.InvokeNative(0x5E3BDDBCB83F3D84, PlayerPedId(), GetHashKey(weapon_first_used), 0, false, true, true, 1.0)
						Citizen.Wait(10)
						for k2,v2 in pairs(json.decode(v.ammo)) do
							SetPedAmmoByType(PlayerPedId(), GetHashKey(k2), v2);
						end
						local comps_decoded = json.decode(v.comps)
						TriggerEvent("gum_weapons:load_components", comps_decoded)
						local load_dirt = 0
						local weaponEntityIndex = GetCurrentPedWeaponEntityIndex(PlayerPedId())
						while Citizen.InvokeNative(0x810E8AE9AFEA7E54, weaponEntityIndex, Citizen.ResultAsFloat()) ~= v.conditionlevel and load_dirt < 150 do
							load_dirt = load_dirt+1
							Citizen.InvokeNative(0xA7A57E89E965D839, weaponEntityIndex, tonumber(v.conditionlevel))
							Citizen.InvokeNative(0x812CE61DEBCAB948, weaponEntityIndex, tonumber(v.conditionlevel))
							Citizen.Wait(10)
						end
						bp_condition[v.id] = v.conditionlevel
						condition_level[v.id] = v.conditionlevel
						Citizen.Wait(1500)
						Citizen.InvokeNative(0xFCCC886EDE3C63EC, PlayerPedId(), false, true, true)
						Citizen.Wait(500)
					else
						if weapon_second_used == false then
							weapon_second_used = v.name
							Citizen.InvokeNative(0xB282DC6EBD803C75, PlayerPedId(), GetHashKey(weapon_second_used), 0, true, 0);
							--Citizen.InvokeNative(0x5E3BDDBCB83F3D84, PlayerPedId(), GetHashKey(weapon_second_used), 0, false, true, true, 1.0)
							Citizen.Wait(10)
							for k2,v2 in pairs(json.decode(v.ammo)) do
								SetPedAmmoByType(PlayerPedId(), GetHashKey(k2), v2);
							end
							local comps_decoded = json.decode(v.comps)
							TriggerEvent("gum_weapons:load_components", comps_decoded)
							local load_dirt = 0
							local weaponEntityIndex = GetCurrentPedWeaponEntityIndex(PlayerPedId())
							while Citizen.InvokeNative(0x810E8AE9AFEA7E54, weaponEntityIndex, Citizen.ResultAsFloat()) ~= v.conditionlevel and load_dirt < 150 do
								load_dirt = load_dirt+1
								Citizen.InvokeNative(0xA7A57E89E965D839, weaponEntityIndex, tonumber(v.conditionlevel))
								Citizen.InvokeNative(0x812CE61DEBCAB948, weaponEntityIndex, tonumber(v.conditionlevel))
								Citizen.Wait(10)
							end
							bp_condition[v.id] = v.conditionlevel
							condition_level[v.id] = v.conditionlevel
							Citizen.Wait(1500)
							Citizen.InvokeNative(0xFCCC886EDE3C63EC, PlayerPedId(), false, true, true)
							Citizen.Wait(500)
						end
					end
				end
				if string.match(v.name, "PISTOL") then
					if weapon_first_used == false then
						weapon_first_used = v.name
						Citizen.InvokeNative(0xB282DC6EBD803C75, PlayerPedId(), GetHashKey(weapon_first_used), 0, true, 0);
						--Citizen.InvokeNative(0x5E3BDDBCB83F3D84, PlayerPedId(), GetHashKey(weapon_first_used), 0, false, true, true, 1.0)
						Citizen.Wait(10)
						for k2,v2 in pairs(json.decode(v.ammo)) do
							SetPedAmmoByType(PlayerPedId(), GetHashKey(k2), v2);
						end
						local comps_decoded = json.decode(v.comps)
						TriggerEvent("gum_weapons:load_components", comps_decoded)
						local load_dirt = 0
						local weaponEntityIndex = GetCurrentPedWeaponEntityIndex(PlayerPedId())
						while Citizen.InvokeNative(0x810E8AE9AFEA7E54, weaponEntityIndex, Citizen.ResultAsFloat()) ~= v.conditionlevel and load_dirt < 150 do
							load_dirt = load_dirt+1
							Citizen.InvokeNative(0xA7A57E89E965D839, weaponEntityIndex, tonumber(v.conditionlevel))
							Citizen.InvokeNative(0x812CE61DEBCAB948, weaponEntityIndex, tonumber(v.conditionlevel))
							Citizen.Wait(10)
						end
						bp_condition[v.id] = v.conditionlevel
						condition_level[v.id] = v.conditionlevel
						Citizen.Wait(1500)
						Citizen.InvokeNative(0xFCCC886EDE3C63EC, PlayerPedId(), false, true, true)
						Citizen.Wait(500)
					else
						if weapon_second_used == false then
							weapon_second_used = v.name
							--Citizen.InvokeNative(0x5E3BDDBCB83F3D84, PlayerPedId(), GetHashKey(weapon_second_used), 0, false, true, true, 1.0)
							Citizen.InvokeNative(0xB282DC6EBD803C75, PlayerPedId(), GetHashKey(weapon_second_used), 0, true, 0);
							Citizen.Wait(500)
							for k2,v2 in pairs(json.decode(v.ammo)) do
								SetPedAmmoByType(PlayerPedId(), GetHashKey(k2), v2);
							end
							local comps_decoded = json.decode(v.comps)
							TriggerEvent("gum_weapons:load_components", comps_decoded)
							local load_dirt = 0
							local weaponEntityIndex = GetCurrentPedWeaponEntityIndex(PlayerPedId())
							while Citizen.InvokeNative(0x810E8AE9AFEA7E54, weaponEntityIndex, Citizen.ResultAsFloat()) ~= v.conditionlevel and load_dirt < 150 do
								load_dirt = load_dirt+1
								Citizen.InvokeNative(0xA7A57E89E965D839, weaponEntityIndex, tonumber(v.conditionlevel))
								Citizen.InvokeNative(0x812CE61DEBCAB948, weaponEntityIndex, tonumber(v.conditionlevel))
								Citizen.Wait(10)
							end
							bp_condition[v.id] = v.conditionlevel
							condition_level[v.id] = v.conditionlevel
							Citizen.Wait(1500)
							Citizen.InvokeNative(0xFCCC886EDE3C63EC, PlayerPedId(), false, true, true)
							Citizen.Wait(500)
						end
					end
				else
					if string.match(v.name, "pistol") then
						if weapon_first_used == false then
							weapon_first_used = v.name
							--Citizen.InvokeNative(0x5E3BDDBCB83F3D84, PlayerPedId(), GetHashKey(weapon_first_used), 0, false, true, true, 1.0)
							Citizen.InvokeNative(0xB282DC6EBD803C75, PlayerPedId(), GetHashKey(weapon_first_used), 0, true, 0);
							Citizen.Wait(10)
							for k2,v2 in pairs(json.decode(v.ammo)) do
								SetPedAmmoByType(PlayerPedId(), GetHashKey(k2), v2);
							end
							local comps_decoded = json.decode(v.comps)
							TriggerEvent("gum_weapons:load_components", comps_decoded)
							local load_dirt = 0
							local weaponEntityIndex = GetCurrentPedWeaponEntityIndex(PlayerPedId())
							while Citizen.InvokeNative(0x810E8AE9AFEA7E54, weaponEntityIndex, Citizen.ResultAsFloat()) ~= v.conditionlevel and load_dirt < 150 do
								load_dirt = load_dirt+1
								Citizen.InvokeNative(0xA7A57E89E965D839, weaponEntityIndex, tonumber(v.conditionlevel))
								Citizen.InvokeNative(0x812CE61DEBCAB948, weaponEntityIndex, tonumber(v.conditionlevel))
								Citizen.Wait(10)
							end
							bp_condition[v.id] = v.conditionlevel
							condition_level[v.id] = v.conditionlevel
							Citizen.Wait(1500)
							Citizen.InvokeNative(0xFCCC886EDE3C63EC, PlayerPedId(), false, true, true)
							Citizen.Wait(500)
						else
							if weapon_second_used == false then
								weapon_second_used = v.name
								--Citizen.InvokeNative(0x5E3BDDBCB83F3D84, PlayerPedId(), GetHashKey(weapon_second_used), 0, false, true, true, 1.0)
								Citizen.InvokeNative(0xB282DC6EBD803C75, PlayerPedId(), GetHashKey(weapon_second_used), 0, true, 0);
								Citizen.Wait(10)
								for k2,v2 in pairs(json.decode(v.ammo)) do
									SetPedAmmoByType(PlayerPedId(), GetHashKey(k2), v2);
								end
								local comps_decoded = json.decode(v.comps)
								TriggerEvent("gum_weapons:load_components", comps_decoded)
								local load_dirt = 0
								local weaponEntityIndex = GetCurrentPedWeaponEntityIndex(PlayerPedId())
								while Citizen.InvokeNative(0x810E8AE9AFEA7E54, weaponEntityIndex, Citizen.ResultAsFloat()) ~= v.conditionlevel and load_dirt < 150 do
									load_dirt = load_dirt+1
									Citizen.InvokeNative(0xA7A57E89E965D839, weaponEntityIndex, tonumber(v.conditionlevel))
									Citizen.InvokeNative(0x812CE61DEBCAB948, weaponEntityIndex, tonumber(v.conditionlevel))
									Citizen.Wait(10)
								end
								bp_condition[v.id] = v.conditionlevel
								condition_level[v.id] = v.conditionlevel
								Citizen.Wait(1500)
								Citizen.InvokeNative(0xFCCC886EDE3C63EC, PlayerPedId(), false, true, true)
								Citizen.Wait(500)
							end
						end
					else
						local weapon_what = "other"
						if GetHashKey('GROUP_REPEATER') == GetWeapontypeGroup(v.name) then
							weapon_what = "REPEATER"
						elseif GetHashKey('GROUP_SHOTGUN') == GetWeapontypeGroup(v.name) then
							weapon_what = "SHOTGUN"
						elseif GetHashKey('GROUP_RIFLE') == GetWeapontypeGroup(v.name) then
							weapon_what = "RIFLE"
						elseif GetHashKey('GROUP_SNIPER') == GetWeapontypeGroup(v.name) then
							weapon_what = "SNIPER"
						elseif GetHashKey('GROUP_BOW') == GetWeapontypeGroup(v.name) then
							weapon_what = "BOW"
						else
							weapon_what = "other"
						end
						if rifle_first_used == false and weapon_what ~= "other" then
							rifle_first_used = v.name
							Citizen.InvokeNative(0xB282DC6EBD803C75, PlayerPedId(), GetHashKey(rifle_first_used), 0, true, 0);
							--Citizen.InvokeNative(0x5E3BDDBCB83F3D84, PlayerPedId(), GetHashKey(rifle_first_used), 0, false, true, true, 1.0)
							Citizen.Wait(10)
							for k2,v2 in pairs(json.decode(v.ammo)) do
								SetPedAmmoByType(PlayerPedId(), GetHashKey(k2), v2);
							end
							local comps_decoded = json.decode(v.comps)
							TriggerEvent("gum_weapons:load_components", comps_decoded)
							local load_dirt = 0
							local weaponEntityIndex = GetCurrentPedWeaponEntityIndex(PlayerPedId())
							while Citizen.InvokeNative(0x810E8AE9AFEA7E54, weaponEntityIndex, Citizen.ResultAsFloat()) ~= v.conditionlevel and load_dirt < 150 do
								load_dirt = load_dirt+1
								Citizen.InvokeNative(0xA7A57E89E965D839, weaponEntityIndex, tonumber(v.conditionlevel))
								Citizen.InvokeNative(0x812CE61DEBCAB948, weaponEntityIndex, tonumber(v.conditionlevel))
								Citizen.Wait(10)
							end
							local comps_decoded = json.decode(v.comps)
							TriggerEvent("gum_weapons:load_components", comps_decoded)
							bp_condition[v.id] = v.conditionlevel
							condition_level[v.id] = v.conditionlevel
							Citizen.Wait(1500)
							Citizen.InvokeNative(0xFCCC886EDE3C63EC, PlayerPedId(), false, true, true)
							Citizen.Wait(500)
						else
							if rifle_second_used == false and weapon_what ~= "other" then
								rifle_second_used = v.name
								Citizen.InvokeNative(0xB282DC6EBD803C75, PlayerPedId(), GetHashKey(rifle_second_used), 0, true, 0);
								--Citizen.InvokeNative(0x5E3BDDBCB83F3D84, PlayerPedId(), GetHashKey(rifle_second_used), 0, false, true, true, 1.0)
								Citizen.Wait(10)
								for k2,v2 in pairs(json.decode(v.ammo)) do
									SetPedAmmoByType(PlayerPedId(), GetHashKey(k2), v2);
								end
								local comps_decoded = json.decode(v.comps)
								TriggerEvent("gum_weapons:load_components", comps_decoded)
								local load_dirt = 0
								local weaponEntityIndex = GetCurrentPedWeaponEntityIndex(PlayerPedId())
								while Citizen.InvokeNative(0x810E8AE9AFEA7E54, weaponEntityIndex, Citizen.ResultAsFloat()) ~= v.conditionlevel and load_dirt < 150 do
									load_dirt = load_dirt+1
									Citizen.InvokeNative(0xA7A57E89E965D839, weaponEntityIndex, tonumber(v.conditionlevel))
									Citizen.InvokeNative(0x812CE61DEBCAB948, weaponEntityIndex, tonumber(v.conditionlevel))
									Citizen.Wait(10)
								end
								bp_condition[v.id] = v.conditionlevel
								condition_level[v.id] = v.conditionlevel
								Citizen.Wait(1500)
								Citizen.InvokeNative(0xFCCC886EDE3C63EC, PlayerPedId(), false, true, true)
								Citizen.Wait(500)
							else
								if weapon_what == "other" then
									Citizen.InvokeNative(0xB282DC6EBD803C75, PlayerPedId(), GetHashKey(v.name), 0, true, 0);
									--Citizen.InvokeNative(0x5E3BDDBCB83F3D84, PlayerPedId(), GetHashKey(v.name), 0, false, true, true, 1.0);
									local comps_decoded = json.decode(v.comps)
									TriggerEvent("gum_weapons:load_components", comps_decoded)
									local weaponEntityIndex = GetCurrentPedWeaponEntityIndex(PlayerPedId())
									Citizen.InvokeNative(0xA7A57E89E965D839, weaponEntityIndex, tonumber(v.conditionlevel))
									Citizen.InvokeNative(0x812CE61DEBCAB948, weaponEntityIndex, tonumber(v.conditionlevel))
									Citizen.Wait(50)
									bp_condition[v.id] = v.conditionlevel
									condition_level[v.id] = v.conditionlevel
									Citizen.Wait(1500)
									if v.name == 'weapon_melee_davy_lantern' then
										GiveWeaponToPed_2(PlayerPedId(), GetHashKey('weapon_melee_davy_lantern'), 0, true,true, 12, false, 0.5, 1.0, 752097756, false,0, false);
										Citizen.InvokeNative(0xADF692B254977C0C, PlayerPedId(), GetHashKey('weapon_melee_davy_lantern'), 0, 12, 0, 0);
									end
									Citizen.Wait(100)
									Citizen.InvokeNative(0xFCCC886EDE3C63EC, PlayerPedId(), false, true, true)
									Citizen.Wait(500)
								end
							end
						end
					end
				end
			end
		end
		Citizen.Wait(100)
	end
	RemoveAllWeapons()
	Citizen.Wait(2000)
	for k,v in pairs(weapon_table) do
		if v.used == 1 then
			if string.match(v.name, "REVOLVER")  then
				if weapon_first_used == false then
					weapon_first_used = v.name
					--Citizen.InvokeNative(0x5E3BDDBCB83F3D84, PlayerPedId(), GetHashKey(weapon_first_used), 0, false, true, true, 1.0)
					Citizen.InvokeNative(0xB282DC6EBD803C75, PlayerPedId(), GetHashKey(weapon_first_used), 0, true, 0);
					Citizen.Wait(500)
					for k2,v2 in pairs(json.decode(v.ammo)) do
						SetPedAmmoByType(PlayerPedId(), GetHashKey(k2), v2);
					end
					local comps_decoded = json.decode(v.comps)
					TriggerEvent("gum_weapons:load_components", comps_decoded)
					local load_dirt = 0
					local weaponEntityIndex = GetCurrentPedWeaponEntityIndex(PlayerPedId())
						load_dirt = load_dirt+1
						Citizen.InvokeNative(0xA7A57E89E965D839, weaponEntityIndex, tonumber(v.conditionlevel))
						Citizen.InvokeNative(0x812CE61DEBCAB948, weaponEntityIndex, tonumber(v.conditionlevel))
						Citizen.Wait(500)
					bp_condition[v.id] = v.conditionlevel
					condition_level[v.id] = v.conditionlevel
					Citizen.Wait(1500)
					Citizen.InvokeNative(0xFCCC886EDE3C63EC, PlayerPedId(), false, true, true)
					Citizen.Wait(500)
				else
					if weapon_second_used == false then
						weapon_second_used = v.name
						--Citizen.InvokeNative(0x5E3BDDBCB83F3D84, PlayerPedId(), GetHashKey(weapon_second_used), 0, false, true, true, 1.0)
						Citizen.InvokeNative(0xB282DC6EBD803C75, PlayerPedId(), GetHashKey(weapon_second_used), 0, true, 0);
						Citizen.Wait(500)
						for k2,v2 in pairs(json.decode(v.ammo)) do
							SetPedAmmoByType(PlayerPedId(), GetHashKey(k2), v2);
						end
						local comps_decoded = json.decode(v.comps)
						TriggerEvent("gum_weapons:load_components", comps_decoded)			
						local load_dirt = 0
						local weaponEntityIndex = GetCurrentPedWeaponEntityIndex(PlayerPedId())
							Citizen.InvokeNative(0xA7A57E89E965D839, weaponEntityIndex, tonumber(v.conditionlevel))
							Citizen.InvokeNative(0x812CE61DEBCAB948, weaponEntityIndex, tonumber(v.conditionlevel))
							Citizen.Wait(500)
						bp_condition[v.id] = v.conditionlevel
						condition_level[v.id] = v.conditionlevel
						Citizen.Wait(1500)
						Citizen.InvokeNative(0xFCCC886EDE3C63EC, PlayerPedId(), false, true, true)
						Citizen.Wait(500)
					end
				end
			else
				if string.match(v.name, "revolver") then
					if weapon_first_used == false then
						weapon_first_used = v.name
						Citizen.InvokeNative(0xB282DC6EBD803C75, PlayerPedId(), GetHashKey(weapon_first_used), 0, true, 0);
						--Citizen.InvokeNative(0x5E3BDDBCB83F3D84, PlayerPedId(), GetHashKey(weapon_first_used), 0, false, true, true, 1.0)
						Citizen.Wait(500)
						for k2,v2 in pairs(json.decode(v.ammo)) do
							SetPedAmmoByType(PlayerPedId(), GetHashKey(k2), v2);
						end
						local comps_decoded = json.decode(v.comps)
						TriggerEvent("gum_weapons:load_components", comps_decoded)
						local load_dirt = 0
						local weaponEntityIndex = GetCurrentPedWeaponEntityIndex(PlayerPedId())
							Citizen.InvokeNative(0xA7A57E89E965D839, weaponEntityIndex, tonumber(v.conditionlevel))
							Citizen.InvokeNative(0x812CE61DEBCAB948, weaponEntityIndex, tonumber(v.conditionlevel))
							Citizen.Wait(500)
						bp_condition[v.id] = v.conditionlevel
						condition_level[v.id] = v.conditionlevel
						Citizen.Wait(1500)
						Citizen.InvokeNative(0xFCCC886EDE3C63EC, PlayerPedId(), false, true, true)
						Citizen.Wait(500)
					else
						if weapon_second_used == false then
							weapon_second_used = v.name
							Citizen.InvokeNative(0xB282DC6EBD803C75, PlayerPedId(), GetHashKey(weapon_second_used), 0, true, 0);
							--Citizen.InvokeNative(0x5E3BDDBCB83F3D84, PlayerPedId(), GetHashKey(weapon_second_used), 0, false, true, true, 1.0)
							Citizen.Wait(500)
							for k2,v2 in pairs(json.decode(v.ammo)) do
								SetPedAmmoByType(PlayerPedId(), GetHashKey(k2), v2);
							end
							local comps_decoded = json.decode(v.comps)
							TriggerEvent("gum_weapons:load_components", comps_decoded)
							local load_dirt = 0
							local weaponEntityIndex = GetCurrentPedWeaponEntityIndex(PlayerPedId())
							Citizen.InvokeNative(0xA7A57E89E965D839, weaponEntityIndex, tonumber(v.conditionlevel))
							Citizen.InvokeNative(0x812CE61DEBCAB948, weaponEntityIndex, tonumber(v.conditionlevel))
							Citizen.Wait(500)
							bp_condition[v.id] = v.conditionlevel
							condition_level[v.id] = v.conditionlevel
							Citizen.Wait(1500)
							Citizen.InvokeNative(0xFCCC886EDE3C63EC, PlayerPedId(), false, true, true)
							Citizen.Wait(500)
						end
					end
				end
				if string.match(v.name, "PISTOL") then
					if weapon_first_used == false then
						weapon_first_used = v.name
						Citizen.InvokeNative(0xB282DC6EBD803C75, PlayerPedId(), GetHashKey(weapon_first_used), 0, true, 0);
						--Citizen.InvokeNative(0x5E3BDDBCB83F3D84, PlayerPedId(), GetHashKey(weapon_first_used), 0, false, true, true, 1.0)
						Citizen.Wait(500)
						for k2,v2 in pairs(json.decode(v.ammo)) do
							SetPedAmmoByType(PlayerPedId(), GetHashKey(k2), v2);
						end
						local comps_decoded = json.decode(v.comps)
						TriggerEvent("gum_weapons:load_components", comps_decoded)
						local load_dirt = 0
						local weaponEntityIndex = GetCurrentPedWeaponEntityIndex(PlayerPedId())
						Citizen.InvokeNative(0xA7A57E89E965D839, weaponEntityIndex, tonumber(v.conditionlevel))
						Citizen.InvokeNative(0x812CE61DEBCAB948, weaponEntityIndex, tonumber(v.conditionlevel))

						bp_condition[v.id] = v.conditionlevel
						condition_level[v.id] = v.conditionlevel
						Citizen.Wait(1500)
						Citizen.InvokeNative(0xFCCC886EDE3C63EC, PlayerPedId(), false, true, true)
						Citizen.Wait(500)
					else
						if weapon_second_used == false then
							weapon_second_used = v.name
							--Citizen.InvokeNative(0x5E3BDDBCB83F3D84, PlayerPedId(), GetHashKey(weapon_second_used), 0, false, true, true, 1.0)
							Citizen.InvokeNative(0xB282DC6EBD803C75, PlayerPedId(), GetHashKey(weapon_second_used), 0, true, 0);
							Citizen.Wait(500)
							for k2,v2 in pairs(json.decode(v.ammo)) do
								SetPedAmmoByType(PlayerPedId(), GetHashKey(k2), v2);
							end
							local comps_decoded = json.decode(v.comps)
							TriggerEvent("gum_weapons:load_components", comps_decoded)
							local load_dirt = 0
							local weaponEntityIndex = GetCurrentPedWeaponEntityIndex(PlayerPedId())
							Citizen.InvokeNative(0xA7A57E89E965D839, weaponEntityIndex, tonumber(v.conditionlevel))
							Citizen.InvokeNative(0x812CE61DEBCAB948, weaponEntityIndex, tonumber(v.conditionlevel))
							Citizen.Wait(500)
	
							bp_condition[v.id] = v.conditionlevel
							condition_level[v.id] = v.conditionlevel
							Citizen.Wait(1500)
							Citizen.InvokeNative(0xFCCC886EDE3C63EC, PlayerPedId(), false, true, true)
							Citizen.Wait(500)
						end
					end
				else
					if string.match(v.name, "pistol") then
						if weapon_first_used == false then
							weapon_first_used = v.name
							--Citizen.InvokeNative(0x5E3BDDBCB83F3D84, PlayerPedId(), GetHashKey(weapon_first_used), 0, false, true, true, 1.0)
							Citizen.InvokeNative(0xB282DC6EBD803C75, PlayerPedId(), GetHashKey(weapon_first_used), 0, true, 0);
							Citizen.Wait(500)
							for k2,v2 in pairs(json.decode(v.ammo)) do
								SetPedAmmoByType(PlayerPedId(), GetHashKey(k2), v2);
							end
							local comps_decoded = json.decode(v.comps)
							TriggerEvent("gum_weapons:load_components", comps_decoded)
							local load_dirt = 0
							local weaponEntityIndex = GetCurrentPedWeaponEntityIndex(PlayerPedId())
							Citizen.InvokeNative(0xA7A57E89E965D839, weaponEntityIndex, tonumber(v.conditionlevel))
							Citizen.InvokeNative(0x812CE61DEBCAB948, weaponEntityIndex, tonumber(v.conditionlevel))
							bp_condition[v.id] = v.conditionlevel
							condition_level[v.id] = v.conditionlevel
							Citizen.Wait(1500)
							Citizen.InvokeNative(0xFCCC886EDE3C63EC, PlayerPedId(), false, true, true)
							Citizen.Wait(500)
						else
							if weapon_second_used == false then
								weapon_second_used = v.name
								--Citizen.InvokeNative(0x5E3BDDBCB83F3D84, PlayerPedId(), GetHashKey(weapon_second_used), 0, false, true, true, 1.0)
								Citizen.InvokeNative(0xB282DC6EBD803C75, PlayerPedId(), GetHashKey(weapon_second_used), 0, true, 0);
								Citizen.Wait(500)
								for k2,v2 in pairs(json.decode(v.ammo)) do
									SetPedAmmoByType(PlayerPedId(), GetHashKey(k2), v2);
								end
								local comps_decoded = json.decode(v.comps)
								TriggerEvent("gum_weapons:load_components", comps_decoded)
								local load_dirt = 0
								local weaponEntityIndex = GetCurrentPedWeaponEntityIndex(PlayerPedId())
								Citizen.InvokeNative(0xA7A57E89E965D839, weaponEntityIndex, tonumber(v.conditionlevel))
								Citizen.InvokeNative(0x812CE61DEBCAB948, weaponEntityIndex, tonumber(v.conditionlevel))
								Citizen.Wait(10)
								bp_condition[v.id] = v.conditionlevel
								condition_level[v.id] = v.conditionlevel
								Citizen.Wait(1500)
								Citizen.InvokeNative(0xFCCC886EDE3C63EC, PlayerPedId(), false, true, true)
								Citizen.Wait(500)
							end
						end
					else
						local weapon_what = "other"
						if GetHashKey('GROUP_REPEATER') == GetWeapontypeGroup(v.name) then
							weapon_what = "REPEATER"
						elseif GetHashKey('GROUP_SHOTGUN') == GetWeapontypeGroup(v.name) then
							weapon_what = "SHOTGUN"
						elseif GetHashKey('GROUP_RIFLE') == GetWeapontypeGroup(v.name) then
							weapon_what = "RIFLE"
						elseif GetHashKey('GROUP_SNIPER') == GetWeapontypeGroup(v.name) then
							weapon_what = "SNIPER"
						elseif GetHashKey('GROUP_BOW') == GetWeapontypeGroup(v.name) then
							weapon_what = "BOW"
						else
							weapon_what = "other"
						end
						if rifle_first_used == false and weapon_what ~= "other" then
							rifle_first_used = v.name
							Citizen.InvokeNative(0xB282DC6EBD803C75, PlayerPedId(), GetHashKey(rifle_first_used), 0, true, 0);
							--Citizen.InvokeNative(0x5E3BDDBCB83F3D84, PlayerPedId(), GetHashKey(rifle_first_used), 0, false, true, true, 1.0)
							Citizen.Wait(500)
							for k2,v2 in pairs(json.decode(v.ammo)) do
								SetPedAmmoByType(PlayerPedId(), GetHashKey(k2), v2);
							end
							local comps_decoded = json.decode(v.comps)
							TriggerEvent("gum_weapons:load_components", comps_decoded)
							local load_dirt = 0
							local weaponEntityIndex = GetCurrentPedWeaponEntityIndex(PlayerPedId())
							Citizen.InvokeNative(0xA7A57E89E965D839, weaponEntityIndex, tonumber(v.conditionlevel))
							Citizen.InvokeNative(0x812CE61DEBCAB948, weaponEntityIndex, tonumber(v.conditionlevel))
							Citizen.Wait(500)
							local comps_decoded = json.decode(v.comps)
							TriggerEvent("gum_weapons:load_components", comps_decoded)
							bp_condition[v.id] = v.conditionlevel
							condition_level[v.id] = v.conditionlevel
							Citizen.Wait(1500)
							Citizen.InvokeNative(0xFCCC886EDE3C63EC, PlayerPedId(), false, true, true)
							Citizen.Wait(500)
						else
							if rifle_second_used == false and weapon_what ~= "other" then
								rifle_second_used = v.name
								Citizen.InvokeNative(0xB282DC6EBD803C75, PlayerPedId(), GetHashKey(rifle_second_used), 0, true, 0);
								--Citizen.InvokeNative(0x5E3BDDBCB83F3D84, PlayerPedId(), GetHashKey(rifle_second_used), 0, false, true, true, 1.0)
								Citizen.Wait(500)
								for k2,v2 in pairs(json.decode(v.ammo)) do
									SetPedAmmoByType(PlayerPedId(), GetHashKey(k2), v2);
								end
								local comps_decoded = json.decode(v.comps)
								TriggerEvent("gum_weapons:load_components", comps_decoded)
								local load_dirt = 0
								local weaponEntityIndex = GetCurrentPedWeaponEntityIndex(PlayerPedId())

								Citizen.InvokeNative(0xA7A57E89E965D839, weaponEntityIndex, tonumber(v.conditionlevel))
								Citizen.InvokeNative(0x812CE61DEBCAB948, weaponEntityIndex, tonumber(v.conditionlevel))
								Citizen.Wait(10)
								bp_condition[v.id] = v.conditionlevel
								condition_level[v.id] = v.conditionlevel
								Citizen.Wait(1500)
								Citizen.InvokeNative(0xFCCC886EDE3C63EC, PlayerPedId(), false, true, true)
								Citizen.Wait(500)
							else
								if weapon_what == "other" then
									Citizen.InvokeNative(0xB282DC6EBD803C75, PlayerPedId(), GetHashKey(v.name), 0, true, 0);
									--Citizen.InvokeNative(0x5E3BDDBCB83F3D84, PlayerPedId(), GetHashKey(v.name), 0, false, true, true, 1.0);
									local comps_decoded = json.decode(v.comps)
									TriggerEvent("gum_weapons:load_components", comps_decoded)
									local weaponEntityIndex = GetCurrentPedWeaponEntityIndex(PlayerPedId())
									Citizen.InvokeNative(0xA7A57E89E965D839, weaponEntityIndex, tonumber(v.conditionlevel))
									Citizen.InvokeNative(0x812CE61DEBCAB948, weaponEntityIndex, tonumber(v.conditionlevel))
									Citizen.Wait(50)
									bp_condition[v.id] = v.conditionlevel
									condition_level[v.id] = v.conditionlevel
									Citizen.Wait(1500)
									if v.name == 'weapon_melee_davy_lantern' then
										GiveWeaponToPed_2(PlayerPedId(), GetHashKey('weapon_melee_davy_lantern'), 0, true,true, 12, false, 0.5, 1.0, 752097756, false,0, false);
										Citizen.InvokeNative(0xADF692B254977C0C, PlayerPedId(), GetHashKey('weapon_melee_davy_lantern'), 0, 12, 0, 0);
									end
									Citizen.Wait(500)
									Citizen.InvokeNative(0xFCCC886EDE3C63EC, PlayerPedId(), false, true, true)
									Citizen.Wait(500)
								end
							end
						end
					end
				end
			end
		end
		Citizen.Wait(100)
	end
	Citizen.Wait(200)
	if weapon_second_used ~= false and weapon_first_used ~= false then
		GiveWeaponToPed_2(PlayerPedId(), GetHashKey(weapon_second_used), 0, true,true, 3, false, 0.5, 1.0, 752097756, false,0, false);
		GiveWeaponToPed_2(PlayerPedId(), GetHashKey(weapon_first_used), 0, true, true, 2, false, 0.5, 1.0, 752097756, false, 0, false);
	end
	Citizen.Wait(1000)
	TriggerEvent("gum_character:selected_char")
	logged_true = true
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
		can_again = false
		for k,v in pairs(eWeaponAttachPoint) do
			local reval, weaponhash = GetCurrentPedWeapon(PlayerPedId(), 0, v, 0)
			if weaponhash == GetHashKey(data.model) then
				can_again = true
			end
		end
		Citizen.Wait(0)
		if not can_again and logged_true == true then
			local IsRevolver = Citizen.InvokeNative(0xC212F1D05A8232BB, GetHashKey(data.model))
			local IsPistol = Citizen.InvokeNative(0xDDC64F5E31EEDAB6, GetHashKey(data.model))
			--REVOLVERS AND PISTOLS
			if (IsRevolver == 1 or IsPistol == 1) then
				if weapon_first_used == false then
					exports['gum_notify']:DisplayLeftNotification(Config.Language[10].text, Config.Language[12].text, 'pistol', 2000)
					SendNUIMessage({type = "weapon_desc_update", data_info = data.id})

					weapon_first_used = data.model
					Citizen.InvokeNative(0xB282DC6EBD803C75, PlayerPedId(), GetHashKey(weapon_first_used), 0, true, 0);
					for k,v in pairs(weapon_table) do
						if tonumber(v.id) == tonumber(data.id) then
							for k2,v2 in pairs(json.decode(v.ammo)) do
								SetPedAmmoByType(PlayerPedId(), GetHashKey(k2), v2);
							end
							local comps_decoded = json.decode(v.comps)
							TriggerEvent("gum_weapons:load_components", comps_decoded)
							Citizen.Wait(1500)
							local weaponEntityIndex = GetCurrentPedWeaponEntityIndex(PlayerPedId())
							bp_condition[v.id] = v.conditionlevel
							condition_level[v.id] = v.conditionlevel
							Citizen.InvokeNative(0xA7A57E89E965D839, weaponEntityIndex, v.conditionlevel)
							Citizen.InvokeNative(0x812CE61DEBCAB948, weaponEntityIndex, v.dirtlevel, 0)
						end
					end
					Citizen.Wait(500)
					Citizen.InvokeNative(0xFCCC886EDE3C63EC, PlayerPedId(), false, true, true)
					TriggerServerEvent("gum_inventory:send_state_weapon", data.id, 1)
				else
					if weapon_second_used == false then
						exports['gum_notify']:DisplayLeftNotification(Config.Language[10].text, Config.Language[13].text, 'pistol', 2000)
						SendNUIMessage({type = "weapon_desc_update", data_info = data.id})
						weapon_second_used = data.model
						Citizen.InvokeNative(0xB282DC6EBD803C75, PlayerPedId(), GetHashKey(weapon_second_used), 0, true, 0);
						for k,v in pairs(weapon_table) do
							if tonumber(v.id) == tonumber(data.id) then
								for k2,v2 in pairs(json.decode(v.ammo)) do
									SetPedAmmoByType(PlayerPedId(), GetHashKey(k2), v2);
								end
								local comps_decoded = json.decode(v.comps)
								TriggerEvent("gum_weapons:load_components", comps_decoded)
								Citizen.Wait(1500)
								local weaponEntityIndex = GetCurrentPedWeaponEntityIndex(PlayerPedId())
								bp_condition[v.id] = v.conditionlevel
								condition_level[v.id] = v.conditionlevel
								Citizen.InvokeNative(0xA7A57E89E965D839, weaponEntityIndex, v.conditionlevel)
								Citizen.InvokeNative(0x812CE61DEBCAB948, weaponEntityIndex, v.dirtlevel, 0)
							end
						end
						Citizen.Wait(500)
						Citizen.InvokeNative(0xFCCC886EDE3C63EC, PlayerPedId(), false, true, true)
						TriggerServerEvent("gum_inventory:send_state_weapon", data.id, 1)
						GiveWeaponToPed_2(PlayerPedId(), GetHashKey(weapon_second_used), 0, true,true, 3, false, 0.5, 1.0, 752097756, false,0, false);
						GiveWeaponToPed_2(PlayerPedId(), GetHashKey(weapon_first_used), 0, true, true, 2, false, 0.5, 1.0, 752097756, false, 0, false);
					else
						exports['gum_notify']:DisplayLeftNotification(Config.Language[10].text, Config.Language[14].text, 'pistol', 2000)
					end
				end
			else
				---RIFLES AND REPEATERS
				local weapon_what = "other"
				if GetHashKey('GROUP_REPEATER') == GetWeapontypeGroup(data.model) then
					weapon_what = "REPEATER"
				elseif GetHashKey('GROUP_SHOTGUN') == GetWeapontypeGroup(data.model) then
					weapon_what = "SHOTGUN"
				elseif GetHashKey('GROUP_RIFLE') == GetWeapontypeGroup(data.model) then
					weapon_what = "RIFLE"
				elseif GetHashKey('GROUP_SNIPER') == GetWeapontypeGroup(data.model) then
					weapon_what = "SNIPER"
				elseif GetHashKey('GROUP_BOW') == GetWeapontypeGroup(data.model) then
					weapon_what = "BOW"
				else
					weapon_what = "other"
				end
				if rifle_first_used == false and weapon_what ~= "other" then
					rifle_first_used = data.model
					exports['gum_notify']:DisplayLeftNotification(Config.Language[10].text, Config.Language[15].text, 'rifle', 2000)
					SendNUIMessage({type = "weapon_desc_update", data_info = data.id})
					Citizen.InvokeNative(0xB282DC6EBD803C75, PlayerPedId(), GetHashKey(data.model), 0, true, 0);
					for k,v in pairs(weapon_table) do
						if tonumber(v.id) == tonumber(data.id) then
							for k2,v2 in pairs(json.decode(v.ammo)) do
								SetPedAmmoByType(PlayerPedId(), GetHashKey(k2), v2);
							end
							SetPedAmmoByType(PlayerPedId(), GetHashKey('AMMO_ARROW'), 1);
							local comps_decoded = json.decode(v.comps)
							TriggerEvent("gum_weapons:load_components", comps_decoded)
							Citizen.Wait(1500)
							local weaponEntityIndex = GetCurrentPedWeaponEntityIndex(PlayerPedId())
							bp_condition[v.id] = v.conditionlevel
							condition_level[v.id] = v.conditionlevel
							Citizen.InvokeNative(0xA7A57E89E965D839, weaponEntityIndex, v.conditionlevel)
							Citizen.InvokeNative(0x812CE61DEBCAB948, weaponEntityIndex, v.dirtlevel, 0)
						end
					end
					Citizen.Wait(500)
					Citizen.InvokeNative(0xFCCC886EDE3C63EC, PlayerPedId(), false, true, true)
					TriggerServerEvent("gum_inventory:send_state_weapon", data.id, 1)
				else
					if rifle_second_used == false and weapon_what ~= "other" then
						rifle_second_used = data.model
						exports['gum_notify']:DisplayLeftNotification(Config.Language[10].text, Config.Language[16].text, 'rifle', 2000)
						SendNUIMessage({type = "weapon_desc_update", data_info = data.id})
						Citizen.InvokeNative(0xB282DC6EBD803C75, PlayerPedId(), GetHashKey(data.model), 0, true, 0);
						if weapon_what == "BOW" then
							SetPedAmmoByType(PlayerPedId(), GetHashKey('AMMO_ARROW'), 1);
						end
						for k,v in pairs(weapon_table) do
							if tonumber(v.id) == tonumber(data.id) then
								for k2,v2 in pairs(json.decode(v.ammo)) do
									SetPedAmmoByType(PlayerPedId(), GetHashKey(k2), v2);
								end
								local comps_decoded = json.decode(v.comps)
								TriggerEvent("gum_weapons:load_components", comps_decoded)
								Citizen.Wait(1500)
								local weaponEntityIndex = GetCurrentPedWeaponEntityIndex(PlayerPedId())
								bp_condition[v.id] = v.conditionlevel
								condition_level[v.id] = v.conditionlevel
								Citizen.InvokeNative(0xA7A57E89E965D839, weaponEntityIndex, v.conditionlevel)
								Citizen.InvokeNative(0x812CE61DEBCAB948, weaponEntityIndex, v.dirtlevel, 0)
							end
						end
						Citizen.Wait(500)
						Citizen.InvokeNative(0xFCCC886EDE3C63EC, PlayerPedId(), false, true, true)
						TriggerServerEvent("gum_inventory:send_state_weapon", data.id, 1)
					else
						if rifle_first_used ~= false and rifle_second_used ~= false and weapon_what ~= "other" then
							exports['gum_notify']:DisplayLeftNotification(Config.Language[10].text, Config.Language[17].text, 'rifle', 2000)
						end

						if weapon_what == "other" then
							exports['gum_notify']:DisplayLeftNotification(Config.Language[10].text, Config.Language[18].text, 'other', 2000)
							SendNUIMessage({type = "weapon_desc_update", data_info = data.id})
							Citizen.InvokeNative(0xB282DC6EBD803C75, PlayerPedId(), GetHashKey(data.model), 0, true, 0);
							TriggerServerEvent("gum_inventory:send_state_weapon", data.id, 1)
							for k,v in pairs(weapon_table) do
								if tonumber(v.id) == tonumber(data.id) then
									if weapon_what == "BOW" then
										SetPedAmmoByType(PlayerPedId(), GetHashKey('AMMO_ARROW'), 1);
									end
									local comps_decoded = json.decode(v.comps)
									TriggerEvent("gum_weapons:load_components", comps_decoded)
									Citizen.Wait(1500)
									local weaponEntityIndex = GetCurrentPedWeaponEntityIndex(PlayerPedId())
									bp_condition[v.id] = v.conditionlevel
									condition_level[v.id] = v.conditionlevel
									Citizen.InvokeNative(0xA7A57E89E965D839, weaponEntityIndex, v.conditionlevel)
									Citizen.InvokeNative(0x812CE61DEBCAB948, weaponEntityIndex, v.dirtlevel, 0)
								end
							end
							Citizen.Wait(500)
							Citizen.InvokeNative(0xFCCC886EDE3C63EC, PlayerPedId(), false, true, true)

							if data.model == 'weapon_melee_davy_lantern' then
								GiveWeaponToPed_2(PlayerPedId(), GetHashKey('weapon_melee_davy_lantern'), 0, true,true, 12, false, 0.5, 1.0, 752097756, false,0, false);
								Citizen.InvokeNative(0xADF692B254977C0C, PlayerPedId(), GetHashKey('weapon_melee_davy_lantern'), 0, 12, 0, 0);
							end
						end
					end
				end
			end
		else
			local IsRevolver = Citizen.InvokeNative(0xC212F1D05A8232BB, GetHashKey(data.model))
			local IsPistol = Citizen.InvokeNative(0xDDC64F5E31EEDAB6, GetHashKey(data.model))
			if (IsRevolver == 1 or IsPistol == 1) then
				if data.model == weapon_second_used then
					exports['gum_notify']:DisplayLeftNotification(Config.Language[10].text, Config.Language[13].text, 'bag', 2000)
					SendNUIMessage({type = "weapon_desc_update", data_info = data.id})
					TriggerServerEvent("gum_inventory:send_state_weapon", data.id, 0)
					weapon_second_used = false
					RemoveWeaponFromPed(PlayerPedId(), GetHashKey(data.model))
					Citizen.Wait(200)
					Citizen.InvokeNative("0xB282DC6EBD803C75", PlayerPedId(), GetHashKey(weapon_first_used), 0, true, 0);
				end
				Citizen.Wait(0)
				if data.model == weapon_first_used then
					RemoveWeaponFromPed(PlayerPedId(), GetHashKey(data.model))
					weapon_first_used = false
					TriggerServerEvent("gum_inventory:send_state_weapon", data.id, 0)
					exports['gum_notify']:DisplayLeftNotification(Config.Language[10].text, Config.Language[12].text, 'bag', 2000)
					SendNUIMessage({type = "weapon_desc_update", data_info = data.id})
				end
			else
				if rifle_first_used ~= data.model and rifle_second_used ~= data.model then
					TriggerServerEvent("gum_inventory:send_state_weapon", data.id, 0)
					exports['gum_notify']:DisplayLeftNotification(Config.Language[10].text, Config.Language[21].text, 'bag', 2000)
					SendNUIMessage({type = "weapon_desc_update", data_info = data.id})
					RemoveWeaponFromPed(PlayerPedId(), GetHashKey(data.model))
				end
				Citizen.Wait(0)
				if rifle_first_used == data.model then
					rifle_first_used = false
					TriggerServerEvent("gum_inventory:send_state_weapon", data.id, 0)
					exports['gum_notify']:DisplayLeftNotification(Config.Language[10].text, Config.Language[22].text, 'bag', 2000)
					SendNUIMessage({type = "weapon_desc_update", data_info = data.id})
					RemoveWeaponFromPed(PlayerPedId(), GetHashKey(data.model))
				else
					if rifle_second_used == data.model then
						rifle_second_used = false
						TriggerServerEvent("gum_inventory:send_state_weapon", data.id, 0)
						exports['gum_notify']:DisplayLeftNotification(Config.Language[10].text, Config.Language[23].text, 'bag', 2000)
						SendNUIMessage({type = "weapon_desc_update", data_info = data.id})
						RemoveWeaponFromPed(PlayerPedId(), GetHashKey(data.model))
					end
				end
			end
		end
	end
	Citizen.Wait(1000)
	equip_spam = false
	can_save = true
end)

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
				GiveWeaponToPed_2(PlayerPedId(), GetHashKey(weapon_second_used), 0, true,true, 3, false, 0.5, 1.0, 752097756, false,0, false);
				GiveWeaponToPed_2(PlayerPedId(), GetHashKey(weapon_first_used), 0, true, true, 2, false, 0.5, 1.0, 752097756, false, 0, false);		
				Citizen.InvokeNative(0xADF692B254977C0C, PlayerPedId(), GetHashKey(weapon_first_used), 0, 0, 0, 0);
				Citizen.InvokeNative(0xADF692B254977C0C, PlayerPedId(), GetHashKey(weapon_second_used), 0, 1, 0, 0);
				Citizen.Wait(400)
				GiveWeaponToPed_2(PlayerPedId(), GetHashKey(weapon_second_used), 0, true,true, 3, false, 0.5, 1.0, 752097756, false,0, false);
				GiveWeaponToPed_2(PlayerPedId(), GetHashKey(weapon_first_used), 0, true, true, 2, false, 0.5, 1.0, 752097756, false, 0, false);		
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
			elseif v.weapon == false then
				if v.item == "money" then
					dropped_item = CreateObject("p_moneystack01x", v.x, v.y, v.z, false, false, false)
					PlaceObjectOnGroundProperly(dropped_item)
					FreezeEntityPosition(dropped_item, true)
					Citizen.InvokeNative(0x7DFB49BCDB73089A, dropped_item, true)
					table.insert(dropped_items_entity, {id=v.id, entity=dropped_item, x=v.x ,y=v.y, z=v.z, item=v.item, count=v.count, weapon=v.weapon, weapon_model=v.weapon_model})
				else
					if v.item == "gold" then
						dropped_item = CreateObject("p_goldstack01x", v.x, v.y, v.z, false, false, false)
						PlaceObjectOnGroundProperly(dropped_item)
						FreezeEntityPosition(dropped_item, true)
						Citizen.InvokeNative(0x7DFB49BCDB73089A, dropped_item, true)
						table.insert(dropped_items_entity, {id=v.id, entity=dropped_item, x=v.x ,y=v.y, z=v.z, item=v.item, count=v.count, weapon=v.weapon, weapon_model=v.weapon_model})
					else
						dropped_item = CreateObject("p_cs_dirtybag01x", v.x, v.y, v.z, false, false, false)
						PlaceObjectOnGroundProperly(dropped_item)
						FreezeEntityPosition(dropped_item, true)
						Citizen.InvokeNative(0x7DFB49BCDB73089A, dropped_item, true)
						table.insert(dropped_items_entity, {id=v.id, entity=dropped_item, x=v.x ,y=v.y, z=v.z, item=v.item, count=v.count, weapon=v.weapon, weapon_model=v.weapon_model})
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
