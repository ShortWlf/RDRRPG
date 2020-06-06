data = {}

TriggerEvent("redemrp_inventory:getData", function(call) data = call end)

RegisterServerEvent('art_woodcutter:comjob')
AddEventHandler('art_woodcutter:comjob', function()
    TriggerEvent('redemrp:getPlayerFromId', source, function(user)
        --if user.getJob() == Config.JobName then
            TriggerClientEvent('art_woodcutter:comienzo', source)
            TriggerClientEvent("redemrp_notification:start", source, Language.translate[Config.lang]['gopos'], 5)
        --else
            --TriggerClientEvent("redemrp_notification:start", source, Language.translate[Config.lang]['nojob'], 5)
        --end
    end)
end)

RegisterServerEvent('art_woodcutter:cobrar')
AddEventHandler('art_woodcutter:cobrar', function(dinero, xp)
    TriggerEvent('redemrp:getPlayerFromId', source, function(user)
        user.addMoney(dinero)
        user.addXP(xp)
        local itemMadera = Config.ItemRedward

        local count1 = math.random(2, 6)
        
        data.addItem(source, itemMadera, count1)

        TriggerClientEvent("redemrp_notification:start", source, "Has recibido " .. count1 .. " de " .. itemMadera, 4)
	end)
end)