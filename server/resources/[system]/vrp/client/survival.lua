-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local timeDeath = 300
local ropeCarry = false
local treatment = false
local deathStatus = false
local playerActive = false
local emergencyButton = false

local invincibles = 0
local updateTimers = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- EMEGENCYTEXTS
-----------------------------------------------------------------------------------------------------------------------------------------
local emergencyTexts = {
	{ "Encontrei uma pessoa acidentada e necessita de paramédicos urgentemente." },
	{ "Necessito de ajuda, uma pessoa acabou de se ferir gravemente e está perdendo muito sangue." },
	{ "Encontrei uma pessoa reclamando de muitas dores no corpo e falta de ar, ela precisa de primeiros socorros." },
	{ "Encontrei uma pessoa inconsciente e eu não sei o que fazer, venha rapido por favor." }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP:PLAYERACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp:playerActive")
AddEventHandler("vrp:playerActive",function(user_id)
	playerActive = true

	SetDiscordAppId(909884329084223488)
	SetDiscordRichPresenceAsset("creative")
	SetRichPresence("#"..user_id.." - Creative Roleplay")
	SetDiscordRichPresenceAssetSmall("creative")
	SetDiscordRichPresenceAssetText("Creative Roleplay")
	SetDiscordRichPresenceAssetSmallText("Creative Roleplay")
	SetDiscordRichPresenceAction(0,"Entrar na Cidade","https://www.creative-rp.com/")
	SetDiscordRichPresenceAction(1,"Nosso Instagram","https://www.creative-rp.com/instagram/")

	local pid = PlayerId()
	local ped = PlayerPedId()

	SetEntityInvincible(ped,true)
	FreezeEntityPosition(ped,false)
	NetworkSetFriendlyFireOption(true)
	SetCanAttackFriendly(ped,true,false)

	SetRadarZoom(1100)
	SetMaxWantedLevel(0)
	SetPedHelmet(ped,false)
	SetDeepOceanScaler(0.0)
	SetRandomEventFlag(false)
	SetPlayerTargetingMode(2)
	DistantCopCarSirens(false)
	SetWeaponsNoAutoswap(true)
	SetPlayerCanUseCover(pid,false)
	SetPedSteersAroundPeds(ped,true)
	DisableVehicleDistantlights(true)
	SetFlashLightKeepOnWhileMoving(true)
	SetPedDropsWeaponsWhenDead(ped,false)
	SetPedCanLosePropsOnDamage(ped,false,0)
	SetPedCanBeKnockedOffVehicle(ped,false)
	SetPedCanRagdollFromPlayerImpact(ped,false)

	SetPedConfigFlag(ped,48,true)
	SetPedConfigFlag(ped,33,false)

	SetBlipAlpha(GetNorthRadarBlip(),0)

	SetAudioFlag("DisableFlightMusic",true)
	SetAudioFlag("PoliceScannerDisabled",true)
	StartAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE")
	SetScenarioTypeEnabled("WORLD_VEHICLE_EMPTY",false)
	StartAudioScene("FBI_HEIST_H5_MUTE_AMBIENCE_SCENE")
	SetScenarioTypeEnabled("WORLD_VEHICLE_SALTON",false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_MECHANIC",false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_POLICE_CAR",false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_STREETRACE",false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_POLICE_BIKE",false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_BUSINESSMEN",false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_SALTON_DIRT_BIKE",false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_BIKE_OFF_ROAD_RACE",false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_POLICE_NEXT_TO_CAR",false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_MILITARY_PLANES_BIG",false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_MILITARY_PLANES_SMALL",false)
	SetStaticEmitterEnabled("LOS_SANTOS_VANILLA_UNICORN_01_STAGE",false)
	SetStaticEmitterEnabled("LOS_SANTOS_VANILLA_UNICORN_02_MAIN_ROOM",false)
	SetStaticEmitterEnabled("LOS_SANTOS_VANILLA_UNICORN_03_BACK_ROOM",false)
	SetAmbientZoneListStatePersistent("AZL_DLC_Hei4_Island_Zones",true,true)
	SetAmbientZoneListStatePersistent("AZL_DLC_Hei4_Island_Disabled_Zones",false,true)

	for i = 0,121 do
		EnableDispatchService(i,false)
	end

	Citizen.Wait(10000)

	SetEntityInvincible(ped,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADUPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if playerActive then
			if GetGameTimer() >= updateTimers then
				local ped = PlayerPedId()
				updateTimers = GetGameTimer() + 10000
				vRPS.userUpdate(GetPedArmour(ped),GetEntityHealth(ped),GetEntityCoords(ped))

				if invincibles < 3 then
					invincibles = invincibles + 1

					if invincibles >= 3 then
						SetEntityInvincible(ped,false)
						TriggerEvent("paramedic:playerActive")
					end
				end
			end
		end

		Citizen.Wait(5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999

		if playerActive then
			local ped = PlayerPedId()
			if GetEntityHealth(ped) <= 101 then
				if not deathStatus then
					deathStatus = true
					emergencyButton = false

					local coords = GetEntityCoords(ped)
					NetworkResurrectLocalPlayer(coords,0.0)

					SetEntityHealth(ped,101)
					SetEntityInvincible(ped,true)

					timeDeath = 300

					TriggerEvent("hud:RemoveHood")
					TriggerEvent("hud:RemoveScuba")
					TriggerEvent("radio:outServers")
					TriggerEvent("smartphone:Close")
					TriggerEvent("pma-voice:toggleMute")
					TriggerServerEvent("inventory:Cancel")
					TriggerEvent("inventory:clearWeapons")
					TriggerServerEvent("paramedic:bloodDeath")

					SendNUIMessage({ deathtext = "Você está inconsciente, aguarde <color>"..timeDeath.."</color> segundos" })
					TriggerEvent("inventory:preventWeapon",false)
					tvRP.playAnim(false,{"dead","dead_a"},true)
					SendNUIMessage({ death = true })
					TriggerEvent("inventory:Close")
				else
					timeDistance = 1
					SetEntityHealth(ped,101)

					if not IsEntityPlayingAnim(ped,"dead","dead_a",3) and not IsPedInAnyVehicle(ped) and not ropeCarry then
						tvRP.playAnim(false,{"dead","dead_a"},true)
					end

					if IsPedInAnyVehicle(ped) then
						local vehicle = GetVehiclePedIsUsing(ped)
						if GetPedInVehicleSeat(vehicle,-1) == ped then
							SetVehicleEngineOn(vehicle,false,true,true)
						end
					end

					if timeDeath <= 0 then
						if emergencyButton then
							SendNUIMessage({ deathtext = "Digite <color>/GG</color> para desistir imediatamente" })
						else
							if IsControlJustPressed(1,304) then
								TriggerEvent("smartphone:callParamedic",emergencyTexts[math.random(#emergencyTexts)][1])
								emergencyButton = true
							end

							SendNUIMessage({ deathtext = "Digite <color>/GG</color> para desistir imediatamente<br>Pressione <color2>H</color2> para notificar os paramédicos" })
						end
					else
						SendNUIMessage({ deathtext = "Você está inconsciente, aguarde <color>"..timeDeath.."</color> segundos" })
					end
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:ROPECARRY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:ropeCarry")
AddEventHandler("player:ropeCarry",function()
	ropeCarry = not ropeCarry
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HEALTHRECHARGE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		SetPlayerHealthRechargeMultiplier(PlayerId(),0)
		SetPlayerHealthRechargeLimit(PlayerId(),0)

		if GetEntityMaxHealth(PlayerPedId()) ~= 200 then
			SetEntityMaxHealth(PlayerPedId(),200)
			SetPedMaxHealth(PlayerPedId(),200)
		end

		Citizen.Wait(100)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKDEATH
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.checkDeath()
	if deathStatus and timeDeath <= 0 then
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GG
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("gg",function(source,args,rawCommand)
	if deathStatus and timeDeath <= 0 then
		timeDeath = 300
		deathStatus = false

		ClearPedTasks(PlayerPedId())
		ClearPedBloodDamage(PlayerPedId())
		SetEntityHealth(PlayerPedId(),200)
		SetEntityInvincible(PlayerPedId(),false)

		TriggerEvent("resetHandcuff")
		TriggerEvent("resetBleeding")
		TriggerEvent("resetDiagnostic")
		TriggerServerEvent("vRP:endGame")
		TriggerEvent("pma-voice:toggleMute")
		TriggerEvent("inventory:clearWeapons")
		TriggerEvent("pma-voice:toggleMute")

		DoScreenFadeOut(0)
		SetEntityCoordsNoOffset(PlayerPedId(),-1041.25,-2744.99,21.35,false,false,false,true)
		SendNUIMessage({ death = false })
		Citizen.Wait(1000)
		DoScreenFadeIn(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESPAWNPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.respawnPlayer()
	timeDeath = 300
	deathStatus = false

	ClearPedTasks(PlayerPedId())
	ClearPedBloodDamage(PlayerPedId())
	SetEntityHealth(PlayerPedId(),200)
	SetEntityInvincible(PlayerPedId(),false)

	TriggerEvent("resetHandcuff")
	TriggerEvent("resetBleeding")
	TriggerEvent("resetDiagnostic")
	TriggerServerEvent("vRP:endGame")
	TriggerEvent("inventory:clearWeapons")
	TriggerEvent("pma-voice:toggleMute")

	DoScreenFadeOut(0)
	SetEntityCoordsNoOffset(PlayerPedId(),-1041.25,-2744.99,21.35,false,false,false,true)
	SendNUIMessage({ death = false })
	Citizen.Wait(1000)
	DoScreenFadeIn(1000)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REVIVEPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.revivePlayer(health)
	SetEntityHealth(PlayerPedId(),health)
	SetEntityInvincible(PlayerPedId(),false)

	if deathStatus then
		timeDeath = 300
		deathStatus = false

		ClearPedTasks(PlayerPedId())

		TriggerEvent("resetBleeding")
		SendNUIMessage({ death = false })
		TriggerEvent("pma-voice:toggleMute")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTIMEDEATH
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	local deathTimers = GetGameTimer()

	while true do
		if GetGameTimer() >= deathTimers then
			deathTimers = GetGameTimer() + 1000

			if deathStatus then
				if timeDeath > 0 then
					timeDeath = timeDeath - 1
				end
			end
		end

		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBUTTONS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		if deathStatus then
			timeDistance = 1
			DisableControlAction(1,18,true)
			DisableControlAction(1,22,true)
			DisableControlAction(1,24,true)
			DisableControlAction(1,25,true)
			DisableControlAction(1,68,true)
			DisableControlAction(1,70,true)
			DisableControlAction(1,91,true)
			DisableControlAction(1,69,true)
			DisableControlAction(1,75,true)
			DisableControlAction(1,140,true)
			DisableControlAction(1,142,true)
			DisableControlAction(1,257,true)
			DisablePlayerFiring(PlayerPedId(),true)
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTTREATMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.startTreatment()
	if not treatment then
		TriggerEvent("player:blockCommands",true)
		TriggerEvent("resetDiagnostic")
		TriggerEvent("resetBleeding")
		treatment = true
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTREATMENT
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	local treatmentTimers = GetGameTimer()

	while true do
		if GetGameTimer() >= treatmentTimers then
			treatmentTimers = GetGameTimer() + 1000

			if treatment then
				local ped = PlayerPedId()
				local health = GetEntityHealth(ped)

				if health < 200 then
					SetEntityHealth(ped,health + 1)
				else
					treatment = false
					TriggerEvent("player:blockCommands",false)
					TriggerEvent("Notify","amarelo","Tratamento concluido.",5000)
				end
			end
		end

		Citizen.Wait(500)
	end
end)