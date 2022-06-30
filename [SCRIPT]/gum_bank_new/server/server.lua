local gumCore = {}

TriggerEvent("getCore",function(core)
	gumCore = core
end)
	
Inventory = exports.gum_inventory:gum_inventoryApi()
gum = exports.gum_core:gumAPI()
local city = {}


gum.addNewCallBack("gum_bank:get_bank", function(source, firstname,lastname,money,gold)
    local _source = source
    local User = gumCore.getUser(_source)
	local Character = User.getUsedCharacter
	local u_identifier = Character.identifier
	local u_charid = Character.charIdentifier
	local firstname = Character.firstname
	local lastname = Character.lastname
	local money = 0
	local gold = 0
	exports.ghmattimysql:execute("SELECT money,gold FROM bank_users WHERE identifier = @identifier and charidentifier = @charidentifier and name = @name", {['identifier'] = u_identifier, ['charidentifier'] = u_charid, ['name'] = city[_source]}, function(result)
		if result[1] ~= nil then
			money = result[1].money
			gold = result[1].gold
		else
			local Parameters = { ['identifier'] = u_identifier, ['charidentifier'] = u_charid, ['money'] = 0, ['name'] = city[_source] }
			exports.ghmattimysql:execute("INSERT INTO bank_users ( `identifier`,`charidentifier`,`money`,`name` ) VALUES ( @identifier,@charidentifier,@money,@name )", Parameters)
		end
	end)
	Citizen.Wait(200)
	return firstname, lastname, money, gold
end)

gum.addNewCallBack("gum_bank:get_borrow", function(source, date)
	local _source = source
    local User = gumCore.getUser(_source)
	local Character = User.getUsedCharacter
	local u_identifier = Character.identifier
	local u_charid = Character.charIdentifier
	local date = 0
	exports.ghmattimysql:execute('SELECT borrow_pay FROM bank_users WHERE borrow_pay < now() - interval 1 DAY and identifier=@identifier and charidentifier=@charidentifier' , {['identifier']=u_identifier, ['charidentifier']=u_charid}, function(result)
		if result[1] ~= nil then
		 	date = os.date(''..Config.Language[6].text..' : %d.%m ve %H:%M', (result[1].borrow_pay/1000))
		end
	end)
	Citizen.Wait(100)
	return date
end)

RegisterServerEvent('gum_bank:get_bank_city')
AddEventHandler( 'gum_bank:get_bank_city', function(cityes)
	local _source = source
	city[tonumber(_source)] = cityes
	TriggerClientEvent("gum_bank:get_bank", tonumber(source), city[source])
end)

RegisterServerEvent('gum_bank:addmoney')
AddEventHandler( 'gum_bank:addmoney', function(citye, value, havem, haveg)
	local _source = source
	local User = gumCore.getUser(_source)
	local Character = User.getUsedCharacter
	local firstname = Character.firstname
	local lastname = Character.lastname
	local u_identifier = Character.identifier
	local u_charid = Character.charIdentifier
	local user_money = Character.money
	if tonumber(user_money) >= tonumber(value) and tonumber(value) > 0 then
		if Config.WebhookEnable == true then
			DiscordWeb(16753920, "**Dal do banky** \n **Steam hex** : "..u_identifier.."\n **Steam name** : "..GetPlayerName(tonumber(_source)).." \n **Má peněz na účtě** : "..havem.."$\n**Dal peněz** : "..value.."$" , argss, "")
		end

		Character.removeCurrency(tonumber(_source), 0, value)
		TriggerClientEvent("gum_notify:notify", tonumber(_source), Config.Language[1].text, ""..Config.Language[9].text.." "..value.."$</br>"..Config.Language[13].text..""..tonumber(havem)+tonumber(value).."", 'bag', 2500)
		exports.ghmattimysql:execute("UPDATE bank_users SET money=@value WHERE name=@name AND identifier=@u_identifier AND charidentifier=@u_charid", {["u_identifier"]=u_identifier, ["u_charid"]=u_charid, ["name"]=citye, ["value"]=tonumber(havem)+tonumber(value)},
		function (result)
			TriggerClientEvent("gum_bank:update", tonumber(_source), citye, firstname, lastname, tonumber(havem)+tonumber(value), tonumber(haveg))
		end)
	else
		TriggerClientEvent("gum_notify:notify", tonumber(_source), Config.Language[1].text, Config.Language[7].text, 'bag', 2500)
	end
end)


