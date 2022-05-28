-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("garages",cRP)
vPLAYER = Tunnel.getInterface("player")
vCLIENT = Tunnel.getInterface("garages")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local vehList = {}
local vehNitro = {}
local vehPlates = {}
local spawnTimers = {}
local searchTimers = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGELOCATES
-----------------------------------------------------------------------------------------------------------------------------------------
local garageLocates = {
	["1"] = { name = "Garage", payment = false }, -- Public Garage
	["2"] = { name = "Garage", payment = true }, -- Garage
	["3"] = { name = "Garage", payment = false }, -- Public Garage
	["4"] = { name = "Garage", payment = true }, -- Garage
	["5"] = { name = "Garage", payment = true }, -- Garage
	["6"] = { name = "Garage", payment = true }, -- Garage
	["7"] = { name = "Garage", payment = true }, -- Garage
	["8"] = { name = "Garage", payment = true }, -- Garage
	["9"] = { name = "Garage", payment = true }, -- Garage
	["10"] = { name = "Garage", payment = true }, -- Garage
	["11"] = { name = "Garage", payment = true }, -- Garage
	["12"] = { name = "Garage", payment = true }, -- Garage
	["13"] = { name = "Garage", payment = true }, -- Garage
	["14"] = { name = "Garage", payment = true }, -- Garage
	["15"] = { name = "Garage", payment = true }, -- Garage
	["16"] = { name = "Garage", payment = true }, -- Garage
	["17"] = { name = "Garage", payment = true }, -- Garage
	["18"] = { name = "Garage", payment = true }, -- Garage
	["19"] = { name = "Garage", payment = true }, -- Hotel Eclipse Tower
	["20"] = { name = "Garage", payment = true }, -- Hotel Eclipse Tower
	["21"] = { name = "Garage", payment = true }, -- Casino
	["22"] = { name = "Garage", payment = true }, -- Garage
	["23"] = { name = "Garage", payment = false }, -- Public Garage
	["24"] = { name = "Garage", payment = true }, -- Hotel Garage
	["25"] = { name = "Garage", payment = true }, -- Garage
	["41"] = { name = "Paramedic", payment = false, perm = "Paramedic" }, -- Hospital 1
	["42"] = { name = "heliParamedic", payment = false, perm = "Paramedic" }, -- Hospital 1
	["43"] = { name = "Paramedic", payment = false, perm = "Paramedic" }, -- Hospital 2
	["44"] = { name = "heliParamedic", payment = false, perm = "Paramedic" }, -- Hospital 2
	["45"] = { name = "Paramedic", payment = false, perm = "Paramedic" }, -- Hospital 3
	["61"] = { name = "Police", payment = false, perm = "Police" }, -- LSPD 1
	["62"] = { name = "heliPolice", payment = false, perm = "Police" }, -- LSPD 1
	["63"] = { name = "Police", payment = false, perm = "Police" }, -- Sheriff 1
	["64"] = { name = "heliPolice", payment = false, perm = "Police" }, -- Sheriff 1
	["65"] = { name = "Police", payment = false, perm = "Police" }, -- Sheriff 2
	["66"] = { name = "busPolice", payment = false, perm = "Police" }, -- Sheriff 2
	["67"] = { name = "Police", payment = false, perm = "Police" }, -- Bolingbroke Penitentiary
	["68"] = { name = "heliPolice", payment = false, perm = "Police" }, -- Bolingbroke Penitentiary
	["69"] = { name = "Police", payment = false, perm = "Police" }, -- Ranger
	["70"] = { name = "Police", payment = false, perm = "Police" }, -- LSPD 2
	["71"] = { name = "heliPolice", payment = false, perm = "Police" }, -- LSPD 2
	["72"] = { name = "Police", payment = false, perm = "Police" }, -- LSPD 2
	["121"] = { name = "Boats", payment = true }, -- Boats
	["122"] = { name = "Boats", payment = true }, -- Boats
	["123"] = { name = "Boats", payment = true }, -- Boats
	["124"] = { name = "Boats", payment = true }, -- Boats
	["125"] = { name = "Boats", payment = true }, -- Boats
	["126"] = { name = "Boats", payment = true }, -- Boats
	["141"] = { name = "Lumberman", payment = true }, -- Lumberman
	["142"] = { name = "Driver", payment = true }, -- Bus Driver
	["143"] = { name = "Garbageman", payment = true }, -- Garbageman 1
	["144"] = { name = "Transporter", payment = true }, -- Transporter
	["145"] = { name = "Taxi", payment = true }, -- Taxi 1
	["146"] = { name = "TowDriver", payment = true }, -- Impound 1
	["147"] = { name = "TowDriver", payment = true }, -- Impound 2
	["148"] = { name = "TowDriver", payment = true }, -- Impound 3
	["149"] = { name = "Garbageman", payment = true }, -- Garbageman 1
	["150"] = { name = "Garbageman", payment = true }, -- Garbageman 3
	["151"] = { name = "Taxi", payment = true }, -- Taxi 2
	["152"] = { name = "Mechanic", payment = false, perm = "Mechanic" }, -- Mechanic
	["153"] = { name = "DishesDesserts", payment = false, perm = "DishesDesserts" }, -- Dishes & Desserts
	["154"] = { name = "Garage", payment = true }, -- Garage
	["155"] = { name = "Playboy", payment = false, perm = "Playboy" }, -- Playboy
	["156"] = { name = "BurgerShot", payment = false, perm = "BurgerShot" }, -- BurgerShot
	["157"] = { name = "WeazelNews", payment = false, perm = "WeazelNews" }, -- WeazelNews
	["158"] = { name = "PopsDiner", payment = false, perm = "PopsDiner" }, -- PopsDiner
	["159"] = { name = "PizzaThis", payment = false, perm = "PizzaThis" }, -- PizzaThis
	["160"] = { name = "Mechanic", payment = false, perm = "Mechanic" } -- Mechanic
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLATENITRO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("plateNitro")
AddEventHandler("plateNitro",function(vehPlate,vehStatus)
	vehNitro[vehPlate] = parseInt(vehStatus)
	TriggerClientEvent("hud:plateNitro",-1,vehPlate,vehStatus)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLATEREVERYONE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("plateReveryone")
AddEventHandler("plateReveryone",function(vehPlate)
	if vehPlates[vehPlate] then
		vehPlates[vehPlate] = nil

		TriggerClientEvent("garages:syncRemlates",-1,vehPlate)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLATEEVERYONE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("plateEveryone")
AddEventHandler("plateEveryone",function(vehPlate)
	if vehPlates[vehPlate] == nil then
		vehPlates[vehPlate] = true

		TriggerClientEvent("garages:syncPlates",-1,vehPlate)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLATEPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("platePlayers")
AddEventHandler("platePlayers",function(vehPlate,user_id)
	local plateId = vRP.userPlate(vehPlate)
	if not plateId then
		vehPlates[vehPlate] = user_id
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLATEROBBERYS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("plateRobberys")
AddEventHandler("plateRobberys",function(vehPlate,vehName)
	if vehPlate ~= nil and vehName ~= nil then
		local source = source
		local user_id = vRP.getUserId(source)
		if user_id then
			if vehPlates[vehPlate] ~= user_id then
				vehPlates[vehPlate] = user_id
				TriggerClientEvent("garages:syncPlates",-1,vehPlate)
			end

			TriggerClientEvent("Notify",source,"verde","Chave recebida.",3000)

			if math.random(100) >= 50 then
				local ped = GetPlayerPed(source)
				local coords = GetEntityCoords(ped)

				local policeResult = vRP.numPermission("Police")
				for k,v in pairs(policeResult) do
					async(function()
						TriggerClientEvent("NotifyPush",v,{ code = "31", title = "Roubo de Veículo", x = coords["x"], y = coords["y"], z = coords["z"], vehicle = vehicleName(vehName).." - "..vehPlate, time = "Recebido às "..os.date("%H:%M"), blipColor = 44 })
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES
-----------------------------------------------------------------------------------------------------------------------------------------
local workgarage = {
	["Paramedic"] = {
		"lguard",
		"blazer2",
		"ambulance",
		"ambulance2"
	},
	["heliParamedic"] = {
		"maverick2"
	},
	["Police"] = {
		"ballerpol",
		"elegy2pol",
		"fugitivepol",
		"komodapol",
		"kurumapol",
		"polchar",
		"polvic",
		"oracle2pol",
		"police3pol",
		"policepol",
		"r1250pol",
		"schafter2pol",
		"sheriff2pol",
		"sultanrspol",
		"tailgater2pol",
		"polcorv",
		"polchall",
		"poltang",
		"nc700pol"
	},
	["heliPolice"] = {
		"maverick2"
	},
	["busPolice"] = {
		"pbus",
		"riot"
	},
	["Fireman"] = {
		"firetruck"
	},
	["Driver"] = {
		"bus"
	},
	["Boats"] = {
		"dinghy",
		"jetmax",
		"marquis",
		"seashark",
		"speeder",
		"squalo",
		"suntrap",
		"toro",
		"tropic"
	},
	["Transporter"] = {
		"stockade"
	},
	["Lumberman"] = {
		"ratloader"
	},
	["Fisherman"] = {
		"mule3"
	},
	["Trucker"] = {
		"packer"
	},
	["Kart"] = {
		"veto",
		"veto2"
	},
	["TowDriver"] = {
		"flatbed"
	},
	["AirForce"] = {
		"volatus",
		"supervolito",
		"cuban800",
		"luxor",
		"mammatus",
		"miljet",
		"nimbus",
		"shamal",
		"velum",
		"buzzard2",
		"frogger",
		"havok",
		"swift",
		"swift2",
		"dodo"
	},
	["Garbageman"] = {
		"trash"
	},
	["Taxi"] = {
		"taxi"
	},
	["deliveryWork"] = {
		"bmx"
	},
	["Hunter"] = {
		"mule3"
	},
	["Mechanic"] = {
		"flatbed",
		"flatbed2",
		"towtruck2"
	},
	["DishesDesserts"] = {
		"uwu"
	},
	["BurgerShot"] = {
		"burgershot"
	},
	["WeazelNews"] = {
		"weazel"
	},
	["PopsDiner"] = {
		"popsdiner"
	},
	["PizzaThis"] = {
		"pizzathis"
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- MYVEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.myVehicles(garageWork)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local myVehicle = {}
		local garageName = garageLocates[garageWork]["name"]
		local vehicle = vRP.query("vehicles/getVehicles",{ user_id = parseInt(user_id) })

		if workgarage[garageName] then
			for k,v in pairs(workgarage[garageName]) do
				local veh = vRP.query("vehicles/selectVehicles",{ user_id = parseInt(user_id), vehicle = v })
				if veh[1] then
					table.insert(myVehicle,{ name = veh[1]["vehicle"], name2 = vehicleName(veh[1]["vehicle"]), engine = parseInt(veh[1]["engine"] * 0.1), body = parseInt(veh[1]["body"] * 0.1), fuel = parseInt(veh[1]["fuel"]) })
				end
			end
		else
			for k,v in ipairs(vehicle) do
				if v["work"] == "false" then
					table.insert(myVehicle,{ name = vehicle[k]["vehicle"], name2 = vehicleName(vehicle[k]["vehicle"]), engine = parseInt(vehicle[k]["engine"] * 0.1), body = parseInt(vehicle[k]["body"] * 0.1), fuel = parseInt(vehicle[k]["fuel"]) })
				end
			end
		end

		return myVehicle
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWNVEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.spawnVehicles(vehName,garageName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if spawnTimers[user_id] == nil then
			spawnTimers[user_id] = true

			local vehNet = nil
			for k,v in pairs(vehList) do
				if parseInt(v[1]) == parseInt(user_id) and v[2] == vehName then
					vehNet = parseInt(k)
					break
				end
			end

			local vehicle = vRP.query("vehicles/selectVehicles",{ user_id = parseInt(user_id), vehicle = vehName })
			
			if vehNet == nil then
				local vehPrice = vehiclePrice(vehName)
				
				if os.time() >= parseInt(vehicle[1]["tax"] + 24 * 7 * 60 * 60) then
					TriggerClientEvent("Notify",source,"amarelo","Taxa do veículo atrasada, efetue o pagamento<br>através do seu tablet no sistema da benefactor.",5000)
				elseif parseInt(os.time()) <= parseInt(vehicle[1]["time"] + 24 * 60 * 60) then
					local status = vRP.request(source,"Veículo detido, deseja acionar o seguro pagando <b>$"..parseFormat(vehPrice * 0.5).."</b> dólares?",60)
					if status then
						if vRP.paymentFull(user_id,vehPrice * 0.5) then
							vRP.execute("vehicles/arrestVehicles",{ user_id = parseInt(user_id), vehicle = vehName, arrest = 0, time = 0 })
						else
							TriggerClientEvent("Notify",source,"vermelho","Dólares insuficientes.",5000)
						end
					end
				elseif parseInt(vehicle[1]["arrest"]) >= 1 then
					local status = vRP.request(source,"Veículo detido, deseja acionar o seguro pagando <b>$"..parseFormat(vehPrice * 0.1).."</b> dólares?",60)
					if status then
						if vRP.paymentFull(user_id,vehPrice * 0.1) then
							vRP.execute("vehicles/arrestVehicles",{ user_id = parseInt(user_id), vehicle = vehName, arrest = 0, time = 0 })
						else
							TriggerClientEvent("Notify",source,"vermelho","Dólares insuficientes.",5000)
						end
					end
				else
					if parseInt(vehicle[1]["rental"]) > 0 then
						if parseInt(os.time()) >= (vehicle[1]["rental"] + 24 * vehicle[1]["rendays"] * 60 * 60) then
							TriggerClientEvent("Notify",source,"amarelo","Validade do veículo expirou, efetue a renovação do mesmo.",5000)
							spawnTimers[user_id] = nil

							return
						end
					end

					local mHash = GetHashKey(vehName)
					local checkSpawn,vehCoords = vCLIENT.spawnPosition(source)
					if checkSpawn then

						local vehMods = nil
						local custom = vRP.query("entitydata/getData",{ dkey = "custom:"..user_id..":"..vehName })
						if parseInt(#custom) > 0 then
							vehMods = custom[1]["dvalue"]
						end

						if garageLocates[garageName]["payment"] then
							if vRP.userPremium(user_id) then
								local vehObject = CreateVehicle(mHash,vehCoords[1],vehCoords[2],vehCoords[3],vehCoords[4],true,true)

								while not DoesEntityExist(vehObject) do
									Citizen.Wait(1)
								end

								local netVeh = NetworkGetNetworkIdFromEntity(vehObject)
								vCLIENT.createVehicle(-1,mHash,netVeh,vehicle[1]["plate"],vehicle[1]["engine"],vehicle[1]["body"],vehicle[1]["fuel"],vehMods,vehicle[1]["windows"],vehicle[1]["doors"],vehicle[1]["tyres"])
								TriggerEvent("engine:insertEngines",netVeh,vehicle[1]["fuel"])
								TriggerEvent("plateNitro",vehicle[1]["plate"],vehicle[1]["nitro"])
								vehList[netVeh] = { user_id,vehName,vehicle[1]["plate"] }
								TriggerEvent("plateEveryone",vehicle[1]["plate"])
								vehPlates[vehicle[1]["plate"]] = user_id
								
								TriggerClientEvent("Notify",source,"azul",completeTimers(parseInt(86400 * 7 - (os.time() - vehicle[1]["tax"]))),1000)
							else
								if vRP.request(source,"Deseja retirar o veículo pagando <b>$"..parseFormat(vehPrice * 0.05).."</b> dólares?",30) then
									if vRP.getBank(user_id) >= parseInt(vehPrice * 0.05) then
										local vehObject = CreateVehicle(mHash,vehCoords[1],vehCoords[2],vehCoords[3],vehCoords[4],true,true)

										while not DoesEntityExist(vehObject) do
											Citizen.Wait(1)
										end

										local netVeh = NetworkGetNetworkIdFromEntity(vehObject)
										vCLIENT.createVehicle(-1,mHash,netVeh,vehicle[1]["plate"],vehicle[1]["engine"],vehicle[1]["body"],vehicle[1]["fuel"],vehMods,vehicle[1]["windows"],vehicle[1]["doors"],vehicle[1]["tyres"])
										TriggerEvent("engine:insertEngines",netVeh,vehicle[1]["fuel"])
										TriggerEvent("plateNitro",vehicle[1]["plate"],vehicle[1]["nitro"])
										TriggerEvent("plateEveryone",vehicle[1]["plate"])
										vehPlates[vehicle[1]["plate"]] = user_id
										vehList[netVeh] = { user_id,vehName }
										
										TriggerClientEvent("Notify",source,"azul",completeTimers(parseInt(86400 * 7 - (os.time() - vehicle[1]["tax"]))),1000)
									else
										TriggerClientEvent("Notify",source,"vermelho","Dólares insuficientes.",5000)
									end
								end
							end
						else
							local vehObject = CreateVehicle(mHash,vehCoords[1],vehCoords[2],vehCoords[3],vehCoords[4],true,true)

							while not DoesEntityExist(vehObject) do
								Citizen.Wait(1)
							end

							local netVeh = NetworkGetNetworkIdFromEntity(vehObject)
							vCLIENT.createVehicle(-1,mHash,netVeh,vehicle[1]["plate"],vehicle[1]["engine"],vehicle[1]["body"],vehicle[1]["fuel"],vehMods,vehicle[1]["windows"],vehicle[1]["doors"],vehicle[1]["tyres"])
							TriggerEvent("engine:insertEngines",netVeh,vehicle[1]["fuel"])
							TriggerEvent("plateNitro",vehicle[1]["plate"],vehicle[1]["nitro"])
							vehList[netVeh] = { user_id,vehName,vehicle[1]["plate"] }
							TriggerEvent("plateEveryone",vehicle[1]["plate"])
							vehPlates[vehicle[1]["plate"]] = user_id
							
							TriggerClientEvent("Notify",source,"azul",completeTimers(parseInt(86400 * 7 - (os.time() - vehicle[1]["tax"]))),1000)
						end
					end
				end
			else
				if GetGameTimer() >= searchTimers[user_id] then
					searchTimers[user_id] = GetGameTimer() + 60000

					local idNetwork = NetworkGetEntityFromNetworkId(vehNet)
					if DoesEntityExist(idNetwork) and not IsPedAPlayer(idNetwork) then
						vCLIENT.searchBlip(source,GetEntityCoords(idNetwork))
						TriggerClientEvent("Notify",source,"amarelo","Rastreador do veículo foi ativado por <b>30 segundos</b>, lembrando que<br>se o mesmo estiver em movimento a localização pode ser imprecisa.",10000)
					else
						if vehList[vehNet] then
							vehList[vehNet] = nil
						end

						if vehPlates[vehicle[1]["plate"]] then
							vehPlates[vehicle[1]["plate"]] = nil
						end

						TriggerClientEvent("Notify",source,"verde","A seguradora efetuou o resgate do seu veículo e o mesmo já se encontra disponível para retirada.",5000)
					end
				else
					TriggerClientEvent("Notify",source,"amarelo","O rastreador só pode ser ativado a cada <b>60 segundos</b>.",5000)
				end
			end

			spawnTimers[user_id] = nil
		else
			TriggerClientEvent("Notify",source,"amarelo","Existe uma busca por seu veículo em andamento.",5000)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("car",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Moderador") and args[1] then
			local ped = GetPlayerPed(source)
			local coords = GetEntityCoords(ped)
			local heading = GetEntityHeading(ped)

			local mHash = GetHashKey(args[1])
			local vehObject = CreateVehicle(mHash,coords["x"],coords["y"],coords["z"],heading,true,true)

			while not DoesEntityExist(vehObject) do
				Citizen.Wait(1)
			end

			local netVeh = NetworkGetNetworkIdFromEntity(vehObject)
			local vehPlate = "VEH"..parseInt(math.random(10000,99999) + user_id)
			vCLIENT.createVehicle(-1,mHash,netVeh,vehPlate,1000,1000,100,nil,false,false,false,{ 1.25,0.75,0.95 })
			TriggerEvent("engine:insertEngines",netVeh,100,"")
			vehList[netVeh] = { user_id,vehName,vehPlate }
			TaskWarpPedIntoVehicle(ped,vehObject,-1)
			TriggerEvent("plateEveryone",vehPlate)
			-- TriggerEvent("plateNitro",vehPlate,2000)
			vehPlates[vehPlate] = user_id
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("dv",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Suporte") then
			local vehicle = vRPC.nearVehicle(source,15)
			if vehicle then
				vCLIENT.deleteVehicle(source,vehicle)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:LOCKVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:lockVehicle")
AddEventHandler("garages:lockVehicle",function(vehNet,vehPlate,vehLock)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vehPlates[vehPlate] == user_id then
			TriggerClientEvent("garages:vehicleLock",-1,vehNet,vehLock)

			if vehLock then
				TriggerClientEvent("sounds:source",source,"unlocked",0.4)
				TriggerClientEvent("Notify",source,"unlocked","Veículo destrancado.",5000)
			else
				TriggerClientEvent("sounds:source",source,"locked",0.3)
				TriggerClientEvent("Notify",source,"locked","Veículo trancado.",5000)
			end

			if not vRPC.inVehicle(source) then
				vRPC.playAnim(source,true,{"anim@mp_player_intmenu@key_fob@","fob_click"},false)
				Citizen.Wait(400)
				vRPC.stopAnim(source)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYDELETE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.tryDelete(vehNet,vehEngine,vehBody,vehFuel,vehDoors,vehWindows,vehTyres,vehPlate,vehBrake)
	if vehList[vehNet] and vehNet ~= 0 then
		local user_id = vehList[vehNet][1]
		local vehName = vehList[vehNet][2]

		if parseInt(vehEngine) <= 100 then
			vehEngine = 100
		end

		if parseInt(vehBody) <= 100 then
			vehBody = 100
		end

		if parseInt(vehFuel) >= 100 then
			vehFuel = 100
		end

		if parseInt(vehFuel) <= 5 then
			vehFuel = 5
		end

		local vehicle = vRP.query("vehicles/selectVehicles",{ user_id = parseInt(user_id), vehicle = tostring(vehName) })
		if vehicle[1] ~= nil then
			vRP.execute("vehicles/updateVehicles",{ user_id = parseInt(user_id), vehicle = tostring(vehName), engine = parseInt(vehEngine), body = parseInt(vehBody), fuel = parseInt(vehFuel), doors = json.encode(vehDoors), windows = json.encode(vehWindows), tyres = json.encode(vehTyres) })
		end
	end

	TriggerEvent("garages:deleteVehicle",vehNet,vehPlate)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:DELETEVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:deleteVehicle")
AddEventHandler("garages:deleteVehicle",function(vehNet,vehPlate)
	TriggerClientEvent("player:deleteVehicle",-1,vehNet,vehPlate)
	TriggerEvent("plateReveryone",vehPlate)

	if vehList[vehNet] then
		vehList[vehNet] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RETURNGARAGES
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.returnGarages(garageName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if workgarage[garageLocates[garageName]["name"]] == nil then
			if vRP.getFines(user_id) > 0 then
				TriggerClientEvent("Notify",source,"vermelho","Multas pendentes encontradas.",3000)
				return false
			end
		end

		if not vRP.wantedReturn(user_id) then
			if string.sub(garageName,0,5) == "Homes" then
				local consult = vRP.query("propertys/userPermissions",{ name = garageName, user_id = parseInt(user_id) })
				if consult[1] == nil then
					return false
				else
					local ownerConsult = vRP.query("propertys/userOwnermissions",{ name = garageName })
					if ownerConsult[1] then
						if parseInt(os.time()) >= parseInt(ownerConsult[1]["tax"] + 24 * 7 * 60 * 60) then
							TriggerClientEvent("Notify",source,"amarelo","Taxas da propriedade atrasada.",10000)
							return false
						end
					end
				end
			end

			if garageLocates[garageName]["perm"] ~= nil then
				if vRP.hasPermission(user_id,garageLocates[garageName]["perm"]) then
					return vCLIENT.openGarage(source,garageName)
				end
			else
				return vCLIENT.openGarage(source,garageName)
			end
		end

		return false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:UPDATEGARAGES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:updateGarages")
AddEventHandler("garages:updateGarages",function(homeName,homeInfos)
	garageLocates[homeName] = { ["name"] = homeName, ["payment"] = false }

	-- CONFIG
	local configFile = LoadResourceFile("logsystem","garageConfig.json")
	local configTable = json.decode(configFile)
	configTable[homeName] = { ["name"] = homeName, ["payment"] = false }
	SaveResourceFile("logsystem","garageConfig.json",json.encode(configTable),-1)

	-- LOCATES
	local locatesFile = LoadResourceFile("logsystem","garageLocates.json")
	local locatesTable = json.decode(locatesFile)
	locatesTable[homeName] = homeInfos
	SaveResourceFile("logsystem","garageLocates.json",json.encode(locatesTable),-1)

	TriggerClientEvent("garages:updateLocs",-1,homeName,homeInfos)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:REMOVEGARAGES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:removeGarages")
AddEventHandler("garages:removeGarages",function(homeName)
	if garageLocates[homeName] then
		garageLocates[homeName] = nil

		local configFile = LoadResourceFile("logsystem","garageConfig.json")
		local configTable = json.decode(configFile)
		if configTable[homeName] then
			configTable[homeName] = nil
			SaveResourceFile("logsystem","garageConfig.json",json.encode(configTable),-1)
		end

		local locatesFile = LoadResourceFile("logsystem","garageLocates.json")
		local locatesTable = json.decode(locatesFile)
		if locatesTable[homeName] then
			locatesTable[homeName] = nil
			SaveResourceFile("logsystem","garageLocates.json",json.encode(locatesTable),-1)
		end

		TriggerClientEvent("garages:updateRemove",-1,homeName)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ASYNCFUNCTION
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	local configFile = LoadResourceFile("logsystem","garageConfig.json")
	local configTable = json.decode(configFile)

	for k,v in pairs(configTable) do
		garageLocates[k] = v
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERSPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source)
	TriggerClientEvent("garages:allPlates",source,vehPlates)
	TriggerClientEvent("hud:allNitro",source,vehNitro)

	local locatesFile = LoadResourceFile("logsystem","garageLocates.json")
	local locatesTable = json.decode(locatesFile)

	TriggerClientEvent("garages:allLocs",source,locatesTable)

	searchTimers[user_id] = GetGameTimer()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERLEAVE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerLeave",function(user_id,source)
	if searchTimers[user_id] then
		searchTimers[user_id] = nil
	end

	if spawnTimers[user_id] then
		spawnTimers[user_id] = nil
	end
end)