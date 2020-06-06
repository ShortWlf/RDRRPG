local isDelivering = false

Citizen.CreateThread(function()
	Wait(0)
	jobspot1 = N_0x554d9d53f696d002(Config.MainSprite, Config.MainJob1.x, Config.MainJob1.y, Config.MainJob1.z)
		Citizen.InvokeNative(0x9CB1A1623062F402, jobspot1, "Short Delivery")
	jobspot2 = N_0x554d9d53f696d002(Config.MainSprite, Config.MainJob2.x, Config.MainJob2.y, Config.MainJob2.z)
		Citizen.InvokeNative(0x9CB1A1623062F402, jobspot2, "Short Delivery")
	jobspot3 = N_0x554d9d53f696d002(Config.MainSprite, Config.MainJob3.x, Config.MainJob3.y, Config.MainJob3.z)
		Citizen.InvokeNative(0x9CB1A1623062F402, jobspot3, "Short Delivery")
	jobspot4 = N_0x554d9d53f696d002(Config.MainSprite, Config.MainJob4.x, Config.MainJob4.y, Config.MainJob4.z)
		Citizen.InvokeNative(0x9CB1A1623062F402, jobspot4, "Short Delivery")
end)

Citizen.CreateThread(function()
    while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local betweencoords = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, Config.MainJob1.x, Config.MainJob1.y, Config.MainJob1.z, true)
		local betweencoords2 = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, Config.MainJob2.x, Config.MainJob2.y, Config.MainJob2.z, true)
		local betweencoords3 = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, Config.MainJob3.x, Config.MainJob3.y, Config.MainJob3.z, true)
		local betweencoords4 = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, Config.MainJob4.x, Config.MainJob4.y, Config.MainJob4.z, true)
		if betweencoords <= 2.2 then
		DrawTxt(Config.StartWorking1, 0.50, 0.90, 0.7, 0.7, true, 255, 255, 255, 255, true)
			if IsControlJustPressed(2, 0xCEFD9220) then
				p1 = N_0x554d9d53f696d002(203020899, Config.Point1.x, Config.Point1.y, Config.Point1.z)
					SetBlipSprite(p1, Config.DeliverySprite, 1)
					Citizen.InvokeNative(0x9CB1A1623062F402, p1, "Delivery")
				isDelivering = true
				wagon()
			end

		elseif betweencoords2 <= 2.2 then
		DrawTxt(Config.StartWorking2, 0.50, 0.90, 0.7, 0.7, true, 255, 255, 255, 255, true)
			if IsControlJustPressed(2, 0xCEFD9220) then
				p2 = N_0x554d9d53f696d002(203020899, Config.Point2.x, Config.Point2.y, Config.Point2.z)
					SetBlipSprite(p2, Config.DeliverySprite, 1)
					Citizen.InvokeNative(0x9CB1A1623062F402, p2, "Delivery")
				isDelivering = true
				wagon()
			end

		elseif betweencoords3 <= 2.2 then
		DrawTxt(Config.StartWorking3, 0.50, 0.90, 0.7, 0.7, true, 255, 255, 255, 255, true)
			if IsControlJustPressed(2, 0xCEFD9220) then
				p3 = N_0x554d9d53f696d002(203020899, Config.Point3.x, Config.Point3.y, Config.Point3.z)
					SetBlipSprite(p3, Config.DeliverySprite, 1)
					Citizen.InvokeNative(0x9CB1A1623062F402, p3, "Delivery")
				isDelivering = true
				wagon()
			end

		elseif betweencoords4 <= 2.2 then
		DrawTxt(Config.StartWorking4, 0.50, 0.90, 0.7, 0.7, true, 255, 255, 255, 255, true)
			if IsControlJustPressed(2, 0xCEFD9220) then
				p4 = N_0x554d9d53f696d002(203020899, Config.Point4.x, Config.Point4.y, Config.Point4.z)
					SetBlipSprite(p4, Config.DeliverySprite, 1)
					Citizen.InvokeNative(0x9CB1A1623062F402, p4, "Delivery")
				isDelivering = true
				wagon()
			end
		else end
	end
end)

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
	Citizen.InvokeNative(0xADA9255D, 1);
    DisplayText(str, x, y)
end

Citizen.CreateThread(function()
while true do
	Wait(0)
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local betweencoords = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, Config.Point1.x, Config.Point1.y, Config.Point1.z, true)
	local betweencoords2 = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, Config.Point2.x, Config.Point2.y, Config.Point2.z, true)
	local betweencoords3 = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, Config.Point3.x, Config.Point3.y, Config.Point3.z, true)
	local betweencoords4 = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, Config.Point4.x, Config.Point4.y, Config.Point4.z, true)
	if betweencoords <= Config.ZoneSize and isDelivering then
	DrawTxt(Config.Deliver, 0.50, 0.90, 0.7, 0.7, true, 255, 255, 255, 255, true)
		if IsControlJustPressed(2, 0xB2F377E8) then
			TriggerEvent("redemrp_notification:start", "Delivering" , 4, "warning")
			TriggerServerEvent('redemrp_Deliveryjob:payout', Config.Cash1, Config.Gold1, Config.EXP1)
				isDelivering = false
				RemoveBlip(p1)
			end
	elseif betweencoords2 <= Config.ZoneSize and isDelivering then
	DrawTxt(Config.Deliver, 0.50, 0.90, 0.7, 0.7, true, 255, 255, 255, 255, true)
		if IsControlJustPressed(2, 0xB2F377E8) then
			TriggerEvent("redemrp_notification:start", "Delivering" , 4, "warning")
			TriggerServerEvent('redemrp_Deliveryjob:payout', Config.Cash2, Config.Gold2, Config.EXP2)
				isDelivering = false
				RemoveBlip(p2)
			end
	elseif betweencoords3 <= Config.ZoneSize and isDelivering then
	DrawTxt(Config.Deliver, 0.50, 0.90, 0.7, 0.7, true, 255, 255, 255, 255, true)
		if IsControlJustPressed(2, 0xB2F377E8) then
			TriggerEvent("redemrp_notification:start", "Delivering" , 4, "warning")
			TriggerServerEvent('redemrp_Deliveryjob:payout', Config.Cash3, Config.Gold3, Config.EXP3)
				deliver()
				isDelivering = false
				RemoveBlip(p3)
			end
			
	elseif betweencoords4 <= Config.ZoneSize and isDelivering then
	DrawTxt(Config.Deliver, 0.50, 0.90, 0.7, 0.7, true, 255, 255, 255, 255, true)
		if IsControlJustPressed(2, 0xB2F377E8) then
			TriggerEvent("redemrp_notification:start", "Delivering" , 4, "warning")
			TriggerServerEvent('redemrp_Deliveryjob:payout', Config.Cash4, Config.Gold4, Config.EXP4)
				isDelivering = false
				RemoveBlip(p4)
			end
	else end
	end
end)

function wagon()
    local ped = PlayerPedId()
    local car_start = GetEntityCoords(ped)
    local car_name = "CART01"
    local carHash = GetHashKey(car_name)
    RequestModel(carHash)

    while not HasModelLoaded(carHash) do
        Citizen.Wait(0)
    end

    local car = CreateVehicle(carHash, Config.Cart1.x, Config.Cart1.y, Config.Cart1.z, Config.Cart1.h, true, false)
    SetVehicleOnGroundProperly(car)
    SetPedIntoVehicle(ped, car, -1)
    SetModelAsNoLongerNeeded(carHash)
end
