TriggerEvent("redemrp_inventory:getData",function(call)
    data = call
end)

RegisterServerEvent("RegisterUsableItem:fishingrod")
AddEventHandler("RegisterUsableItem:fishingrod", function(source)
    TriggerClientEvent('ml_fisher:StartFishing', source)
end)


RegisterNetEvent("fishing")
AddEventHandler("fishing", function()

    TriggerEvent('redemrp:getPlayerFromId', source, function(user)
            data.addItem(source,"fish", 1)
			
    end)
    TriggerClientEvent("redemrp_notification:start",source, "You got a fish!", 2)
end)