RegisterServerEvent('gum_bank:takemoney')
AddEventHandler( 'gum_bank:takemoney', function(citye, value, havem, haveg)
	local _source = source
	local User = gumCore.getUser(_source)
	local Character = User.getUsedCharacter
	local firstname = Character.firstname
	local lastname = Character.lastname
	local u_identifier = Character.identifier
	local u_charid = Character.charIdentifier
	if tonumber(havem) >= tonumber(value) and tonumber(value) > 0 then
		if Config.WebhookEnable == true then
			DiscordWeb(16753920, "**Vzal z banky** \n **Steam hex** : "..u_identifier.."\n **Steam name** : "..GetPlayerName(tonumber(_source)).." \n **Má peněz na účtě** : "..havem.."$\n**Vzal peněz** : "..value.."$" , argss, "")
		end
		Character.addCurrency(tonumber(_source), 0, tonumber(value))
		TriggerClientEvent("gum_notify:notify", tonumber(_source), Config.Language[1].text, ""..Config.Language[10].text..""..value.."$</br>"..Config.Language[13].text..""..tonumber(havem)-tonumber(value).."", 'bag', 1500)
		exports.ghmattimysql:execute("UPDATE bank_users SET money=@value WHERE name=@name AND identifier=@u_identifier AND charidentifier=@u_charid", {["u_identifier"]=u_identifier, ["u_charid"]=u_charid, ["name"]=citye, ["value"]=tonumber(havem)-tonumber(value)},
		function (result)
			TriggerClientEvent("gum_bank:update", tonumber(_source), citye, firstname, lastname, tonumber(havem)-tonumber(value), tonumber(haveg))
		end)
	else
		TriggerClientEvent("gum_notify:notify", tonumber(_source), Config.Language[1].text, Config.Language[7].text, 'bag', 2500)
	end
end)


RegisterServerEvent('gum_bank:addgold')
AddEventHandler( 'gum_bank:addgold', function(citye, value, havem, haveg)
	local _source = source
	local User = gumCore.getUser(_source)
	local Character = User.getUsedCharacter
	local firstname = Character.firstname
	local lastname = Character.lastname
	local u_identifier = Character.identifier
	local u_charid = Character.charIdentifier
	local user_gold = Character.gold
	if tonumber(user_gold) >= tonumber(value) and tonumber(value) > 0 then
		if Config.WebhookEnable == true then
			DiscordWeb(16753920, "**Dal do banky** \n **Steam hex** : "..u_identifier.."\n **Steam name** : "..GetPlayerName(tonumber(_source)).." \n **Má zlata na účtě** : "..haveg.."G\n**Dal zlata** : "..value.."G" , argss, "")
		end
		Character.removeCurrency(tonumber(_source), 1, value)
		TriggerClientEvent("gum_notify:notify", tonumber(_source), Config.Language[1].text, ""..Config.Language[9].text..""..value.." "..Config.Language[10].text.."</br>"..Config.Language[13].text..""..tonumber(haveg)+tonumber(value).."", 'bag', 1500)
		exports.ghmattimysql:execute("UPDATE bank_users SET gold=@value WHERE name=@name AND identifier=@u_identifier AND charidentifier=@u_charid", {["u_identifier"]=u_identifier, ["u_charid"]=u_charid, ["name"]=citye, ["value"]=tonumber(haveg)+tonumber(value)},
		function (result)
			TriggerClientEvent("gum_bank:update", tonumber(_source), citye, firstname, lastname, tonumber(havem), tonumber(haveg)+tonumber(value))
		end)
	else
		TriggerClientEvent("gum_notify:notify", tonumber(_source), Config.Language[1].text, Config.Language[8].text, 'bag', 2500)
	end
end)


RegisterServerEvent('gum_bank:takegold')
AddEventHandler( 'gum_bank:takegold', function(citye, value, havem, haveg)
	local _source = source
	local User = gumCore.getUser(_source)
	local Character = User.getUsedCharacter
	local firstname = Character.firstname
	local lastname = Character.lastname
	local u_identifier = Character.identifier
	local u_charid = Character.charIdentifier
	if tonumber(haveg) >= tonumber(value) and tonumber(value) > 0 then
		if Config.WebhookEnable == true then
			DiscordWeb(16753920, "**Vzal z banky** \n **Steam hex** : "..u_identifier.."\n **Steam name** : "..GetPlayerName(tonumber(_source)).." \n **Má zlata na účtě** : "..haveg.."G\n**Vzal zlata** : "..value.."G" , argss, "")
		end
		Character.addCurrency(tonumber(_source), 1, value)
		TriggerClientEvent("gum_notify:notify", tonumber(_source), Config.Language[1].text, ""..Config.Language[10].text..""..value.." "..Config.Language[10].text.."</br>"..Config.Language[13].text..""..tonumber(haveg)-tonumber(value).."", 'bag', 1500)
		exports.ghmattimysql:execute("UPDATE bank_users SET gold=@value WHERE name=@name AND identifier=@u_identifier AND charidentifier=@u_charid", {["u_identifier"]=u_identifier, ["u_charid"]=u_charid, ["name"]=citye, ["value"]=tonumber(haveg)-tonumber(value)},
		function (result)
			TriggerClientEvent("gum_bank:update", tonumber(_source), citye, firstname, lastname, tonumber(havem), tonumber(haveg)-tonumber(value))
		end)
	else
		TriggerClientEvent("gum_notify:notify", tonumber(_source), Config.Language[1].text, "You dont have this money", 'bag', 2500)
	end
end)


