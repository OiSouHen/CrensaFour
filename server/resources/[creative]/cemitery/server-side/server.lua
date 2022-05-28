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
Tunnel.bindInterface("cemitery",cRP)
vCLIENT = Tunnel.getInterface("cemitery")
vTASKBAR = Tunnel.getInterface("taskbar")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local activeItens = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTIVESYNC
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		for k,v in pairs(activeItens) do
			if activeItens[k] > 0 then
				activeItens[k] = activeItens[k] - 1
			end
		end

		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROBBERYS
-----------------------------------------------------------------------------------------------------------------------------------------
local makeProducts = {
	{ item = "notepad", min = 1, max = 3 },
	{ item = "mouse", min = 1, max = 1 },
	{ item = "silverring", min = 1, max = 1 },
	{ item = "goldring", min = 1, max = 1 },
	{ item = "watch", min = 1, max = 2 },
	{ item = "ominitrix", min = 1, max = 1 },
	{ item = "bracelet", min = 1, max = 1 },
	{ item = "dices", min = 1, max = 2 },
	{ item = "dish", min = 1, max = 3 },
	{ item = "sneakers", min = 1, max = 2 },
	{ item = "rimel", min = 1, max = 3 },
	{ item = "blender", min = 1, max = 1 },
	{ item = "switch", min = 1, max = 3 },
	{ item = "brush", min = 1, max = 2 },
	{ item = "domino", min = 1, max = 3 },
	{ item = "floppy", min = 1, max = 4 },
	{ item = "deck", min = 1, max = 2 },
	{ item = "pliers", min = 1, max = 2 },
	{ item = "slipper", min = 1, max = 1 },
	{ item = "dollars", min = 45, max = 85 },
	{ item = "soap", min = 1, max = 1 },
	{ item = "teddy", min = 1, max = 1 },
	{ item = "rose", min = 1, max = 1 },
	{ item = "acetone", min = 1, max = 1 },
	{ item = "sulfuric", min = 1, max = 1 },
	{ item = "rope", min = 1, max = 1 },
	{ item = "cotton", min = 1, max = 2 },
	{ item = "saline", min = 1, max = 1 },
	{ item = "alcohol", min = 1, max = 1 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTMETHOD
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.paymentMethod()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local rand = math.random(#makeProducts)
		local value = math.random(makeProducts[rand]["min"],makeProducts[rand]["max"])
		local taskResult = vTASKBAR.taskOne(source)
		if taskResult then
			vRPC.playAnim(source,false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)
		
			activeItens[user_id] = 5
			TriggerClientEvent("Progress",source,5000)
			TriggerClientEvent("inventory:blockButtons",source,true)
				
			Wait(5000)
				
			if activeItens[user_id] == 0 then
				activeItens[user_id] = nil
				vRPC.stopAnim(source,false)
				TriggerClientEvent("inventory:blockButtons",source,false)
				vRP.generateItem(user_id,makeProducts[rand]["item"],value,true)
				Citizen.Wait(100)
			end
		else
			local source = source
			local ped = GetPlayerPed(source)
			local coords = GetEntityCoords(ped)

			local policeResult = vRP.numPermission("Police")
			for k,v in pairs(policeResult) do
				async(function()
					TriggerClientEvent("NotifyPush",v,{ code = "31", title = "Assalto em Andamento", x = coords["x"], y = coords["y"], z = coords["z"], time = "Recebido às "..os.date("%H:%M"), blipColor = 5 })
				end)
			end
			
			vRP.wantedTimer(user_id,30)
		end
		
		vRP.upgradeStress(user_id,1)
		TriggerClientEvent("player:applyGsr",source)
	end
end