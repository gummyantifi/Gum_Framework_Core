exports('gum_inventoryApi',function()
    local self = {}

    
    self.check_itemtable = function(source)
        local global_variable = {}
        exports.ghmattimysql:execute('SELECT * FROM items' , {}, function(result)
            if result ~= nil then
                global_variable = result 
            end
        end)
        Citizen.Wait(200)
        return global_variable
    end
    self.preload_itemtable = function()
        local global_variable = {}
        exports.ghmattimysql:execute('SELECT * FROM items' , {}, function(result)
            if result ~= nil then
                global_variable = result 
            end
        end)
        Citizen.Wait(200)
        return global_variable
    end
    self.preload_weapontable = function()
        global_wep_variable = RECORDSW
        return global_wep_variable
    end
    self.check_weapontable = function(source)
        global_wep_variable = RECORDSW
        return global_wep_variable
    end

    self.createstorage = function(source, id, tosize)
        TriggerEvent("gumCore:registerstorage",source, id, tosize)
    end

    self.updatestorage = function(source, id, tosize)
        TriggerEvent("gumCore:updatestorage",source, id, tosize)
    end

    self.openstorage = function(source, id)
        TriggerEvent("gumCore:openstorage",source, id)
    end
    
    self.subWeapon = function(source,weaponid)
        TriggerEvent("gumCore:subWeapon",source,tonumber(weaponid))
    end

    self.createWeapon = function(source,weaponName,ammoaux,compaux)
        TriggerEvent("gumCore:registerWeapon",source,tostring(weaponName),ammoaux,compaux)
    end

    self.giveWeapon = function(source,weaponid,target)
        TriggerEvent("gumCore:giveWeapon",source,weaponid,target)
    end

    self.addItem = function(source,itemName,cuantity)
        TriggerEvent("gumCore:addItem",source,tostring(itemName),tonumber(cuantity))
    end

    self.subItem = function(source,itemName,cuantity)
        TriggerEvent("gumCore:subItem",source,tostring(itemName),tonumber(cuantity))
    end

    self.getItemCount = function(source,item)
        local count = 0
        TriggerEvent("gumCore:getItemCount", source, item, function(itemcount)
            count = itemcount
        end, tostring(item))
        return count
    end

    self.addBullets = function(source,weaponId,type,cuantity)
        TriggerEvent("gumCoreClient:addBullets",source,weaponId,type,cuantity)
    end

    self.getWeaponBullets = function(source,weaponId)
        local bull
        TriggerEvent("gumCore:getWeaponBullets",source,function(bullets)
            bull = bullets
        end,weaponId)
        return bull
    end
    
    self.canCarryItems = function(source, amount)
        local can
        TriggerEvent("gumCore:canCarryItems",source, amount,function(data)
            can = data
        end)
        return can
    end
    
    self.RegisterUsableItem = function(itemName,cb)
        TriggerEvent("gumCore:registerUsableItem",itemName,cb)
    end

    self.getUserInventory = function(source)
        local inv
        TriggerEvent("gumCore:getUserInventory", source, function(invent)
            inv = invent
        end)
        return inv
    end

    self.CloseInv = function(source)
        TriggerClientEvent("gum_inventory:CloseInv",source)
    end
    
    return self
end)
