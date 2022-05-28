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
Tunnel.bindInterface("register",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local boxTimers = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPLYTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.applyTimers(boxId)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if boxTimers[boxId] then
			if GetGameTimer() < boxTimers[boxId] then
				TriggerClientEvent("Notify",source,"amarelo","Sistema indisponível no momento.",5000)
				return false
			else
				local consultItem = vRP.getInventoryItemAmount(user_id,"pliers")
				if consultItem[1] <= 0 then
					TriggerClientEvent("Notify",source,"amarelo","Necessário possuir um <b>Alicate</b>.",5000)
					return false
				end

				startBox(boxId,source)
				return true
			end
		else
			startBox(boxId,source)
			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTBOX
-----------------------------------------------------------------------------------------------------------------------------------------
function startBox(boxId,source)
	boxTimers[boxId] = GetGameTimer() + (20 * 60000)

	if math.random(100) >= 75 then
		local ped = GetPlayerPed(source)
		local coords = GetEntityCoords(ped)
		TriggerClientEvent("player:applyGsr",source)

		local policeResult = vRP.numPermission("Police")
		for k,v in pairs(policeResult) do
			async(function()
				vRPC.playSound(v,"ATM_WINDOW","HUD_FRONTEND_DEFAULT_SOUNDSET")
				TriggerClientEvent("NotifyPush",v,{ code = "31", title = "Caixa Registradora", x = coords["x"], y = coords["y"], z = coords["z"], criminal = "Alarme de segurança", time = "Recebido às "..os.date("%H:%M"), blipColor = 16 })
			end)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTMETHOD
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.paymentMethod(boxLocate)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
	    local value = math.random(85,145)
	    local consult = vRP.getInformation(user_id)
		if boxLocate == "Sul" and consult[1]["locate"] == "Norte" then
			vRP.wantedTimer(user_id,30)
			vRP.generateItem(user_id,"dollars",value,true)
			vRP.generateItem(user_id,"dollars",value * 0.1,true)
		elseif boxLocate == "Norte" and consult[1]["locate"] == "Sul" then
			vRP.wantedTimer(user_id,30)
			vRP.generateItem(user_id,"dollars",value,true)
			vRP.generateItem(user_id,"dollars",value * 0.1,true)
		elseif boxLocate == "Sul" and consult[1]["locate"] == "Sul" then
			vRP.wantedTimer(user_id,30)
			vRP.generateItem(user_id,"dollars",value,true)
		elseif boxLocate == "Norte" and consult[1]["locate"] == "Norte" then
			vRP.wantedTimer(user_id,30)
			vRP.generateItem(user_id,"dollars",value,true)
		end
	end
end