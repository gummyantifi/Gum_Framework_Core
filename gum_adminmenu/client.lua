MenuData = {}
local Speed = Config.Speed
local FollowCam = Config.FollowCam
local source = GetPlayerServerId(0)
local noclip = false
local RelativeMode = Config.RelativeMode
local spectating = false
local steamip = 0
local steamhex = 0
local items_table = {}
local player_list = {}
TriggerEvent("gum_menu:getData",function(call)
    MenuData = call
end)

RegisterNetEvent("Open_Menu")
AddEventHandler("Open_Menu", function()
	Open_Admin_Menu()
end)
RegisterNetEvent("send_hex")
AddEventHandler("send_hex", function(hex, ip)
	steamhex = hex
	steamip = ip
end)

RegisterNetEvent("tptocoords")
AddEventHandler("tptocoords", function(x, y, z)
	SetEntityCoords(PlayerPedId(), tonumber(x), tonumber(y), tonumber(z))
end)

local playerCount = 0

RegisterNetEvent('GetActivePlayers:CB')
AddEventHandler('GetActivePlayers:CB', function(count)
    playerCount = count
end)


CreateThread(function()
	TriggerEvent('chat:addSuggestion', '/db', 'Znovu načte rychle vaši postavu.', {})
	TriggerEvent('chat:addSuggestion', '/dbs', 'Znovu načte pomalu vaši postavu.', {})
	TriggerEvent('chat:addSuggestion', '/try', 'Náhodná reakce na /do  -> Ano / Ne.', {})
	TriggerEvent('chat:addSuggestion', '/me', 'Slouží k nahrazení vykonávané interakce.', {})
	TriggerEvent('chat:addSuggestion', '/do', 'Slouží k doplnění informací v RP.', {})
	TriggerEvent('chat:addSuggestion', '/doc', 'Slouží k doplnění informací k časování 1/10,2/10 atd.', {})
	TriggerEvent('chat:addSuggestion', '/stav', 'Do stavu můžeš napsat například zranění, či jiné.', {})
	TriggerEvent('chat:addSuggestion', '/stav_stat', 'Zapne nebo vypne tvůj stav.', {})
	TriggerEvent('chat:addSuggestion', '/rev', 'Oživí hráče nebo tebe.', {})
	TriggerEvent('chat:addSuggestion', '/twp', 'Teleportuješ svou postavu na označené místo na mapě.', {})
	TriggerEvent('chat:addSuggestion', '/twb', 'Teleportuješ se zpět na původní místo.', {})
	TriggerEvent('chat:addSuggestion', '/n', 'Zapne/Vypne No-Clip.', {})
	TriggerEvent('chat:addSuggestion', '/admin', 'Otevře administrační menu.', {})
	TriggerEvent('chat:addSuggestion', '/p_info', 'Vypíše do [F8] steam hex, ip, steam jméno.', {})
	TriggerEvent('chat:addSuggestion', '/klobouk', 'Sundá nebo nasadí tvou pokrývku hlavy.', {})
	TriggerEvent('chat:addSuggestion', '/bryle', 'Sundá nebo nasadí tvou brýle.', {})
	TriggerEvent('chat:addSuggestion', '/maska', 'Sundá nebo nasadí tvou masku.', {})
	TriggerEvent('chat:addSuggestion', '/satek', 'Sundá nebo nasadí tvůj šátek.', {})
	TriggerEvent('chat:addSuggestion', '/kravata', 'Sundá nebo nasadí tvou kravatu.', {})
	TriggerEvent('chat:addSuggestion', '/kosile', 'Sundá nebo nasadí tvou košili.', {})
	TriggerEvent('chat:addSuggestion', '/ksandy', 'Sundá nebo nasadí tvé kšandy.', {})
	TriggerEvent('chat:addSuggestion', '/vesta', 'Sundá nebo nasadí tvou vestu.', {})
	TriggerEvent('chat:addSuggestion', '/kabat', 'Sundá nebo nasadí tvůj kabat.', {})
	TriggerEvent('chat:addSuggestion', '/poncho', 'Sundá nebo nasadí tvé pončo.', {})
	TriggerEvent('chat:addSuggestion', '/plast', 'Sundá nebo nasadí tvůj plášť.', {})
	TriggerEvent('chat:addSuggestion', '/prsteny', 'Sundá nebo nasadí tvé rukavice.', {})
	TriggerEvent('chat:addSuggestion', '/naramek', 'Sundá nebo nasadí tvůj náramek.', {})
	TriggerEvent('chat:addSuggestion', '/opasek', 'Sundá nebo nasadí tvůj opasek.', {})
	TriggerEvent('chat:addSuggestion', '/prezka', 'Sundá nebo nasadí tvou přezku.', {})
	TriggerEvent('chat:addSuggestion', '/kalhoty', 'Sundá nebo nasadí tvé kalhoty.', {})
	TriggerEvent('chat:addSuggestion', '/sukne', 'Sundá nebo nasadí tvou sukni.', {})
	TriggerEvent('chat:addSuggestion', '/chaps', 'Sundá nebo nasadí tvé prsteny.', {})
	TriggerEvent('chat:addSuggestion', '/boty', 'Sundá nebo nasadí tvé chapsy.', {})
	TriggerEvent('chat:addSuggestion', '/ostruhy', 'Sundá nebo nasadí tvé boty.', {})
	TriggerEvent('chat:addSuggestion', '/kamase', 'Sundá nebo nasadí tvé kamaše.', {})
	TriggerEvent('chat:addSuggestion', '/natepniky', 'Sundá nebo nasadí tvé nátepníky.', {})
	TriggerEvent('chat:addSuggestion', '/pasy', 'Sundá nebo nasadí tvé muníční pásy.', {})
	TriggerEvent('chat:addSuggestion', '/doplnky', 'Sundá nebo nasadí tvé doplňky.', {})
	TriggerEvent('chat:addSuggestion', '/brasny', 'Sundá nebo nasadí tvou brašnu.', {})
	TriggerEvent('chat:addSuggestion', '/pdoplnek', 'Sundá nebo nasadí tvé příslušenství na opasek.', {})
	TriggerEvent('chat:addSuggestion', '/svleknout', 'Svlékneš se do naha', {})
	TriggerEvent('chat:addSuggestion', '/obleknout', 'Oblékneš si všechno oblečení.', {})
	TriggerEvent('chat:addSuggestion', '/kunpije', 'Kůň se napije z vody. [Musíš být dál od koně a level 3]', {})
	TriggerEvent('chat:addSuggestion', '/kunodpocivat', 'Kůň začne odpočívat. [Musíš být dál od koně a level 2]', {})
	TriggerEvent('chat:addSuggestion', '/kunspi', 'Kůň začne spát. [Musíš být dál od koně a level 2]', {})
	TriggerEvent('chat:addSuggestion', '/kunhratky', 'Kůň si začne hrát. [Musíš být dál od koně a mít level 4]', {})
	TriggerEvent('chat:addSuggestion', '/posta', 'Otevře administraci tvého poštovního holuba', {})
	TriggerEvent('chat:addSuggestion', '/bandana', 'Nasadí nebo sundá bandanu. (Musíš ji mít vybavenou)', {})
	TriggerEvent('chat:addSuggestion', '/rukavy', 'Vyhrne rukávy od košile nebo vrátí zpět.', {})
	TriggerEvent('chat:addSuggestion', '/dh', 'Vypne subtext na vagónech (Dobré vypnout v případě zda lezeš či slézáš z vagónu)', {})
end)