RegisterServerEvent('gum_bank:borrow_money_now')
AddEventHandler( 'gum_bank:borrow_money_now', function(borrow_value, borrow_add, borrow_calc_percent, citye)
	local _source = source
	local User = gumCore.getUser(_source)
	local Character = User.getUsedCharacter
	local u_identifier = Character.identifier
	local u_charid = Character.charIdentifier
	local have_borrow = false
	exports.ghmattimysql:execute('SELECT * FROM bank_users WHERE borrow > 0 and identifier=@identifier and charidentifier=@charidentifier' , {['identifier']=u_identifier, ['charidentifier']=u_charid}, function(result)
		if result[1] ~= nil then
			have_borrow = true
		end
	end)
	Citizen.Wait(100)
	if have_borrow == true then
		TriggerClientEvent("gum_notify:notify", tonumber(_source), Config.Language[1].text, ""..Config.Language[14].text.."", 'bag', 4500)
		return false
	end
	Citizen.Wait(100)
	exports.ghmattimysql:execute("UPDATE bank_users SET borrow=@borrow,borrow_money=@borrow_money,borrow_pay=CURRENT_TIMESTAMP() WHERE name=@name AND identifier=@u_identifier AND charidentifier=@u_charid", {["u_identifier"]=u_identifier, ["u_charid"]=u_charid, ["name"]=citye, ["borrow"]=tonumber(borrow_value)+tonumber(borrow_add), ["borrow_money"]=tonumber(borrow_calc_percent)},
	function (result)
		if result ~= nil then
			if Config.WebhookEnable == true then
				DiscordWeb(16753920, "**Si půjčil** \n **Steam hex** : "..u_identifier.."\n **Steam name** : "..GetPlayerName(tonumber(_source)).." \n **Pujčil si** : "..borrow_value.."$" , argss, "")
			end
			Character.addCurrency(tonumber(_source), 0, tonumber(borrow_value))
			TriggerClientEvent("gum_notify:notify", tonumber(_source), Config.Language[1].text, ""..Config.Language[15].text..""..borrow_value+borrow_add.."$</br>"..Config.Language[16].text..""..borrow_calc_percent.."$", 'bag', 4500)
		end
	end)
end)

RegisterServerEvent('gum_bank:remove_borrow')
AddEventHandler( 'gum_bank:remove_borrow', function()
	local _source = source
	local User = gumCore.getUser(_source)
	local Character = User.getUsedCharacter
	local u_identifier = Character.identifier
	local u_charid = Character.charIdentifier

	exports.ghmattimysql:execute("SELECT borrow_money,borrow,name FROM bank_users WHERE identifier = @identifier and charidentifier = @charidentifier", {['identifier'] = u_identifier, ['charidentifier'] = u_charid}, function(result)
		if result ~= nil then
			for k,v in pairs(result) do
				if v.borrow_money ~= 0 then
					Character.removeCurrency(tonumber(_source), 0, v.borrow_money)
					if v.borrow-v.borrow_money <= 0 then
						exports.ghmattimysql:execute("UPDATE bank_users SET borrow=@borrow,borrow_pay=NULL,borrow_money=@borrow_money WHERE name=@name AND identifier=@u_identifier AND charidentifier=@u_charid", {["u_identifier"]=u_identifier, ["u_charid"]=u_charid, ["name"]=v.name, ["borrow"]=tonumber(0), ["borrow_money"]=tonumber(0)},
						function (result)
						end)
					else
						exports.ghmattimysql:execute("UPDATE bank_users SET borrow=@borrow,borrow_pay=CURRENT_TIMESTAMP() WHERE name=@name AND identifier=@u_identifier AND charidentifier=@u_charid", {["u_identifier"]=u_identifier, ["u_charid"]=u_charid, ["name"]=v.name, ["borrow"]=tonumber(v.borrow-v.borrow_money)},
						function (result)
	
						end)
					end
				end
			end
		end
	end)

end)

function DiscordWeb(color, name, footer)
    local embed = {{["color"] = color,["title"] = "",["description"] = "".. name .."",["footer"] = {["text"] = footer,},}}
    PerformHttpRequest(Config.WebhookLink, function(err, text, headers) end, 'POST', json.encode({username = "Bank log", embeds = embed}), { ['Content-Type'] = 'application/json' })
end

