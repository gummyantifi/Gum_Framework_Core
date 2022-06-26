gumCore = {}

TriggerEvent("getCore",function(core)
	gumCore = core
end)
gum = exports.gum_core:gumAPI()

	
Inventory = exports.gum_inventory:gum_inventoryApi()
gum = exports.gum_core:gumAPI()
local blockSpamItems = {}
local metaDataCache = {}
for a,b in pairs(Config.Metabolism) do
    Inventory.RegisterUsableItem(b.idItem, function(data)
        if blockSpamItems[data.source] == nil then
            blockSpamItems[data.source] = true
            -- Inventory.subItem(data.source, b.idItem, 1)
            TriggerClientEvent("gum_metabolism:eatIt", data.source, b)
            local User = gumCore.getUser(data.source)
            local Character = User.getUsedCharacter
            if metaDataCache[data.source].hunger+b.hunger >= 100 then
                metaDataCache[data.source].hunger = 100
            else
                metaDataCache[data.source].hunger = metaDataCache[data.source].hunger+b.hunger
            end
            if metaDataCache[data.source].thirst+b.thirst >= 100 then
                metaDataCache[data.source].thirst = 100
            else
                metaDataCache[data.source].thirst = metaDataCache[data.source].thirst+b.thirst
            end
            metaDataCache[data.source] = {hunger=metaDataCache[data.source].hunger, thirst=metaDataCache[data.source].thirst}
        end
    end)
end

AddEventHandler('playerDropped', function (reason)
    local _source = source
    local User = gumCore.getUser(_source)
    local Character = User.getUsedCharacter
	local meta_table = {Thirst=metaDataCache[_source].hunger, Hunger=metaDataCache[_source].thirst}
    Character.setMeta(tonumber(_source), meta_table)
end)

RegisterServerEvent('gum_metabolism:deBlockSpam')
AddEventHandler( 'gum_metabolism:deBlockSpam', function()
    local _source = source
    blockSpamItems[_source] = nil
end)

gum.addNewCallBack("gum_metabolism:getStatus", function(source, hunger,thirst)
    local _source = source
    local User = gumCore.getUser(_source)
    local Character = User.getUsedCharacter
    metaDataCache[_source] = {hunger=json.decode(Character.meta).Hunger, thirst=json.decode(Character.meta).Thirst}
	return json.decode(Character.meta).Hunger, json.decode(Character.meta).Thirst
end)
