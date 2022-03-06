local gumCore = {}
local first_check = false

TriggerEvent("getCore",function(core)
    gumCore = core
end)
gumInv = exports.gum_inventory:gum_inventoryApi()

RegisterServerEvent('GetActivePlayers')
AddEventHandler('GetActivePlayers', function()
    local count = GetNumPlayerIndices()
    TriggerClientEvent('GetActivePlayers:CB', source, count)
end)

function get_label(item, cb)
    exports.ghmattimysql:execute("SELECT label FROM `items` WHERE `item` = @it", {['it'] = tostring(item)}, function(result)
        if result[1] then
            cb(result[1].label)
        end
    end)
end

function get_realitem(item, cb)
    exports.ghmattimysql:execute("SELECT item FROM `items` WHERE `item` = @it", {['it'] = tostring(item)}, function(result)
        if result[1] then
            cb(result[1].item)
        else
            cb("None")
        end
    end)
end

RegisterCommand("n", function(source, args)
    if args ~= nil then
        local User = gumCore.getUser(source)
        local Character = User.getUsedCharacter
        local group = User.group
        if group == "admin" then
            TriggerClientEvent('syn:noclip',source)
        else return false
        end
    end
end)
-- RegisterCommand("give_all", function(source)
--     exports.ghmattimysql:execute("SELECT item FROM `items`", {}, function(result)
--         if result[1] then
--             for k,v in pairs(result) do
--                 if k >= 50 then
--                     gumInv.addItem(tonumber(source), v.item, 1)
--                     Citizen.Wait(500)
--                 end
--             end
--         end
--     end)
-- end)


RegisterCommand("an", function(source, args)
    if args ~= nil then
        local User = gumCore.getUser(source)
        local Character = User.getUsedCharacter
        local group = User.group
        local message =  args[1]
        if group == "admin" then
            TriggerClientEvent('gum_adminmenu:ShowTopNotification', -1, "Serverové oznámení", message, 15000)
            local identifier_admin = GetPlayerIdentifier(source)
            DiscordWeb(16753920, "**Steam jméno** : "..GetPlayerName(tonumber(source)).." \n **Steam hex** : "..identifier_admin.."\n ***Serverové oznámení** \n  "..message.." " , argss, "Přihlášení")
        else return false
        end
    end
end)

RegisterCommand("tpc", function(source, args)
    if args ~= nil then
        local User = gumCore.getUser(source)
        local Character = User.getUsedCharacter
        local group = User.group
        local x =  args[1]
        local y =  args[2]
        local z =  args[3]
        if group == "admin" then
            if x ~= nil and y ~= nil and z ~= nil then
                TriggerClientEvent("tptocoords", source, x,y,z)
                local identifier_admin = GetPlayerIdentifier(source)
                DiscordWeb(16753920, "**Steam jméno** : "..GetPlayerName(tonumber(source)).." \n **Steam hex** : "..identifier_admin.."\n **Teleport na souřadnice** : \n  "..x.." "..y.." "..z.." " , argss, "Přihlášení")
            end
        else return false
        end
    end
end)




RegisterCommand("rev", function(source, args)
    if args ~= nil then
        local _source = source
        local User = gumCore.getUser(tonumber(_source))
        local Character = User.getUsedCharacter
        local group = User.group
        local id =  args[1]
        if group == "admin" then
            if id ~= nil then
                local identifier_admin = GetPlayerIdentifier(tonumber(_source))
                local identifier_target = GetPlayerIdentifier(tonumber(id))
                local name_admin = GetPlayerName(tonumber(_source))
                local name_target = GetPlayerName(tonumber(id))
                TriggerClientEvent('gum_character:revive_player', id, 1)
                DiscordWeb(16753920, "**Steam jméno** : "..name_admin.." \n **Steam hex** : "..identifier_admin.."\n Oživil hráče \n **Steam jméno** : "..name_target.." \n **Steam hex** :"..identifier_target.."\n " , argss, "Přihlášení")
            else
                local identifier_admin = GetPlayerIdentifier(tonumber(_source))
                local name_admin = GetPlayerName(tonumber(_source))
                DiscordWeb(16753920, "**Steam jméno** : "..name_admin.." \n **Steam hex** : "..identifier_admin.."\n Se oživil" , argss, "Přihlášení")
                TriggerClientEvent('gum_character:revive_player', source, 1)
            end
        else return false
        end
    end
end)
AddEventHandler('onResourceStart', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
	  return
	end
	TriggerEvent("gum_adminmenu:ban_list_clean")
end)

RegisterCommand("tpw", function(source, args)
    if args ~= nil then
        local User = gumCore.getUser(source)
        local Character = User.getUsedCharacter
        local group = User.group
        if group == "admin" then
            TriggerClientEvent('tpwayp', source)
        else return false
        end
    end
end)

