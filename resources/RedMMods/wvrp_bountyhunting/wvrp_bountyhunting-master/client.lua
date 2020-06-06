local starting = false
local already = false
local createdped = {}
local count = {}
local pressing = false

function missionstart()
							
	starting = true
	animals = {
	{hash = 0xF90FDED2, x = 489.53, y = 619.81, z = 111.7, true, true}
			  }
			  
	for k,item in pairs(animals) do
		createdped[k] = CreatePed(item.hash, item.x, item.y, item.z, true, true)
		Citizen.InvokeNative(0x283978A15512B2FE, createdped[k], true)
		Citizen.InvokeNative(0x23f74c2fda6e7c61, 953018525, createdped[k])
		count[k] = (createdped[k])
	end

	Citizen.CreateThread(function()
		local x = #animals
			while starting == true do
			Citizen.Wait(0)
			for k,v in pairs(createdped) do
					if IsEntityDead(v) then
						if count[k] ~= nil then
							x = x - 1
							count[k] = nil
							if x == 0 then
							TriggerServerEvent('wvrp_bountyhunting:AddSomeMoney')
							Citizen.InvokeNative(0x4AD96EF928BD4F9A, hash)
							stopmission()
						end
					end
				end
			end
		end
	end)
end

function stopmission()
	pressing = false
	starting = false
	already = false
end

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
	Citizen.InvokeNative(0xADA9255D, 1);
    DisplayText(str, x, y)
end

function startdialog()
	Citizen.CreateThread(function()
	  local timetocheck = 600
		while timetocheck >= 0  do
			Citizen.Wait(0)
			DrawTxt(Config.KillingMessage, 0.50, 0.90, 0.7, 0.7, true, 255, 255, 255, 255, true)
			timetocheck = timetocheck - 1
		end
	end)
end

function startscenario()
	DoScreenFadeOut(1000)
	Wait(1000)
	DoScreenFadeIn(1000)
	gameplaycam = GetRenderingCam()
	cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -1850.33, -901.9, 147.78, 300.00,0.00,0.00, 100.00, false, 0)
	DoesCamExist(cam)
	SetCamCoord(cam, -1850.33, -901.9, 147.78)
	PointCamAtCoord(cam, -1875.75, -912.91, 137.91)
	RenderScriptCams(true, false, 1, true, true)
	SetCamActive(cam, true)
	startdialog()
	Wait(10000)
	SetCamCoord(cam,GetGameplayCamCoord())
	SetCamRot(cam, GetGameplayCamRot(2), 2)
	RenderScriptCams( 1, 1, 0, 0, 0)
	RenderScriptCams( 0, 1, 1000, 0, 0)
	SetCamActive(gameplaycam, true)
	SetCamActive(cam, false)
	DestroyCam(cam, true)
	DisplayHud(true)
	DisplayRadar(true)
end

Citizen.CreateThread(function()
    while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local betweencoords = GetDistanceBetweenCoords(coords, -276.08, 805.28, 119.38, true)
		if betweencoords < 2.0 and not already then
			DrawTxt(Config.HuntingMessage, 0.50, 0.90, 0.7, 0.7, true, 255, 255, 255, 255, true)
			if IsControlJustPressed(2, 0xCEFD9220) and not pressing then
				pressing = true
				GiveWeaponToPed_2(playerPed, 0x772C8DD6, 10, true, true, 1, false, 0.5, 1.0, 1.0, true, 0, 0)
				SetPedAmmo(playerPed, 0x772C8DD6, 10)
				missionstart()
				already = true
				startscenario()
			end
		end
	end
end)



