--ml
local campfire = 0
local tent = 0
local cauldron = 0
local hitch = 0
local Table = 0
local chair = 0


Citizen.CreateThread(function()
	local sexe =  IsPedMale(PlayerPedId())
    local checkbox2 = false
    WarMenu.CreateMenu('ml', "camp")
    WarMenu.SetSubTitle('ml', 'camping menu')
	
    WarMenu.CreateSubMenu('inv1', 'ml', 'set')
	WarMenu.CreateSubMenu('inv2', 'ml', 'del')
	WarMenu.CreateSubMenu('inv3', 'ml', 'del full')


    while true do

        local ped = GetPlayerPed()
        local coords = GetEntityCoords(PlayerPedId())
		local sexe =  IsPedMale(PlayerPedId())
		
        if WarMenu.IsMenuOpened('ml') then
		
		if WarMenu.MenuButton('camp set', 'inv1') then
            end
		if WarMenu.MenuButton('camp del', 'inv2') then
            end	
		if WarMenu.MenuButton('full camp del', 'inv3') then
            end	

            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('inv1') then

            if WarMenu.Button('set campfire') then
		
		TriggerServerEvent("campfire", function()  --check/del campfire items
			end)
			
		elseif WarMenu.Button('set tent') then
		
		TriggerServerEvent("tent", function()  --check/del tent items
			end)
			
		elseif WarMenu.Button('set cauldron') then 
		
		TriggerServerEvent("cauldron", function()  --check/del cauldron items
			end)
		
		elseif WarMenu.Button('set hitch') then
		
		TriggerServerEvent("hitch", function()  --check/del hitch items
			end)
		
		elseif WarMenu.Button('set table') then
		
		TriggerServerEvent("table", function()  --check/del table items
			end)
		
		elseif WarMenu.Button('set chair') then
		
		TriggerServerEvent("chair", function()  --check/del chair items
			end)
       
            end

            WarMenu.Display()
			
		elseif WarMenu.IsMenuOpened('inv2') then
		if WarMenu.Button('del campfire') then
		TriggerEvent("ml_camping:delcampfire")
		
		elseif WarMenu.Button('del tent') then
		TriggerEvent("ml_camping:deltent")
		
		elseif WarMenu.Button('del cauldron') then 
		TriggerEvent("ml_camping:delcauldron")
		
		elseif WarMenu.Button('del hitch') then
		TriggerEvent("ml_camping:delhitch")
		
		elseif WarMenu.Button('del table') then
		TriggerEvent("ml_camping:deltable")
		
		elseif WarMenu.Button('del chair') then
		TriggerEvent("ml_camping:delchair")
	
       
            end

            WarMenu.Display()
			
			elseif WarMenu.IsMenuOpened('inv3') then
		if WarMenu.Button('del full camp') then
		TriggerEvent("ml_camping:delfullcamp")


			end

            WarMenu.Display()

        elseif whenKeyJustPressed(keys["J"]) then 
            WarMenu.OpenMenu('ml')
        end
		
	
        Citizen.Wait(0)
    end
end)

--setting 

RegisterNetEvent('ml_camping:setcampfire')
AddEventHandler('ml_camping:setcampfire', function()
if campfire ~= 0 then
        SetEntityAsMissionEntity(campfire)
        DeleteObject(campfire)
        campfire = 0
    end
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 30000, true, false, false, false)
    exports['progressBars']:startUI(30000, "Creating Camp")
    Citizen.Wait(30000)
    ClearPedTasksImmediately(PlayerPedId())
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
    local prop = CreateObject(GetHashKey("p_campfire02x"), x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)
    campfire = prop

end)

RegisterNetEvent('ml_camping:settent')
AddEventHandler('ml_camping:settent', function()
 if tent ~= 0 then
        SetEntityAsMissionEntity(tent)
        DeleteObject(tent)
        tent = 0
    end
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 30000, true, false, false, false)
    exports['progressBars']:startUI(30000, "Colocando tienda")
    Citizen.Wait(30000)
    ClearPedTasksImmediately(PlayerPedId())
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
    local prop = CreateObject(GetHashKey("mp005_s_posse_tent_bountyhunter07x"), x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)
    tent = prop

end)

