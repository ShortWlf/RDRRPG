local keys = { ['G'] = 0x760A9C6F, ['S'] = 0xD27782E3, ['W'] = 0x8FD015D8, ['H'] = 0x24978A28, ['G'] = 0x5415BE48, ["ENTER"] = 0xC7B5340A, ['E'] = 0xDFF812F9,["BACKSPACE"] = 0x156F7119 }
local campfire = 0

--menu

Citizen.CreateThread(function()
    WarMenu.CreateMenu('campfire', "prepare food")
    WarMenu.SetSubTitle('campfire', 'prepare food')
    WarMenu.CreateSubMenu('cook', 'campfire', 'cook food')
  

    while true do

        local ped = GetPlayerPed(-1)
        local coords = GetEntityCoords(PlayerPedId())

        if WarMenu.IsMenuOpened('campfire') then
            if WarMenu.MenuButton('Cook', 'cook') then
            end

            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('cook') then
            
            if WarMenu.Button('Cook Raw Meat') then
                       TriggerServerEvent("def_cookfood:getmeat")
 
			end
   
            WarMenu.Display()
		
        end
        Citizen.Wait(0)
    end
end)

RegisterCommand("cookfood", function(source, args, rawCommand) -- craft COMMAND
local _source = source
		if campfire ~= 0 then
		
            SetEntityAsMissionEntity(campfire)
            DeleteObject(campfire)
            campfire = 0
            end
            local playerPed = PlayerPedId()
			Citizen.Wait(0)
            ClearPedTasksImmediately(PlayerPedId())
			
            TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), -1, true, false, false, false)
			exports['progressBars']:startUI(10000, "Setting fire...")
			Citizen.Wait(10000)
			WarMenu.OpenMenu('campfire')
            local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
            local prop = CreateObject(GetHashKey("p_campfire02x"), x, y, z, true, false, true)
            SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
            PlaceObjectOnGroundProperly(prop)
            campfire = prop

end, false)

Citizen.CreateThread(function()
    while true do
	local playerPed = PlayerPedId()
        Citizen.Wait(0)
		
        if whenKeyJustPressed(keys['BACKSPACE']) then
			exports['progressBars']:startUI(10000, "Removing fire...")
			Citizen.Wait(10000)
            if campfire ~= 0 then
            SetEntityAsMissionEntity(campfire)
            DeleteObject(campfire)
			ClearPedTasksImmediately(PlayerPedId())
            campfire = 0
            end
     end
	end
end)

RegisterCommand("delfire", function(source, args, rawCommand)
    if campfire == 0 then
        print("There is no campfire.")
    else
        SetEntityAsMissionEntity(campfire)
        DeleteObject(campfire)
        campfire = 0
    end
end, false)

--- Settings ProgressBars ---

--- Fleisch --- 

RegisterNetEvent('def_cookfood:cookmeat')
AddEventHandler('def_cookfood:cookmeat', function()

    local playerPed = PlayerPedId()
    --TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 27000, true, false, false, false)
    exports['progressBars']:startUI(27000, "Cooking meat...")
   -- Citizen.Wait(27000)
   -- ClearPedTasksImmediately(PlayerPedId())

end)

function whenKeyJustPressed(key)
    if Citizen.InvokeNative(0x580417101DDB492F, 0, key) then
        return true
    else
        return false
    end
end