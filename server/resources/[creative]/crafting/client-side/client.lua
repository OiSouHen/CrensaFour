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
Tunnel.bindInterface("crafting",cRP)
vSERVER = Tunnel.getInterface("crafting")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("invClose",function()
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideNUI" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTCRAFTING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestCrafting",function(data,cb)
	local inventoryCraft,inventoryUser,invPeso,invMaxpeso = vSERVER.requestCrafting(data["craft"])
	if inventoryCraft then
		cb({ inventoryCraft = inventoryCraft, inventario = inventoryUser, invPeso = invPeso, invMaxpeso = invMaxpeso })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONCRAFT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("functionCraft",function(data)
	if MumbleIsConnected() then
		vSERVER.functionCrafting(data["index"],data["craft"],data["amount"],data["slot"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONDESTROY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("functionDestroy",function(data)
	if MumbleIsConnected() then
		vSERVER.functionDestroy(data["index"],data["craft"],data["amount"],data["slot"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("populateSlot",function(data)
	if MumbleIsConnected() then
		TriggerServerEvent("crafting:populateSlot",data["item"],data["slot"],data["target"],data["amount"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateSlot",function(data)
	if MumbleIsConnected() then
		TriggerServerEvent("crafting:updateSlot",data["item"],data["slot"],data["target"],data["amount"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTING:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("crafting:Update")
AddEventHandler("crafting:Update",function(action)
	SendNUIMessage({ action = action })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local craftList = {
	{ 82.45,-1553.26,29.59,"Lixeiro" },
	{ 287.36,2843.6,44.7,"Lixeiro" },
	{ -413.68,6171.99,31.48,"Lixeiro" },
	{ 1272.26,-1712.57,54.76,"ilegalWeapons" },
	{ 46.98,-1748.2,29.64,"legalShop" },
	{ 2747.42,3471.54,55.67,"legalShop" },
	{ 2524.34,4106.46,38.59,"TheLost" },
	{ 807.67,-757.51,26.77,"PizzaThis" },
	{ -1198.04,-899.07,13.99,"BurgerShot" },
	{ 1593.9,6455.35,26.02,"PopsDiner" },
	{ -590.37,-1059.77,22.34,"Desserts" },
	{ -818.2,-717.87,23.78,"Triads" },
	{ 128.59,-3008.95,7.04,"Mechanic" },
	{ 545.17,-166.72,54.49,"Mechanic" },
	{ -1649.15,-1062.79,12.15,"Arcade" },
	{ -1543.54,79.91,57.00,"Playboy" },
	{ 122.69,-1041.57,29.56,"BeanMachine" },
	{ -1077.9,-1675.71,4.57,"Crips" },
	{ -592.58,-935.41,23.88,"Weazel" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTARGET
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)

	for k,v in pairs(craftList) do
		exports["target"]:AddCircleZone("Crafting:"..k,vector3(v[1],v[2],v[3]),0.75,{
			name = "Crafting:"..k,
			heading = 3374176
		},{
			shop = k,
			distance = 1.0,
			options = {
				{
					event = "crafting:openSystem",
					label = "Abrir",
					tunnel = "shop"
				}
			}
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTING:OPENSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("crafting:openSystem",function(shopId)
	if vSERVER.requestPerm(craftList[shopId][4]) then
		SetNuiFocus(true,true)
		SendNUIMessage({ action = "showNUI", name = craftList[shopId][4] })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTING:FUELSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("crafting:fuelShop",function()
	SetNuiFocus(true,true)
	SendNUIMessage({ action = "showNUI", name = "fuelShop" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTING:OPENSOURCE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("crafting:openSource")
AddEventHandler("crafting:openSource",function()
	SetNuiFocus(true,true)
	SendNUIMessage({ action = "showNUI", name = "craftShop" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTING:AMMUNATION
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("crafting:Ammunation")
AddEventHandler("crafting:Ammunation",function()
	SetNuiFocus(true,true)
	SendNUIMessage({ action = "showNUI", name = "ammuShop" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTING:TOYS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("crafting:Toys")
AddEventHandler("crafting:Toys",function()
	if vSERVER.requestPerm("Toys") then
		SetNuiFocus(true,true)
		SendNUIMessage({ action = "showNUI", name = "Toys" })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTING:STREETS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("crafting:Streets")
AddEventHandler("crafting:Streets",function()
	if vSERVER.requestPerm("Streets") then
		SetNuiFocus(true,true)
		SendNUIMessage({ action = "showNUI", name = "Streets" })
	end
end)