local check_char = false
local check_login = false


local table_for_now = {}
RegisterNetEvent("gum_adminmenu:send_table")
AddEventHandler("gum_adminmenu:send_table", function(table)
	table_for_now = table
end)

RegisterNetEvent("gum:SelectedCharacter")
AddEventHandler("gum:SelectedCharacter", function(charid)
	Citizen.CreateThread(function()
		while true do
			if check_char == false then
				Citizen.Wait(4000)
				TriggerServerEvent("Check_Item_Table")
			    check_char = true
			end
			Citizen.Wait(2000)
		end
	end)
end)



RegisterNetEvent("sendtoclient")
AddEventHandler("sendtoclient", function(table_lst)
	player_list = table_lst
end)

function Open_Admin_Menu()
	MenuData.CloseAll()
	local elements = {
		{label = ""..Config.Language[3].text.."", value = 'admin_list' , desc = ""..Config.Language[4].text..""},
		{label = ""..Config.Language[5].text.."", value = 'player_list' , desc = ""..Config.Language[6].text..""},
		{label = ""..Config.Language[7].text.."", value = 'item_list' , desc = ""},
	}
   MenuData.Open('default', GetCurrentResourceName(), 'gum_adminmenu',
	{
		title    = ''..Config.Language[8].text..'',
		subtext    = 'Hlavní nabídka',
		align    = 'top-left',
		elements = elements,
	},
	function(data, menu)
		if(data.current.value == 'player_list') then
			TriggerServerEvent("sendplayerslist")
			Citizen.Wait(1000)
			Open_Player_List()
		end
		if(data.current.value == 'admin_list') then
			Open_Admin_List()
		end
		if(data.current.value == 'item_list') then
			Open_Item_List()
		end
	end,
	function(data, menu)
		menu.close()
	end)
