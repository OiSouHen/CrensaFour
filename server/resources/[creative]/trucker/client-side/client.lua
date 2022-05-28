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
Tunnel.bindInterface("trucker",cRP)
vSERVER = Tunnel.getInterface("trucker")
vGARAGE = Tunnel.getInterface("garages")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local sPackage = 1
local sPosition = 1
local serviceBlip = nil
local initPackage = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRUCKERS
-----------------------------------------------------------------------------------------------------------------------------------------
local Truckers = {
	[1518533038] = true,
	[387748548] = true,
	[569305213] = true,
	[-2137348917] = true
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PACKSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
local packService = {
	[1] = {
		["trailer"] = "tr4",
		["coords"] = {
			{ 1256.59,-3239.63,5.17 },
			{ 1725.68,4701.59,41.91,true },
			{ 2793.5,4346.1,49.23 },
			{ 583.97,-267.48,43.32 },
			{ 712.87,-3198.19,18.89 },
			{ 1256.59,-3239.63,5.17 }
		}
	},
	[2] = {
		["trailer"] = "armytanker",
		["coords"] = {
			{ 1256.59,-3239.63,5.17 },
			{ 1682.1,4923.7,41.45,true },
			{ 2793.5,4346.1,49.23 },
			{ 583.97,-267.48,43.32 },
			{ 712.87,-3198.19,18.89 },
			{ 1256.59,-3239.63,5.17 }
		}
	},
	[3] = {
		["trailer"] = "tvtrailer",
		["coords"] = {
			{ 1256.59,-3239.63,5.17 },
			{ -688.78,5778.91,16.7,true },
			{ 2793.5,4346.1,49.23 },
			{ 583.97,-267.48,43.32 },
			{ 712.87,-3198.19,18.89 },
			{ 1256.59,-3239.63,5.17 }
		}
	},
	[4] = {
		["trailer"] = "tanker",
		["coords"] = {
			{ 1256.59,-3239.63,5.17 },
			{ 154.75,6612.86,31.27,true },
			{ 2793.5,4346.1,49.23 },
			{ 583.97,-267.48,43.32 },
			{ 712.87,-3198.19,18.89 },
			{ 1256.59,-3239.63,5.17 }
		}
	},
	[5] = {
		["trailer"] = "trailerlogs",
		["coords"] = {
			{ 1256.59,-3239.63,5.17 },
			{ -576.72,5329.59,69.61,true },
			{ 2793.5,4346.1,49.23 },
			{ 583.97,-267.48,43.32 },
			{ 712.87,-3198.19,18.89 },
			{ 1256.59,-3239.63,5.17 }
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRUCKER:INITSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("trucker:initService")
AddEventHandler("trucker:initService",function()
	if not initPackage and not vSERVER.checkExist() then
		sPosition = 1
		initPackage = true
		sPackage = math.random(#packService)
		TriggerEvent("Notify","amarelo","Dirija-se até seu caminhão, buzine o mesmo<br>para receber a carga responsável pelo transporte.",5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		if initPackage then
			local Vehicle = GetPlayersLastVehicle()
			if IsEntityAVehicle(Vehicle) then
				local vehModel = GetEntityModel(Vehicle)
				if Truckers[vehModel] then
					local Ped = PlayerPedId()
					local coords = GetEntityCoords(Ped)
					local distance = #(coords - vector3(packService[sPackage]["coords"][sPosition][1],packService[sPackage]["coords"][sPosition][2],packService[sPackage]["coords"][sPosition][3]))

					if distance <= 200 then
						timeDistance = 1
						DrawMarker(1,packService[sPackage]["coords"][sPosition][1],packService[sPackage]["coords"][sPosition][2],packService[sPackage]["coords"][sPosition][3] - 3,0,0,0,0,0,0,12.0,12.0,8.0,255,255,255,25,0,0,0,0)
						DrawMarker(21,packService[sPackage]["coords"][sPosition][1],packService[sPackage]["coords"][sPosition][2],packService[sPackage]["coords"][sPosition][3] + 1,0,0,0,0,180.0,130.0,3.0,3.0,2.0,42,137,255,100,0,0,0,1)

						if distance <= 10 then
							if sPosition >= #packService[sPackage]["coords"] then
								initPackage = false
								vSERVER.paymentMethod()

								if DoesBlipExist(serviceBlip) then
									RemoveBlip(serviceBlip)
									serviceBlip = nil
								end
							else
								if sPosition == 1 then
									if IsControlJustPressed(1,38) then
										local Heading = GetEntityHeading(Vehicle)
										local vehCoords = GetOffsetFromEntityInWorldCoords(Vehicle,0.0,-12.0,0.0)
										local Trailer = CreateVehicle(packService[sPackage]["trailer"],vehCoords["x"],vehCoords["y"],vehCoords["z"],Heading,true,false)

										if NetworkDoesNetworkIdExist(Trailer) then
											local vehicleNet = NetToEnt(Trailer)
											if NetworkDoesNetworkIdExist(vehicleNet) then
												SetVehicleOnGroundProperly(vehicleNet)
											end
										end

										sPosition = sPosition + 1
										makeBlipMarked()
									end
								else
									if packService[sPackage]["coords"][sPosition][4] ~= nil then
										if not IsPedInAnyVehicle(Ped) and IsControlJustPressed(1,38) then
											local _,vehNet,vehPlate,modelVehicle = vRP.vehList(10)
											if modelVehicle == packService[sPackage]["trailer"] then
												TriggerEvent("Notify","amarelo","Volte para receber o pagamento.",5000)
												TriggerServerEvent("garages:deleteVehicle",vehNet,vehPlate)
												sPosition = sPosition + 1
												makeBlipMarked()
											end
										end
									else
										sPosition = sPosition + 1
										makeBlipMarked()
									end
								end
							end
						end
					end
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAKEBLIPMARKED
-----------------------------------------------------------------------------------------------------------------------------------------
function makeBlipMarked()
	if DoesBlipExist(serviceBlip) then
		RemoveBlip(serviceBlip)
		serviceBlip = nil
	end

	serviceBlip = AddBlipForCoord(packService[sPackage]["coords"][sPosition][1],packService[sPackage]["coords"][sPosition][2],packService[sPackage]["coords"][sPosition][3])
	SetBlipSprite(serviceBlip,12)
	SetBlipColour(serviceBlip,84)
	SetBlipScale(serviceBlip,0.9)
	SetBlipRoute(serviceBlip,true)
	SetBlipAsShortRange(serviceBlip,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Caminhoneiro")
	EndTextCommandSetBlipName(serviceBlip)
end