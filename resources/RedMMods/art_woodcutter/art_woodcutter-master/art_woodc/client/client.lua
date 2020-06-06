local dinero = math.random(Config.money['min'], Config.money['max'])
local xp = math.random(Config.xp['min'], Config.xp['max'])
local PrimeraMina = false
local Mina1 = false
local Arbol1, Arbol2, Arbol3, Arbol4 = nil, nil, nil, nil
local Mina2 = false
local Mina3 = false
local Mina4 = false
local FinMina = false
local Entrega = false
local EntregaFinal = false
local blipname = "WoodC"

Citizen.CreateThread(function()
    local blip = Citizen.InvokeNative(0x554d9d53f696d002, -592068833, Config.Zonas['init'].x, Config.Zonas['init'].y, Config.Zonas['init'].z)
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)
        local pos = GetEntityCoords(PlayerPedId())
        Citizen.InvokeNative(0x2A32FAA57B937173, -1795314153, Config.Zonas['init'].x, Config.Zonas['init'].y, Config.Zonas['init'].z - 1.0, 0, 0, 0, 0, 0, 0, 3.5, 3.5, 0.9, 18, 255, 1, 155, 0, 0, 2, 0, 0, 0, 0)

        if (Vdist(pos.x, pos.y, pos.z, Config.Zonas['init'].x, Config.Zonas['init'].y, Config.Zonas['init'].z) < 3.0) then
            if Mina1 == false then
                DrawTxt(Language.translate[Config.lang]['press'], 0.3, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
                if IsControlJustPressed(0, 0xC7B5340A) then
                    TriggerServerEvent('art_woodcutter:comjob')
                end
            end
        end
        if PrimeraMina == true then
            Citizen.InvokeNative(0x2A32FAA57B937173, -1795314153, Config.Zonas['Miner1'].x, Config.Zonas['Miner1'].y, Config.Zonas['Miner1'].z - 1.0, 0, 0, 0, 0, 0, 0, 3.0, 3.0, 1.5, 255, 255, 0, 155, 0, 0, 2, 0, 0, 0, 0)
            if (Vdist(pos.x, pos.y, pos.z, Config.Zonas['Miner1'].x, Config.Zonas['Miner1'].y, Config.Zonas['Miner1'].z) < 3.0) then
                DrawTxt(Language.translate[Config.lang]['press'], 0.3, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
                if IsControlJustPressed(0, 0xC7B5340A) then
                    animacion()
                    animacion3(Arbol1) -- aqui la he liado seguro
                    TriggerEvent("redemrp_notification:start", Language.translate[Config.lang]['goto'], 5)
					RemoveBlip(blip)
					blip2 = Citizen.InvokeNative(0x554d9d53f696d002, 203020899, Config.Zonas['Miner2'].x, Config.Zonas['Miner2'].y, Config.Zonas['Miner2'].z)
                    SetBlipSprite(blip2, -570710357, 1)
					PrimeraMina = false
                    Mina2 = true
                end
            end
        elseif Mina2 == true then
            Citizen.InvokeNative(0x2A32FAA57B937173, -1795314153, Config.Zonas['Miner2'].x, Config.Zonas['Miner2'].y, Config.Zonas['Miner2'].z - 1.0, 0, 0, 0, 0, 0, 0, 3.0, 3.0, 1.5, 255, 255, 0, 155, 0, 0, 2, 0, 0, 0, 0)
            if (Vdist(pos.x, pos.y, pos.z, Config.Zonas['Miner2'].x, Config.Zonas['Miner2'].y, Config.Zonas['Miner2'].z) < 3.0) then
                DrawTxt(Language.translate[Config.lang]['press'], 0.3, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
                if IsControlJustPressed(0, 0xC7B5340A) then
                    animacion()
                    animacion3(Arbol2)
                    TriggerEvent("redemrp_notification:start", Language.translate[Config.lang]['goto'], 5)
                    RemoveBlip(blip2)
                    blip3 = Citizen.InvokeNative(0x554d9d53f696d002, 203020899, Config.Zonas['Miner3'].x, Config.Zonas['Miner3'].y, Config.Zonas['Miner3'].z)
                    SetBlipSprite(blip3, -570710357, 1)
                    Mina2 = false
                    Mina3 = true
                end
            end
        elseif Mina3 == true then
            Citizen.InvokeNative(0x2A32FAA57B937173, -1795314153, Config.Zonas['Miner3'].x, Config.Zonas['Miner3'].y, Config.Zonas['Miner3'].z - 1.0, 0, 0, 0, 0, 0, 0, 3.0, 3.0, 1.5, 255, 255, 0, 155, 0, 0, 2, 0, 0, 0, 0)
            if (Vdist(pos.x, pos.y, pos.z, Config.Zonas['Miner3'].x, Config.Zonas['Miner3'].y, Config.Zonas['Miner3'].z) < 3.0) then
                DrawTxt(Language.translate[Config.lang]['press'], 0.3, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
                if IsControlJustPressed(0, 0xC7B5340A) then
                    animacion()
                    animacion3(Arbol3)
                    TriggerEvent("redemrp_notification:start", Language.translate[Config.lang]['goto'], 5)
                    RemoveBlip(blip3)
                    blip4 = Citizen.InvokeNative(0x554d9d53f696d002, 203020899, Config.Zonas['Miner4'].x, Config.Zonas['Miner4'].y, Config.Zonas['Miner4'].z)
                    SetBlipSprite(blip4, -570710357, 1)
                    Mina3 = false
                    Mina4 = true
                end
            end
        elseif Mina4 == true then
            Citizen.InvokeNative(0x2A32FAA57B937173, -1795314153, Config.Zonas['Miner4'].x, Config.Zonas['Miner4'].y, Config.Zonas['Miner4'].z - 1.0, 0, 0, 0, 0, 0, 0, 3.0, 3.0, 1.5, 255, 255, 0, 155, 0, 0, 2, 0, 0, 0, 0)
            if (Vdist(pos.x, pos.y, pos.z, Config.Zonas['Miner4'].x, Config.Zonas['Miner4'].y, Config.Zonas['Miner4'].z) < 3.0) then
                DrawTxt(Language.translate[Config.lang]['press'], 0.3, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
                if IsControlJustPressed(0, 0xC7B5340A) then
                    animacion()
                    animacion3(Arbol4)
                    TriggerEvent("redemrp_notification:start", Language.translate[Config.lang]['load'], 5)
                    RemoveBlip(blip4)
                    blip5 = Citizen.InvokeNative(0x554d9d53f696d002, 203020899, Config.Zonas['Vehicle'].x, Config.Zonas['Vehicle'].y, Config.Zonas['Vehicle'].z)
                    SetBlipSprite(blip5, -570710357, 1)
                    TriggerEvent('art_woodcutter:rutafinal')
                    Mina4 = false
                    FinMina = true
                end
            end
        elseif FinMina == true then
            if (Vdist(pos.x, pos.y, pos.z, Config.Zonas['Vehicle'].x, Config.Zonas['Vehicle'].y, Config.Zonas['Vehicle'].z) < 3.0) then
                DrawTxt(Language.translate[Config.lang]['pressc'], 0.3, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
                if IsControlJustPressed(0, 0xC7B5340A) then
                    animacion2()
                    TriggerEvent("redemrp_notification:start", Language.translate[Config.lang]['carry'], 5)
                    RemoveBlip(blip5)
                    blip6 = Citizen.InvokeNative(0x554d9d53f696d002, 203020899, Config.Zonas['Entrega'].x, Config.Zonas['Entrega'].y, Config.Zonas['Entrega'].z)
                    SetBlipSprite(blip6, -570710357, 1)
                    FinMina = false
                    Entrega = true
                    TriggerEvent('art_woodcutter:comcrono')
                end
            end
        elseif Entrega == true then
            Citizen.InvokeNative(0x2A32FAA57B937173, -1795314153, Config.Zonas['Entrega'].x, Config.Zonas['Entrega'].y, Config.Zonas['Entrega'].z - 1.0, 0, 0, 0, 0, 0, 0, 4.0, 4.0, 1.5, 255, 23, 23, 155, 0, 0, 2, 0, 0, 0, 0)
            if (Vdist(pos.x, pos.y, pos.z, Config.Zonas['Entrega'].x, Config.Zonas['Entrega'].y, Config.Zonas['Entrega'].z) < 3.0) then
                DrawTxt(Language.translate[Config.lang]['pressf'], 0.3, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
                if IsControlJustPressed(0, 0xC7B5340A) then
                    if IsPedInAnyVehicle(PlayerPedId(), true) then
                        DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
                        TriggerEvent("redemrp_notification:start", Language.translate[Config.lang]['completejob'] ..dinero.."$ | "..xp.."XP", 5)
						RemoveBlip(blip6)
						TriggerServerEvent('art_woodcutter:cobrar', dinero, xp)
                        Entrega = false
                        Mina1 = false
                        ClearGpsMultiRoute()
                    else
                        TriggerEvent("redemrp_notification:start", Language.translate[Config.lang]['noveh'], 5)
                    end
                end
            end
        end
    end
end)

RegisterNetEvent('art_woodcutter:rutafinal')
AddEventHandler('art_woodcutter:rutafinal', function()
	Citizen.Wait(0)

	local jugador = PlayerPedId()
	local vehiculo = GetHashKey(Config.Vehiculo)
	RequestModel(vehiculo)

	while not HasModelLoaded(vehiculo) do
		Citizen.Wait(0)
	end

	spawncar = CreateVehicle(vehiculo, Config.Zonas['Vehicle'].x, Config.Zonas['Vehicle'].y, Config.Zonas['Vehicle'].z, Config.Zonas['Vehicle'].heading, true, false)
	SetVehicleOnGroundProperly(spawncar)
    SetModelAsNoLongerNeeded(vehiculo)

    StartGpsMultiRoute(6, true, true)
        
    -- Add the points
    AddPointToGpsMultiRoute(Config.Zonas['Entrega'].x, Config.Zonas['Entrega'].y, Config.Zonas['Entrega'].z)
    AddPointToGpsMultiRoute(Config.Zonas['Entrega'].x, Config.Zonas['Entrega'].y, Config.Zonas['Entrega'].z)

    -- Set the route to render
    SetGpsMultiRouteRender(true)
    
    
end)

RegisterNetEvent('art_woodcutter:comienzo')
AddEventHandler('art_woodcutter:comienzo', function(source)
    blip = Citizen.InvokeNative(0x554d9d53f696d002, 203020899, Config.Zonas['Miner1'].x, Config.Zonas['Miner1'].y, Config.Zonas['Miner1'].z)
    SetBlipSprite(blip, -570710357, 1)
    PrimeraMina = true
    Mina1 = true
    SpawnearArboles("p_tree_pine_ponderosa_06") -- Spawneo de arboles al empezar
end)

RegisterNetEvent('art_woodcutter:comcrono')
AddEventHandler('art_woodcutter:comcrono', function()
	local timer = 210

	Citizen.CreateThread(function()
		while timer > 0 and Entrega do
			Citizen.Wait(1000)

			if timer > 0 then
				timer = timer - 1
			end
		end
	end)

	Citizen.CreateThread(function()
		while Entrega do
			Citizen.Wait(0)
			DrawTxt(Language.translate[Config.lang]['temp']..timer..Language.translate[Config.lang]['seconds'], 0.4, 0.92, 0.4, 0.4, true, 255, 255, 255, 150, false)
            if timer < 1 then
                TriggerEvent("redemrp_notification:start", Language.translate[Config.lang]['lose'], 5)
				Mina1, Mina2, Mina3, Mina4, FinMina, Entrega, PrimeraMina = false, false, false, false, false, false, false
				DeleteVehicle(spawncar)
				RemoveBlip(blip6)
                SetEntityCoords(PlayerPedId(), Config.Zonas['Vehicle'].x, Config.Zonas['Vehicle'].y, Config.Zonas['Vehicle'].z)
			end
		end
	end)
end)

function animacion()

    local playerPed = PlayerPedId()
    local prop_name = 'p_axe02x'
    local x,y,z = table.unpack(GetEntityCoords(playerPed))
    local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
    local boneIndex = GetEntityBoneIndexByName(playerPed, "SKEL_R_Finger12")

    RequestAnimDict("amb_work@world_human_tree_chop@male_a@idle_b")
    while not HasAnimDictLoaded("amb_work@world_human_tree_chop@male_a@idle_b") do
        Citizen.Wait(100)
    end
    TaskPlayAnim(playerPed, "amb_work@world_human_tree_chop@male_a@idle_b", "idle_f", 8.0, -8.0, 10000, 0, 0, true, 0, false, 0, false)
    AttachEntityToEntity(prop, playerPed,boneIndex, 0.200, -0.0, 0.5010, 1.024, -160.0, -70.0, true, true, false, true, 1, true)

    exports['progressBars']:startUI(10000, Language.translate[Config.lang]['mining'])
    Wait(10000)
    ClearPedSecondaryTask(playerPed)
    DeleteObject(prop)
end

function animacion2()
    TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('PROP_HUMAN_SACK_STORAGE_IN'), 7000, true, false, false, false)
    exports['progressBars']:startUI(7000, Language.translate[Config.lang]['placing'])
    Wait(7000)
    ClearPedTasksImmediately(PlayerPedId())
end

function animacion3(object)
    local rot = 1.01
    while true do
        Wait(10)
        rot = rot + 1
        SetEntityRotation(object, rot, 0.0, 0.0, 1, true)
        if(rot >= 90) then
            break
        end

    end
    DeleteObject(object)
end

function SpawnearArboles(hash)
    local obj = GetHashKey(hash)
    Wait(500)
    RequestModel(obj)
    if not HasModelLoaded(obj) then 
        RequestModel(obj) 
    end

    while not HasModelLoaded(obj) do 
        Citizen.Wait(1) 
    end

    Arbol1 = CreateObject(obj, Config.Zonas['Miner1'].x, Config.Zonas['Miner1'].y, Config.Zonas['Miner1'].z +1.0, true, true, true)
    Arbol2 = CreateObject(obj, Config.Zonas['Miner2'].x, Config.Zonas['Miner2'].y, Config.Zonas['Miner2'].z +1.0, true, true, true)
    Arbol3 = CreateObject(obj, Config.Zonas['Miner3'].x, Config.Zonas['Miner3'].y, Config.Zonas['Miner3'].z +1.0, true, true, true)
    Arbol4 = CreateObject(obj, Config.Zonas['Miner4'].x, Config.Zonas['Miner4'].y, Config.Zonas['Miner4'].z +1.0, true, true, true)
    PlaceObjectOnGroundProperly(Arbol1)
    PlaceObjectOnGroundProperly(Arbol2)
    PlaceObjectOnGroundProperly(Arbol3)
    PlaceObjectOnGroundProperly(Arbol4)
    SetEntityAsMissionEntity(Arbol1, true)
    SetEntityAsMissionEntity(Arbol2, true)
    SetEntityAsMissionEntity(Arbol3, true)
    SetEntityAsMissionEntity(Arbol4, true)
--[[
    while true do
        Wait(10)
        rot = rot + 1
        SetEntityRotation(object, rot, 0.0, 0.0, 1, true)
        print(GetEntityRotation(object))
        if(rot >= 90) then
            break
        end
    end

    DeleteObject(object)
    ]]--

end

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)


    --Citizen.InvokeNative(0x66E0276CC5F6B9DA, 2)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
	Citizen.InvokeNative(0xADA9255D, 1);
    DisplayText(str, x, y)
end

function CreateVarString(p0, p1, variadic)
    return Citizen.InvokeNative(0xFA925AC00EB830B9, p0, p1, variadic, Citizen.ResultAsLong())
end