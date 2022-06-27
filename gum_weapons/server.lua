


TriggerEvent("getCore",function(core)
    gumCore = core
end)

gumInv = exports.gum_inventory:gum_inventoryApi()

RegisterServerEvent("gum_weapons:save_comps")
AddEventHandler("gum_weapons:save_comps", function(table_comps, weapon_id, price)
    local _source = source
    local User = gumCore.getUser(_source)
    local Character = User.getUsedCharacter
    local identifier = Character.identifier
    local charidentifier = Character.charIdentifier
    local check_money = Character.money
    if price <= check_money then
        exports.ghmattimysql:execute('SELECT name,id,ammo FROM loadout WHERE identifier=@identifier AND charidentifier = @charidentifier AND used = @used ' , {['identifier'] = identifier, ['charidentifier'] = charidentifier, ['used'] = 1}, function(result)
            if result ~= nil then
                for k,v in pairs(result) do
                    if GetHashKey(v.name) == weapon_id then
                        local Parameters = { ['id'] = v.id, ['comps'] = json.encode(table_comps) } 
                        exports.ghmattimysql:execute("UPDATE loadout SET comps=@comps WHERE id=@id", Parameters)
                        TriggerClientEvent("gum_weapons:load_components", tonumber(_source), table_comps)
                        Character.removeCurrency(tonumber(_source), 0, price)
                        TriggerClientEvent("gum_notify:notify", _source, Config.Language[1].text, ""..Config.Language[3].text..""..price.."$", 'rifle', 2000)
                    end
                end
            end
        end)
    else
        TriggerClientEvent("gum_notify:notify", _source, Config.Language[1].text, Config.Language[2].text, 'rifle', 2000)
    end
end)

RegisterServerEvent("gum_weapons:check_comps")
AddEventHandler("gum_weapons:check_comps", function(weapon_id)
    local _source = source
    local User = gumCore.getUser(_source)
    local Character = User.getUsedCharacter
    local Identifier = Character.identifier
    local CharIdentifier = Character.charIdentifier

    exports.ghmattimysql:execute('SELECT name,id,comps FROM loadout WHERE identifier=@identifier AND charidentifier = @charidentifier AND used = @used ' , {['identifier'] = Identifier, ['charidentifier'] = CharIdentifier, ['used'] = 1}, function(result)
        if result ~= nil then
             for k,v in pairs(result) do
                 if GetHashKey(v.name) == weapon_id then
                    local send_table = json.decode(v.comps)
                    TriggerClientEvent("gum_weapons:wep_components", tonumber(_source), send_table)
                 end
             end
         end
     end)
end)

Citizen.CreateThread(function()
    for k,v in pairs(Config.ammo) do 
        for l,m in pairs(v) do 
            local guncheck2 = 0
            local playeritem = 0
            if m.guncheck2 ~= nil then
                guncheck2 = m.guncheck2
            end
            if m.playeritem ~= nil then 
                playeritem = m.playeritem
            end
            gumInv.RegisterUsableItem(m.item, function(data)
    	    gumInv.subItem(data.source, m.item, 1)
    	    TriggerClientEvent('gum_weapons:getgun', data.source,m.key,m.guncheck,m.qt,m.item,guncheck2,playeritem)
            end) 
        end
    end
end)

