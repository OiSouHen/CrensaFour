-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPS = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("inventory",cRP)
vSERVER = Tunnel.getInterface("inventory")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local dropList = {}
local useWeapon = ""
local Backpack = false
local weaponActive = false
local putWeaponHands = false
local storeWeaponHands = false
local timeReload = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLOCKBUTTONS
-----------------------------------------------------------------------------------------------------------------------------------------
local blockButtons = false
RegisterNetEvent("inventory:blockButtons")
AddEventHandler("inventory:blockButtons",function(status)
	blockButtons = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLOCKS
-----------------------------------------------------------------------------------------------------------------------------------------
function blockInvents()
	if exports["player"]:handCuff() then
		return false
	end

	return blockButtons
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBUTTONS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)

	while true do
		local timeDistance = 999
		if blockButtons then
			timeDistance = 1
			DisableControlAction(1,75,true)
			DisableControlAction(1,47,true)
			DisableControlAction(1,257,true)
			DisablePlayerFiring(PlayerPedId(),true)
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLOCKINVENTS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("blockInvents",blockInvents)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GRIDCHUNK
-----------------------------------------------------------------------------------------------------------------------------------------
function gridChunk(x)
	return math.floor((x + 8192) / 128)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOCHANNEL
-----------------------------------------------------------------------------------------------------------------------------------------
function toChannel(v)
	return (v["x"] << 8) | v["y"]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETGRIDZONE
