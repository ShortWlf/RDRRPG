keys = {
    ['G'] = 0x760A9C6F,
    ['S'] = 0xD27782E3,
    ['W'] = 0x8FD015D8,
	['H'] = 0x24978A28,
	['G'] = 0x5415BE48,
	['E'] = 0xDFF812F9
}


local travelBlips = {
vector3(-174.39, 633.33, 114.09), -- valentine
vector3(1521.92, 439.09, 90.68), -- emerald ranch
vector3(2931.52, 1282.81, 44.64), -- annesburg
vector3(2747.10, -1394.87, 46.18), -- st denis
vector3(-2494.6, -2424.69, 60.6), -- macfarlane ranch
vector3(-1094.71, -575.26, 82.41), -- riggs station
vector3(1231.26, -1299.74, 76.9), -- rhodes
vector3(587.28, 1672.7, 187.77), -- baccus station
vector3(-6046.68, -3257.94, -14.31) -- gaptooth ridge
}

local actpos = nil
local pos2 = nil
local pos3 = nil
local pos4 = nil
local pos5 = nil
local intravel = 0

Citizen.CreateThread(function()
	Wait(100)
	for k,v in pairs(travelBlips) do
		Wait(0)
		local blip = Citizen.InvokeNative(0x554d9d53f696d002, 1664425300, v)
		SetBlipSprite(blip, 784218150)
		Citizen.InvokeNative(0x9CB1A1623062F402, blip, "Train Station")
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
	for k,v in pairs(travelBlips) do
			if Vdist(coords, v) < 2 then
				if (intravel ~= 1) then
				DrawTxt("Press [E] to open Fast Travel", 0.50, 0.95, 0.6, 0.6, true, 255, 255, 255, 255, true, 10000)
				else end
				if IsControlJustReleased(0, keys['E']) then
					--exports.progressBars:StartUI('test', 30)
					--TriggerServerEvent('amakuu_fasttravel:openMenu', source)
					openMenu()
					actpos = v
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
 WarMenu.CreateMenu('Travel', 'Fast Travel')
 while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		if WarMenu.IsMenuOpened('Travel') then
		WarMenu.Display()
			if WarMenu.Button('Valentine - 5$') then
			getCurrentPos()
			TriggerServerEvent('amakuu_fasttravel:buyTicket', vector3(-170.64,628.58,113.00), 5)
			WarMenu.CloseMenu()
			elseif WarMenu.Button('Emerald Ranch - 3$') then
			getCurrentPos()
			TriggerServerEvent('amakuu_fasttravel:buyTicket', vector3(1525.4,432.59,90.0), 3)
			WarMenu.CloseMenu()
			elseif WarMenu.Button('Annesburg - 8$') then
			getCurrentPos()
			TriggerServerEvent('amakuu_fasttravel:buyTicket', vector3(2945.21,1272.35,44.0), 8)
			WarMenu.CloseMenu()
			elseif WarMenu.Button('St. Denis - 15$') then
			getCurrentPos()
			TriggerServerEvent('amakuu_fasttravel:buyTicket', vector3(2688.77,-1459.11,46.0), 15)
			WarMenu.CloseMenu()
			elseif WarMenu.Button('Macfarlanes Ranch - 6$') then
			getCurrentPos()
			TriggerServerEvent('amakuu_fasttravel:buyTicket', vector3(-2493.89,-2434.62,60.6), 6)
			WarMenu.CloseMenu()
			elseif WarMenu.Button('Riggs Station - 4$') then
			getCurrentPos()
			TriggerServerEvent('amakuu_fasttravel:buyTicket', vector3(-1104.26,-572.26,82.0), 4)
			WarMenu.CloseMenu()
			elseif WarMenu.Button('Rhodes - 10$') then
			getCurrentPos()
			TriggerServerEvent('amakuu_fasttravel:buyTicket', vector3(1218.83,-1298.03,76.0), 10)
			WarMenu.CloseMenu()
			elseif WarMenu.Button('Bacchus Station - 17$') then
			getCurrentPos()
			TriggerServerEvent('amakuu_fasttravel:buyTicket', vector3(582.8,1685.29,187.67), 17)
			WarMenu.CloseMenu()
			elseif WarMenu.Button('Gaptooth Ridge - 25$') then
			getCurrentPos()
			TriggerServerEvent('amakuu_fasttravel:buyTicket', vector3(-6033.22,-3264.7,-20.0), 25)
			WarMenu.CloseMenu()
			end
			--WarMenu.Display()
			--WarMenu.Close()
			end
end
end)