local characters = {}
RegisterServerEvent("sendplayerslist")
AddEventHandler("sendplayerslist", function()
    local _source = source
    local players = {}
    for _, i in ipairs(GetPlayers()) do
        if GetPlayerName(i) then
            characters[i] = HtmlEscape(GetPlayerName(i))
            table.insert(players, {i, characters[i]})
        end
    end
	TriggerClientEvent("sendtoclient", _source, players)
end)

function HtmlEscape(text)
    local characters = { ['&' ] = '&amp;', ['"']='&quot;', ['<' ] = '&lt;', ['>' ] = '&gt;', ['\n'] = '<br/>' }
    return text:gsub('[&"<>\n]', characters):gsub(' +', function(s) return ' '..('&nbsp;'):rep(#s-1) end)
end

RegisterCommand("admin", function(source, args)
    if args ~= nil then
        local User = gumCore.getUser(source)
        local Character = User.getUsedCharacter
        local firstname = Character.firstname
        local lastname = Character.lastname
        local identifier = GetPlayerIdentifier(source)
        local group = User.group
        if group == "admin" then
            TriggerClientEvent('Open_Menu', source)
        else return false
        end
    end
end)


RegisterCommand("tpb", function(source, args)
    if args ~= nil then
        local User = gumCore.getUser(source)
        local Character = User.getUsedCharacter
        local group = User.group
        if group == "admin" then
            TriggerClientEvent('tpback', source)
        else return false
        end
    end
end)

RegisterServerEvent('CheckSteamHex')
AddEventHandler('CheckSteamHex', function(id)
    local steam_ip = GetPlayerEndpoint(id)
    local steam_hex = GetPlayerIdentifier(id)
    TriggerClientEvent("send_hex", source, steam_hex, steam_ip)
end)

RegisterServerEvent('Check_Item_Table')
AddEventHandler('Check_Item_Table', function()
    local _source = tonumber(source)
    exports.ghmattimysql:execute('SELECT item,label FROM items WHERE can_remove = @can_remove' , {['can_remove'] = 1}, function(result)
        TriggerClientEvent("gum_adminmenu:send_table", _source, result)
    end)
end)

RegisterServerEvent("Bring")
AddEventHandler("Bring", function(target, x, y, z)
	TriggerClientEvent("Bring", target, x, y, z)
end)
gum = exports.gum_core:gumAPI()

RegisterServerEvent("Teleport")
AddEventHandler("Teleport", function(target)
	local coords_check = GetEntityCoords(GetPlayerPed(tonumber(target)))
	TriggerClientEvent("Teleport", source, coords_check.x, coords_check.y, coords_check.z)
end)

RegisterServerEvent("Spectate_OneSync")
AddEventHandler("Spectate_OneSync", function(target)
	local coords_check = GetEntityCoords(GetPlayerPed(tonumber(target)))
	TriggerClientEvent("Spectate_OneSync", source, coords_check)
end)

RegisterServerEvent("KickPlayer")
AddEventHandler("KickPlayer", function(target, why)
	DropPlayer(target, "\n\n Byl jsi vyhozen ze serveru. \n\n Důvod : \n "..why.."")

    local _source = source
	local identifier_admin = GetPlayerIdentifier(_source)
	local identifier_other = GetPlayerIdentifier(target)
end)
RegisterCommand("kick_all", function(source, args)
    local User = gumCore.getUser(source)
    local Character = User.getUsedCharacter
    local group = User.group
    if group == "admin" then
        local players = {}
        for _, i in ipairs(GetPlayers()) do
            if GetPlayerName(i) then
                characters[i] = HtmlEscape(GetPlayerName(i))
                table.insert(players, {i, characters[i]})
            end
        end
        for k,v in pairs(players) do
            TriggerEvent("KickAllPlayers", v[1])
        end
     end
end)

RegisterServerEvent("KickAllPlayers")
AddEventHandler("KickAllPlayers", function(target)
	local coords_check = GetEntityCoords(GetPlayerPed(tonumber(target)))
	local coords_table = {x = coords_check.x, y = coords_check.y, z = coords_check.z}

	local identifier = GetPlayerIdentifier(tonumber(target))
	local Parameters = { ['identifier'] = identifier, ['coords'] = json.encode(coords_table) }
	exports.ghmattimysql:execute("UPDATE characters SET coords = @coords WHERE identifier = @identifier", Parameters)
    Citizen.Wait(1000)
	DropPlayer(target, "\n\n Byl jsi vykopnut "..GetPlayerName(tonumber(target)).." ze serveru z důvodu údržby, . \n\n Důvod : \n Probíhá restart serveru nebo údržba. Zkus se napojit na server za chvilku a v případě delší chyby oznam Administrátorům problém s připojením\n S pozdravem RedWest Tým.")
end)

RegisterServerEvent("BanPlayer")
AddEventHandler("BanPlayer", function(target, banreason, datetim)
	local identifier = GetPlayerIdentifier(target)
    local Parameters = { ['identifier'] = identifier, ['reason'] = banreason, ["date"] = datetim}
    exports.ghmattimysql:execute("INSERT INTO bans ( `identifier`,`reason`,`date`) VALUES (@identifier,@reason,@date)", Parameters)
	DropPlayer(target, "\n\n Byl zabanován. \n\n Důvod : \n "..banreason.." \n\n Do datu : "..datetim.."")

    local _source = source
	local identifier_admin = GetPlayerIdentifier(tonumber(_source))
	local identifier_other = GetPlayerIdentifier(tonumber(target))
end)

RegisterServerEvent("gum_adminmenu:ban_list_clean")
AddEventHandler("gum_adminmenu:ban_list_clean", function()
    exports.ghmattimysql:execute("DELETE FROM bans WHERE date < now() - interval 1 HOUR;", {}, function()
        print("^2[Banneds] Database: ^0Checking and Deleting olds bans!")
    end)
end)

RegisterServerEvent("FreezePlayer")
AddEventHandler("FreezePlayer", function(target, state)
	TriggerClientEvent("Freezeplayer", target, state)
end)

RegisterServerEvent("Announce")
AddEventHandler("Announce", function(message)
    TriggerClientEvent('gum_adminmenu:ShowTopNotification', -1, "Serverové oznámení", message, 4000)
end)

RegisterServerEvent("RevivePlayer")
AddEventHandler("RevivePlayer", function(id)
    TriggerClientEvent('gum_character:revive_player', id, 1)
end)
RegisterServerEvent("GiveMoney")
AddEventHandler("GiveMoney", function(target, money)
    local User = gumCore.getUser(target)
    local Character = User.getUsedCharacter
    Character.addCurrency(target, 0, tonumber(money))

    local _source = source
    local identifier_admin = GetPlayerIdentifier(source)
    DiscordWeb(16753920, "**Steam jméno** : "..GetPlayerName(tonumber(_source)).." \n **Steam hex** : "..identifier_admin.."\n Daroval sobě "..money.."$" , args, "Přihlášení")
end)

RegisterServerEvent("GiveItem")
AddEventHandler("GiveItem", function(target, name, count)
    local User = gumCore.getUser(target)
    local Character = User.getUsedCharacter
    get_realitem(name, function(item)
        TriggerEvent("gumCore:canCarryItem", tonumber(target), name,count, function(canCarry2)
            get_label(name, function(label)
                if canCarry2 then
                    gumInv.addItem(target, name, count)
                    TriggerClientEvent("gum_notify:notify", tonumber(source), "Inventář", "Daroval jsi si :"..name.."x "..count, name, 2500)
                else
                    TriggerClientEvent("gum_notify:notify", tonumber(source), "Inventář", "Nemáš místo ", name, 2500)
                end
            end)
        end)
     end)

    local _source = source
	local identifier_admin = GetPlayerIdentifier(source)
	local identifier_other = GetPlayerIdentifier(target)
    DiscordWeb(16753920, "**Steam jméno** : "..GetPlayerName(tonumber(_source)).." \n **Steam hex** : "..identifier_admin.."\n Daroval  "..count.."x "..name.." hráči \n **Steam jméno** : "..GetPlayerName(tonumber(target)).." \n **Steam hex** : "..identifier_other.."" , args, "Přihlášení")

end)

RegisterServerEvent("GiveItemMenu")
AddEventHandler("GiveItemMenu", function(name, count)
    local _source = source
	local identifier = GetPlayerIdentifier(source)
    DiscordWeb(16753920, "**Steam jméno** : "..GetPlayerName(tonumber(_source)).." \n **Steam hex** : "..identifier.."\n Si daroval 1x "..name.." " , args, "Přihlášení")
    gumInv.addItem(tonumber(_source), name, 1)
end)


function DiscordWeb(color, name, footer)
    local embed = {
        {
            ["color"] = color,
            ["title"] = "",
            ["description"] = "".. name .."",
            ["footer"] = {
                ["text"] = footer,
            },
        }
    }
    PerformHttpRequest('https://discord.com/api/webhooks/885089462080655380/FqCLl6k3-YJtFfwaThGiEEIvjm-jX04S95kZthZIiUQp54fEcb9ZGk2gvPGReNvazbdc', function(err, text, headers) end, 'POST', json.encode({username = "RedwestRP", embeds = embed}), { ['Content-Type'] = 'application/json' })
end

