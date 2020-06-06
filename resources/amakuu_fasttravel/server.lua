RegisterServerEvent('amakuu_fasttravel:buyTicket')
AddEventHandler('amakuu_fasttravel:buyTicket', function(pos, price)
	local _price = price
	local _pos = pos

	TriggerEvent('redemrp:getPlayerFromId', source, function(user)
	local currentMoney = user.getMoney()
	if currentMoney >= _price then
	user.removeMoney(_price)
	TriggerClientEvent('amakuu_fasttravel:doTravel', source, _pos)
	else 
	TriggerClientEvent('amakuu_fasttravel:noMoney', source)
	end
	end)
end)