end


function Open_Item_List()
	MenuData.CloseAll()
	local elements = {}
	for k,v in pairs(table_for_now) do
		table.insert(elements,{label = "<b>"..v["label"].."</b>", value = ""..v["item"].."", desc = ""..Config.Language[9].text..""})
	end
   	MenuData.Open('default', GetCurrentResourceName(), 'gum_camping',
	{
		title    = ''..Config.Language[7].text..'',
		subtext    = '',
		align    = 'top-left',
		elements = elements,
	},
	function(data, menu)
		for k,v in pairs(table_for_now) do
			if(data.current.value == v["item"]) then
				TriggerServerEvent("GiveItemMenu", v["item"], 1)
			end
		end
	end,
	function(data, menu)
		menu.close()
	end)
end

function Open_Admin_List()
	MenuData.CloseAll()
	local elements = {
		{label = ""..Config.Language[10].text.."", value = 'no_clip' , desc = ""..Config.Language[13].text..""},
		{label = ""..Config.Language[11].text.."", value = 'go_to_wayp' , desc = ""..Config.Language[14].text..""},
		{label = ""..Config.Language[12].text.."", value = 'go_to_back' , desc = ""..Config.Language[15].text..""},
		{label = ""..Config.Language[1].text.."", value = 'talk_to_server' , desc = ""..Config.Language[16].text..""},
	}
   MenuData.Open('default', GetCurrentResourceName(), 'gum_adminmenu',
	{
		title    = ''..Config.Language[3].text..'',
		subtext    = '',
		align    = 'top-left',
		elements = elements,
	},
	function(data, menu)
		if(data.current.value == 'no_clip') then
			NoClip()
		end
		if(data.current.value == 'go_to_wayp') then
			TeleToWaypoint()
		end
		if(data.current.value == 'go_to_back') then
			Return()
		end
		if(data.current.value == 'talk_to_server') then
			Announce()
		end
	end,
	function(data, menu)
		menu.close()
		Open_Admin_Menu()
	end)
end