-----------------------------------------------------------------------------------------------------------------------------------------
function getGridzone(x,y)
	local gridChunk = vector2(gridChunk(x),gridChunk(y))
	return toChannel(gridChunk)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.dropFunctions()
	local ped = PlayerPedId()
	local coords = GetOffsetFromEntityInWorldCoords(ped,0.0,0.5,0.0)

	local gridZone = getGridzone(coords["x"],coords["y"])
	local _,cdz = GetGroundZFor_3dCoord(coords["x"],coords["y"],coords["z"])

	return coords["x"],coords["y"],cdz,gridZone
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Close")
AddEventHandler("inventory:Close",function()
	if Backpack then
		Backpack = false
		SetNuiFocus(false,false)
		SetCursorLocation(0.5,0.5)
		TriggerEvent("hud:Active",true)
		SendNUIMessage({ action = "hideMenu" })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("invClose",function()
	TriggerEvent("inventory:Close")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Craft",function()
	Backpack = false
	SetNuiFocus(false,false)
	TriggerEvent("hud:Active",true)
	SendNUIMessage({ action = "hideMenu" })

	TriggerEvent("crafting:openSource")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- USEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("useItem",function(data)
	if MumbleIsConnected() then
		vSERVER.useItem(data["slot"],data["amount"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SENDITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("sendItem",function(data)
	if MumbleIsConnected() then
		vSERVER.sendItem(data["slot"],data["amount"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateSlot",function(data)
	if MumbleIsConnected() then
		vSERVER.invUpdate(data["slot"],data["target"],data["amount"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Update")
AddEventHandler("inventory:Update",function(action)
	if MumbleIsConnected() then
		SendNUIMessage({ action = action })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CLEANWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:CleanWeapons")
AddEventHandler("inventory:CleanWeapons",function()
	RemoveAllPedWeapons(PlayerPedId(),true)
	TriggerEvent("hud:Weapon",false)
	weaponActive = false
	useWeapon = ""
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CLEARWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:clearWeapons")
AddEventHandler("inventory:clearWeapons",function()
	if useWeapon ~= "" then
		RemoveAllPedWeapons(PlayerPedId(),true)
		TriggerEvent("hud:Weapon",false)
		weaponActive = false
		useWeapon = ""
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:VERIFYWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:verifyWeapon")
AddEventHandler("inventory:verifyWeapon",function(nameItem,splitName)
	local equipeNow = false
	local ped = PlayerPedId()
	local weaponAmmo = GetAmmoInPedWeapon(ped,useWeapon)
	
	if useWeapon == splitName then
		vSERVER.preventWeapon(useWeapon,weaponAmmo)
		TriggerEvent("hud:Weapon",false)
		weaponActive = false
		equipeNow = true
		useWeapon = ""
	end
	
	if not vSERVER.checkExistWeapon(nameItem,weaponAmmo,equipeNow) then
		if HasPedGotWeapon(ped,GetHashKey(splitName),false) then
			RemoveAllPedWeapons(ped,true)
		end
	end
	
	RemoveAllPedWeapons(ped,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:PREVENTWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:preventWeapon")
AddEventHandler("inventory:preventWeapon",function(storeWeapons)
	if useWeapon ~= "" then
		local ped = PlayerPedId()
		local weaponAmmo = GetAmmoInPedWeapon(ped,useWeapon)

		vSERVER.preventWeapon(useWeapon,weaponAmmo)

		useWeapon = ""
		weaponActive = false
		TriggerEvent("hud:Weapon",false)

		if storeWeapons then
			RemoveAllPedWeapons(ped,true)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTERVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.enterVehicle()
	local ped = PlayerPedId()
	if GetVehiclePedIsTryingToEnter(ped) > 0 then
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENBACKPACK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("openBackpack",function(source,args,rawCommand)
	if GetEntityHealth(PlayerPedId()) > 101 and not blockButtons and MumbleIsConnected() then
		if not exports["player"]:blockCommands() and not exports["player"]:handCuff() and not IsPlayerFreeAiming(PlayerId()) then
			Backpack = true
			SetNuiFocus(true,true)
			SetCursorLocation(0.5,0.5)
			TriggerEvent("hud:Active",false)
			SendNUIMessage({ action = "showMenu" })
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYMAPPING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("openBackpack","Manusear a mochila.","keyboard","OEM_3")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLATEVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.plateVehicle()
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped) then
		local vehicle = GetVehiclePedIsUsing(ped)
		if GetPedInVehicleSeat(vehicle,-1) == ped then
			FreezeEntityPosition(vehicle,true)
			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLATEAPPLY
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.plateApply(plate)
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped) then
		local vehicle = GetVehiclePedIsUsing(ped)

		SetVehicleNumberPlateText(vehicle,plate)
		FreezeEntityPosition(vehicle,false)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPAIRVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:repairVehicle")
AddEventHandler("inventory:repairVehicle",function(vehIndex,vehPlate)
	if NetworkDoesNetworkIdExist(vehIndex) then
		local Vehicle = NetToEnt(vehIndex)
		if DoesEntityExist(Vehicle) then
			if GetVehicleNumberPlateText(Vehicle) == vehPlate then
				local vehTyres = {}

				for i = 0,7 do
					local Status = false

					if GetTyreHealth(Vehicle,i) ~= 1000.0 then
						Status = true
					end

					vehTyres[i] = Status
				end

				SetVehicleFixed(Vehicle)
				SetVehicleDeformationFixed(Vehicle)

				for Tyre,Burst in pairs(vehTyres) do
					if Burst then
						SetVehicleTyreBurst(Vehicle,Tyre,true,1000.0)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPAIRTYRES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:repairTyres")
AddEventHandler("inventory:repairTyres",function(vehIndex)
	if NetworkDoesNetworkIdExist(vehIndex) then
		local v = NetToEnt(vehIndex)
		if DoesEntityExist(v) then
			for i = 0,7 do
				SetVehicleTyreFixed(v,i)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPAIRPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:repairPlayer")
AddEventHandler("inventory:repairPlayer",function(vehIndex,vehPlate)
	if NetworkDoesNetworkIdExist(vehIndex) then
		local Vehicle = NetToEnt(vehIndex)
		if DoesEntityExist(Vehicle) then
			if GetVehicleNumberPlateText(Vehicle) == vehPlate then
				SetVehicleEngineHealth(Vehicle,1000.0)
				SetVehicleBodyHealth(Vehicle,1000.0)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPAIRADMIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:repairAdmin")
AddEventHandler("inventory:repairAdmin",function(vehIndex,vehPlate)
	if NetworkDoesNetworkIdExist(vehIndex) then
		local Vehicle = NetToEnt(vehIndex)
		if DoesEntityExist(Vehicle) then
			if GetVehicleNumberPlateText(Vehicle) == vehPlate then
				SetVehicleFixed(Vehicle)
				SetVehicleDeformationFixed(Vehicle)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLEALARM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:vehicleAlarm")
AddEventHandler("inventory:vehicleAlarm",function(vehIndex,vehPlate)
	if NetworkDoesNetworkIdExist(vehIndex) then
		local Vehicle = NetToEnt(vehIndex)
		if DoesEntityExist(Vehicle) then
			if GetVehicleNumberPlateText(Vehicle) == vehPlate then
				SetVehicleAlarm(Vehicle,true)
				StartVehicleAlarm(Vehicle)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARACHUTECOLORS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.parachuteColors()
	local ped = PlayerPedId()
	GiveWeaponToPed(ped,"GADGET_PARACHUTE",1,false,true)
	SetPedParachuteTintIndex(ped,math.random(7))
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FISHCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
local fishCoords = PolyZone:Create({
	vector2(2308.64,3906.11),
	vector2(2180.13,3885.29),
	vector2(2058.22,3883.56),
	vector2(2024.97,3942.53),
	vector2(1748.72,3964.53),
	vector2(1655.65,3886.34),
	vector2(1547.59,3830.17),
	vector2(1540.73,3826.94),
	vector2(1535.67,3816.55),
	vector2(1456.35,3756.87),
	vector2(1263.44,3670.38),
	vector2(1172.99,3648.83),
	vector2(967.98,3653.54),
	vector2(840.55,3679.16),
	vector2(633.13,3600.70),
	vector2(361.73,3626.24),
	vector2(310.58,3571.61),
	vector2(266.92,3493.13),
	vector2(173.49,3421.45),
	vector2(128.16,3442.66),
	vector2(143.41,3743.49),
	vector2(-38.59,3754.16),
	vector2(-132.62,3716.80),
	vector2(-116.73,3805.33),
	vector2(-157.23,3838.81),
	vector2(-204.70,3846.28),
	vector2(-208.28,3873.08),
	vector2(-236.88,4076.58),
	vector2(-184.11,4231.52),
	vector2(-139.54,4253.54),
	vector2(-45.38,4344.43),
	vector2(-5.96,4408.34),
	vector2(38.36,4411.02),
	vector2(150.77,4311.74),
	vector2(216.02,4342.85),
	vector2(294.16,4245.62),
	vector2(396.21,4342.24),
	vector2(438.37,4315.38),
	vector2(505.22,4178.69),
	vector2(606.65,4202.34),
	vector2(684.48,4169.83),
	vector2(773.54,4152.33),
	vector2(877.34,4172.67),
	vector2(912.20,4269.57),
	vector2(850.92,4428.91),
	vector2(922.96,4376.48),
	vector2(941.32,4328.09),
	vector2(995.318,4288.70),
	vector2(1050.33,4215.29),
	vector2(1082.27,4285.61),
	vector2(1060.97,4365.31),
	vector2(1072.62,4372.37),
	vector2(1119.24,4317.53),
	vector2(1275.27,4354.90),
	vector2(1360.96,4285.09),
	vector2(1401.09,4283.69),
	vector2(1422.33,4339.60),
	vector2(1516.60,4393.69),
	vector2(1597.58,4455.65),
	vector2(1650.81,4499.17),
	vector2(1781.12,4525.83),
	vector2(1828.69,4560.26),
	vector2(1866.59,4554.49),
	vector2(2162.70,4664.53),
	vector2(2279.31,4660.26),
	vector2(2290.52,4630.90),
	vector2(2418.64,4613.91),
	vector2(2427.06,4597.69),
	vector2(2449.86,4438.97),
	vector2(2396.62,4353.36),
	vector2(2383.66,4160.74),
	vector2(2383.05,4046.07)
},{ name = "Pescaria" })
-----------------------------------------------------------------------------------------------------------------------------------------
-- FISHINGCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.fishingCoords()
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	if fishCoords:isPointInside(coords) and IsEntityInWater(ped) then
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FISHINGANIM
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.fishingAnim()
	local ped = PlayerPedId()
	if IsEntityPlayingAnim(ped,"amb@world_human_stand_fishing@idle_a","idle_c",3) then
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANIMALANIM
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.animalAnim()
	local ped = PlayerPedId()
	if IsEntityPlayingAnim(ped,"anim@gangops@facility@servers@bodysearch@","player_search",3) then
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkWeapon()
	local ped = PlayerPedId()
	if (GetPedParachuteState(ped) == -1 or GetPedParachuteState(ped) == 0) and not IsPedInParachuteFreeFall(ped) and not IsPedSwimming(ped) then
		if useWeapon ~= "" then
			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKGARBAGEMAN
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkGarbageman()
    if GetEntityModel(GetPlayersLastVehicle()) == 1917016601 then
        return true
    end
	
    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:STEALTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:stealTrunk")
AddEventHandler("inventory:stealTrunk",function(entity)
	if MumbleIsConnected() then
		if useWeapon == "WEAPON_CROWBAR" then
			local trunk = GetEntityBoneIndexByName(entity[3],"boot")
			if trunk ~= -1 then
				local ped = PlayerPedId()
				local coords = GetOffsetFromEntityInWorldCoords(ped,0.0,0.5,0.0)
				local coordsEnt = GetWorldPositionOfEntityBone(entity[3],trunk)
				local distance = #(coords - coordsEnt)
				if distance <= 2.0 then
					vSERVER.stealTrunk(entity)
				end
			end
		else
			TriggerEvent("Notify","amarelo","<b>Pé de Cabra</b> não encontrado.",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:ANIMALS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Animals")
AddEventHandler("inventory:Animals",function(entity)
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	if vSERVER.checkSwitchblade() and GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_UNARMED") then
		TaskTurnPedToFaceEntity(ped,entity[1],-1)
		TriggerEvent("player:blockCommands",true)
		local targetEntity = entity[1]
		TriggerEvent("cancelando",true)
		entity[1] = nil

		Citizen.Wait(1000)
						
		vRP.playAnim(true,{"anim@gangops@facility@servers@bodysearch@","player_search"},true)
		vRP.playAnim(false,{"amb@medic@standing@kneel@base","base"},true)
		TriggerEvent("Progress",15000)

		Citizen.Wait(15000)

		TriggerEvent("player:blockCommands",false)
		TriggerEvent("cancelando",false)
		vSERVER.animalPayment()
		vRP.removeObjects(targetEntity)

		if DoesEntityExist(targetEntity) then
			DeleteEntity(targetEntity)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PUTWEAPONHANDS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.putWeaponHands(weaponName,weaponAmmo)
	if not putWeaponHands then
		if weaponAmmo == nil then
			weaponAmmo = 0
		end

		if weaponAmmo > 0 then
			weaponActive = true
		end

		putWeaponHands = true
		TriggerEvent("cancelando",true)

		local ped = PlayerPedId()
		if HasPedGotWeapon(ped,GetHashKey("GADGET_PARACHUTE"),false) then
			RemoveAllPedWeapons(ped,true)
			GiveWeaponToPed(ped,"GADGET_PARACHUTE",1,false,true)
			SetPedParachuteTintIndex(ped,math.random(7))
		else
			RemoveAllPedWeapons(ped,true)
		end

		if not IsPedInAnyVehicle(ped) then
			loadAnimDict("rcmjosh4")

			TaskPlayAnim(ped,"rcmjosh4","josh_leadout_cop2",3.0,2.0,-1,48,10,0,0,0)

			Citizen.Wait(200)

			GiveWeaponToPed(ped,weaponName,weaponAmmo,false,true)

			Citizen.Wait(300)

			ClearPedTasks(ped)
		else
			GiveWeaponToPed(ped,weaponName,weaponAmmo,true,true)
		end

		TriggerEvent("cancelando",false)
		useWeapon = weaponName
		putWeaponHands = false
		
		-- if itemAmmo(weaponName) then
			TriggerEvent("hud:Weapon",true,weaponName)
		-- end

		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREWEAPONHANDS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.storeWeaponHands()
	if not storeWeaponHands then
		storeWeaponHands = true
		TriggerEvent("cancelando",true)

		local ped = PlayerPedId()
		local lastWeapon = useWeapon
		local weaponAmmo = GetAmmoInPedWeapon(ped,useWeapon)

		if not IsPedInAnyVehicle(ped) then
			loadAnimDict("weapons@pistol@")

			TaskPlayAnim(ped,"weapons@pistol@","aim_2_holster",3.0,2.0,-1,48,10,0,0,0)

			Citizen.Wait(450)

			ClearPedTasks(ped)
		end

		if HasPedGotWeapon(ped,GetHashKey("GADGET_PARACHUTE"),false) then
			RemoveAllPedWeapons(ped,true)
			GiveWeaponToPed(ped,"GADGET_PARACHUTE",1,false,true)
			SetPedParachuteTintIndex(ped,math.random(7))
		else
			RemoveAllPedWeapons(ped,true)
		end

		useWeapon = ""
		weaponActive = false

		storeWeaponHands = false
		TriggerEvent("cancelando",false)
		TriggerEvent("hud:Weapon",false)

		return true,parseInt(weaponAmmo),lastWeapon
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEAPONAMMOS
-----------------------------------------------------------------------------------------------------------------------------------------
local weaponAmmos = {
	["WEAPON_PISTOL_AMMO"] = {
		"WEAPON_PISTOL",
		"WEAPON_PISTOL_MK2",
		"WEAPON_PISTOL50",
		"WEAPON_REVOLVER",
		"WEAPON_COMBATPISTOL",
		"WEAPON_APPISTOL",
		"WEAPON_HEAVYPISTOL",
		"WEAPON_SNSPISTOL",
		"WEAPON_SNSPISTOL_MK2",
		"WEAPON_VINTAGEPISTOL"
	},
	["WEAPON_SMG_AMMO"] = {
		"WEAPON_MICROSMG",
		"WEAPON_MINISMG",
		"WEAPON_SMG",
		"WEAPON_SMG_MK2",
		"WEAPON_GUSENBERG",
		"WEAPON_MACHINEPISTOL"
	},
	["WEAPON_RIFLE_AMMO"] = {
		"WEAPON_COMPACTRIFLE",
		"WEAPON_CARBINERIFLE",
		"WEAPON_CARBINERIFLE_MK2",
		"WEAPON_BULLPUPRIFLE",
		"WEAPON_BULLPUPRIFLE_MK2",
		"WEAPON_ADVANCEDRIFLE",
		"WEAPON_ASSAULTRIFLE",
		"WEAPON_ASSAULTSMG",
		"WEAPON_ASSAULTRIFLE_MK2",
		"WEAPON_SPECIALCARBINE",
		"WEAPON_SPECIALCARBINE_MK2"
	},
	["WEAPON_SHOTGUN_AMMO"] = {
		"WEAPON_PUMPSHOTGUN",
		"WEAPON_PUMPSHOTGUN_MK2",
		"WEAPON_SAWNOFFSHOTGUN"
	},
	["WEAPON_MUSKET_AMMO"] = {
		"WEAPON_SNIPERRIFLE",
		"WEAPON_MUSKET"
	},
	["WEAPON_PETROLCAN_AMMO"] = {
		"WEAPON_PETROLCAN"
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- RECHARGECHECK
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.rechargeCheck(ammoType)
	local weaponHash = nil
	local ped = PlayerPedId()
	local weaponStatus = false

	if weaponAmmos[ammoType] then
		local weaponAmmo = GetAmmoInPedWeapon(ped,useWeapon)

		for k,v in pairs(weaponAmmos[ammoType]) do
			if useWeapon == v then
				weaponHash = GetHashKey(useWeapon)
				weaponStatus = true
				break
			end
		end
	end

	return weaponStatus,weaponHash,parseInt(weaponAmmo)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RECHARGEWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.rechargeWeapon(weaponHash,ammoAmount)
	AddAmmoToPed(PlayerPedId(),weaponHash,ammoAmount)
	weaponActive = true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTOREWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	
	while true do
		local timeDistance = 999
		if weaponActive and useWeapon ~= "" then
			timeDistance = 100
			local ped = PlayerPedId()
			local weaponAmmo = GetAmmoInPedWeapon(ped,useWeapon)

			if GetGameTimer() >= timeReload and IsPedReloading(ped) then
				vSERVER.preventWeapon(useWeapon,weaponAmmo)
				timeReload = GetGameTimer() + 1000
			end

			if weaponAmmo <= 0 or (useWeapon == "WEAPON_PETROLCAN" and weaponAmmo <= 135 and IsPedShooting(ped)) or IsPedSwimming(ped) then
				vSERVER.preventWeapon(useWeapon,weaponAmmo)
				TriggerEvent("hud:Weapon",false)
				RemoveAllPedWeapons(ped,true)
				weaponActive = false
				useWeapon = ""
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADRENALINECDS
-----------------------------------------------------------------------------------------------------------------------------------------
local adrenalineCds = {
	{ -469.26,6289.48,13.61 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADRENALINEDISTANCE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.adrenalineDistance()
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)

	for k,v in pairs(adrenalineCds) do
		local distance = #(coords - vector3(v[1],v[2],v[3]))
		if distance <= 5 then
			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FIREVARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local fireTimers = nil
local firecracker = nil
-----------------------------------------------------------------------------------------------------------------------------------------
-- FIRETIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if fireTimers ~= nil then
			if GetGameTimer() >= fireTimers then
				fireTimers = nil
			end
		end

		Citizen.Wait(10000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKCRACKER
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkCracker()
	if fireTimers ~= nil then
		return false
	end

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FIRECRACKER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Firecracker")
AddEventHandler("inventory:Firecracker",function()
	if not HasNamedPtfxAssetLoaded("scr_indep_fireworks") then
		RequestNamedPtfxAsset("scr_indep_fireworks")
		while not HasNamedPtfxAssetLoaded("scr_indep_fireworks") do
			Citizen.Wait(1)
		end
	end

	local mHash = GetHashKey("ind_prop_firework_03")

	RequestModel(mHash)
	while not HasModelLoaded(mHash) do
		Citizen.Wait(1)
	end

	if HasModelLoaded(mHash) then
		local explosives = 25
		local ped = PlayerPedId()
		fireTimers = GetGameTimer() + (5 * 60000)
		local coords = GetOffsetFromEntityInWorldCoords(ped,0.0,0.6,0.0)
		firecracker = CreateObject(mHash,coords["x"],coords["y"],coords["z"],true,true,false)

		PlaceObjectOnGroundProperly(firecracker)
		FreezeEntityPosition(firecracker,true)
		SetEntityAsNoLongerNeeded(firecracker)
		SetModelAsNoLongerNeeded(mHash)

		Citizen.Wait(10000)

		repeat
			UseParticleFxAssetNextCall("scr_indep_fireworks")
			local explode = StartNetworkedParticleFxNonLoopedAtCoord("scr_indep_firework_trailburst",coords["x"],coords["y"],coords["z"],0.0,0.0,0.0,2.5,false,false,false,false)
			explosives = explosives - 1

			Citizen.Wait(2000)
		until explosives <= 0

		TriggerServerEvent("tryDeleteObject",NetworkGetNetworkIdFromEntity(firecracker))
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKWATER
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkWater()
	return IsPedSwimming(PlayerPedId())
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLECARRY
-----------------------------------------------------------------------------------------------------------------------------------------
local uCarry = nil
local iCarry = false
local sCarry = false
RegisterNetEvent("toggleCarry")
AddEventHandler("toggleCarry",function(source)
	uCarry = source
	iCarry = not iCarry

	local ped = PlayerPedId()
	if iCarry and uCarry then
		Citizen.InvokeNative(0x6B9BBD38AB0796DF,ped,GetPlayerPed(GetPlayerFromServerId(uCarry)),4103,11816,0.48,0.0,0.0,0.0,0.0,0.0,false,false,false,false,2,true)
		sCarry = true
	else
		if sCarry then
			DetachEntity(ped,false,false)
			sCarry = false
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOADANIMDIC
-----------------------------------------------------------------------------------------------------------------------------------------
function loadAnimDict(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(1)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKSTOCKADE
-----------------------------------------------------------------------------------------------------------------------------------------
local stockTimers = 0
local stockVehicle = nil

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
},{ name="santos" })

function cRP.checkStockade(vehNet)
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)

	if losSantos:isPointInside(coords) then
		if not IsPedInAnyVehicle(ped) then
			local vehicle = vRP.nearVehicle(10)
			if NetworkGetNetworkIdFromEntity(vehicle) == vehNet then
				if DoesEntityExist(vehicle) and GetEntityModel(vehicle) == GetHashKey("stockade") then
					local coordsVeh = GetOffsetFromEntityInWorldCoords(vehicle,0.0,-3.5,0.0)
					local distance = #(coords - coordsVeh)
					if distance <= 1.5 then
						stockTimers = 30
						stockVehicle = vehicle

						return NetworkGetNetworkIdFromEntity(vehicle)
					end
				end
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXPLODESTOCKADE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if stockTimers > 0 then
			stockTimers = stockTimers - 1

			if stockTimers <= 0 then
				local coordsVeh = GetOffsetFromEntityInWorldCoords(stockVehicle,0.0,-4.5,0.0)
				local _,cdz = GetGroundZFor_3dCoord(coordsVeh["x"],coordsVeh["y"],coordsVeh["z"])
				local gridZone = getGridzone(coordsVeh["x"],coordsVeh["y"])

				SetVehicleDoorBroken(stockVehicle,2,false)
				SetVehicleDoorBroken(stockVehicle,3,false)
				vSERVER.dropStockade(coordsVeh["x"],coordsVeh["y"],cdz,gridZone)
				AddExplosion(coordsVeh["x"],coordsVeh["y"],coordsVeh["z"],"EXPLOSION_TANKER",2.0,true,false,2.0)
				ApplyForceToEntity(stockVehicle,0,coordsVeh["x"],coordsVeh["y"],coordsVeh["z"],0.0,0.0,0.0,1,false,true,true,true,true)

				stockVehicle = nil
			end
		end

		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:DROPREMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:dropRemove")
AddEventHandler("inventory:dropRemove",function(gridZone,numberSelect)
	if dropList[gridZone] then
		if dropList[gridZone][numberSelect] then
			dropList[gridZone][numberSelect] = nil
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:DROPINSERT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:dropInsert")
AddEventHandler("inventory:dropInsert",function(gridZone,numberSelect,dropTable)
	if dropList[gridZone] == nil then
		dropList[gridZone] = {}
	end

	dropList[gridZone][numberSelect] = dropTable
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:DROPLIST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:dropList")
AddEventHandler("inventory:dropList",function(dropTable)
	dropList = dropTable
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("dropItem",function(data)
	if MumbleIsConnected() then
		local ped = PlayerPedId()
		local coords = GetOffsetFromEntityInWorldCoords(ped,0.0,0.5,0.0)
		local gridZone = getGridzone(coords["x"],coords["y"])
	local _,cdz = GetGroundZFor_3dCoord(coords["x"],coords["y"],coords["z"])

		vSERVER.dropItem(data["item"],data["slot"],data["amount"],coords["x"],coords["y"],cdz,gridZone)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADDROPBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		local gridZone = getGridzone(coords["x"],coords["y"])

		if dropList[gridZone] then
			for k,v in pairs(dropList[gridZone]) do
				local distance = #(coords - vector3(v["coords"][1],v["coords"][2],v["coords"][3]))
				if distance <= 50 then
					timeDistance = 1
					DrawMarker(21,v["coords"][1],v["coords"][2],v["coords"][3] + 0.25,0.0,0.0,0.0,0.0,180.0,0.0,0.25,0.35,0.25,46,110,76,100,0,0,0,1)
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTINVENTORY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestInventory",function(data,cb)
	local dropItems = {}
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	local gridZone = getGridzone(coords["x"],coords["y"])
	local _,cdz = GetGroundZFor_3dCoord(coords["x"],coords["y"],coords["z"])

	if dropList[gridZone] then
		for k,v in pairs(dropList[gridZone]) do
			local distance = #(vector3(coords["x"],coords["y"],cdz) - vector3(v["coords"][1],v["coords"][2],v["coords"][3]))
			if distance <= 0.9 then
				v["id"] = k
				table.insert(dropItems,v)
			end
		end
	end

	local inventario,invPeso,invMaxpeso = vSERVER.requestInventory()
	if inventario then
		cb({ inventario = inventario, drop = dropItems, invPeso = invPeso, invMaxpeso = invMaxpeso })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PICKUPITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("pickupItem",function(data)
	if MumbleIsConnected() then
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		local gridZone = getGridzone(coords["x"],coords["y"])

		vSERVER.itemPickup(data["id"],data["amount"],data["target"],gridZone)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WHEELCHAIR
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.wheelChair(vehPlate)
	local ped = PlayerPedId()
	local vehName = "wheelchair"
	local mHash = GetHashKey(vehName)

	RequestModel(mHash)
	while not HasModelLoaded(mHash) do
		Citizen.Wait(1)
	end

	local heading = GetEntityHeading(ped)
	local coords = GetOffsetFromEntityInWorldCoords(ped,0.0,0.75,0.0)
	local nveh = CreateVehicle(mHash,coords["x"],coords["y"],coords["z"],heading,true,true)

	SetVehicleOnGroundProperly(nveh)
	SetVehicleNumberPlateText(nveh,vehPlate)
	SetEntityAsMissionEntity(nveh,true,true)
	SetModelAsNoLongerNeeded(mHash)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WHEELTREADS
-----------------------------------------------------------------------------------------------------------------------------------------
local wheelChair = false
Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			local vehicle = GetVehiclePedIsUsing(ped)
			local model = GetEntityModel(vehicle)
			if model == -1178021069 then
				if not IsEntityPlayingAnim(ped,"missfinale_c2leadinoutfin_c_int","_leadin_loop2_lester",3) then
					vRP.playAnim(true,{"missfinale_c2leadinoutfin_c_int","_leadin_loop2_lester"},true)
					wheelChair = true
				end
			end
		else
			if wheelChair then
				vRP.removeObjects("one")
				wheelChair = false
			end
		end

		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARISCANNER
-----------------------------------------------------------------------------------------------------------------------------------------
local scanTable = {}
local initSounds = {}
local soundScanner = 999
local userScanner = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- SCANCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
local scanCoords = {
	{ -1811.94,-968.5,1.72,357.17 },
	{ -1788.29,-958.0,3.35,328.82 },
	{ -1756.9,-942.98,6.91,311.82 },
	{ -1759.97,-910.12,7.58,334.49 },
	{ -1791.44,-904.11,5.12,39.69 },
	{ -1827.87,-900.32,2.48,68.04 },
	{ -1840.76,-882.39,2.81,51.03 },
	{ -1793.4,-819.9,7.73,328.82 },
	{ -1737.69,-791.3,9.44,317.49 },
	{ -1714.6,-784.61,9.82,306.15 },
	{ -1735.88,-757.92,10.11,2.84 },
	{ -1763.22,-764.65,9.49,65.2 },
	{ -1786.23,-782.4,8.71,99.22 },
	{ -1809.5,-798.29,7.89,104.89 },
	{ -1816.35,-827.68,6.44,141.74 },
	{ -1833.23,-856.58,3.52,147.41 },
	{ -1842.88,-869.45,2.98,144.57 },
	{ -1865.34,-858.4,2.12,99.22 },
	{ -1868.01,-835.58,3.0,51.03 },
	{ -1860.76,-810.59,4.04,8.51 },
	{ -1848.85,-790.99,6.3,348.67 },
	{ -1834.31,-767.03,8.17,337.33 },
	{ -1819.3,-742.04,8.85,331.66 },
	{ -1804.76,-713.39,9.76,331.66 },
	{ -1805.32,-695.22,10.23,348.67 },
	{ -1824.32,-685.97,10.23,36.86 },
	{ -1849.16,-699.25,9.45,85.04 },
	{ -1868.9,-716.3,8.86,110.56 },
	{ -1890.07,-736.57,6.27,124.73 },
	{ -1909.8,-759.44,3.52,130.4 },
	{ -1920.19,-782.25,2.8,144.57 },
	{ -1939.84,-765.34,1.99,85.04 },
	{ -1932.96,-746.47,3.05,8.51 },
	{ -1954.69,-722.8,3.03,28.35 },
	{ -1954.53,-688.85,4.06,11.34 },
	{ -1939.8,-651.94,8.74,351.5 },
	{ -1926.48,-627.37,10.67,348.67 },
	{ -1920.73,-615.67,10.95,340.16 },
	{ -1924.48,-596.03,11.56,51.03 },
	{ -1952.53,-597.0,11.02,70.87 },
	{ -1972.12,-609.32,8.73,102.05 },
	{ -1989.01,-629.48,5.21,124.73 },
	{ -2002.97,-659.48,3.03,141.74 },
	{ -2028.03,-658.61,1.82,107.72 },
	{ -2045.57,-637.91,2.02,65.2 },
	{ -2031.42,-618.65,3.23,0.0 },
	{ -2003.74,-603.38,6.3,328.82 },
	{ -1982.79,-588.43,10.01,317.49 },
	{ -1968.4,-565.72,11.42,323.15 },
	{ -1980.98,-545.43,11.58,5.67 },
	{ -1996.36,-552.72,11.68,17.01 },
	{ -2013.33,-573.78,8.95,102.05 },
	{ -2030.05,-604.62,3.93,133.23 },
	{ -2035.79,-626.99,3.0,150.24 },
	{ -2053.05,-626.67,2.31,113.39 },
	{ -2062.58,-596.05,3.03,45.36 },
	{ -2096.8,-579.13,2.75,53.86 },
	{ -2116.49,-559.09,2.29,48.19 },
	{ -2093.8,-539.57,3.74,22.68 },
	{ -2067.11,-526.37,6.98,328.82 },
	{ -2049.71,-516.4,9.13,308.98 },
	{ -2029.87,-507.17,11.49,300.48 },
	{ -2049.27,-492.94,11.17,11.34 },
	{ -2073.38,-483.05,9.13,42.52 },
	{ -2102.99,-470.71,6.52,56.7 },
	{ -2119.62,-451.87,6.67,48.19 },
	{ -2134.43,-460.37,5.24,93.55 },
	{ -1805.06,-936.1,2.53,189.93 },
	{ -1786.4,-932.99,4.38,269.3},
	{ -1744.87,-926.96,7.65,269.3 },
	{ -1763.18,-925.72,6.99,104.89 },
	{ -1773.65,-895.76,7.35,357.17 },
	{ -1750.28,-883.7,7.75,277.8 },
	{ -1733.24,-862.29,8.17,311.82 },
	{ -1703.01,-838.56,9.03,300.48 },
	{ -1720.85,-834.19,8.95,31.19 },
	{ -1747.12,-839.86,8.39,138.9 },
	{ -1764.27,-856.95,7.75,147.41 },
	{ -1776.27,-868.44,7.78,119.06 },
	{ -1803.86,-872.72,5.34,93.55 },
	{ -1744.12,-901.55,7.7,79.38 },
	{ -1765.09,-808.12,8.58,31.19 },
	{ -1773.17,-728.07,10.01,8.51 },
	{ -1849.14,-729.09,8.85,136.07 },
	{ -1866.65,-758.66,6.96,150.24 },
	{ -1886.42,-794.12,3.25,158.75 },
	{ -1795.97,-748.07,9.17,297.64 },
	{ -1915.8,-682.79,8.0,62.37 },
	{ -1911.86,-651.71,10.26,0.0 },
	{ -1899.29,-623.49,11.34,345.83 },
	{ -1847.11,-670.69,10.45,17.01 },
	{ -1874.69,-647.34,10.92,39.69 },
	{ -1958.9,-629.78,8.34,73.71 },
	{ -1951.39,-575.59,11.53,343.0 },
	{ -1991.28,-569.55,10.72,164.41 },
	{ -2056.68,-569.32,4.57,99.22 },
	{ -2088.29,-560.62,3.27,87.88 },
	{ -2042.45,-542.51,8.46,308.98 },
	{ -2020.91,-528.58,11.12,306.15 },
	{ -2092.91,-499.58,5.37,79.38 },
	{ -2113.6,-521.59,2.27,147.41 },
	{ -2139.09,-496.06,2.27,48.19 },
	{ -2122.44,-486.23,3.56,280.63 },
	{ -2034.27,-577.42,6.74,294.81 },
	{ -2003.72,-536.62,11.78,320.32 },
	{ -2023.41,-551.31,9.59,255.12 },
	{ -2014.0,-626.04,3.76,189.93 },
	{ -1967.67,-656.53,5.24,255.12 },
	{ -1878.77,-672.36,9.76,257.96 },
	{ -1827.96,-702.26,9.67,240.95 },
	{ -1855.87,-771.67,6.94,164.41 },
	{ -1846.08,-830.98,3.79,175.75 },
	{ -1830.72,-804.5,6.67,334.49 },
	{ -1770.76,-835.92,7.84,311.82 },
	{ -1724.61,-812.2,9.25,303.31 },
	{ -1828.9,-719.11,9.3,65.2 },
	{ -1893.81,-707.65,7.73,110.56 },
	{ -1921.84,-716.82,5.22,212.6 },
	{ -1891.7,-756.03,4.95,218.27 },
	{ -1890.51,-818.0,2.95,303.31 },
	{ -1806.69,-770.32,8.29,306.15 },
	{ -1763.57,-747.01,9.81,303.31 },
	{ -1980.27,-691.34,3.02,189.93 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- INITSCANNER
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	local amountCoords = 0
	repeat
		amountCoords = amountCoords + 1
		local rand = math.random(#scanCoords)
		scanTable[amountCoords] = scanCoords[rand]
		Citizen.Wait(1)
	until amountCoords == 25
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SCANNERCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:updateScanner")
AddEventHandler("inventory:updateScanner",function(status)
	userScanner = status
	soundScanner = 999
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSCANNER
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		if userScanner then
			local ped = PlayerPedId()
			if not IsPedInAnyVehicle(ped) then
				local coords = GetEntityCoords(ped)

				for k,v in pairs(scanTable) do
					local distance = #(coords - vector3(v[1],v[2],v[3]))
					if distance <= 7.25 then
						soundScanner = 1000

						if initSounds[k] == nil then
							initSounds[k] = true
						end

						if distance <= 1.25 then
							timeDistance = 1
							soundScanner = 250

							if IsControlJustPressed(1,38) and MumbleIsConnected() then
								TriggerServerEvent("inventory:makeProducts",{},"scanner")

								local rand = math.random(#scanCoords)
								scanTable[k] = scanCoords[rand]
								initSounds[k] = nil
								soundScanner = 999
							end
						end
					else
						if initSounds[k] then
							initSounds[k] = nil
							soundScanner = 999
						end
					end
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSCANNERSOUND
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if userScanner and (soundScanner == 1000 or soundScanner == 250) then
			PlaySoundFrontend(-1,"MP_IDLE_TIMER","HUD_FRONTEND_DEFAULT_SOUNDSET")
		end

		Citizen.Wait(soundScanner)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DECOR
-----------------------------------------------------------------------------------------------------------------------------------------
DecorRegister("DrugsPeds",3)
DecorRegister("StealPeds",3)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local DrugsTimer = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTEALNPCS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		local Ped = PlayerPedId()

		if not IsPedInAnyVehicle(ped) and IsPedArmed(Ped,7) then
			local Handler,Selected = FindFirstPed()

			repeat
				if not IsEntityDead(Selected) and not DecorExistOn(Selected,"StealPeds") and not IsPedDeadOrDying(Selected) and GetPedArmour(Selected) <= 0 and not IsPedAPlayer(Selected) and not IsPedInAnyVehicle(Selected) and GetPedType(Selected) ~= 28 then
					local Coords = GetEntityCoords(Ped)
					local pCoords = GetEntityCoords(Selected)
					local Distance = #(Coords - pCoords)

					if Distance <= 5 then
						timeDistance = 100

						local Pid = PlayerId()
						if Distance <= 2 and (IsPedInMeleeCombat(Ped) or IsPlayerFreeAiming(Pid)) then
							ClearPedTasks(Selected)
							ClearPedSecondaryTask(Selected)
							ClearPedTasksImmediately(Selected)

							local SelectedTimers = 0
							local SelectedControl = NetworkRequestControlOfEntity(Selected)
							while not SelectedControl and SelectedTimers <= 1000 do
								SelectedControl = NetworkRequestControlOfEntity(Selected)
								SelectedTimers = SelectedTimers + 1
							end

							TaskSetBlockingOfNonTemporaryEvents(Selected,true)
							SetBlockingOfNonTemporaryEvents(Selected,true)
							SetEntityAsMissionEntity(Selected,true,true)
							SetPedDropsWeaponsWhenDead(Selected,false)
							TaskTurnPedToFaceEntity(Selected,Ped,3.0)
							SetPedSuffersCriticalHits(Selected,false)
							DecorSetInt(Selected,"StealPeds",-1)
							SetPedAsNoLongerNeeded(Selected)

							RequestAnimDict("random@mugging3")
							while not HasAnimDictLoaded("random@mugging3") do
								Citizen.Wait(1)
							end

							local SelectedRobbery = 1000
							TriggerEvent("inventory:blockButtons",true)
							TriggerEvent("player:blockCommands",true)
							TaskPlayAnim(Selected,"random@mugging3","handsup_standing_base",8.0,1.0,-1,16,0,0,0,0)

							while true do
								local Coords = GetEntityCoords(Ped)
								local pCoords = GetEntityCoords(Selected)
								local Distance = #(Coords - pCoords)

								if Distance <= 2 and (IsPedInMeleeCombat(Ped) or IsPlayerFreeAiming(Pid)) then
									SelectedRobbery = SelectedRobbery - 1

									if not IsEntityPlayingAnim(Selected,"random@mugging3","handsup_standing_base",3) then
										TaskPlayAnim(Selected,"random@mugging3","handsup_standing_base",8.0,1.0,-1,16,0,0,0,0)
									end

									if SelectedRobbery <= 0 then
										local Anim = "mp_safehouselost@"
										local Hash = "prop_paper_bag_small"

										RequestModel(Hash)
										while not HasModelLoaded(Hash) do
											Citizen.Wait(1)
										end

										RequestAnimDict(Anim)
										while not HasAnimDictLoaded(Anim) do
											Citizen.Wait(1)
										end

										local Object = CreateObject(Hash,Coords["x"],Coords["y"],Coords["z"],false,false,false)
										AttachEntityToEntity(Object,Selected,GetPedBoneIndex(Selected,28422),0.0,-0.05,0.05,180.0,0.0,0.0,false,false,false,false,2,true)
										TaskPlayAnim(Selected,Anim,"package_dropoff",8.0,1.0,-1,16,0,0,0,0)

										Citizen.Wait(3000)

										if DoesEntityExist(Object) then
											SetModelAsNoLongerNeeded(Hash)
											DeleteEntity(Object)
										end

										ClearPedSecondaryTask(Selected)
										TaskWanderStandard(Selected,10.0,10)
										vSERVER.StealPeds()

										TriggerEvent("inventory:blockButtons",false)
										TriggerEvent("player:blockCommands",false)

										break
									end
								else
									ClearPedSecondaryTask(Selected)
									TaskWanderStandard(Selected,10.0,10)

									TriggerEvent("inventory:blockButtons",false)
									TriggerEvent("player:blockCommands",false)

									break
								end

								Citizen.Wait(1)
							end
						end
					end
				end

				Success,Selected = FindNextPed(Handler)
			until not Success EndFindPed(Handler)
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADDRUGSPEDS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		local Ped = PlayerPedId()

		if not IsPedInAnyVehicle(ped) then
			local Handler,Selected = FindFirstPed()

			repeat
				if not IsEntityDead(Selected) and not DecorExistOn(Selected,"DrugsPeds") and not IsPedDeadOrDying(Selected) and GetPedArmour(Selected) <= 0 and not IsPedAPlayer(Selected) and not IsPedInAnyVehicle(Selected) and GetPedType(Selected) ~= 28 then
					local Coords = GetEntityCoords(Ped)
					local pCoords = GetEntityCoords(Selected)
					local Distance = #(Coords - pCoords)

					if Distance <= 1 then
						timeDistance = 1

						if IsControlJustPressed(1,38) and GetGameTimer() >= DrugsTimer and vSERVER.AmountDrugs() then
							DrugsTimer = GetGameTimer() + 5000

							ClearPedTasks(Selected)
							ClearPedSecondaryTask(Selected)
							ClearPedTasksImmediately(Selected)

							local SelectedTimers = 0
							local SelectedRobbery = 1000
							TriggerEvent("inventory:blockButtons",true)
							TriggerEvent("player:blockCommands",true)
							local SelectedControl = NetworkRequestControlOfEntity(Selected)
							while not SelectedControl and SelectedTimers <= 1000 do
								SelectedControl = NetworkRequestControlOfEntity(Selected)
								SelectedTimers = SelectedTimers + 1
							end

							TaskSetBlockingOfNonTemporaryEvents(Selected,true)
							SetBlockingOfNonTemporaryEvents(Selected,true)
							SetEntityAsMissionEntity(Selected,true,true)
							SetPedDropsWeaponsWhenDead(Selected,false)
							TaskTurnPedToFaceEntity(Selected,Ped,3.0)
							SetPedSuffersCriticalHits(Selected,false)
							DecorSetInt(Selected,"DrugsPeds",-1)
							SetPedAsNoLongerNeeded(Selected)

							while true do
								local Coords = GetEntityCoords(Ped)
								local pCoords = GetEntityCoords(Selected)
								local Distance = #(Coords - pCoords)

								if Distance <= 2 then
									SelectedRobbery = SelectedRobbery - 1

									if SelectedRobbery <= 0 then
										local Anim = "mp_safehouselost@"
										local Hash = "prop_anim_cash_note"

										RequestModel(Hash)
										while not HasModelLoaded(Hash) do
											Citizen.Wait(1)
										end

										RequestAnimDict(Anim)
										while not HasAnimDictLoaded(Anim) do
											Citizen.Wait(1)
										end

										local Object = CreateObject(Hash,Coords["x"],Coords["y"],Coords["z"],false,false,false)
										AttachEntityToEntity(Object,Selected,GetPedBoneIndex(Selected,28422),0.0,0.0,0.0,90.0,0.0,0.0,false,false,false,false,2,true)
										vRP.createObjects(Anim,"package_dropoff","prop_paper_bag_small",16,28422,0.0,-0.05,0.05,180.0,0.0,0.0)
										TaskPlayAnim(Selected,Anim,"package_dropoff",8.0,1.0,-1,16,0,0,0,0)

										Citizen.Wait(3000)

										if DoesEntityExist(Object) then
											SetModelAsNoLongerNeeded(Hash)
											DeleteEntity(Object)
										end

										vRP.removeObjects()
										ClearPedSecondaryTask(Selected)
										TaskWanderStandard(Selected,10.0,10)
										vSERVER.DrugsPeds()

										TriggerEvent("inventory:blockButtons",false)
										TriggerEvent("player:blockCommands",false)

										break
									end
								else
									ClearPedSecondaryTask(Selected)
									TaskWanderStandard(Selected,10.0,10)

									TriggerEvent("inventory:blockButtons",false)
									TriggerEvent("player:blockCommands",false)

									break
								end

								Citizen.Wait(1)
							end
						end
					end
				end

				Success,Selected = FindNextPed(Handler)
			until not Success EndFindPed(Handler)
		end

		Citizen.Wait(timeDistance)
	end
end)