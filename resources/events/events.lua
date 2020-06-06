Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local player = PlayerPedId()
        local coords = GetEntityCoords(player)
        local excludeEntity = player
        local shapeTest = StartShapeTestBox(coords.x, coords.y, coords.z, 2.0, 2.0, 2.0, 0.0, 0.0, 0.0, true, 8, excludeEntity)
        local rtnVal, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(shapeTest)
        excludeEntity = entityHit
	local type = GetPedType(entityHit)
	local dead = IsEntityDead(entityHit)
	local PressTime = 0
	if type == 28 and dead then
	shape = false
	looted = true
        looted = Citizen.InvokeNative(0x8DE41E9902E85756, entityHit)
        if IsControlJustReleased(0, 0x41AC83D1) then
	KeyHeldTime = GetGameTimer() - PressTime
	PressTime = 0
	if KeyHeldTime > 250 then
            if looted == false then
                print("looted")
	TriggerEvent("hunting:showprompt", "looted.")
            elseif looted == 1 then
                print("already looted")
		    end
		end
            end
        end
    end
end)