function Open_Player_List()
	MenuData.CloseAll()
	local elements = {}
	for k, v in ipairs(player_list) do 
		table.insert(elements,{label = "<b>[ "..v[1].." ]</b> "..v[2].."", value = ""..v[2]..""})
	end

   MenuData.Open('default', GetCurrentResourceName(), 'gum_adminmenu',
	{
		title    = ''..Config.Language[5].text..'',
		subtext    = '',
		align    = 'top-left',
		elements = elements,
	},
	function(data, menu)
		for k, v in ipairs(player_list) do 
			if(data.current.value == ''..v[2]..'') then
				TriggerServerEvent("CheckSteamHex", v[1])
				Citizen.Wait(200)
				Open_Player_Menu(v[1], v[2])
			end
		end
	end,
	function(data, menu)
		menu.close()
		Open_Admin_Menu()
	end)
end

function Open_Player_Menu(v, v2)
	MenuData.CloseAll()
	local elements = {
		{label = ""..Config.Language[17].text.."", value = 'kick_player' , desc = ""},
		{label = ""..Config.Language[18].text.."", value = 'ban_player' , desc = ""},
		{label = ""..Config.Language[19].text.."", value = 'freeze_player' , desc = ""},
		{label = ""..Config.Language[20].text.."", value = 'revive_player' , desc = ""},
		{label = ""..Config.Language[21].text.."", value = 'go_to_player' , desc = ""},
		{label = ""..Config.Language[22].text.."", value = 'bring_player' , desc = ""},
		{label = ""..Config.Language[23].text.."", value = 'spect_player' , desc = ""},
		{label = ""..Config.Language[24].text.."", value = 'kick_player' , desc = ""},
		{label = ""..Config.Language[25].text.."", value = 'give_item' , desc = ""},
		{label = ""..Config.Language[26].text.."", value = 'give_money' , desc = ""},
	}
   MenuData.Open('default', GetCurrentResourceName(), 'gum_adminmenu',
	{
		title    = '<b>[ '..v..' ]</b> '..v2..'',
		subtext    = ''..steamhex..'<br>'..steamip..'',
		align    = 'top-left',
		elements = elements,
	},
	function(data, menu)
		if(data.current.value == 'freeze_player') then
			if not freeze_player_on then
				freeze_player_on = true
				TriggerServerEvent("FreezePlayer", v, true)
			else
				freeze_player_on = false
				TriggerServerEvent("FreezePlayer", v, false)
			end
		end
		if(data.current.value == 'go_to_player') then
			Teleport(v)
		end
		if(data.current.value == 'revive_player') then
			TriggerServerEvent("RevivePlayer", v)
		end
		if(data.current.value == 'bring_player') then
			Bring(v)
		end
		if(data.current.value == 'spect_player') then
			if not spectating then
				Spectate(v)
			else
				CancelCamera()
			end
		end
		if(data.current.value == 'kick_player') then
			TriggerEvent("guminputs:getInput", ""..Config.Language[27].text.."", ""..Config.Language[28].text.." :", function(cb)
				local kick_reason = tostring(cb)
				if kick_reason ~= nil and kick_reason ~= 'close' then
					TriggerServerEvent("KickPlayer", v, kick_reason)
				end
			end)
		end
		if(data.current.value == 'ban_player') then
			TriggerEvent("guminputs:getInput", ""..Config.Language[27].text.."", ""..Config.Language[29].text.."", function(cb)
				local ban_reason = tostring(cb)
				if ban_reason ~= nil and ban_reason ~= 'close' then
					Citizen.Wait(1000)
					TriggerEvent("guminputs:getInput", ""..Config.Language[27].text.."", ""..Config.Language[1300].text.."", function(cb)
						local date_ban = tostring(cb)
						if date_ban ~= nil and date_ban ~= 'close' then
							TriggerServerEvent("BanPlayer", v, ban_reason, date_ban)
						end
					end)
				end
				return  false
			end)
		end
		if(data.current.value == 'give_item') then
			TriggerEvent("guminputs:getInput", ""..Config.Language[27].text.."", ""..Config.Language[31].text.."", function(cb)
				local name_item = tostring(cb)
				if name_item ~= nil and name_item ~= 'close' then
					Citizen.Wait(500)
					TriggerEvent("guminputs:getInput", ""..Config.Language[27].text.."", ""..Config.Language[32].text.."", function(cb)
						local count_item = tonumber(cb)
						if count_item ~= nil and count_item ~= 0 and count_item >= 0 and count_item ~= 'close' then
							TriggerServerEvent("GiveItem", v, name_item, count_item)
						end
					end)
					return true
				else
					return false
				end
			end)
		end
		if(data.current.value == 'give_money') then
			TriggerEvent("guminputs:getInput", ""..Config.Language[27].text.."", ""..Config.Language[33].text.."", function(cb)
				local count_money = tonumber(cb)
				if count_money ~= nil and count_money ~= 0 and count_money >= 0 and count_money ~= 'close' then
					TriggerServerEvent("GiveMoney", v, tonumber(string.format("%.2f", count_money)))
				end
				return true
			end)
		end
	end,
	function(data, menu)
		menu.close()
		Open_Player_List()
	end)