function getCurrentPos()
if (actpos == travelBlips[1]) then --valentine
pos2 = vector3(-124.91,645.33,125.00)
pos3 = vector3(-200.11,568.23,125.51)
pos4 = vector3(-177.68,629.01,114.09)
pos5 = vector3(-235.1,315.47,119.25)
elseif (actpos == travelBlips[2]) then -- emerald ranch
pos2 = vector3(1540.73,463.03,95.0)
pos3 = vector3(1519.66,348.92,95.0)
pos4 = vector3(1522.27,435.29,90.68)
pos5 = vector3(1410.76,180.58,92.06)
elseif (actpos == travelBlips[3]) then -- annesburg
pos2 = vector3(2978.67, 1305.45, 50.0)
pos3 = vector3(2909.62, 1233.68, 50.0)
pos4 = vector3(2937.14, 1281.08, 50.0)
pos5 = vector3(2833.98, 1125.29, 50.0)
elseif (actpos == travelBlips[4]) then -- st.denis
pos2 = vector3(2778.77, -1458.37, 60.0)
pos3 = vector3(2574.64, -1480.20, 60.0)
pos4 = vector3(2694.07, -1451.91, 60.0)
pos5 = vector3(2443.74, -1472.85, 60.0)
elseif (actpos == travelBlips[5]) then -- macfarlane ranch
pos2 = vector3(-2530.57, -2402.56, 70.0)
pos3 = vector3(-2465.52, -2496.63, 70.0)
pos4 = vector3(-2492.42, -2423.8, 70.0)
pos5 = vector3(-2345.18, -2505.43, 70.0)
elseif (actpos == travelBlips[6]) then -- riggs station
pos2 = vector3(-1080.56, -602.13, 95.0)
pos3 = vector3(-1156.05, -534.0, 95.0)
pos4 = vector3(-1092.75, -569.76, 95.0)
pos5 = vector3(-1263.16, -434.89, 97.92)
elseif (actpos == travelBlips[7]) then -- rhodes
pos2 = vector3(1252.8, -1360.6, 85.0)
pos3 = vector3(1172.94, -1255.82, 85.0)
pos4 = vector3(1228.29, -1296.08, 85.0)
pos5 = vector3(1011.2, -975.43, 85.0)
elseif (actpos == travelBlips[8]) then -- bacchus station
pos2 = vector3(579.29, 1730.29, 200.0)
pos3 = vector3(635.92, 1628.5, 200.0)
pos4 = vector3(577.9, 1674.83, 200.0)
pos5 = vector3(736.75, 1576.9, 200.0)
elseif (actpos == travelBlips[9]) then -- gaptooth ridge
pos2 = vector3(-6050.63, -3293.34, -5.0)
pos3 = vector3(-5923.58, -3359.63, -5.0)
pos4 = vector3(-6043.67, -3255.48, -5.0)
pos5 = vector3(-5823.74, -3243.66, -5.0)
else end
end

RegisterNetEvent('amakuu_fasttravel:doTravel')
AddEventHandler('amakuu_fasttravel:doTravel', function(pos1)
local _pos1 = pos1
local ped = PlayerPedId()
	Citizen.CreateThread(function()
		Wait(0)
		intravel = 1
		cameraBars()
		DoScreenFadeOut(500)
		Wait(500)
		DoScreenFadeIn(500)
		PlaySoundFrontend("Gain_Point", "HUD_MP_PITP", true, 1)
		cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", pos2, 300.00,0.00,0.00, 70.00, false, 0)
		PointCamAtCoord(cam, pos4)
		SetCamActive(cam, true)
		RenderScriptCams(true, false, 1, true, true)
		Wait(1000)
		cam2 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", pos3, 300.00,0.00,0.00, 70.00, false, 0)
		PointCamAtCoord(cam2, pos5)
		SetCamActiveWithInterp(cam2, cam, 5700, true, true)
		Wait(4500)
		DoScreenFadeOut(2000)
		Wait(2000)
		SetEntityCoords(ped, _pos1)
		intravel = 0
		DoScreenFadeIn(2000)
		SetCamActive(cam, false)
		SetCamActive(cam2, false)
		DestroyAllCams()
	end)
end)

function cameraBars()
	Citizen.CreateThread(function()
		while intravel == 1 do
			Wait(0)
			N_0xe296208c273bd7f0(-1, -1, 0, 17, 0, 0)
		end
	end)
end

RegisterNetEvent('amakuu_fasttravel:noMoney')
AddEventHandler('amakuu_fasttravel:noMoney', function()
PlaySoundFrontend("HP_HORSE", "HUD_MP_FREE_MODE", true, 1)
TriggerEvent("redemrp_notification:start", "You don't have enough money!", 2, "error")
end)

function openMenu()
WarMenu.OpenMenu('Travel')
end

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
 local str = CreateVarString(10, "LITERAL_STRING", str, Citizen.ResultAsLong())
	SetTextScale(w, h)
	SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
	Citizen.InvokeNative(0xADA9255D, 10);
	DisplayText(str, x, y)
end