RegisterServerEvent("gum_weapons:addammo")
AddEventHandler("gum_weapons:addammo", function(wephash,qt,key,playeritem,item)
    local _source = source
    local User = gumCore.getUser(source)
    local Character = User.getUsedCharacter
    local identifier = Character.identifier
    local charidentifier = Character.charIdentifier
    local used = 1
    local weapid
    local max
    exports.ghmattimysql:execute('SELECT name,id,ammo FROM loadout WHERE identifier=@identifier AND charidentifier = @charidentifier ' , {['identifier'] = identifier, ['charidentifier'] = charidentifier}, function(result)
        if result[1] ~= nil then 
            for i=1, #result, 1 do
                if playeritem == 0 then
                    if GetHashKey(result[i].name) == wephash then
                        weapid = result[i].id
                    end
                elseif  playeritem ~= 0 then
                    for k,v in pairs(playeritem) do 
                        if v == result[i].name then
                            weapid = result[i].id
                        end
                    end
                end
            end
            for k,v in pairs(Config.ammo) do
                for l,m in pairs(v) do
                    if m.key == key then 
                        max = m.maxammo
                    end
                end
            end
            if weapid ~= nil then
                exports.ghmattimysql:execute('SELECT ammo FROM loadout WHERE id = @id ' , {['id'] = weapid}, function(result)
                    if result[1] ~= nil then 
                        local ammo = json.decode(result[1].ammo)
                        if contains(ammo, key) then
                            if (ammo[key] + qt) > max then
                                qt = max - ammo[key]
                                ammo[key] = max 
                            else
                                ammo[key] = ammo[key] + qt
                            end
                        else
                            ammo[key] = tonumber(qt)
                        end
                        if qt > 0 then
                            exports.ghmattimysql:execute("UPDATE loadout Set ammo=@ammo WHERE id=@id", { ['id'] = weapid, ['ammo'] = json.encode(ammo) })
                            for k,v in pairs(ammo) do
                                print(weapid, k,v)
                            end
                        else
                            TriggerClientEvent("gum_weapons:givebackbox",_source,item)
                        end
                    end
                end)
            else
                TriggerClientEvent("gum_weapons:givebackbox",_source,item)
            end
        end
    end)
end)

RegisterServerEvent("gum_weapons:givebackbox")
AddEventHandler("gum_weapons:givebackbox", function(item)
    local _source = source
    gumInv.addItem(_source, item, 1)
end)

RegisterServerEvent("gum_weapons:buy_weapon")
AddEventHandler("gum_weapons:buy_weapon", function(itemtobuy,itemprice,itemlabel)
    local _source = source
    local User = gumCore.getUser(tonumber(_source)) -- Return User with functions and all characters
    local Character = gumCore.getUser(tonumber(_source)).getUsedCharacter
    local playername = Character.firstname .. ' ' .. Character.lastname
    local money = Character.money
    local identifier = Character.identifier
    local total = money - itemprice
    TriggerEvent("gumCore:canCarryWeapons", tonumber(_source), 1, function(canCarry)
        if canCarry then
            if total >= 0 then
                Character.removeCurrency(tonumber(_source),0, itemprice)
                local ammo = {["nothing"] = 0}
                local components =  {}
                gumInv.createWeapon(tonumber(_source), itemtobuy, ammo, components)
                TriggerClientEvent("gum_notify:notify", _source, Config.Language[1].text, ""..Config.Language[4].text.." "..itemlabel.."", 'rifle', 2000)
            else
                TriggerClientEvent("gum_notify:notify", _source, Config.Language[1].text, ""..Config.Language[2].text.."", 'rifle', 2000)
            end
        else
            TriggerClientEvent("gum_notify:notify", _source, Config.Language[1].text, ""..Config.Language[5].text.."", 'rifle', 2000)
        end
    end)
end)

RegisterServerEvent("gum_weapons:buyammo")
AddEventHandler("gum_weapons:buyammo", function(itemtobuy,itemprice,count)
    local _source = source
    local User = gumCore.getUser(source)
    local Character = User.getUsedCharacter
    local user_money = Character.money
    if user_money >= tonumber(itemprice)*tonumber(count) then
            TriggerEvent("gumCore:canCarryItem", tonumber(_source), itemtobuy, tonumber(count), function(canCarry2)
                if canCarry2 then
                    Character.removeCurrency(tonumber(_source),0, tonumber(count)*itemprice)
                    gumInv.addItem(tonumber(_source), itemtobuy, tonumber(count))
                else
                    TriggerClientEvent("gum_notify:notify", tonumber(_source), Config.Language[1].text, ""..Config.Language[6].text.."", 'money', 1000)
                end
            end)
    else
        TriggerClientEvent("gum_notify:notify", tonumber(_source), Config.Language[1].text, ""..Config.Language[2].text.."", 'money', 1000)
    end
end)

function contains(table, element)
    for k, v in pairs(table) do
          if k == element then
            return true
        end
    end
  return false
  end