end

-----------------------
function GetPlayers()
	local players = {}
	for i = 0, 256 do
		if NetworkIsPlayerActive(i) then
			table.insert(players, i)
		end
	end
	return players
end

RegisterNetEvent("tpback")
AddEventHandler("tpback", function()
	SetEntityCoords(PlayerPedId(), lastlocation)
end)

function Return()
	SetEntityCoords(PlayerPedId(), lastlocation)
end
function Announce()
	TriggerEvent("guminputs:getInput", ""..Config.Language[27].text.."", ""..Config.Language[34].text.."", function(input)
		local message = tostring(input)
		if message ~= 'close' then
			TriggerServerEvent("Announce", message)
		end
		return true
	end)
end
RegisterNetEvent("tpwayp")
AddEventHandler("tpwayp", function()
	TeleToWaypoint()
end)
function TeleToWaypoint()
	local ply = PlayerPedId()
	local pCoords = GetEntityCoords(ply)
	lastlocation = pCoords
	local WP = GetWaypointCoords()
	if (WP.x == 0 and WP.y == 0) then
	else
		local height = 1
		for height = 1, 1000 do
			SetEntityCoords(ply, WP.x, WP.y, height + 0.0)
			local foundground, groundZ, normal = GetGroundZAndNormalFor_3dCoord(WP.x, WP.y, height + 0.0)
			if foundground then
				SetEntityCoords(ply, WP.x, WP.y, height + 0.0)
				break
			end
			Wait(25)
		end
	end
end
local cam = nil
local isDead = false
local angleY = 0.0
local angleZ = 0.0


RegisterNetEvent("Spectate_OneSync")
AddEventHandler("Spectate_OneSync", function(coords)
	SetEntityVisible(PlayerPedId(), false)
	FreezeEntityPosition(PlayerPedId(), true)
	print(coords.x, coords.y, coords.z-2.0)
	SetEntityCoords(PlayerPedId(), coords.x, coords.y, coords.z-2.0)
end)
function Spectate(v)
	lastlocation = GetEntityCoords(PlayerPedId())
	if Config.OneSync then
		TriggerServerEvent("Spectate_OneSync", v)
		Citizen.Wait(2000)
	end
	for i,l in pairs(GetPlayers()) do
		if tonumber(GetPlayerServerId(l)) == tonumber(v) then
			v = l
		end
	end
	StartDeathCam(v)
	spectating = true
	Citizen.CreateThread(function()
		while spectating do
			ProcessCamControls(v)
			Citizen.Wait(10)
		end
	end)
end

function StartDeathCam(v)
    Citizen.CreateThread(function()
        ClearFocus()
        local playerPed = GetPlayerPed(v)
        cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", GetEntityCoords(playerPed), 0, 0, 0, GetGameplayCamFov())
        SetCamActive(cam, true)
        RenderScriptCams(true, true, 1000, true, false)
    end)
end

function EndDeathCam()
    Citizen.CreateThread(function()
        ClearFocus()
        RenderScriptCams(false, false, 0, true, false)
        DestroyCam(cam, false)
        cam = nil
    end)
