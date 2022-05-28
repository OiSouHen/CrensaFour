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
Tunnel.bindInterface("tablet",cRP)
vSERVER = Tunnel.getInterface("tablet")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local typeCars = {}
local typeBikes = {}
local typeWorks = {}
local typeRental = {}
local Open = "Santos"
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADFOCUS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTERTABLET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("tablet:enterTablet")
AddEventHandler("tablet:enterTablet",function(Select)
	local ped = PlayerPedId()
	if not IsPauseMenuActive() and not exports["inventory"]:blockInvents() and not exports["player"]:blockCommands() and not exports["player"]:handCuff() and GetEntityHealth(ped) > 101 and not IsEntityInWater(ped) and MumbleIsConnected() then
		Open = Select
		SetNuiFocus(true,true)
		SetCursorLocation(0.5,0.5)
		SendNUIMessage({ action = "openSystem" })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSESYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("closeSystem",function()
	SetNuiFocus(false,false)
	SetCursorLocation(0.5,0.5)
	SendNUIMessage({ action = "closeSystem" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEVEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.updateVehicles(Cars,Bikes,Works,Rental)
	typeCars = Cars
	typeBikes = Bikes
	typeWorks = Works
	typeRental = Rental
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTCARROS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestCarros",function(data,cb)
	cb({ result = typeCars })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTMOTOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestMotos",function(data,cb)
	cb({ result = typeBikes })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTSERVICOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestServicos",function(data,cb)
	cb({ result = typeWorks })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTALUGUEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestAluguel",function(data,cb)
	cb({ result = typeRental })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTPOSSUIDOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestPossuidos",function(data,cb)
	cb({ result = vSERVER.requestPossuidos() })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTBUY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestBuy",function(data)
	if MumbleIsConnected() then
		vSERVER.requestBuy(data["name"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTRENTAL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestRental",function(data)
	if MumbleIsConnected() then
		vSERVER.requestRental(data["name"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RENTALMONEY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("rentalMoney",function(data)
	if MumbleIsConnected() then
		vSERVER.rentalMoney(data["name"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTTAX
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestTax",function(data)
	if MumbleIsConnected() then
		vSERVER.requestTax(data["name"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTTRANSF
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestTransf",function(data)
	if MumbleIsConnected() then
		SetNuiFocus(false,false)
		SetCursorLocation(0.5,0.5)
		SendNUIMessage({ action = "closeSystem" })

		vSERVER.requestTransf(data["name"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTSELL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestSell",function(data)
	if MumbleIsConnected() then
		vSERVER.requestSell(data["name"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TABLET:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("tablet:Update")
AddEventHandler("tablet:Update",function(action)
	SendNUIMessage({ action = action })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRIVEABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local vehDrive = nil
local benDrive = false
local benCoords = { 0.0,0.0,0.0 }
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTDRIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestDrive",function(data)
	local driveIn,vehPlate = vSERVER.startDrive()
	if driveIn then
		SetNuiFocus(false,false)
		SetCursorLocation(0.5,0.5)
		SendNUIMessage({ action = "closeSystem" })

		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		benCoords = { coords["x"],coords["y"],coords["z"] }

		TriggerEvent("races:insertList",true)
		TriggerEvent("player:blockCommands",true)
		TriggerEvent("Notify","azul","Teste iniciado, para finalizar saia do veículo.",5000)

		Citizen.Wait(1000)

		vehCreate(data["name"],vehPlate)

		Citizen.Wait(1000)

		SetPedIntoVehicle(ped,vehDrive,-1)
		benDrive = true
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHCREATE
-----------------------------------------------------------------------------------------------------------------------------------------
function vehCreate(vehName,vehPlate)
	local mHash = GetHashKey(vehName)

	RequestModel(mHash)
	while not HasModelLoaded(mHash) do
		Citizen.Wait(1)
	end

	if HasModelLoaded(mHash) then
		if Open == "Santos" then
			vehDrive = CreateVehicle(mHash,-53.28,-1110.93,26.47,68.04,false,false)
		elseif Open == "Sandy" then
			vehDrive = CreateVehicle(mHash,1209.74,2713.49,37.81,175.75,false,false)
		end

		SetEntityInvincible(vehDrive,true)
		SetVehicleNumberPlateText(vehDrive,vehPlate)
		SetModelAsNoLongerNeeded(mHash)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADDRIVE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		if benDrive then
			timeDistance = 1
			DisableControlAction(1,69,false)

			local ped = PlayerPedId()
			if not IsPedInAnyVehicle(ped) then
				Citizen.Wait(1000)

				benDrive = false
				vSERVER.removeDrive()
				TriggerEvent("races:insertList",false)
				TriggerEvent("player:blockCommands",false)
				SetEntityCoords(ped,benCoords[1],benCoords[2],benCoords[3],1,0,0,0)
				DeleteEntity(vehDrive)
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
-- local initVehicles = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
-- local Vehicles = {
	-- {
		-- ["coords"] = vector3(-42.39,-1101.32,26.98),
		-- ["heading"] = 19.85,
		-- ["model"] = "rangerover",
		-- ["distance"] = 50
	-- },{
		-- ["coords"] = vector3(-54.61,-1096.86,26.98),
		-- ["heading"] = 31.19,
		-- ["model"] = "skyliner342",
		-- ["distance"] = 50
	-- },{
		-- ["coords"] = vector3(-47.57,-1092.05,26.98),
		-- ["heading"] = 283.47,
		-- ["model"] = "audir8",
		-- ["distance"] = 50
	-- },{
		-- ["coords"] = vector3(-37.02,-1093.42,26.98),
		-- ["heading"] = 206.93,
		-- ["model"] = "bentleybacalar",
		-- ["distance"] = 50
	-- },{
		-- ["coords"] = vector3(-49.78,-1083.86,26.98),
		-- ["heading"] = 65.2,
		-- ["model"] = "corvettec7",
		-- ["distance"] = 50
	-- }
-- }
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADVEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
-- Citizen.CreateThread(function()
	-- while true do
		-- local ped = PlayerPedId()
		-- local coords = GetEntityCoords(ped)

		-- for k,v in pairs(Vehicles) do
			-- local distance = #(coords - v["coords"])
			-- if distance <= v["distance"] then
				-- if initVehicles[k] == nil then
					-- local mHash = GetHashKey(v["model"])

					-- RequestModel(mHash)
					-- while not HasModelLoaded(mHash) do
						-- Citizen.Wait(1)
					-- end

					-- if HasModelLoaded(mHash) then
						-- initVehicles[k] = CreateVehicle(mHash,v["coords"],v["heading"],false,false)
						-- SetVehicleNumberPlateText(initVehicles[k],"PDMSPORT")
						-- FreezeEntityPosition(initVehicles[k],true)
						-- SetVehicleDoorsLocked(initVehicles[k],2)
						-- SetModelAsNoLongerNeeded(mHash)
					-- end
				-- end
			-- else
				-- if initVehicles[k] then
					-- if DoesEntityExist(initVehicles[k]) then
						-- DeleteEntity(initVehicles[k])
						-- initVehicles[k] = nil
					-- end
				-- end
			-- end
		-- end

		-- Citizen.Wait(1000)
	-- end
-- end)