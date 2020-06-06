local keys = { ['G'] = 0x760A9C6F, ['S'] = 0xD27782E3, ['W'] = 0x8FD015D8, ['H'] = 0x24978A28, ['G'] = 0x5415BE48, ["ENTER"] = 0xC7B5340A, ['E'] = 0xDFF812F9 }



Citizen.CreateThread(function()
 WarMenu.CreateMenu('ShopWeapon', 'Gun Shop')
 WarMenu.CreateSubMenu('Vintovki', 'ShopWeapon', 'Rifle')
 WarMenu.CreateSubMenu('Shotgun', 'ShopWeapon', 'Shotgun')
WarMenu.CreateSubMenu('Revovlers', 'ShopWeapon', 'Revovlers')
 WarMenu.CreateSubMenu('Other', 'ShopWeapon', 'Other')
 WarMenu.CreateSubMenu('Ammo', 'ShopWeapon', 'Ammo')
 WarMenu.SetSubTitle('ShopWeapon', 'Weapon list')
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		if WarMenu.IsMenuOpened('ShopWeapon') then
			if WarMenu.MenuButton('Rifle', 'Vintovki') then end
			if WarMenu.MenuButton('Shotgun', 'Shotgun') then end
			if WarMenu.MenuButton('Revovlers', 'Revovlers') then end
			if WarMenu.MenuButton('Other', 'Other') then end
			if WarMenu.MenuButton('Ammo', 'Ammo') then end
			WarMenu.Display()
			elseif WarMenu.IsMenuOpened('Vintovki') then
			if WarMenu.Button('Varmint 20 $ level require [1]') then
				TriggerServerEvent('bberry:buyweapon', 20, 'WEAPON_RIFLE_VARMINT', 1)
				elseif WarMenu.Button('Bolt action rifle 50$ level require [10]') then
					TriggerServerEvent('bberry:buyweapon', 50, 'WEAPON_RIFLE_BOLTACTION', 10)
					ExecuteCommand("boltaction")
			end
				WarMenu.Display()
			elseif WarMenu.IsMenuOpened('Shotgun') then 
			if WarMenu.Button('Double barrel shotgun 30$ level require [3]') then
				TriggerServerEvent('bberry:buyweapon', 30, 'WEAPON_SHOTGUN_DOUBLEBARREL', 3)
				elseif WarMenu.Button('Sawed-off shotgun 30$ level require [2]') then
				TriggerServerEvent('bberry:buyweapon', 30, 'WEAPON_SHOTGUN_SAWEDOFF', 2)
				elseif WarMenu.Button('Pump shotgun 50$ level require [5]') then
				TriggerServerEvent('bberry:buyweapon', 50, 'WEAPON_SHOTGUN_PUMP', 5)
				elseif WarMenu.Button('Semi-automatic shotgun 60$ level require [12]') then
				TriggerServerEvent('bberry:buyweapon', 60, 'WEAPON_SHOTGUN_SEMIAUTO', 12)
				elseif WarMenu.Button('Repeater shotgun 80$ level require [8]') then
				TriggerServerEvent('bberry:buyweapon', 80, 'WEAPON_SHOTGUN_REPEATING', 8)
			end
			WarMenu.Display()
			elseif WarMenu.IsMenuOpened('Revovlers') then 
			if WarMenu.Button('Cattleman revovler 40$ level require [1]') then
				TriggerServerEvent('bberry:buyweapon', 40, 'WEAPON_REVOLVER_CATTLEMAN', 1)
				ExecuteCommand("cattleman")
			end
			WarMenu.Display()
				elseif WarMenu.IsMenuOpened('Other') then
					if WarMenu.Button('Fishing pole 10$ level require [1]') then
						TriggerServerEvent('bberry:buyweapon', 10, 'WEAPON_FISHINGROD', 1)
						ExecuteCommand("fishrod")
						elseif WarMenu.Button('Lasso 10$ level require [1]') then
						TriggerServerEvent('bberry:buyweapon', 10, 'WEAPON_LASSO', 1)
						ExecuteCommand("lasso")
						elseif WarMenu.Button('Hunting knife 10$ level require [1]') then
						TriggerServerEvent('bberry:buyweapon', 10, 'WEAPON_MELEE_KNIFE', 1)
						ExecuteCommand("hknife")
						elseif WarMenu.Button('Hunting bow 100$ level require [1]') then
						TriggerServerEvent('bberry:buyweapon', 100, 'WEAPON_BOW', 1)
						ExecuteCommand("hbow")
						elseif WarMenu.Button('Throwing knifes 20$ level require [3]') then
						TriggerServerEvent('bberry:buyweapon', 20, 'WEAPON_THROWN_THROWING_KNIVES', 3)
						elseif WarMenu.Button('Tomahawk 20$ level require [8]') then
						TriggerServerEvent('bberry:buyweapon', 20, 'WEAPON_THROWN_TOMAHAWK', 8)
						elseif WarMenu.Button('Dynamite 50$ level require [15]') then
						TriggerServerEvent('bberry:buyweapon', 50, 'WEAPON_THROWN_DYNAMITE', 15)
					end
						WarMenu.Display()
						elseif WarMenu.IsMenuOpened('Ammo') then
					if WarMenu.Button('Ammo for all type of weapons 40$') then
						TriggerServerEvent('bberry:buyammo', 40)
					end
				WarMenu.Display()
		end
	for k,v in pairs(Config.Coords) do
			if Vdist(coords, v) < 2 then
				DrawTxt(Config.Shoptext, 0.50, 0.95, 0.6, 0.6, true, 255, 255, 255, 255, true, 10000)
				if IsControlJustReleased(0, keys['G']) then
					WarMenu.OpenMenu('ShopWeapon')
				end
			end
		end
	end
end)