end

function ProcessCamControls(v)
    Citizen.CreateThread(function()
		local coords = GetEntityCoords(GetPlayerPed(v))
		SetEntityCoords(PlayerPedId(), coords.x, coords.y, coords.z-10)
		FreezeEntityPosition(PlayerPedId(), true)
		SetEntityVisible(PlayerPedId(), false)
        local playerCoords = GetEntityCoords(GetPlayerPed(v))
        DisableFirstPersonCamThisFrame()
        local newPos = ProcessNewPosition(v)
        SetCamCoord(cam, newPos.x, newPos.y, newPos.z)
        PointCamAtCoord(cam, playerCoords.x, playerCoords.y, playerCoords.z + 0.5)
    end)
end

function ProcessNewPosition(v)
    local mouseX = 0.0
    local mouseY = 0.0
    if (IsInputDisabled(0)) then
        mouseX = GetDisabledControlNormal(1, 0x4D8FB4C1) * 3.0
        mouseY = GetDisabledControlNormal(1, 0xFDA83190) * 3.0
    else
        mouseX = GetDisabledControlNormal(1, 0x4D8FB4C1) * 1.5
        mouseY = GetDisabledControlNormal(1, 0xFDA83190) * 1.5
    end
    angleZ = angleZ - mouseX
    angleY = angleY + mouseY

    if (angleY > 89.0) then angleY = 89.0 elseif (angleY < -89.0) then angleY = -89.0 end
    local pCoords = GetEntityCoords(GetPlayerPed(v))
    local behindCam = {
        x = pCoords.x + ((Cos(angleZ) * Cos(angleY)) + (Cos(angleY) * Cos(angleZ))) / 2 * (3.0 + 0.5),
        y = pCoords.y + ((Sin(angleZ) * Cos(angleY)) + (Cos(angleY) * Sin(angleZ))) / 2 * (3.0 + 0.5),
        z = pCoords.z + ((Sin(angleY))) * (3.0 + 0.5)
    }
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

function CancelCamera()
	print(lastlocation.x,lastlocation.y,lastlocation.z)
    RenderScriptCams(true, false, 1, true, true)
    DestroyCam(camera, true)
    DestroyAllCams()
	spectating = false
	Citizen.Wait(100)
	SetEntityCoords(PlayerPedId(), lastlocation.x, lastlocation.y, lastlocation.z)
	SetEntityVisible(PlayerPedId(), true)
	SetEntityInvincible(PlayerPedId(), false)
	FreezeEntityPosition(PlayerPedId(), false)
end

RegisterNetEvent("Bring")
AddEventHandler("Bring", function(x, y, z)
	SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
end)

RegisterNetEvent("Freezeplayer")
AddEventHandler("Freezeplayer", function(state)
	FreezeEntityPosition(PlayerPedId(), state)
end)

function Bring(v)
	local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
	TriggerServerEvent("Bring", v, x, y, z)
end

function Teleport(v)
	lastlocation = GetEntityCoords(PlayerPedId())
	if Config.OneSync == true then
		TriggerServerEvent("Teleport", v)
	else
		for i,l in pairs(GetPlayers()) do
			if tonumber(GetPlayerServerId(l)) == tonumber(v) then
				local coords = GetEntityCoords(GetPlayerPed(l))
				SetEntityCoords(PlayerPedId(), coords.x, coords.y, coords.z)
			end
		end
	end
end
RegisterNetEvent("Teleport")
AddEventHandler("Teleport", function(x, y, z)
	SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
end)

RegisterNetEvent("atomic:noclip")
AddEventHandler("atomic:noclip", function()
	NoClip()
end)
function NoClip()
	local ped = PlayerPedId()
	if not noclip then
		noclip = true
		SetEntityVisible(ped, false)
		SetPlayerInvincible(ped, true)
		FreezeEntityPosition(ped, true)
		TriggerServerEvent("Log", systemlogs, "No Clip", GetPlayerName(PlayerId()).." turned No Clip on.", 65535)
	else
		noclip = false
		SetEntityVisible(ped, true)
		SetPlayerInvincible(ped, false)
		FreezeEntityPosition(ped, false)
		TriggerServerEvent("Log", systemlogs, "No Clip", GetPlayerName(PlayerId()).." turned No Clip off.", 65535)
	end
