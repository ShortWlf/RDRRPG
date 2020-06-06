local notificationInSafeZone = false
local notificationOutSafeZone = false
local closestZoneIndex = 1

-- Creating Blip at the locations. 
Citizen.CreateThread(function()
	while not NetworkIsPlayerActive(PlayerId()) do
		Citizen.Wait(0)
	end

	for i = 1, #Config.zones, 1 do
		Citizen.InvokeNative(0x554d9d53f696d002, 1560611276, Config.zones[i].x, Config.zones[i].y, Config.zones[i].z) -- Add blip icon
	end
end)

--Find and save  the nearest safezone location.
Citizen.CreateThread(function()
	while not NetworkIsPlayerActive(PlayerId()) do
		Citizen.Wait(0)
	end
	
	while true do
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local minDistance = 100000
		for i = 1, #Config.zones, 1 do
			local betweencoords = GetDistanceBetweenCoords(coords, Config.zones[i].x, Config.zones[i].y, Config.zones[i].z, true)
			if betweencoords < minDistance then
				minDistance = betweencoords
				closestZoneIndex = i
			end
		end
		Citizen.Wait(15000)
	end
end)

-- Disable Weapon Attack and Melee Attack
Citizen.CreateThread(function()
	while not NetworkIsPlayerActive(PlayerId()) do
		Citizen.Wait(0)
	end

	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local betweencoords = GetDistanceBetweenCoords(coords, Config.zones[closestZoneIndex].x, Config.zones[closestZoneIndex].y, Config.zones[closestZoneIndex].z, true)
	
		if betweencoords <= Config.safeRadius then 
			if not notificationInSafeZone then
				NetworkSetFriendlyFireOption(false)
				ClearPlayerWantedLevel(PlayerId())
				ShowNotification("You are in a safe zone.")
				notificationInSafeZone = true
				notificationOutSafeZone = false
			end
		else
			if not notifOut then
				NetworkSetFriendlyFireOption(true)
				ShowNotification("You leaving the safe zone.")
				notificationOutSafeZone = true
				notificationInSafeZone = false
			end
		end
		if notificationInSafeZone then
			DisablePlayerFiring(playerPed, true) -- Disables firing all together if they somehow bypass inzone Mouse Disable
      		DisableControlAction(0, 0x07CE1E61, true) -- Disable attack  control
      		DisableControlAction(0, 0xB2F377E8, true) -- Disable MeleeAttack control
			if IsDisabledControlJustPressed(0, 0x07CE1E61) or IsDisabledControlJustPressed(0, 0xB2F377E8) then 	
				ShowNotification("You can not do that in safe zone.")
			end
		end
	end
end)

local function ShowNotification( _message )
	local timer = 200
	while timer > 0 do
		DisplayHelp(_message, 0.50, 0.90, 0.6, 0.6, true, 161, 3, 0, 255, true, 10000)
		timer = timer - 1
		Citizen.Wait(0)
	end
end