RegisterNetEvent('Message:cancel')	
AddEventHandler('Message:cancel', function()
local timer = 200
	while timer > 0 do
		Citizen.Wait(0)
		DrawTxt(Config.NoMoney, 0.50, 0.90, 0.6, 0.6, true, 161, 3, 0, 255, true, 10000)
		timer = timer - 1
	end
end)

RegisterNetEvent('Message:missinglevel')	
AddEventHandler('Message:missinglevel', function()
local timer = 200
	while timer > 0 do
		Citizen.Wait(0)
		DrawTxt(Config.LevelMissing, 0.50, 0.90, 0.6, 0.6, true, 161, 3, 0, 255, true, 10000)
		timer = timer - 1
	end
end)

RegisterNetEvent('give:weapon')
AddEventHandler('give:weapon', function(weapon)
    Citizen.CreateThread(function()
        local weapon = GetHashKey(weapon)
		local playerPed = PlayerPedId()
        Wait(1000)
		GiveDelayedWeaponToPed(playerPed, weapon, 100, true, 2)
    end)
end)

RegisterNetEvent('give:weaponammo')
AddEventHandler('give:weaponammo', function()
	Citizen.CreateThread(function()
		vintova = {
		'WEAPON_RIFLE_VARMINT',
		'WEAPON_RIFLE_BOLTACTION',
		'WEAPON_RIFLE_SPRINGFIELD',
		'WEAPON_SHOTGUN_DOUBLEBARREL',
		'WEAPON_SHOTGUN_SAWEDOFF',
		'WEAPON_SHOTGUN_PUMP',
		'WEAPON_SHOTGUN_SEMIAUTO',
		'WEAPON_SHOTGUN_REPEATING',
		'WEAPON_PISTOL_VOLCANIC',
		'WEAPON_PISTOL_SEMIAUTO',
		'WEAPON_PISTOL_MAUSER'
				}
		Wait(1000)
		for k,v in pairs(vintova) do
			local weapon = GetHashKey(v)
			SetPedAmmo(GetPlayerPed(), weapon, 100)
		end
    end)
end)

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
 local str = CreateVarString(10, "LITERAL_STRING", str, Citizen.ResultAsLong())
	SetTextScale(w, h)
	SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
	Citizen.InvokeNative(0xADA9255D, 10);
	DisplayText(str, x, y)
end

Citizen.CreateThread(function()
	Wait(0)
	for k,v in pairs(Config.Coords) do
		Citizen.InvokeNative(0x554d9d53f696d002, 1664425300, v)
	end
end)