end
function GetNoClipTarget()
	local ped = PlayerPedId()
	local veh = GetVehiclePedIsIn(ped, false)
	local mnt = GetMount(ped)
	return (veh == 0 and (mnt == 0 and ped or mnt) or veh)
end
function TranslateHeading(entity, h)
	if GetEntityType(entity) == 1 then
		return (h + 180) % 360
	else
		return h
	end
end

RegisterNetEvent('gum_adminmenu:ShowTopNotification')
AddEventHandler('gum_adminmenu:ShowTopNotification', function(tittle, subtitle, duration)
    exports.gum_adminmenu:ShowTopNotification(tostring(tittle), tostring(subtitle), tonumber(duration))
end)

function DrawText(text, x, y, centred)
	SetTextScale(0.35, 0.35)
	SetTextColor(255, 255, 255, 255)
	SetTextCentre(centred)
	SetTextDropshadow(1, 0, 0, 0, 200)
	SetTextFontForCurrentCommand(0)
	DisplayText(CreateVarString(10, "LITERAL_STRING", text), x, y)
end
function ToggleRelativeMode()
	RelativeMode = not RelativeMode
	SetResourceKvp('relativeMode', tostring(RelativeMode))
end

function ToggleFollowCam()
	FollowCam = not FollowCam
	SetResourceKvp('followCam', tostring(FollowCam))
end

function SetSpeed(value)
	Speed = value
	SetResourceKvp('speed', tostring(Speed))
end


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

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
	Citizen.InvokeNative(0xADA9255D, 1);
    DisplayText(str, x, y)
end

function LoadSettings()
	local relativeMode = GetResourceKvpString('relativeMode')
	if relativeMode ~= nil then
		RelativeMode = relativeMode == 'true'
	end

	local followCam = GetResourceKvpString('followCam')
	if followCam ~= nil then
		FollowCam = followCam == 'true'
	end

	local speed = GetResourceKvpString('speed')
	if speed ~= nil then
		Speed = tonumber(speed)
	end
end
	
