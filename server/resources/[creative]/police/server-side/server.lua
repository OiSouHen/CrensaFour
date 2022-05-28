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
Tunnel.bindInterface("police",cRP)
vCLIENT = Tunnel.getInterface("police")
vTASKBAR = Tunnel.getInterface("taskbar")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local actived = {}
local prisonMarkers = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRESET
-----------------------------------------------------------------------------------------------------------------------------------------
local preset = {
	["mp_m_freemode_01"] = {
		["hat"] = { item = -1, texture = 0 },
		["pants"] = { item = 133, texture = 0 },
		["vest"] = { item = 0, texture = 0 },
		["bracelet"] = { item = -1, texture = 0 },
		["decals"] = { item = 0, texture = 0 },
		["mask"] = { item = 0, texture = 0 },
		["shoes"] = { item = 25, texture = 0 },
		["tshirt"] = { item = 15, texture = 0 },
		["torso"] = { item = 362, texture = 0 },
		["accessory"] = { item = 0, texture = 0 },
		["watch"] = { item = -1, texture = 0 },
		["arms"] = { item = 83, texture = 0 },
		["glass"] = { item = 0, texture = 0 },
		["ear"] = { item = -1, texture = 0 }
	},
	["mp_f_freemode_01"] = {
		["hat"] = { item = -1, texture = 0 },
		["pants"] = { item = 140, texture = 0 },
		["vest"] = { item = 0, texture = 0 },
		["bracelet"] = { item = -1, texture = 0 },
		["decals"] = { item = 0, texture = 0 },
		["mask"] = { item = 0, texture = 0 },
		["shoes"] = { item = 25, texture = 0 },
		["tshirt"] = { item = 14, texture = 0 },
		["torso"] = { item = 381, texture = 0 },
		["accessory"] = { item = 0, texture = 0 },
		["watch"] = { item = -1, texture = 0 },
		["arms"] = { item = 86, texture = 0 },
		["glass"] = { item = 0, texture = 0 },
		["ear"] = { item = -1, texture = 0 }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE:PRISONCLOTHES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("police:prisonClothes")
AddEventHandler("police:prisonClothes",function(entity)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and vRP.getHealth(source) > 101 then
		if vRP.hasPermission(user_id,"Police") then
			local mHash = vRP.modelPlayer(entity[1])
			if mHash == "mp_m_freemode_01" or mHash == "mp_f_freemode_01" then
				TriggerClientEvent("updateRoupas",entity[1],preset[mHash])
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANREC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cleanrec",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id and args[1] then
		if vRP.hasPermission(user_id,"servicePolice") then
			local nuser_id = parseInt(args[1])
			if nuser_id > 0 then
				vRP.execute("prison/cleanRecords",{ nuser_id = nuser_id })
				TriggerClientEvent("Notify",source,"verde","Limpeza efetuada.",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INITPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.initPrison(nuser_id,services,fines,text)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if actived[user_id] == nil then
			actived[user_id] = true

			local identity = vRP.userIdentity(user_id)
			local otherPlayer = vRP.userSource(nuser_id)
			if otherPlayer then
				vCLIENT.syncPrison(otherPlayer,true,true)
				TriggerClientEvent("radio:outServers",otherPlayer)
			end

			vRP.execute("prison/insertPrison",{ police = identity["name"].." "..identity["name2"], nuser_id = parseInt(nuser_id), services = services, fines = fines, text = text, date = os.date("%d/%m/%Y").." ás "..os.date("%H:%M") })
			vRP.execute("characters/setPrison",{ user_id = parseInt(nuser_id), prison = parseInt(services) })
			vRP.execute("characters/updateCriminal",{ criminal = 1, id = parseInt(nuser_id) })
			vRPC.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
			TriggerClientEvent("Notify",source,"verde","Prisão efetuada.",5000)
			TriggerClientEvent("police:Update",source,"reloadPrison")

			if fines > 0 then
				vRP.addFines(nuser_id,fines)
			end

			TriggerEvent("discordLogs","Police","**Por:** "..parseFormat(user_id).."\n**Passaporte:** "..parseFormat(nuser_id).."\n**Serviços:** "..parseFormat(services).."\n**Multa:** $"..parseFormat(fines).."\n**Horário:** "..os.date("%H:%M:%S").."\n**Motivo:** "..text,13541152)

			actived[user_id] = nil
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEARCHUSER
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.searchUser(nuser_id)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local identity = vRP.userIdentity(nuser_id)
		if identity then
			local fines = vRP.getFines(nuser_id)
			local records = vRP.query("prison/getRecords",{ nuser_id = parseInt(nuser_id) })

			return { true,identity["name"].." "..identity["name2"],identity["phone"],fines,records,identity["port"],identity["serial"],identity["criminal"],identity["locate"] }
		end
	end

	return { false }
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INITFINE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.initFine(nuser_id,fines,text)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and fines > 0 then
		if actived[user_id] == nil then
			actived[user_id] = true

			TriggerEvent("discordLogs","Police","**Por:** "..parseFormat(user_id).."\n**Passaporte:** "..parseFormat(nuser_id).."\n**Multa:** $"..parseFormat(fines).."\n**Horário:** "..os.date("%H:%M:%S").."\n**Motivo:** "..text,2316674)
			TriggerClientEvent("Notify",source,"verde","Multa aplicada.",5000)
			TriggerClientEvent("police:Update",source,"reloadFine")
			vRP.addFines(nuser_id,fines)

			actived[user_id] = nil
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATECRIMINAL
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.updateCriminal(nuser_id)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local criminalStatus = ""
		local identity = vRP.userIdentity(user_id)
		local nidentity = vRP.userIdentity(nuser_id)

		if nidentity["criminal"] == 1 then
			criminalStatus = "Regularizado"
			vRP.execute("characters/updateCriminal",{ criminal = 0, id = parseInt(nuser_id) })
		else
			criminalStatus = "Atrasado"
			vRP.execute("characters/updateCriminal",{ criminal = 1, id = parseInt(nuser_id) })
		end

		TriggerClientEvent("police:Update",source,"reloadSearch",parseInt(nuser_id))
		TriggerEvent("discordLogs","Police","**Por:** "..parseFormat(user_id).."\n**Passaporte:** "..parseFormat(nuser_id).."\n**Período criminal:** "..portStatus.."\n**Horário:** "..os.date("%H:%M:%S"),6303352)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEPORT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.updatePort(nuser_id)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local portStatus = ""
		local identity = vRP.userIdentity(user_id)
		local nidentity = vRP.userIdentity(nuser_id)

		if nidentity["port"] == 0 then
			portStatus = "Ativado"
			vRP.execute("characters/updatePort",{ port = 1, id = parseInt(nuser_id) })
		else
			portStatus = "Desativado"
			vRP.execute("characters/updatePort",{ port = 0, id = parseInt(nuser_id) })
		end

		TriggerClientEvent("police:Update",source,"reloadSearch",parseInt(nuser_id))
		TriggerEvent("discordLogs","Police","**Por:** "..parseFormat(user_id).."\n**Passaporte:** "..parseFormat(nuser_id).."\n**Porte:** "..portStatus.."\n**Horário:** "..os.date("%H:%M:%S"),6303352)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRISONSYNC
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		for k,v in pairs(prisonMarkers) do
			if prisonMarkers[k][1] > 0 then
				prisonMarkers[k][1] = prisonMarkers[k][1] - 1

				if prisonMarkers[k][1] <= 0 then
					if vRP.userSource(prisonMarkers[k][2]) then
						TriggerEvent("blipsystem:serviceExit",k)
					end

					prisonMarkers[k] = nil
				end
			end
		end

		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REDUCEPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.reducePrison()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local reducevalue = math.random(1,2)
		vRP.execute("characters/removePrison",{ user_id = parseInt(user_id), prison = reducevalue })

		local consult = vRP.getInformation(user_id)
		if parseInt(consult[1]["prison"]) <= 0 then
			vCLIENT.syncPrison(source,false,false)
			vRP.execute("characters/fixPrison",{ user_id = parseInt(user_id) })
			vRP.execute("characters/updateCriminal",{ criminal = 0, id = parseInt(user_id) })
			vCLIENT.exitPrison(source)
			TriggerClientEvent("Notify",source,"verde","Serviço acabou, esperamos não vê-lo novamente.",5000)
		else
			vCLIENT.asyncServices(source)
			TriggerClientEvent("Notify",source,"azul","Restam <b>"..parseInt(consult[1]["prison"]).." serviços</b>.",5000)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPOLICE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkPolice()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Police") then
			return true
		end
	end

	return false
end
--------------------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERSPAWN
--------------------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source)
	local consult = vRP.getInformation(user_id)
	if consult[1] then
		if parseInt(consult[1]["prison"]) <= 0 then
			return
		else
			TriggerClientEvent("Notify",source,"azul","Restam <b>"..parseInt(consult[1]["prison"]).." serviços</b>.",5000)
			vCLIENT.syncPrison(source,true,false)
		end
	end
end)