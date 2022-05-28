-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("player",cRP)
vSERVER = Tunnel.getInterface("player")
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEAATTACHS
-----------------------------------------------------------------------------------------------------------------------------------------
local weaAttachs = {
	["WEAPON_PISTOL"] = {
		"COMPONENT_AT_PI_FLSH"
	},
	["WEAPON_HEAVYPISTOL"] = {
		"COMPONENT_AT_PI_FLSH"
	},
	["WEAPON_PISTOL_MK2"] = {
		"COMPONENT_AT_PI_RAIL",
		"COMPONENT_AT_PI_FLSH_02",
		"COMPONENT_AT_PI_COMP"
	},
	["WEAPON_COMBATPISTOL"] = {
		"COMPONENT_AT_PI_FLSH"
	},
	["WEAPON_APPISTOL"] = {
		"COMPONENT_AT_PI_FLSH"
	},
	["WEAPON_MICROSMG"] = {
		"COMPONENT_AT_PI_FLSH",
		"COMPONENT_AT_SCOPE_MACRO"
	},
	["WEAPON_SMG"] = {
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_SCOPE_MACRO_02",
		"COMPONENT_AT_PI_SUPP"
	},
	["WEAPON_ASSAULTSMG"] = {
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_SCOPE_MACRO",
		"COMPONENT_AT_AR_SUPP_02"
	},
	["WEAPON_COMBATPDW"] = {
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_AR_AFGRIP",
		"COMPONENT_AT_SCOPE_SMALL"
	},
	["WEAPON_PUMPSHOTGUN"] = {
		"COMPONENT_AT_AR_FLSH"
	},
	["WEAPON_CARBINERIFLE"] = {
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_SCOPE_MEDIUM",
		"COMPONENT_AT_AR_AFGRIP"
	},
	["WEAPON_ASSAULTRIFLE"] = {
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_SCOPE_MACRO",
		"COMPONENT_AT_AR_AFGRIP"
	},
	["WEAPON_MACHINEPISTOL"] = {
		"COMPONENT_AT_PI_SUPP"
	},
	["WEAPON_ASSAULTRIFLE_MK2"] = {
		"COMPONENT_AT_AR_AFGRIP_02",
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_SCOPE_MEDIUM_MK2",
		"COMPONENT_AT_MUZZLE_01"
	},
	["WEAPON_PISTOL50"] = {
		"COMPONENT_AT_PI_FLSH"
	},
	["WEAPON_SNSPISTOL_MK2"] = {
		"COMPONENT_AT_PI_FLSH_03",
		"COMPONENT_AT_PI_RAIL_02",
		"COMPONENT_AT_PI_COMP_02"
	},
	["WEAPON_SMG_MK2"] = {
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_SCOPE_MACRO_02_SMG_MK2",
		"COMPONENT_AT_MUZZLE_01"
	},
	["WEAPON_BULLPUPRIFLE"] = {
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_SCOPE_SMALL",
		"COMPONENT_AT_AR_SUPP"
	},
	["WEAPON_BULLPUPRIFLE_MK2"] = {
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_SCOPE_MACRO_02_MK2",
		"COMPONENT_AT_MUZZLE_01"
	},
	["WEAPON_SPECIALCARBINE"] = {
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_SCOPE_MEDIUM",
		"COMPONENT_AT_AR_AFGRIP"
	},
	["WEAPON_SPECIALCARBINE_MK2"] = {
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_SCOPE_MEDIUM_MK2",
		"COMPONENT_AT_MUZZLE_01"
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ATTACHS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("attachs",function(source,args)
	local ped = PlayerPedId()
	for k,v in pairs(weaAttachs) do
		if GetSelectedPedWeapon(ped) == GetHashKey(k) then
			for k2,v2 in pairs(v) do
				GiveWeaponComponentToPed(ped,GetHashKey(k),GetHashKey(v2))
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLOCKCOMMANDS
-----------------------------------------------------------------------------------------------------------------------------------------
local blockCommands = false
RegisterNetEvent("player:blockCommands")
AddEventHandler("player:blockCommands",function(status)
	blockCommands = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLOCKS
-----------------------------------------------------------------------------------------------------------------------------------------
function blocks()
	if exports["player"]:handCuff() then
		return false
	end

	return blockCommands
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLOCKCOMMANDS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("blockCommands",blocks)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SALARYAWAY
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	local awayTimers = GetGameTimer()
	local awaySystem = {
		["coords"] = vector3(0.0,0.0,0.0),
		["time"] = 30
	}

	while true do
		if GetGameTimer() >= awayTimers then
			awayTimers = GetGameTimer() + 60000

			local ped = PlayerPedId()
			local coords = GetEntityCoords(ped)
			local distance = #(coords - awaySystem["coords"])

			if distance >= 1 then
				awaySystem["time"] = awaySystem["time"] - 1

				if GetEntityHealth(ped) > 101 and awaySystem["time"] <= 0 then
					awaySystem["coords"] = coords
					awaySystem["time"] = 30
					vSERVER.getSalary()
				end
			end
		end

		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEATSHUFFLE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			timeDistance = 100

			if not GetPedConfigFlag(ped,184,true) then
				SetPedConfigFlag(ped,184,true)
			end

			local Vehicle = GetVehiclePedIsIn(ped)
			if GetPedInVehicleSeat(Vehicle,0) == ped then
				if GetIsTaskActive(ped,165) then
					SetPedIntoVehicle(ped,Vehicle,0)
				end
			end
		else
			if GetPedConfigFlag(ped,184,true) then
				SetPedConfigFlag(ped,184,false)
			end
		end

		Citizen.Wait(100)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETENERGETIC
-----------------------------------------------------------------------------------------------------------------------------------------
local energetic = 0
RegisterNetEvent("setEnergetic")
AddEventHandler("setEnergetic",function(timers,number)
	energetic = energetic + timers
	SetRunSprintMultiplierForPlayer(PlayerId(),number)
end)

Citizen.CreateThread(function()
	while true do
		if energetic > 0 then
			energetic = energetic - 1
			RestorePlayerStamina(PlayerId(),1.0)

			if energetic <= 0 or GetEntityHealth(PlayerPedId()) <= 101 then
				SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
				energetic = 0
			end
		end

		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETECSTASY
-----------------------------------------------------------------------------------------------------------------------------------------
local ecstasy = 0
RegisterNetEvent("setEcstasy")
AddEventHandler("setEcstasy",function()
	ecstasy = ecstasy + 10

	if not GetScreenEffectIsActive("MinigameTransitionIn") then
		StartScreenEffect("MinigameTransitionIn",0,true)
	end
end)

Citizen.CreateThread(function()
	while true do
		if ecstasy > 0 then
			ecstasy = ecstasy - 1
			ShakeGameplayCam("LARGE_EXPLOSION_SHAKE",0.05)

			if ecstasy <= 0 or GetEntityHealth(PlayerPedId()) <= 101 then
				ecstasy = 0

				TriggerServerEvent("upgradeStress",100)
				if GetScreenEffectIsActive("MinigameTransitionIn") then
					StopScreenEffect("MinigameTransitionIn")
				end
			end
		end

		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETMETH
-----------------------------------------------------------------------------------------------------------------------------------------
local methanfetamine = 0
RegisterNetEvent("setMeth")
AddEventHandler("setMeth",function()
	methanfetamine = methanfetamine + 30

	if not GetScreenEffectIsActive("DMT_flight") then
		StartScreenEffect("DMT_flight",0,true)
	end
end)

Citizen.CreateThread(function()
	while true do
		if methanfetamine > 0 then
			methanfetamine = methanfetamine - 1

			if methanfetamine <= 0 or GetEntityHealth(PlayerPedId()) <= 101 then
				methanfetamine = 0

				if GetScreenEffectIsActive("DMT_flight") then
					StopScreenEffect("DMT_flight")
				end
			end
		end

		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETCOCAINE
-----------------------------------------------------------------------------------------------------------------------------------------
local cocaine = 0
RegisterNetEvent("setCocaine")
AddEventHandler("setCocaine",function()
	cocaine = cocaine + 30

	if not GetScreenEffectIsActive("MinigameTransitionIn") then
		StartScreenEffect("MinigameTransitionIn",0,true)
	end
end)

Citizen.CreateThread(function()
	while true do
		if cocaine > 0 then
			cocaine = cocaine - 1

			if cocaine <= 0 or GetEntityHealth(PlayerPedId()) <= 101 then
				cocaine = 0

				if GetScreenEffectIsActive("MinigameTransitionIn") then
					StopScreenEffect("MinigameTransitionIn")
				end
			end
		end

		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANEFFECTDRUGS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("cleanEffectDrugs")
AddEventHandler("cleanEffectDrugs",function()
	if GetScreenEffectIsActive("MinigameTransitionIn") then
		StopScreenEffect("MinigameTransitionIn")
	end

	if GetScreenEffectIsActive("DMT_flight") then
		StopScreenEffect("DMT_flight")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETDRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
local drunkTime = 0
RegisterNetEvent("setDrunkTime")
AddEventHandler("setDrunkTime",function(timers)
	drunkTime = drunkTime + timers

	TriggerEvent("vrp:blockDrunk",true)
	RequestAnimSet("move_m@drunk@verydrunk")
	while not HasAnimSetLoaded("move_m@drunk@verydrunk") do
		Citizen.Wait(1)
	end

	SetPedMovementClipset(PlayerPedId(),"move_m@drunk@verydrunk",0.25)
end)

Citizen.CreateThread(function()
	while true do
		if drunkTime > 0 then
			drunkTime = drunkTime - 1

			if drunkTime <= 0 or GetEntityHealth(PlayerPedId()) <= 101 then
				ResetPedMovementClipset(PlayerPedId(),0.25)
				TriggerEvent("vrp:blockDrunk",false)
			end
		end

		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCHOODOPTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:syncHoodOptions")
AddEventHandler("player:syncHoodOptions",function(vehIndex,options)
	if NetworkDoesNetworkIdExist(vehIndex) then
		local v = NetToEnt(vehIndex)
		if DoesEntityExist(v) then
			if options == "open" then
				SetVehicleDoorOpen(v,4,0,0)
			elseif options == "close" then
				SetVehicleDoorShut(v,4,0)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETEVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:deleteVehicle")
AddEventHandler("player:deleteVehicle",function(vehIndex,vehPlate)
	if NetworkDoesNetworkIdExist(vehIndex) then
		local v = NetToEnt(vehIndex)
		if DoesEntityExist(v) and GetVehicleNumberPlateText(v) == vehPlate then
			SetEntityAsMissionEntity(v,false,false)
			DeleteEntity(v)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETEOBJECT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:deleteObject")
AddEventHandler("player:deleteObject",function(entIndex)
	if NetworkDoesNetworkIdExist(entIndex) then
		local v = NetToEnt(entIndex)
		if DoesEntityExist(v) then
			SetEntityAsMissionEntity(v,false,false)
			DeleteEntity(v)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCDOORSOPTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:syncDoorsOptions")
AddEventHandler("player:syncDoorsOptions",function(vehIndex,options)
	if NetworkDoesNetworkIdExist(vehIndex) then
		local v = NetToEnt(vehIndex)
		if DoesEntityExist(v) and GetVehicleDoorLockStatus(v) == 1 then
			if options == "open" then
				SetVehicleDoorOpen(v,5,0,0)
			elseif options == "close" then
				SetVehicleDoorShut(v,5,0)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCWINS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:syncWins")
AddEventHandler("player:syncWins",function(vehIndex,status)
	if NetworkDoesNetworkIdExist(vehIndex) then
		local v = NetToEnt(vehIndex)
		if DoesEntityExist(v) then
			if status == "1" then
				RollUpWindow(v,0)
				RollUpWindow(v,1)
				RollUpWindow(v,2)
				RollUpWindow(v,3)
			else
				RollDownWindow(v,0)
				RollDownWindow(v,1)
				RollDownWindow(v,2)
				RollDownWindow(v,3)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCDOORS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:syncDoors")
AddEventHandler("player:syncDoors",function(vehIndex,door)
	if NetworkDoesNetworkIdExist(vehIndex) then
		local v = NetToEnt(vehIndex)
		if DoesEntityExist(v) and GetVehicleDoorsLockedForPlayer(v,PlayerId()) ~= 1 then
			if door == "1" then
				if GetVehicleDoorAngleRatio(v,0) == 0 then
					SetVehicleDoorOpen(v,0,0,0)
				else
					SetVehicleDoorShut(v,0,0)
				end
			elseif door == "2" then
				if GetVehicleDoorAngleRatio(v,1) == 0 then
					SetVehicleDoorOpen(v,1,0,0)
				else
					SetVehicleDoorShut(v,1,0)
				end
			elseif door == "3" then
				if GetVehicleDoorAngleRatio(v,2) == 0 then
					SetVehicleDoorOpen(v,2,0,0)
				else
					SetVehicleDoorShut(v,2,0)
				end
			elseif door == "4" then
				if GetVehicleDoorAngleRatio(v,3) == 0 then
					SetVehicleDoorOpen(v,3,0,0)
				else
					SetVehicleDoorShut(v,3,0)
				end
			elseif door == "5" then
				if GetVehicleDoorAngleRatio(v,5) == 0 then
					SetVehicleDoorOpen(v,5,0,0)
				else
					SetVehicleDoorShut(v,5,0)
				end
			elseif door == "6" then
				if GetVehicleDoorAngleRatio(v,4) == 0 then
					SetVehicleDoorOpen(v,4,0,0)
				else
					SetVehicleDoorShut(v,4,0)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEATPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:seatPlayer")
AddEventHandler("player:seatPlayer",function(vehIndex)
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped) then
		local vehicle = GetVehiclePedIsUsing(ped)

		if vehIndex == "0" then
			if IsVehicleSeatFree(vehicle,-1) then
				SetPedIntoVehicle(ped,vehicle,-1)
			end
		else
			if IsVehicleSeatFree(vehicle,parseInt(vehIndex - 1)) then
				SetPedIntoVehicle(ped,vehicle,parseInt(vehIndex - 1))
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLEHANDCUFF
-----------------------------------------------------------------------------------------------------------------------------------------
local handcuff = false
function cRP.toggleHandcuff()
	if not handcuff then
		handcuff = true
		TriggerEvent("radio:outServers")
		exports["smartphone"]:closeSmartphone()
	else
		handcuff = false
		vRP.stopAnim(false)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEHANDCUFF
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.removeHandcuff()
	if handcuff then
		handcuff = false
		vRP.stopAnim(false)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETHANDCUFF
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.getHandcuff()
	return handcuff
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETHANDCUFF
-----------------------------------------------------------------------------------------------------------------------------------------
function handcuffs()
	return handcuff
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HANDCUFF
-----------------------------------------------------------------------------------------------------------------------------------------
exports("handCuff",handcuffs)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESETHANDCUFF
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("resetHandcuff")
AddEventHandler("resetHandcuff",function()
	if handcuff then
		handcuff = false
		vRP.stopAnim(false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOVEMENTCLIP
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.movementClip(dict)
	RequestAnimSet(dict)
	while not HasAnimSetLoaded(dict) do
		Citizen.Wait(1)
	end

	SetPedMovementClipset(PlayerPedId(),dict,0.25)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:TARGET
-----------------------------------------------------------------------------------------------------------------------------------------
Target = false
RegisterNetEvent("target:Target")
AddEventHandler("target:Target",function(status)
	Target = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPLYROPE
-----------------------------------------------------------------------------------------------------------------------------------------
local startRope = false
RegisterNetEvent("player:applyRope")
AddEventHandler("player:applyRope",function(status)
	startRope = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHANDCUFF
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 100
		if handcuff or Target then
			timeDistance = 1
			DisableControlAction(1,18,true)
			DisableControlAction(1,21,true)
			DisableControlAction(1,55,true)
			DisableControlAction(1,102,true)
			DisableControlAction(1,179,true)
			DisableControlAction(1,203,true)
			DisableControlAction(1,76,true)
			DisableControlAction(1,23,true)
			DisableControlAction(1,24,true)
			DisableControlAction(1,25,true)
			DisableControlAction(1,140,true)
			DisableControlAction(1,142,true)
			DisableControlAction(1,143,true)
			DisableControlAction(1,75,true)
			DisableControlAction(1,22,true)
			DisableControlAction(1,243,true)
			DisableControlAction(1,257,true)
			DisableControlAction(1,263,true)
			DisablePlayerFiring(PlayerPedId(),true)
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHANDCUFF
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		local ped = PlayerPedId()
		if handcuff and GetEntityHealth(ped) > 101 and not startRope then
			if not IsEntityPlayingAnim(ped,"mp_arresting","idle",3) then
				RequestAnimDict("mp_arresting")
				while not HasAnimDictLoaded("mp_arresting") do
					Citizen.Wait(1)
				end

				TaskPlayAnim(ped,"mp_arresting","idle",3.0,3.0,-1,49,0,0,0,0)
				timeDistance = 1
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOTDISTANCE
-----------------------------------------------------------------------------------------------------------------------------------------
local losSantos = PolyZone:Create({
	vector2(-2153.08,-3131.33),
	vector2(-1581.58,-2092.38),
	vector2(-3271.05,275.85),
	vector2(-3460.83,967.42),
	vector2(-3202.39,1555.39),
	vector2(-1642.50,993.32),
	vector2(312.95,1054.66),
	vector2(1313.70,341.94),
	vector2(1739.01,-1280.58),
	vector2(1427.42,-3440.38),
	vector2(-737.90,-3773.97)
},{ name = "santos" })

local sandyShores = PolyZone:Create({
	vector2(-375.38,2910.14),
	vector2(307.66,3664.47),
	vector2(2329.64,4128.52),
	vector2(2349.93,4578.50),
	vector2(1680.57,4462.48),
	vector2(1570.01,4961.27),
	vector2(1967.55,5203.67),
	vector2(2387.14,5273.98),
	vector2(2735.26,4392.21),
	vector2(2512.33,3711.16),
	vector2(1681.79,3387.82),
	vector2(258.85,2920.16)
},{ name = "sandy" })

local paletoBay = PolyZone:Create({
	vector2(-529.40,5755.14),
	vector2(-234.39,5978.46),
	vector2(278.16,6381.84),
	vector2(672.67,6434.39),
	vector2(699.56,6877.77),
	vector2(256.59,7058.49),
	vector2(17.64,7054.53),
	vector2(-489.45,6449.50),
	vector2(-717.59,6030.94)
},{ name = "paleto" })
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSHOTSFIRED
-----------------------------------------------------------------------------------------------------------------------------------------
local residual = false
local policeService = false
local coolTimers = GetGameTimer()
local sprayTimers = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSHOT
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		local ped = PlayerPedId()
		if IsPedArmed(ped,6) and GetGameTimer() >= sprayTimers then
			timeDistance = 1
			
			if IsPedShooting(ped) then
				sprayTimers = GetGameTimer() + 60000
				coolTimers = GetGameTimer() + 3000
				residual = true
				
				if not IsPedCurrentWeaponSilenced(ped) then
					local coords = GetEntityCoords(ped)
					if (losSantos:isPointInside(coords) or sandyShores:isPointInside(coords) or paletoBay:isPointInside(coords)) and not policeService then
						TriggerServerEvent("evidence:dropEvidence","blue")
						vSERVER.shotsFired()
					end
				else
					if math.random(100) >= 80 then
						local coords = GetEntityCoords(ped)
						if (losSantos:isPointInside(coords) or sandyShores:isPointInside(coords) or paletoBay:isPointInside(coords)) and not policeService then
							TriggerServerEvent("evidence:dropEvidence","blue")
							vSERVER.shotsFired()
						end
					end
				end
			end
		end
		
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- COOLTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if coolTimers > 0 then
			coolTimers = coolTimers - 1
		end

		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHAKESHOTTING
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) and IsPedArmed(ped,6) then
			timeDistance = 1

			local selectWeapon = GetSelectedPedWeapon(ped)
			if (selectWeapon == GetHashKey("WEAPON_MACHINEPISTOL") or selectWeapon == GetHashKey("WEAPON_MICROSMG") or selectWeapon == GetHashKey("WEAPON_MINISMG") or selectWeapon == GetHashKey("WEAPON_APPISTOL")) then
				DisablePlayerFiring(ped,true)
				DisableControlAction(1,24,true)
				DisableControlAction(1,25,true)
				DisableControlAction(1,68,true)
				DisableControlAction(1,69,true)
				DisableControlAction(1,70,true)
				DisableControlAction(1,91,true)
				DisableControlAction(1,257,true)
			end

			if IsPedShooting(ped) then
				ShakeGameplayCam("SMALL_EXPLOSION_SHAKE",0.10)
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE:UPDATESERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("police:updateService")
AddEventHandler("police:updateService",function(status)
	policeService = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPLYGSR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:applyGsr")
AddEventHandler("player:applyGsr",function()
	residual = true
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GSRCHECK
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.gsrCheck()
	return residual
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKSOAP
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkSoap()
	local ped = PlayerPedId()
	if IsEntityInWater(ped) and residual then
		return true
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANRESIDUAL
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.cleanResidual()
	residual = false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLECARRY
-----------------------------------------------------------------------------------------------------------------------------------------
local uCarry = nil
local iCarry = false
local sCarry = false
function cRP.toggleCarry(source)
	uCarry = source
	iCarry = not iCarry

	local ped = PlayerPedId()
	if iCarry and uCarry then
		AttachEntityToEntity(ped,GetPlayerPed(GetPlayerFromServerId(uCarry)),11816,0.6,0.0,0.0,0.0,0.0,0.0,false,false,false,false,2,true)
		sCarry = true
	else
		if sCarry then
			DetachEntity(ped,false,false)
			sCarry = false
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:inBennys")
AddEventHandler("player:inBennys",function(status)
	inBennys = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.removeVehicle()
	if not inBennys then
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			TaskLeaveVehicle(ped,GetVehiclePedIsUsing(ped),16)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PUTVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.putVehicle(vehIndex)
	if NetworkDoesNetworkIdExist(vehIndex) then
		local Vehicle = NetToEnt(vehIndex)
		if DoesEntityExist(Vehicle) then
			local vehSeats = 10
			local ped = PlayerPedId()

			repeat
				vehSeats = vehSeats - 1

				if IsVehicleSeatFree(Vehicle,vehSeats) then
					ClearPedTasks(ped)
					ClearPedSecondaryTask(ped)
					
					if iCarry then
						iCarry = false
						DetachEntity(GetPlayerPed(GetPlayerFromServerId(uCarry)),false,false)
					end
					
					SetPedIntoVehicle(ped,Vehicle,vehSeats)

					vehSeats = true
				end
			until vehSeats == true or vehSeats == 0
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRUNKABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local inTrunk = false
local playerInvisible = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:PLAYERINVISIBLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:playerInvisible")
AddEventHandler("player:playerInvisible",function(status)
	playerInvisible = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:ENTERTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:enterTrunk")
AddEventHandler("player:enterTrunk",function(entity)
	if not inTrunk then
		local vehicle = entity[3]
		local vehPlate = entity[1]
		if GetVehicleDoorLockStatus(vehicle) == 1 then
			local trunk = GetEntityBoneIndexByName(vehicle,"boot")
			if trunk ~= -1 then
				if GetVehicleDoorAngleRatio(vehicle,5) < 0.9 then
					local ped = PlayerPedId()
					local coords = GetOffsetFromEntityInWorldCoords(ped,0.0,0.5,0.0)
					local coordsEnt = GetWorldPositionOfEntityBone(vehicle,trunk)
					local distance = #(coords - coordsEnt)
					if distance <= 2.0 then
						playerInvisible = true
						blockCommands = true
						SetEntityVisible(ped,false,false)
						AttachEntityToEntity(ped,vehicle,-1,0.0,-2.2,0.5,0.0,0.0,0.0,false,false,false,false,20,true)
						inTrunk = true
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CHECKTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:checkTrunk")
AddEventHandler("player:checkTrunk",function()
	if inTrunk then
		local ped = PlayerPedId()
		local vehicle = GetEntityAttachedTo(ped)
		if DoesEntityExist(vehicle) then
			inTrunk = false
			DetachEntity(ped,false,false)
			SetEntityVisible(ped,true,false)
			blockCommands = false
			playerInvisible = false
			SetEntityCoords(ped,GetOffsetFromEntityInWorldCoords(ped,0.0,-1.25,-0.25),1,0,0,0)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADINTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999

		if inTrunk then
			local ped = PlayerPedId()
			local vehicle = GetEntityAttachedTo(ped)
			if DoesEntityExist(vehicle) then
				timeDistance = 1

				DisablePlayerFiring(ped,true)

				if IsEntityVisible(ped) then
					playerInvisible = true
					SetEntityVisible(ped,false,false)
				end

				if IsControlJustPressed(1,38) then
					inTrunk = false
					DetachEntity(ped,false,false)
					SetEntityVisible(ped,true,false)
					blockCommands = false
					playerInvisible = false
					SetEntityCoords(ped,GetOffsetFromEntityInWorldCoords(ped,0.0,-1.25,-0.25),1,0,0,0)
				end
			else
				inTrunk = false
				DetachEntity(ped,false,false)
				SetEntityVisible(ped,true,false)
				blockCommands = false
				playerInvisible = false
				SetEntityCoords(ped,GetOffsetFromEntityInWorldCoords(ped,0.0,-1.25,-0.25),1,0,0,0)
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRUISER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cr",function(source,args,rawCommand)
	if exports["chat"]:statusChat() and MumbleIsConnected() then
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			local Vehicle = GetVehiclePedIsUsing(ped)
			if GetPedInVehicleSeat(Vehicle,-1) == ped and not IsEntityInAir(Vehicle) then
				local speed = GetEntitySpeed(Vehicle) * 3.6

				if speed >= 10 then
					if args[1] == nil then
						SetEntityMaxSpeed(Vehicle,GetVehicleEstimatedMaxSpeed(Vehicle))
						TriggerEvent("Notify","amarelo","Controle de cruzeiro desativado.",3000)
					else
						if parseInt(args[1]) > 10 then
							SetEntityMaxSpeed(Vehicle,0.28 * args[1])
							TriggerEvent("Notify","verde","Controle de cruzeiro ativado.",3000)
						end
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GAMEEVENTTRIGGERED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("gameEventTriggered",function(name,args)
	if name == "CEventNetworkEntityDamage" then
		if (GetEntityHealth(args[1]) <= 101 and PlayerPedId() == args[2] and IsPedAPlayer(args[1])) then
			local index = NetworkGetPlayerIndexFromPed(args[1])
			local source = GetPlayerServerId(index)
			TriggerServerEvent("player:deathLogs",source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP:PLAYERACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
local playerActive = false
RegisterNetEvent("vrp:playerActive")
AddEventHandler("vrp:playerActive",function()
	playerActive = true
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAFEBURGER
-----------------------------------------------------------------------------------------------------------------------------------------
local safeBurger = PolyZone:Create({
	vector2(-1188.68,-878.83),
	vector2(-1198.82,-885.54),
	vector2(-1197.20,-888.00),
	vector2(-1202.07,-891.40),
	vector2(-1201.24,-892.50),
	vector2(-1200.82,-893.32),
	vector2(-1203.37,-895.03),
	vector2(-1199.14,-901.76),
	vector2(-1199.65,-902.25),
	vector2(-1198.75,-903.63),
	vector2(-1195.35,-901.35),
	vector2(-1194.95,-901.98),
	vector2(-1195.20,-902.93),
	vector2(-1196.38,-903.84),
	vector2(-1194.87,-906.07),
	vector2(-1193.38,-906.36),
	vector2(-1193.20,-905.87),
	vector2(-1190.91,-906.13),
	vector2(-1189.97,-905.46),
	vector2(-1193.19,-900.83),
	vector2(-1193.91,-901.34),
	vector2(-1195.49,-898.63),
	vector2(-1191.54,-896.07),
	vector2(-1190.37,-897.74),
	vector2(-1180.39,-890.96)
},{ name = "BurgerShot" })
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAFEFISH
-----------------------------------------------------------------------------------------------------------------------------------------
local safeFish = PolyZone:Create({
	vector2(1522.36,3772.69),
	vector2(1529.41,3778.89),
	vector2(1537.68,3783.54),
	vector2(1535.88,3787.09),
	vector2(1552.66,3795.83),
	vector2(1549.07,3802.40),
	vector2(1529.33,3793.77),
	vector2(1527.99,3796.13),
	vector2(1521.92,3793.16),
	vector2(1516.26,3788.72),
	vector2(1513.64,3786.12),
	vector2(1515.38,3784.12),
	vector2(1510.12,3778.29),
	vector2(1508.61,3774.59),
	vector2(1509.24,3771.86),
	vector2(1512.11,3771.08),
	vector2(1516.23,3772.85),
	vector2(1519.52,3775.65)
},{ name = "FishPlanet" })
-----------------------------------------------------------------------------------------------------------------------------------------
-- SQUARE
-----------------------------------------------------------------------------------------------------------------------------------------
local safeSquare = PolyZone:Create({
	  vector2(152.63,-1001.17),
	  vector2(129.78,-993.32),
	  vector2(127.38,-991.56),
	  vector2(126.56,-990.27),
	  vector2(126.05,-988.42),
	  vector2(126.35,-985.75),
	  vector2(160.35,-892.59),
	  vector2(162.87,-887.34),
	  vector2(164.63,-884.61),
	  vector2(166.54,-882.10),
	  vector2(168.37,-879.66),
	  vector2(170.03,-877.06),
	  vector2(171.45,-874.34),
	  vector2(172.82,-871.61),
	  vector2(174.15,-868.74),
	  vector2(175.21,-866.23),
	  vector2(176.44,-863.35),
	  vector2(177.66,-860.56),
	  vector2(178.70,-857.81),
	  vector2(183.97,-843.75),
	  vector2(185.89,-841.26),
	  vector2(188.63,-840.02),
	  vector2(191.54,-840.19),
	  vector2(193.14,-841.48),
	  vector2(194.11,-843.38),
	  vector2(195.16,-845.01),
	  vector2(196.72,-845.92),
	  vector2(246.74,-864.14),
	  vector2(248.81,-864.08),
	  vector2(251.73,-862.72),
	  vector2(253.52,-862.86),
	  vector2(260.32,-865.34),
	  vector2(262.11,-866.44),
	  vector2(264.38,-868.85),
	  vector2(265.62,-871.46),
	  vector2(266.05,-874.31),
	  vector2(265.69,-877.25),
	  vector2(264.72,-879.99),
	  vector2(213.15,-1021.55),
	  vector2(211.52,-1023.84),
	  vector2(208.98,-1024.99),
	  vector2(205.42,-1024.66),
	  vector2(202.17,-1023.48),
	  vector2(196.34,-1021.55),
	  vector2(194.97,-1019.53),
	  vector2(193.14,-1015.18),
	  vector2(192.23,-1014.49),
	  vector2(169.87,-1006.99),
	  vector2(167.61,-1007.46),
	  vector2(163.31,-1009.85),
	  vector2(161.97,-1009.95),
	  vector2(156.65,-1008.10),
	  vector2(155.68,-1007.06),
	  vector2(154.50,-1004.24),
	  vector2(153.67,-1002.24)
},{ name = "squareGarden" })
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSAFE
-----------------------------------------------------------------------------------------------------------------------------------------
local safeTimer = 0
local safeZone = false
Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)

		if safeSquare:isPointInside(coords) or safeBurger:isPointInside(coords) or safeFish:isPointInside(coords) then
			safeTimer = safeTimer + 1

			if not safeZone then
				SetPlayerInvincible(ped,true)
				safeZone = true
			end

			if safeTimer >= 60 then
				TriggerServerEvent("downgradeStress",10)
				safeTimer = 0
			end
		else
			if safeTimer > 0 then
				safeTimer = 0
			end

			if safeZone then
				SetPlayerInvincible(ped,false)
				safeZone = false
			end
		end

		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FPS
-----------------------------------------------------------------------------------------------------------------------------------------
local commandFps = false
RegisterCommand("fps",function(source,args,rawCommand)
	if commandFps then
		ClearTimecycleModifier()
		commandFps = false
	else
		SetTimecycleModifier("cinema")
		commandFps = true
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BIKESBACKPACK
-----------------------------------------------------------------------------------------------------------------------------------------
local bikesPoints = 0
local bikesTea = false
local bikesTeaPoints = 0
local bikeMaxPoints = 900
local bikesTimer = GetGameTimer()
local bikesTeaTimer = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- BIKESMODEL
-----------------------------------------------------------------------------------------------------------------------------------------
local bikesModel = {
	[1131912276] = true,
	[448402357] = true,
	[-836512833] = true,
	[-186537451] = true,
	[1127861609] = true,
	[-1233807380] = true,
	[-400295096] = true
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:MUSHROOMTEA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:MushroomTea")
AddEventHandler("player:MushroomTea",function()
	bikesTea = true
	bikesTeaPoints = 0
	bikeMaxPoints = 600
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBIKES
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()

		if IsPedInAnyVehicle(ped) then
			local vehicle = GetVehiclePedIsUsing(ped)
			local vehModel = GetEntityModel(vehicle)
			local speed = GetEntitySpeed(vehicle) * 3.6

			if bikesModel[vehModel] and GetGameTimer() >= bikesTimer and speed >= 10 then
				bikesTimer = GetGameTimer() + 1000
				bikesPoints = bikesPoints + 1

				if bikesPoints >= bikeMaxPoints then
					vSERVER.bikesBackpack()
					bikesPoints = 0
				end
			end
		end

		if commandFps then
			if IsPedSwimming(ped) then
				ClearTimecycleModifier()
				commandFps = false
			end
		end

		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBIKETEA
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if bikesTea then
			if GetGameTimer() >= bikesTeaTimer then
				bikesTeaTimer = GetGameTimer() + 1000
				bikesTeaPoints = bikesTeaPoints + 1

				if bikesTeaPoints >= 3600 then
					bikeMaxPoints = 900
					bikesTeaPoints = 0
					bikesTea = false
				end
			end
		end

		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:RELATIONSHIP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:Relationship")
AddEventHandler("player:Relationship",function(Group)
	if Group == "Ballas" then
		SetRelationshipBetweenGroups(1,GetHashKey("AMBIENT_GANG_BALLAS"),GetHashKey("PLAYER"))
		SetRelationshipBetweenGroups(1,GetHashKey("PLAYER"),GetHashKey("AMBIENT_GANG_BALLAS"))
	elseif Group == "Families" then
		SetRelationshipBetweenGroups(1,GetHashKey("AMBIENT_GANG_FAMILY"),GetHashKey("PLAYER"))
		SetRelationshipBetweenGroups(1,GetHashKey("PLAYER"),GetHashKey("AMBIENT_GANG_FAMILY"))
	elseif Group == "Vagos" then
		SetRelationshipBetweenGroups(1,GetHashKey("AMBIENT_GANG_MEXICAN"),GetHashKey("PLAYER"))
		SetRelationshipBetweenGroups(1,GetHashKey("PLAYER"),GetHashKey("AMBIENT_GANG_MEXICAN"))
	elseif Group == "TheLost" then
		SetRelationshipBetweenGroups(1,GetHashKey("AMBIENT_GANG_LOST"),GetHashKey("PLAYER"))
		SetRelationshipBetweenGroups(1,GetHashKey("PLAYER"),GetHashKey("AMBIENT_GANG_LOST"))
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANCORAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ancorar",function(source,args,rawCommand)
	local ped = PlayerPedId()
	if IsPedInAnyBoat(ped) then
		local Vehicle = GetVehiclePedIsUsing(ped)
		if CanAnchorBoatHere(Vehicle) then
			TriggerEvent("Notify","verde","Embarcação desancorado.",5000)
			SetBoatAnchor(Vehicle,false)
		else
			TriggerEvent("Notify","verde","Embarcação ancorada.",5000)
			SetBoatAnchor(Vehicle,true)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRUNKABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local inTrash = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:ENTERTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:enterTrash")
AddEventHandler("player:enterTrash",function(entity)
	if not inTrash then
		inTrash = true
		blockCommands = true
		playerInvisible = true

		local ped = PlayerPedId()
		FreezeEntityPosition(ped,true)
		SetEntityVisible(ped,false,false)
		SetEntityCoords(ped,entity[4],1,0,0,0)

		inTrash = GetOffsetFromEntityInWorldCoords(entity[1],0.0,-1.5,0.0)

		while inTrash do
			Citizen.Wait(1)

			if IsControlJustPressed(1,38) then
				FreezeEntityPosition(ped,false)
				SetEntityVisible(ped,true,false)
				SetEntityCoords(ped,inTrash,1,0,0,0)
				blockCommands = false
				playerInvisible = false

				inTrash = false
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CHECKTRASH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:checkTrash")
AddEventHandler("player:checkTrash",function()
	if inTrash then
		local ped = PlayerPedId()
		FreezeEntityPosition(ped,false)
		SetEntityVisible(ped,true,false)
		SetEntityCoords(ped,inTrash,1,0,0,0)
		blockCommands = false
		playerInvisible = false

		inTrash = false
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOCHILA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("mochila",function(source,args,rawCommand)
	SetPedComponentVariation(PlayerPedId(),5,parseInt(args[1]),parseInt(args[2]),1)
end)