-----------------------
RegisterNetEvent("gum:SelectedCharacter")
AddEventHandler("gum:SelectedCharacter", function(charid)
	Citizen.CreateThread(function()
		LoadSettings()
		while true do
			Citizen.Wait(5)
			if spectating then 
				if IsControlJustPressed(0, 0x156F7119) then -- Backspace
					CancelCamera()
				end
			end

			if noclip then
				SetEntityVisible(PlayerPedId(), false)
				-- Disable all controls except a few while in noclip mode
				DisableAllControlActions(0)
				EnableControlAction(0, 0x4A903C11) -- FrontendPauseAlternate
				EnableControlAction(0, 0x9720fcee) -- MpTextChatAll
				EnableControlAction(0, 0xA987235F) -- LookLr
				EnableControlAction(0, 0xD2047988) -- LookUd
				EnableControlAction(0, 0x3D99EEC6) -- HorseGunLr
				EnableControlAction(0, 0xBFF476F9) -- HorseGunUd
				EnableControlAction(0, 0xCF8A4ECA) -- RevealHud
				EnableControlAction(0, 0x4AF4D473) -- Del

				DisableFirstPersonCamThisFrame()

				-- Get the entity we want to control in noclip mode
				local entity = GetNoClipTarget()

				FreezeEntityPosition(entity, true)

				-- Get the position and heading of the entity
				local x, y, z = table.unpack(GetEntityCoords(entity))
				local h = TranslateHeading(entity, GetEntityHeading(entity))

				-- Cap the speed between MinSpeed and MaxSpeed
				if Speed > Config.MaxSpeed then
					SetSpeed(Config.MaxSpeed)
				end
				if Speed < Config.MinSpeed then
					SetSpeed(Config.MinSpeed)
				end

				-- Print the current noclip speed on screen
				DrawText(string.format('NoClip Rychlost : %.1f', Speed), 0.5, 0.90, true)

				-- Change noclip control mode
				if CheckControls(IsDisabledControlJustPressed, 0, Config.ToggleModeControl) then
					ToggleRelativeMode()
				end

				-- Increase/decrease speed
				if CheckControls(IsDisabledControlPressed, 0, Config.IncreaseSpeedControl) then
					SetSpeed(Speed + Config.SpeedIncrement)
				end
				if CheckControls(IsDisabledControlPressed, 0, Config.DecreaseSpeedControl) then
					SetSpeed(Speed - Config.SpeedIncrement)
				end
				if CheckControls(IsDisabledControlPressed, 0, 0x27D1C284) then
					if not visible then
						visible = true
						local ped = PlayerPedId()
						SetEntityVisible(ped, true)
					else
						visible = false
						local ped = PlayerPedId()
						SetEntityVisible(ped, false)
					end
				end

				-- Move up/down
				if CheckControls(IsDisabledControlPressed, 0, Config.UpControl) then
					z = z + Speed
				end
				if CheckControls(IsDisabledControlPressed, 0, Config.DownControl) then
					z = z - Speed
				end

				if RelativeMode then
					-- Print the coordinates, heading and controls on screen
					DrawText(string.format(''..Config.Language[37].text..':\nX: %.2f\nY: %.2f\nZ: %.2f\nHeading: %.0f', x, y, z, h), 0.01, 0.3, false)

					if FollowCam then
						DrawText(''..Config.Language[36].text..'', 0.5, 0.95, true)
					else
						DrawText(''..Config.Language[35].text..'', 0.5, 0.95, true)
					end

					-- Calculate the change in x and y based on the speed and heading.
					local r = -h * math.pi / 180
					local dx = Speed * math.sin(r)
					local dy = Speed * math.cos(r)

					-- Move forward/backward
					if CheckControls(IsDisabledControlPressed, 0, Config.ForwardControl) then
						x = x + dx
						y = y + dy
					end
					if CheckControls(IsDisabledControlPressed, 0, Config.BackwardControl) then
						x = x - dx
						y = y - dy
					end

					if CheckControls(IsDisabledControlJustPressed, 0, Config.FollowCamControl) then
						ToggleFollowCam()
					end

					-- Rotate heading
					if FollowCam then
						local rot = GetGameplayCamRot(2)
						h = rot.z
					else
						if IsDisabledControlPressed(0, Config.LeftControl) then
							h = h + 1
						end
						if IsDisabledControlPressed(0, Config.RightControl) then
							h = h - 1
						end
					end
				else
					-- Print the coordinates and controls on screen
					DrawText(string.format(''..Config.Language[37].text..':\nX: %.2f\nY: %.2f\nZ: %.2f', x, y, z), 0.01, 0.3, false)
					DrawText(''..Config.Language[38].text..'', 0.5, 0.95, true)

					h = 0.0

					-- Move North
					if CheckControls(IsDisabledControlPressed, 0, Config.ForwardControl) then
						y = y + Speed
					end

					-- Move South
					if CheckControls(IsDisabledControlPressed, 0, Config.BackwardControl) then
						y = y - Speed
					end

					-- Move East
					if CheckControls(IsDisabledControlPressed, 0, Config.LeftControl) then
						x = x - Speed
					end

					-- Move West
					if CheckControls(IsDisabledControlPressed, 0, Config.RightControl) then
						x = x + Speed
					end
				end

				SetEntityCoordsNoOffset(entity, x, y, z)
				SetEntityHeading(entity, TranslateHeading(entity, h))
			end
		end
	end)
end)

  