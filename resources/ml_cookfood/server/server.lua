local data = {}
TriggerEvent("redemrp_inventory:getData",function(call)
    data = call
end)

RegisterServerEvent('def_cookfood:getmeat')
AddEventHandler("def_cookfood:getmeat", function(name, weapon)
    local _source = tonumber(source)
    TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
		local count = data.checkItem(_source, "rawmeat")
		if count >= 1 then
		
			data.delItem(_source,"rawmeat", 1)
			
          TriggerClientEvent('def_cookfood:cookmeat', _source)
		  
          Citizen.Wait(26000)
		  
                data.addItem(_source,"cookedmeat", 1)
                TriggerClientEvent("redemrp_notification:start", source, "Meat was cooked", 2, "success")
        else
            TriggerClientEvent("redemrp_notification:start", _source, 'You need: 1 Raw Meat', 3)
        end
    end)
end)