RegisterNetEvent('ml_camping:setcauldron')
AddEventHandler('ml_camping:setcauldron', function()
if cauldron ~= 0 then
        SetEntityAsMissionEntity(cauldron)
        DeleteObject(cauldron)
        cauldron = 0
    end
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 30000, true, false, false, false)
    exports['progressBars']:startUI(30000, "Settting food pot")
    Citizen.Wait(30000)
    ClearPedTasksImmediately(PlayerPedId())
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
    local prop = CreateObject(GetHashKey("S_CAMPFIRECOMBINED01X"), x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)
    cauldron = prop

end)

RegisterNetEvent('ml_camping:sethitch')
AddEventHandler('ml_camping:sethitch', function()
if hitch ~= 0 then
        SetEntityAsMissionEntity(hitch)
        DeleteObject(hitch)
        hitch = 0
    end
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 30000, true, false, false, false)
    exports['progressBars']:startUI(30000, "setting hitch")
    Citizen.Wait(30000)
    ClearPedTasksImmediately(PlayerPedId())
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
    local prop = CreateObject(GetHashKey("P_HITCHINGPOST05X"), x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)
    hitch = prop

end)

RegisterNetEvent('ml_camping:settable')
AddEventHandler('ml_camping:settable', function()
if Table ~= 0 then
        SetEntityAsMissionEntity(Table)
        DeleteObject(Table)
        Table = 0
    end
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 30000, true, false, false, false)
    exports['progressBars']:startUI(30000, "Setting table")
    Citizen.Wait(30000)
    ClearPedTasksImmediately(PlayerPedId())
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
    local prop = CreateObject(GetHashKey("S_BFTABLE01X"), x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)
    Table = prop

end)

RegisterNetEvent('ml_camping:setchair')
AddEventHandler('ml_camping:setchair', function()
if chair ~= 0 then
        SetEntityAsMissionEntity(chair)
        DeleteObject(chair)
        chair = 0
    end
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 30000, true, false, false, false)
    exports['progressBars']:startUI(30000, "Setting Chair")
    Citizen.Wait(30000)
    ClearPedTasksImmediately(PlayerPedId())
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
    local prop = CreateObject(GetHashKey("P_WOODENCHAIR01X"), x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)
    chair = prop

end)

--deleting

RegisterNetEvent('ml_camping:delcampfire')
AddEventHandler('ml_camping:delcampfire', function()
if campfire == 0 then
        print("There is no campfire.")
    else
        SetEntityAsMissionEntity(campfire)
        DeleteObject(campfire)
        campfire = 0
    end

end)

RegisterNetEvent('ml_camping:deltent')
AddEventHandler('ml_camping:deltent', function()
if tent == 0 then
        print("There is no tent.")
    else
        SetEntityAsMissionEntity(tent)
        DeleteObject(tent)
        tent = 0
    end

end)

RegisterNetEvent('ml_camping:delcauldron')
AddEventHandler('ml_camping:delcauldron', function()
if cauldron == 0 then
        print("There is no cauldorn.")
    else
        SetEntityAsMissionEntity(cauldron)
        DeleteObject(cauldron)
        cauldron = 0
    end

end)

RegisterNetEvent('ml_camping:delhitch')
AddEventHandler('ml_camping:delhitch', function()
if hitch == 0 then
        print("There is no hitch.")
    else
        SetEntityAsMissionEntity(hitch)
        DeleteObject(hitch)
        hitch = 0
    end

end)

RegisterNetEvent('ml_camping:deltable')
AddEventHandler('ml_camping:deltable', function()
if Table == 0 then
        print("There is no table.")
    else
        SetEntityAsMissionEntity(Table)
        DeleteObject(Table)
        Table = 0
    end

end)

RegisterNetEvent('ml_camping:delchair')
AddEventHandler('ml_camping:delchair', function()
if chair == 0 then
        print("There is no chair.")
    else
        SetEntityAsMissionEntity(chair)
        DeleteObject(chair)
        chair = 0
    end

end)

-- deleting all

RegisterNetEvent('ml_camping:delfullcamp')
AddEventHandler('ml_camping:delfullcamp', function()

TriggerEvent("ml_camping:delcampfire")

Citizen.Wait(0)

TriggerEvent("ml_camping:deltent")

Citizen.Wait(0)

TriggerEvent("ml_camping:delcauldron")

Citizen.Wait(0)

TriggerEvent("ml_camping:delhitch")

Citizen.Wait(0)

TriggerEvent("ml_camping:deltable")

Citizen.Wait(0)

TriggerEvent("ml_camping:delchair")

end)