local keys = { ['G'] = 0x760A9C6F, ['S'] = 0xD27782E3, ['W'] = 0x8FD015D8, ['H'] = 0x24978A28, ['G'] = 0x5415BE48, ["ENTER"] = 0xC7B5340A, ['E'] = 0xDFF812F9 }

local pressTime = 0
local pressLeft = 0

local recentlySpawned = 0

local boatModel;
local boatSpawn = {}
local NumberboatSpawn = 0

--Config Boats Here

local boates = {
	    [1] = {
		['Text'] = "[$15] Row Boat",
		['SubText'] = "",
		['Desc'] = "",
		['Param'] = {
			['Price'] = 15,
			['Model'] = "rowboatSwamp02",
			['Level'] = 1
		}
	},
		[2] = {
		['Text'] = "[$10] Regular Canoe",
		['SubText'] = "",
		['Desc'] = "",
		['Param'] = {
			['Price'] = 10,
			['Model'] = "CANOE",
			['Level'] = 1
		}
	},

		[3] = {
		['Text'] = "[$8] Pirogue Boat",
		['SubText'] = "",
		['Desc'] = "level require [5]",
		['Param'] = {
			['Price'] = 8,
			['Model'] = "PIROGUE",
			['Level'] = 5
		}
	},

	    [4] = {
		['Text'] = "[$5] Tree Trunk Canoe",
		['SubText'] = "",
		['Desc'] = "level require [2]",
		['Param'] = {
			['Price'] = 5,
			['Model'] = "CANOETREETRUNK",
			['Level'] = 2
		}
	}

}
local function IsNearZone ( location )

	local player = PlayerPedId()
	local playerloc = GetEntityCoords(player, 0)

	for i=1,#location do
		if #(playerloc - location[i]) < 3.0 then
			return true
		end
	end

end

local function DisplayHelp( _message, x, y, w, h, enableShadow, col1, col2, col3, a, centre )

	local str = CreateVarString(10, "LITERAL_STRING", _message, Citizen.ResultAsLong())

	SetTextScale(w, h)
	SetTextColor(col1, col2, col3, a)

	SetTextCentre(centre)

	if enableShadow then
		SetTextDropshadow(1, 0, 0, 0, 255)
	end

	Citizen.InvokeNative(0xADA9255D, 10);

	DisplayText(str, x, y)

end

local function ShowNotification( _message )
	local timer = 200
	while timer > 0 do
		DisplayHelp(_message, 0.50, 0.90, 0.6, 0.6, true, 161, 3, 0, 255, true, 10000)
		timer = timer - 1
		Citizen.Wait(0)
	end
end

Citizen.CreateThread( function()
	WarMenu.CreateMenu('id_boat', 'Shop boates')
	while true do
		if WarMenu.IsMenuOpened('id_boat') then
			for i = 1, #boates do
				if WarMenu.Button(boates[i]['Text'], boates[i]['SubText']) then
					TriggerServerEvent('elrp:buyboat', boates[i]['Param']) 
			end
			end
			WarMenu.Display()
		end
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do

		if IsNearZone( Config.Coords ) then
			DisplayHelp(Config.Shoptext, 0.50, 0.95, 0.6, 0.6, true, 255, 255, 255, 255, true, 10000)
			if IsControlJustReleased(0, keys['E']) then
				WarMenu.OpenMenu('id_boat')
			end
		end

		Citizen.Wait(0)
	end
end)

-- | Blips | --

Citizen.CreateThread(function()
	CreateBlips ( )
end)

-- | Notification | --

RegisterNetEvent('UI:DrawNotification')
AddEventHandler('UI:DrawNotification', function( _message )
	ShowNotification( _message )
end)

-- | Spawn boat | --

RegisterNetEvent( 'elrp:spawnBoat' )
AddEventHandler( 'elrp:spawnBoat', function ( boat )

	local player = PlayerPedId()

	local model = GetHashKey( boat )
	local x,y,z = table.unpack( GetOffsetFromEntityInWorldCoords( player, 0.0, 4.0, 0.5 ) )

	local heading = GetEntityHeading( player ) + 90

	local oldIdOfTheboat = idOfTheboat
	
	local idOfTheboat = NumberboatSpawn + 1

	RequestModel( model )

	while not HasModelLoaded( model ) do
		Wait(500)
	end

	if ( boatSpawn[idOfTheboat] ~= oldIdOfTheboat ) then
		DeleteEntity( boatSpawn[idOfTheboat].model )
	end

	boatModel = CreateVehicle( model, x, y, z, heading, 1, 1 )

	SET_PED_DEFAULT_OUTFIT (boatModel)
	Citizen.InvokeNative(0x23f74c2fda6e7c61, -1230993421, boatModel)
	
	boatSpawn[idOfTheboat] = { id = idOfTheboat, model = boatModel }

end )


function SET_PED_DEFAULT_OUTFIT ( boat )
	return Citizen.InvokeNative(0xAF35D0D2583051B0, boat, true )
end



-- | Timer | --

RegisterCommand("dropboat", function(source, args, raw)
    if recentlySpawned <= 0 then
				recentlySpawned = 10
				TriggerServerEvent('elrp:dropboat')
			else
				TriggerEvent('chat:systemMessage', 'Please wait ' .. recentlySpawned .. ' seconds before dropping your boat.')
				TriggerEvent('chat:addMessage', {
					color = { 171, 59, 36 },
					multiline = true,
					args = {"Anti-Spam", 'Please wait ' .. recentlySpawned .. ' seconds before dropping your boat.'}
				})
			end
   end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
		if recentlySpawned > 0 then
			recentlySpawned = recentlySpawned - 1
		end
    end
end)
