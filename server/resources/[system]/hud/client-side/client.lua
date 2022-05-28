-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPS = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("hud",cRP)
vSERVER = Tunnel.getInterface("hud")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Compass = true
local showHud = false
local clientStress = 0
local showMovie = false
local pauseBreak = false
local clientHunger = 100
local clientThirst = 100
local homeInterior = false
local playerActive = false
local updateFoods = GetGameTimer()
local wantedTimer = GetGameTimer()
local reposeTimer = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- NITRO
-----------------------------------------------------------------------------------------------------------------------------------------
local nitro = {}
local nitroFuel = 0
local nitroFlame = false
local nitroActive = false
local nitroButton = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIGHTTRAILS
-----------------------------------------------------------------------------------------------------------------------------------------
local LightTrails = {}
local LightParticles = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PURGESPRAYS
-----------------------------------------------------------------------------------------------------------------------------------------
local PurgeSprays = {}
local PurgeParticles = {}
local sprayActive = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEATBELT
-----------------------------------------------------------------------------------------------------------------------------------------
local beltSpeed = 0
local beltLock = false
local beltVelocity = vector3(0,0,0)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DIVINABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local divingMask = nil
local divingTank = nil
local clientOxigen = 100
local divingTimers = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEAPONABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Weapon = ""
local lastMax = -1
local lastMin = -1
local WeaponActive = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOCKVARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local clockHours = 13
local clockMinutes = 0
local weatherSync = "CLEAR"
local timeDate = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- MUMBLABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Mumble = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- MUMBLECONNECTED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("mumbleConnected",function()
	if not Mumble then
		SendNUIMessage({ mumble = false })
		Mumble = true
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MUMBLEDISCONNECTED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("mumbleDisconnected",function()
	if Mumble then
		SendNUIMessage({ mumble = true })
		Mumble = false
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:PLATENITRO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:plateNitro")
AddEventHandler("hud:plateNitro",function(vehPlate,status)
	nitro[vehPlate] = parseInt(status)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:ALLNITRO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:allNitro")
AddEventHandler("hud:allNitro",function(vehNitro)
	nitro = vehNitro
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:WANTEDCLIENT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:wantedClient")
AddEventHandler("hud:wantedClient",function(Seconds)
	wantedTimer = GetGameTimer() + (Seconds * 1000)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:REPOSECLIENT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:reposeClient")
AddEventHandler("hud:reposeClient",function(Seconds)
	reposeTimer = GetGameTimer() + (Seconds * 1000)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP:PLAYERACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp:playerActive")
AddEventHandler("vrp:playerActive",function(user_id)
	playerActive = true
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADCIRCLE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	DisplayRadar(false)

	RequestStreamedTextureDict("circlemap",false)
	while not HasStreamedTextureDictLoaded("circlemap") do
		Citizen.Wait(100)
	end

	AddReplaceTexture("platform:/textures/graphics","radarmasksm","circlemap","radarmasksm")

	SetMinimapClipType(1)
	SetMinimapComponentPosition("minimap","L","B",0.009,-0.0125,0.16,0.28)
	SetMinimapComponentPosition("minimap_mask","L","B",0.155,0.12,0.080,0.15)
	SetMinimapComponentPosition("minimap_blur","L","B",0.0095,0.015,0.229,0.311)

	SetBigmapActive(true,false)

	Citizen.Wait(5000)

	SetBigmapActive(false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADGLOBAL
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	DisplayRadar(false)
	
	while true do
		if playerActive then
			if divingMask ~= nil then
				if GetGameTimer() >= divingTimers then
					SendNUIMessage({ oxigen = clientOxigen - 1, oxigenShow = divingMask })
					divingTimers = GetGameTimer() + 30000
					clientOxigen = clientOxigen - 1
					vRPS.clientOxigen()

					if clientOxigen <= 0 then
						local ped = PlayerPedId()
						local health = GetEntityHealth(ped)
					
						SetEntityHealth(ped,health - 50)
					end
				end
			end
		end

		Citizen.Wait(5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADFOODS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if playerActive then
			local ped = PlayerPedId()
			if GetGameTimer() >= updateFoods and GetEntityHealth(ped) > 101 then
				SendNUIMessage({ thirst = clientThirst - 1 })
				SendNUIMessage({ hunger = clientHunger - 1 })
				updateFoods = GetGameTimer() + 90000
				clientThirst = clientThirst - 1
				clientHunger = clientHunger - 1
				vRPS.clientFoods()
			end
		end

		Citizen.Wait(30000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADGLOBAL
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if GetGameTimer() >= timeDate then
			timeDate = GetGameTimer() + 10000
			clockMinutes = clockMinutes + 1

			if clockMinutes >= 60 then
				clockHours = clockHours + 1
				clockMinutes = 0

				if clockHours >= 24 then
					clockHours = 0
				end
			end
		end

		Citizen.Wait(10000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if homeInterior then
			SetWeatherTypeNow("CLEAR")
			SetWeatherTypePersist("CLEAR")
			SetWeatherTypeNowPersist("CLEAR")
			NetworkOverrideClockTime(00,00,00)
		else
			SetWeatherTypeNow(weatherSync)
			SetWeatherTypePersist(weatherSync)
			SetWeatherTypeNowPersist(weatherSync)
			NetworkOverrideClockTime(clockHours,clockMinutes,00)
		end

		Citizen.Wait(1)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- USERTALKING
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("hud:userTalking",function(status)
	talking = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROGRESS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Progress")
AddEventHandler("Progress",function(progressTimer)
	SendNUIMessage({ progress = true, progressTimer = progressTimer })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHUD
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		if playerActive then
			if IsPauseMenuActive() then
				SendNUIMessage({ hud = false })
				pauseBreak = true
			else
				if showHud then
					if pauseBreak then
						SendNUIMessage({ hud = true })
						pauseBreak = false
						displayHud()
					else
						displayHud()

						local ped = PlayerPedId()
						if IsPedInAnyVehicle(ped) then
							timeDistance = 500
						end
					end
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISPLAYHUD
-----------------------------------------------------------------------------------------------------------------------------------------
function displayHud()
	local pid = PlayerId()
	local ped = PlayerPedId()
	local Armour = GetPedArmour(ped)
	local Health = GetEntityHealth(ped)
	local Coords = GetEntityCoords(ped)
	local streetHash = GetStreetNameAtCoord(Coords["x"],Coords["y"],Coords["z"])
	local streetName = GetStreetNameFromHashKey(streetHash)
	local Gadget = HasPedGotWeapon(ped,-72657034,false)

	if IsPedInAnyVehicle(ped) then
		if not IsMinimapRendering() then
			DisplayRadar(true)
		end

		local Vehicle = GetVehiclePedIsUsing(ped)
		local Fuel = GetVehicleFuelLevel(Vehicle)
		local Rotation = GetEntityHeading(Vehicle)
		local Gear = GetVehicleCurrentGear(Vehicle)
		local Plate = GetVehicleNumberPlateText(Vehicle)
		local Locked = GetVehicleDoorLockStatus(Vehicle)
		local Speed = GetEntitySpeed(Vehicle) * 3.6
		
		if (Speed == 0 and Gear == 0) or (Speed == 0 and Gear == 1) then
			Gear = "N"
		elseif (Speed > 0 and Gear == 0) then
			Gear = "R"
		end

		local nitroShow = 0
		if nitroActives then
			nitroShow = nitro[Plate]
		else
			nitroShow = nitro[Plate] or 0
		end

		SendNUIMessage({ vehicle = true, timer = GetGameTimer(), wanted = wantedTimer, repose = reposeTimer, talking = MumbleIsPlayerTalking(pid), nitro = nitroShow, health = Health, armour = Armour, street = streetName, fuel = Fuel, speed = Speed, belt = beltLock, locked = Locked, rotation = Rotation, gear = Gear, parachute = Gadget })
	else
		if IsMinimapRendering() then
			DisplayRadar(false)
		end

		SendNUIMessage({ vehicle = false, timer = GetGameTimer(), wanted = wantedTimer, repose = reposeTimer, talking = MumbleIsPlayerTalking(pid), health = Health, armour = Armour, street = streetName, parachute = Gadget })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("hud",function(source,args,rawCommand)
	if exports["chat"]:statusChat() and MumbleIsConnected() then
		showHud = not showHud

		displayHud()
		SendNUIMessage({ hud = showHud, vehicle = IsPedInAnyVehicle(PlayerPedId()) })

		if IsMinimapRendering() and not showHud then
			DisplayRadar(false)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMPASS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("compass",function(source,args,rawCommand)
	if exports["chat"]:statusChat() and MumbleIsConnected() then
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			Compass = not Compass
			SendNUIMessage({ compass = Compass, vehicle = 1 })

			if Compass then
				TriggerEvent("Notify","verde","Compasso ativado.",3000)
			else
				TriggerEvent("Notify","verde","Compasso desativado.",3000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOVIE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("movie",function(source,args,rawCommand)
	if exports["chat"]:statusChat() and MumbleIsConnected() then
		showMovie = not showMovie

		displayHud()
		SendNUIMessage({ movie = showMovie })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:TOGGLEHOOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:toggleHood")
AddEventHandler("hud:toggleHood",function()
	showHood = not showHood

	if showHood then
		SetPedComponentVariation(PlayerPedId(),1,69,0,1)
	else
		SetPedComponentVariation(PlayerPedId(),1,0,0,1)
	end

	SendNUIMessage({ hood = showHood })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:REMOVEHOOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:RemoveHood")
AddEventHandler("hud:RemoveHood",function()
	if showHood then
		showHood = false
		SendNUIMessage({ hood = showHood })
		SetPedComponentVariation(PlayerPedId(),1,0,0,1)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:HUNGER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Hunger")
AddEventHandler("hud:Hunger",function(number)
	SendNUIMessage({ hunger = number })
	clientHunger = number
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:THIRST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Thirst")
AddEventHandler("hud:Thirst",function(number)
	SendNUIMessage({ thirst = number })
	clientThirst = number
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:STRESS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Stress")
AddEventHandler("hud:Stress",function(number)
	SendNUIMessage({ stress = number })
	clientStress = number
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:OXIGEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Oxigen")
AddEventHandler("hud:Oxigen",function(number)
	SendNUIMessage({ oxigen = number, oxigenShow = divingMask })
	clientOxigen = number
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RECHARGEOXIGEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:rechargeOxigen")
AddEventHandler("hud:rechargeOxigen",function()
	TriggerEvent("Notify","verde","Reabastecimento concluído.",3000)
	SendNUIMessage({ oxigen = 100, oxigenShow = divingMask })
	vRPS.rechargeOxigen()
	clientOxigen = 100
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:WEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Weapon")
AddEventHandler("hud:Weapon",function(Status,Hash)
	if Status then
		Weapon = Hash
		WeaponActive = true
		WeaponName = itemName(Weapon)

		while WeaponActive do
			local ped = PlayerPedId()
			local _,Min = GetAmmoInClip(ped,Weapon)
			local Max = GetAmmoInPedWeapon(ped,Weapon)

			if lastMax ~= Max or lastMin ~= Min then
				if (Max - Min) <= 0 then
					Max = 0
				else
					Max = Max - Min
				end

				SendNUIMessage({ weapons = true, minAmmo = Min, maxAmmo = Max, name = WeaponName })
				lastMax = Max
				lastMin = Min
			end

			Citizen.Wait(100)
		end
	else
		SendNUIMessage({ weapons = false })
		WeaponActive = false
		lastMax = -1
		lastMin = -1
		Weapon = ""
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:ACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Active")
AddEventHandler("hud:Active",function(status)
	showHud = status

	displayHud()

	SendNUIMessage({ hud = showHud })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:RADIO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Radio")
AddEventHandler("hud:Radio",function(number)
	if number <= 0 then
		SendNUIMessage({ radio = "" })
	else
		SendNUIMessage({ radio = "<text>"..parseInt(number).." Mhz</text>" })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:VOIP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Voip")
AddEventHandler("hud:Voip",function(number)
	local Number = tonumber(number)
	local voiceTarget = { "Baixo","Médio","Alto","Muito Alto" }

	SendNUIMessage({ voice = voiceTarget[Number] })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FOWARDPED
-----------------------------------------------------------------------------------------------------------------------------------------
function fowardPed(ped)
	local heading = GetEntityHeading(ped) + 90.0
	if heading < 0.0 then
		heading = 360.0 + heading
	end

	heading = heading * 0.0174533

	return { x = math.cos(heading) * 2.0, y = math.sin(heading) * 2.0 }
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBELT
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		if playerActive then
			local ped = PlayerPedId()
			if IsPedInAnyVehicle(ped) then
				if not IsPedOnAnyBike(ped) and not IsPedInAnyHeli(ped) and not IsPedInAnyPlane(ped) then
					timeDistance = 1

					local Vehicle = GetVehiclePedIsUsing(ped)
					if GetVehicleDoorLockStatus(Vehicle) == 2 or beltLock then
						DisableControlAction(1,75,true)
					end

					local speed = GetEntitySpeed(Vehicle) * 3.6
					if speed ~= beltSpeed then
						if (beltSpeed - speed) >= 60 and not beltLock then
							local fowardVeh = fowardPed(ped)
							local coords = GetEntityCoords(ped)
							local health = GetEntityHealth(ped)
							SetEntityCoords(ped,coords["x"] + fowardVeh["x"],coords["y"] + fowardVeh["y"],coords["z"] + 1,1,0,0,0)
							SetEntityVelocity(ped,beltVelocity["x"],beltVelocity["y"],beltVelocity["z"])
							SetEntityHealth(ped,health - 50)

							Citizen.Wait(1)

							SetPedToRagdoll(ped,5000,5000,0,0,0,0)
						end

						beltVelocity = GetEntityVelocity(Vehicle)
						beltSpeed = speed
					end
				end
			else
				if beltSpeed ~= 0 then
					beltSpeed = 0
				end

				if beltLock then
					SendNUIMessage({ seatbelt = false })
					beltLock = false
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEATBELT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("seatbelt",function(source,args,rawCommand)
	if MumbleIsConnected() then
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			if not IsPedOnAnyBike(ped) then
				if beltLock then
					TriggerEvent("sounds:source","unbelt",0.5)
					SendNUIMessage({ seatbelt = false })
					beltLock = false
				else
					TriggerEvent("sounds:source","belt",0.5)
					SendNUIMessage({ seatbelt = true })
					beltLock = true
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYMAPPING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("seatbelt","Colocar/Retirar o cinto.","keyboard","G")
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOMES:HOURS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("homes:Hours")
AddEventHandler("homes:Hours",function(status)
	homeInterior = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:SYNCTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:syncTimers")
AddEventHandler("hud:syncTimers",function(timer)
	clockHours = parseInt(timer[1])
	clockMinutes = parseInt(timer[2])
	weatherSync = timer[3]
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHEALTHREDUCE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	local foodTimers = GetGameTimer()

	while true do
		if playerActive then
			if GetGameTimer() >= foodTimers then
				foodTimers = GetGameTimer() + 10000

				local ped = PlayerPedId()
				local health = GetEntityHealth(ped)
				if health > 101 then
					if clientHunger >= 10 and clientHunger <= 20 then
						SetEntityHealth(ped,health - 1)
						TriggerEvent("Notify","hunger","Sofrendo com a fome.",3000)
					elseif clientHunger <= 9 then
						SetEntityHealth(ped,health - 2)
						TriggerEvent("Notify","hunger","Sofrendo com a fome.",3000)
					end

					if clientThirst >= 10 and clientThirst <= 20 then
						SetEntityHealth(ped,health - 1)
						TriggerEvent("Notify","thirst","Sofrendo com a sede.",3000)
					elseif clientThirst <= 9 then
						SetEntityHealth(ped,health - 2)
						TriggerEvent("Notify","thirst","Sofrendo com a sede.",3000)
					end
				end
			end
		end

		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSHAKESTRESS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		if playerActive then
			local ped = PlayerPedId()
			if GetEntityHealth(ped) > 101 then
				if clientStress >= 99 then
					timeDistance = 2500
					ShakeGameplayCam("LARGE_EXPLOSION_SHAKE",0.75)
				elseif clientStress >= 80 and clientStress <= 98 then
					timeDistance = 5000
					ShakeGameplayCam("LARGE_EXPLOSION_SHAKE",0.50)
				elseif clientStress >= 60 and clientStress <= 79 then
					timeDistance = 7500
					ShakeGameplayCam("LARGE_EXPLOSION_SHAKE",0.25)
				elseif clientStress >= 40 and clientStress <= 59 then
					timeDistance = 10000
					ShakeGameplayCam("LARGE_EXPLOSION_SHAKE",0.05)
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:REMOVESCUBA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:RemoveScuba")
AddEventHandler("hud:RemoveScuba",function()
	local ped = PlayerPedId()
	if DoesEntityExist(divingMask) or DoesEntityExist(divingTank) then
		if DoesEntityExist(divingMask) then
			SendNUIMessage({ oxigen = clientOxigen, oxigenShow = nil })
			TriggerServerEvent("tryDeleteObject",NetworkGetNetworkIdFromEntity(divingMask))
			divingMask = nil
		end

		if DoesEntityExist(divingTank) then
			TriggerServerEvent("tryDeleteObject",NetworkGetNetworkIdFromEntity(divingTank))
			divingTank = nil
		end

		SetEnableScuba(ped,false)
		SetPedMaxTimeUnderwater(ped,10.0)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:DIVING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Diving")
AddEventHandler("hud:Diving",function()
	local ped = PlayerPedId()

	if DoesEntityExist(divingMask) or DoesEntityExist(divingTank) then
		if DoesEntityExist(divingMask) then
			SendNUIMessage({ oxigen = clientOxigen, oxigenShow = nil })
			TriggerServerEvent("tryDeleteObject",NetworkGetNetworkIdFromEntity(divingMask))
			divingMask = nil
		end

		if DoesEntityExist(divingTank) then
			TriggerServerEvent("tryDeleteObject",NetworkGetNetworkIdFromEntity(divingTank))
			divingTank = nil
		end

		SetEnableScuba(ped,false)
		SetPedMaxTimeUnderwater(ped,10.0)
	else
		local coords = GetEntityCoords(ped)
		local maskModel = GetHashKey("p_s_scuba_mask_s")
		local tankModel = GetHashKey("p_s_scuba_tank_s")

		RequestModel(tankModel)
		while not HasModelLoaded(tankModel) do
			Citizen.Wait(1)
		end

		RequestModel(maskModel)
		while not HasModelLoaded(maskModel) do
			Citizen.Wait(1)
		end

		if HasModelLoaded(tankModel) then
			divingTank = CreateObject(tankModel,coords["x"],coords["y"],coords["z"],true,true,false)
			local netObjs = NetworkGetNetworkIdFromEntity(divingTank)

			SetNetworkIdCanMigrate(netObjs,true)

			SetEntityAsMissionEntity(divingTank,true,false)
			SetEntityInvincible(divingTank,true)

			AttachEntityToEntity(divingTank,ped,GetPedBoneIndex(ped,24818),-0.28,-0.24,0.0,180.0,90.0,0.0,1,1,0,0,2,1)

			SetModelAsNoLongerNeeded(tankModel)
		end

		if HasModelLoaded(maskModel) then
			divingMask = CreateObject(maskModel,coords["x"],coords["y"],coords["z"],true,true,false)
			SendNUIMessage({ oxigen = clientOxigen, oxigenShow = divingMask })
			local netObjs = NetworkGetNetworkIdFromEntity(divingMask)

			SetNetworkIdCanMigrate(netObjs,true)

			SetEntityAsMissionEntity(divingMask,true,false)
			SetEntityInvincible(divingMask,true)

			AttachEntityToEntity(divingMask,ped,GetPedBoneIndex(ped,12844),0.0,0.0,0.0,180.0,90.0,0.0,1,1,0,0,2,1)

			SetModelAsNoLongerNeeded(maskModel)
		end

		SetEnableScuba(ped,true)
		SetPedMaxTimeUnderwater(ped,2000.0)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NITROENABLE
-----------------------------------------------------------------------------------------------------------------------------------------
function nitroEnable()
	if GetGameTimer() >= nitroButton then
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			nitroButton = GetGameTimer() + 5000

			local Vehicle = GetVehiclePedIsUsing(ped)
			if GetVehicleTopSpeedModifier(Vehicle) < 50.0 then
				local vehPlate = GetVehicleNumberPlateText(Vehicle)
				nitroFuel = nitro[vehPlate] or 0

				if nitroFuel >= 1 then
					if GetIsVehicleEngineRunning(Vehicle) then
						local Speed = GetEntitySpeed(Vehicle) * 3.6
						if Speed > 10 then
							nitroActive = true

							while nitroActive do
								if nitroFuel >= 1 then
									nitroFuel = nitroFuel - 1
									nitro[vehPlate] = nitroFuel - 1

									if not nitroFlame then
										-- vSERVER.activeNitro(VehToNet(Vehicle),true)
										SetVehicleRocketBoostActive(Vehicle,true)
										SetVehicleBoostActive(Vehicle,true)
										ModifyVehicleTopSpeed(Vehicle,50.0)
										SetLightTrail(Vehicle,true)
										nitroFlame = vehPlate
									end
								else
									if nitroFlame then
										-- vSERVER.activeNitro(VehToNet(Vehicle),false)
										SetVehicleRocketBoostActive(Vehicle,false)
										vSERVER.updateNitro(vehPlate,nitroFuel)
										SetVehicleBoostActive(Vehicle,false)
										ModifyVehicleTopSpeed(Vehicle,0.0)
										SetLightTrail(Vehicle,false)
										nitroActive = false
										nitroFlame = false
									end
								end

								Citizen.Wait(1)
							end
						else
							SetPurgeSprays(Vehicle,true)
							sprayActive = true
						end
					else
						SetPurgeSprays(Vehicle,true)
						sprayActive = true
					end
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NITRODISABLE
-----------------------------------------------------------------------------------------------------------------------------------------
function nitroDisable()
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped) then
		local Vehicle = GetVehiclePedIsUsing(ped)
		local vehPlate = GetVehicleNumberPlateText(Vehicle)
		if GetVehicleTopSpeedModifier(Vehicle) > 0.0 and nitroFlame then
			-- vSERVER.activeNitro(VehToNet(Vehicle),false)
			SetVehicleRocketBoostActive(Vehicle,false)
			vSERVER.updateNitro(vehPlate,nitroFuel)
			SetVehicleBoostActive(Vehicle,false)
			ModifyVehicleTopSpeed(Vehicle,0.0)
			SetLightTrail(Vehicle,false)
			nitroActive = false
			nitroFlame = false
		end

		if sprayActive then
			SetPurgeSprays(Vehicle,false)
			sprayActive = false
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTIVENITRO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("+activeNitro",nitroEnable)
RegisterCommand("-activeNitro",nitroDisable)
RegisterKeyMapping("+activeNitro","Ativação do nitro.","keyboard","LMENU")
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETLIGHTTRAIL
-----------------------------------------------------------------------------------------------------------------------------------------
function SetLightTrail(Vehicle,Enable)
	if LightTrails[Vehicle] == Enable then
		return
	end

	if Enable then
		local Particles = {}
		local LeftTrail = CreateLightTrail(Vehicle,GetEntityBoneIndexByName(Vehicle,"taillight_l"))
		local RightTrail = CreateLightTrail(Vehicle,GetEntityBoneIndexByName(Vehicle,"taillight_r"))

		table.insert(Particles,LeftTrail)
		table.insert(Particles,RightTrail)

		LightTrails[Vehicle] = true
		LightParticles[Vehicle] = Particles
	else
		if LightParticles[Vehicle] and #LightParticles[Vehicle] > 0 then
			for _,v in ipairs(LightParticles[Vehicle]) do
				StopLightTrail(v)
			end
		end

		LightTrails[Vehicle] = nil
		LightParticles[Vehicle] = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATELIGHTTRAIL
-----------------------------------------------------------------------------------------------------------------------------------------
function CreateLightTrail(Vehicle,Bone)
	UseParticleFxAssetNextCall("core")
	local Particle = StartParticleFxLoopedOnEntityBone("veh_light_red_trail",Vehicle,0.0,0.0,0.0,0.0,0.0,0.0,Bone,1.0,false,false,false)
	SetParticleFxLoopedEvolution(Particle,"speed",1.0,false)

	return Particle
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOPLIGHTTRAIL
-----------------------------------------------------------------------------------------------------------------------------------------
function StopLightTrail(Particle)
	Citizen.CreateThread(function()
		local endTime = GetGameTimer() + 500
		while GetGameTimer() < endTime do 
			Citizen.Wait(0)
			local now = GetGameTimer()
			local Scale = (endTime - now) / 500
			SetParticleFxLoopedScale(Particle,Scale)
			SetParticleFxLoopedAlpha(Particle,Scale)
		end

		StopParticleFxLooped(Particle)
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETPURGESPRAYS
-----------------------------------------------------------------------------------------------------------------------------------------
function SetPurgeSprays(Vehicle,Enable)
	if PurgeSprays[Vehicle] == Enable then
		return
	end

	if Enable then
		local Particles = {}
		local Bone = GetEntityBoneIndexByName(Vehicle,"bonnet")
		local Position = GetWorldPositionOfEntityBone(Vehicle,Bone)
		local Offset = GetOffsetFromEntityGivenWorldCoords(Vehicle,Position["x"],Position["y"],Position["z"])

		for i = 0,3 do
			local LeftPurge = CreatePurgeSprays(Vehicle,Offset["x"] - 0.5,Offset["y"] + 0.05,Offset["z"],40.0,-20.0,0.0,0.5)
			local RightPurge = CreatePurgeSprays(Vehicle,Offset["x"] + 0.5,Offset["y"] + 0.05,Offset["z"],40.0,20.0,0.0,0.5)

			table.insert(Particles,LeftPurge)
			table.insert(Particles,RightPurge)
		end

		PurgeSprays[Vehicle] = true
		PurgeParticles[Vehicle] = Particles
	else
		if PurgeParticles[Vehicle] then
			RemoveParticleFxFromEntity(Vehicle)
		end

		PurgeSprays[Vehicle] = nil
		PurgeParticles[Vehicle] = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEPURGESPRAYS
-----------------------------------------------------------------------------------------------------------------------------------------
function CreatePurgeSprays(Vehicle,xOffset,yOffset,zOffset,xRot,yRot)
	UseParticleFxAssetNextCall("core")
	return StartNetworkedParticleFxNonLoopedOnEntity("ent_sht_steam",Vehicle,xOffset,yOffset,zOffset,xRot,yRot,0.0,0.5,false,false,false)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:ACTIVENITRO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:activeNitro")
AddEventHandler("hud:activeNitro",function(vehNet,Status)
	if NetworkDoesNetworkIdExist(vehNet) then
		local Vehicle = NetToEnt(vehNet)
		if DoesEntityExist(Vehicle) then
			SetVehicleNitroEnabled(Vehicle,Status)
		end
	end
end)