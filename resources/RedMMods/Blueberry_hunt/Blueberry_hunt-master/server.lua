RegisterServerEvent('bberry_hunt:AddSomeMoney')
AddEventHandler('bberry_hunt:AddSomeMoney', function()
local _source = source
local price = Config.Price
local xp = Config.Xp
    TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
       if user ~= nil then
			user.addMoney(price)
			user.addXP(xp)
        end
    end)
end)

