


TriggerEvent("getCore",function(core)
    gumCore = core
end)

gumInv = exports.gum_inventory:gum_inventoryApi()

RegisterServerEvent("gum_weapons:save_comps")
AddEventHandler("gum_weapons:save_comps", function(table_comps, weapId, priceComps)
    local _source = source
    local User = gumCore.getUser(_source)
    local Character = User.getUsedCharacter
    local identifier = Character.identifier
    local charidentifier = Character.charIdentifier
    local check_money = Character.money
    if priceComps <= check_money then
        exports.ghmattimysql:execute('SELECT name,id,ammo FROM loadout WHERE identifier=@identifier AND charidentifier = @charidentifier AND used = @used ' , {['identifier'] = identifier, ['charidentifier'] = charidentifier, ['used'] = 1}, function(result)
            if result ~= nil then
                for k,v in pairs(result) do
                    if GetHashKey(v.name) == weapId then
                        local Parameters = { ['id'] = v.id, ['comps'] = json.encode(table_comps) } 
                        exports.ghmattimysql:execute("UPDATE loadout SET comps=@comps WHERE id=@id", Parameters)
                        Character.removeCurrency(tonumber(_source), 0, priceComps)
                        TriggerClientEvent("gum_weapons:load_components", tonumber(_source), table_comps)
                        TriggerClientEvent("gum_notify:notify", _source, Config.Language[1].text, ""..Config.Language[3].text..""..priceComps.."$", 'rifle', 2000)
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
             for a,b in pairs(result) do
                 if GetHashKey(b.name) == weapon_id then
                    local send_table = json.decode(b.comps)
                    TriggerClientEvent("gum_weapons:wep_components", tonumber(_source), send_table)
                 end
             end
         end
     end)
end)

for a,b in pairs(Config.ammo) do
    for c,d in pairs(b) do 
        gumInv.RegisterUsableItem(d.itemId, function(data)
            gumInv.subItem(data.source, d.itemId, 1)
            local secondGun,weaponItem = 0,0
            if d.secondGun ~= nil then secondGun = d.secondGun end if d.weaponItem ~= nil then weaponItem = d.weaponItem end
            TriggerClientEvent('gum_weapons:getgun', data.source, d.ammoNameHash, d.firstGun, d.boxCount, d.itemId, secondGun, weaponItem)
        end)
    end
end

RegisterServerEvent("gum_weapons:addammo")
AddEventHandler("gum_weapons:addammo", function(wephash,boxCount,ammoType,weaponItem,item)
    local _source = source
    local User = gumCore.getUser(source)
    local Character = User.getUsedCharacter
    local identifier = Character.identifier
    local charidentifier = Character.charIdentifier
    exports.ghmattimysql:execute('SELECT name,id,ammo FROM loadout WHERE identifier=@identifier AND charidentifier = @charidentifier ' , {['identifier'] = identifier, ['charidentifier'] = charidentifier}, function(result)
        local used = 1
        local idLoadout
        local max
        if result[1] ~= nil then 
            for i=1, #result, 1 do
                if weaponItem == 0 then
                    if GetHashKey(result[i].name) == wephash then
                        idLoadout = result[i].id
                    end
                elseif  weaponItem ~= 0 then
                    for k,v in pairs(weaponItem) do 
                        if v == result[i].name then
                            idLoadout = result[i].id
                        end
                    end
                end
            end
            for k,v in pairs(Config.ammo) do
                for l,m in pairs(v) do
                    if m.ammoNameHash == ammoType then 
                        max = m.maxAmmo
                    end
                end
            end
            if idLoadout ~= nil then
                exports.ghmattimysql:execute('SELECT ammo FROM loadout WHERE id = @id ' , {['id'] = idLoadout}, function(result)
                    if result[1] ~= nil then 
                        local ammoTable = json.decode(result[1].ammo)
                        if contains(ammoTable, ammoType) then
                            if (ammoTable[ammoType] + boxCount) > max then
                                boxCount = max - ammoTable[ammoType]
                                ammoTable[ammoType] = max 
                            else
                                ammoTable[ammoType] = ammoTable[ammoType] + boxCount
                            end
                        else
                            ammoTable[ammoType] = tonumber(boxCount)
                        end
                        if boxCount > 0 then
                            exports.ghmattimysql:execute("UPDATE loadout Set ammo=@ammo WHERE id=@id", { ['id'] = idLoadout, ['ammo'] = json.encode(ammoTable) })
                            else
                            TriggerEvent("gum_weapons:givebackbox",_source,item)
                        end
                    end
                end)
            else
                TriggerEvent("gum_weapons:givebackbox",_source,item)
            end
        end
    end)
end)

RegisterServerEvent("gum_weapons:givebackbox")
AddEventHandler("gum_weapons:givebackbox", function(source, item)
    local _source = source
    gumInv.addItem(_source, item, 1)
    TriggerClientEvent("gum_notify:notify", _source, Config.Language[1].text, ""..Config.Language[16].text.."", 'rifle', 2000)
end)

RegisterServerEvent("gum_weapons:buy_weapon")
AddEventHandler("gum_weapons:buy_weapon", function(weaponId,priceWeapon,modelName,itThrowable, idThrowable, countThrowable)
    local _source = source
    local User = gumCore.getUser(tonumber(_source))
    local Character = User.getUsedCharacter
    local money = Character.money
    TriggerEvent("gumCore:canCarryWeapons", tonumber(_source), 1, function(canCarry)
        if canCarry then
            if tonumber(money-priceWeapon) >= 0 then
                if itThrowable then
                    Character.removeCurrency(tonumber(_source),0, priceWeapon)
                    print(itThrowable, idThrowable, countThrowable)
                    gumInv.createWeapon(tonumber(_source), weaponId,  {[idThrowable] = countThrowable}, {})
                    TriggerClientEvent("gum_notify:notify", _source, Config.Language[1].text, ""..Config.Language[4].text.." "..modelName.."", 'rifle', 2000)
                else
                    Character.removeCurrency(tonumber(_source),0, priceWeapon)
                    gumInv.createWeapon(tonumber(_source), weaponId,  {["nothing"] = 0}, {})
                    TriggerClientEvent("gum_notify:notify", _source, Config.Language[1].text, ""..Config.Language[4].text.." "..modelName.."", 'rifle', 2000)
                end
            else
                TriggerClientEvent("gum_notify:notify", _source, Config.Language[1].text, ""..Config.Language[2].text.."", 'rifle', 2000)
            end
        else
            TriggerClientEvent("gum_notify:notify", _source, Config.Language[1].text, ""..Config.Language[5].text.."", 'rifle', 2000)
        end
    end)
end)

RegisterServerEvent("gum_weapons:buyammo")
AddEventHandler("gum_weapons:buyammo", function(ammoId,ammoPrice,count)
    local _source = source
    local User = gumCore.getUser(source)
    local Character = User.getUsedCharacter
    local user_money = Character.money
    if user_money >= tonumber(ammoPrice)*tonumber(count) then
            TriggerEvent("gumCore:canCarryItem", tonumber(_source), ammoId, tonumber(count), function(canCarry2)
                if canCarry2 then
                    Character.removeCurrency(tonumber(_source),0, tonumber(count)*ammoPrice)
                    gumInv.addItem(tonumber(_source), ammoId, tonumber(count))
                    TriggerClientEvent("gum_notify:notify", tonumber(_source), Config.Language[1].text, ""..Config.Language[15].text..(tonumber(count)*ammoPrice).."$", 'money', 1000)
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
