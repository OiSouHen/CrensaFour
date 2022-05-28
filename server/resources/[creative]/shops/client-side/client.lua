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
Tunnel.bindInterface("shops",cRP)
vSERVER = Tunnel.getInterface("shops")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("close",function(data)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideNUI" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestShop",function(data,cb)
	local inventoryShop,inventoryUser,invPeso,invMaxpeso,shopSlots = vSERVER.requestShop(data["shop"])
	if inventoryShop then
		cb({ inventoryShop = inventoryShop, inventoryUser = inventoryUser, invPeso = invPeso, invMaxpeso = invMaxpeso, shopSlots = shopSlots })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTBUY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("functionShops",function(data)
	if MumbleIsConnected() then
		vSERVER.functionShops(data["shop"],data["item"],data["amount"],data["slot"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("populateSlot",function(data)
	if MumbleIsConnected() then
		TriggerServerEvent("shops:populateSlot",data["item"],data["slot"],data["target"],data["amount"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateSlot",function(data)
	if MumbleIsConnected() then
		TriggerServerEvent("shops:updateSlot",data["item"],data["slot"],data["target"],data["amount"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRUNKCHEST:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.updateShops(action)
	SendNUIMessage({ action = action })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local shopList = {
	{ -551.1,-191.07,38.22,"identityStore",false },
	{ -553.3,-192.34,38.22,"identityStore",false },
	{ -544.33,-185.59,52.2,"fidentityStore",false },
	{ -2071.29,-333.13,13.31,"departamentStore",true },
	{ 24.49,-1346.08,29.49,"departamentStore",true },
	{ 2556.04,380.89,108.61,"departamentStore",true },
	{ 1164.82,-323.63,69.2,"departamentStore",true },
	{ -706.16,-914.55,19.21,"departamentStore",true },
	{ -47.39,-1758.63,29.42,"departamentStore",true },
	{ 372.86,327.53,103.56,"departamentStore",true },
	{ -3243.38,1000.11,12.82,"departamentStore",true },
	{ 1728.39,6416.21,35.03,"departamentStore",true },
	{ 549.2,2670.22,42.16,"departamentStore",true },
	{ 1959.54,3741.01,32.33,"departamentStore",true },
	{ 2677.07,3279.95,55.23,"departamentStore",true },
	{ 1697.35,4923.46,42.06,"departamentStore",true },
	{ -1819.55,793.51,138.08,"departamentStore",true },
	{ 1392.03,3606.1,34.98,"departamentStore",true },
	{ -2966.41,391.59,15.05,"departamentStore",true },
	{ -3040.04,584.22,7.9,"departamentStore",true },
	{ 1134.33,-983.09,46.4,"departamentStore",true },
	{ 1165.26,2710.79,38.15,"departamentStore",true },
	{ -1486.77,-377.56,40.15,"departamentStore",true },
	{ -1221.42,-907.91,12.32,"departamentStore",true },
	{ 161.35,6642.39,31.69,"departamentStore",true },
	{ -160.61,6320.88,31.58,"departamentStore",true },
	{ 377.6,-1787.15,29.52,"departamentStore",true },
	{ 1692.28,3760.94,34.69,"ammunationStore",false },
	{ 253.79,-50.5,69.94,"ammunationStore",false },
	{ 842.41,-1035.28,28.19,"ammunationStore",false },
	{ -331.62,6084.93,31.46,"ammunationStore",false },
	{ -662.29,-933.62,21.82,"ammunationStore",false },
	{ -1304.17,-394.62,36.7,"ammunationStore",false },
	{ -1118.95,2699.73,18.55,"ammunationStore",false },
	{ 2567.98,292.65,108.73,"ammunationStore",false },
	{ -3173.51,1088.38,20.84,"ammunationStore",false },
	{ 22.59,-1105.54,29.79,"ammunationStore",false },
	{ 810.22,-2158.99,29.62,"ammunationStore",false },
	{ -1082.25,-247.52,37.76,"premiumStore",false },
	{ -1816.64,-1193.73,14.31,"fishingSell",false },
	{ -695.56,5802.12,17.32,"huntingSell",false },
	{ -679.13,5839.52,17.32,"huntingStore",false },
	{ -172.5,6380.98,31.48,"pharmacyStore",false },
	{ 1690.07,3581.68,35.62,"pharmacyStore",false },
	{ 326.5,-1074.43,29.47,"pharmacyStore",false },
	{ 114.62,-5.3,67.82,"pharmacyStore",false },
	{ 311.97,-597.66,43.29,"pharmacyParamedic",false },
	{ 1822.70,3686.64,34.26,"pharmacyParamedic",false },
	{ -254.64,6326.95,32.82,"pharmacyParamedic",false },
	{ 46.21,-1749.45,29.64,"mercadoCentral",false },
	{ 2747.81,3472.91,55.67,"mercadoCentral",false },
	{ -428.57,-1728.35,19.78,"recyclingSell",false },
	{ 180.55,2793.45,45.65,"recyclingSell",false },
	{ -195.79,6264.95,31.49,"recyclingSell",false },
	{ 487.3,-997.08,30.68,"policeStore",false },
	{ 1838.43,3686.29,34.19,"policeStore",false },
	{ -447.15,6016.51,36.99,"policeStore",false },
	{ 385.5,799.94,190.49,"policeStore",false },
	{ 362.37,-1603.12,25.44,"policeStore",false },
	{ -628.41,-238.36,38.05,"minerShop",false },
	{ 475.1,3555.28,33.23,"ilegalHouse",false },
	{ 112.41,3373.68,35.25,"ilegalCosmetics",false },
	{ 2013.95,4990.88,41.21,"ilegalToys",false },
	{ 186.9,6374.75,32.33,"ilegalCriminal",false },
	{ -653.12,-1502.67,5.22,"ilegalHouse",false },
	{ 389.71,-942.61,29.42,"ilegalCosmetics",false },
	{ 154.98,-1472.47,29.35,"ilegalToys",false },
	{ 488.1,-1456.11,29.28,"ilegalCriminal",false },
	{ 169.76,-1535.88,29.25,"weaponsStore",false },
	{ 301.14,-195.75,61.57,"weaponsStore",false },
	{ 121.84,-3024.88,7.04,"mechanicBuy",false },
	{ 128.7,-3050.9,7.04,"mechanicBuy",false },
	{ 129.92,-3031.54,7.04,"mechanicBuy",false },
	{ 550.83,-176.84,54.49,"mechanicBuy",false },
	{ 947.97,-972.36,39.5,"mechanicTools",false },
	{ -345.28,-124.54,39.01,"mechanicTools",false },
	{ 729.47,-1064.09,22.16,"mechanicTools",false },
	{ -1141.23,-2005.29,13.18,"mechanicTools",false },
	{ 1189.09,2636.7,38.4,"mechanicTools",false },
	{ 98.06,6619.23,32.44,"mechanicTools",false },
	{ -216.4,-1318.9,30.89,"mechanicTools",false },
	{ -197.4,-1320.51,31.09,"mechanicTools",false },
	{ -199.41,-1319.81,31.09,"mechanicTools",false },
	{ -1407.48,-443.59,35.91,"mechanicTools",false },
	{ -40.08,-1056.54,28.39,"mechanicTools",false },
	{ -33.49,-1040.83,28.59,"mechanicTools",false },
	{ -32.14,-1039.04,28.59,"mechanicTools",false },
	{ 1179.12,2635.86,37.74,"mechanicTools",false },
	{ 1523.69,3782.48,34.51,"fishDepartament",true },
	{ 563.19,2752.92,42.87,"animalStore",false },
	{ 987.46,-95.61,74.85,"mcFridge",false },
	{ 2512.3,4098.11,38.59,"mcFridge",false },
	{ 129.71,-1284.65,29.27,"mcFridge",false },
	{ -561.75,286.7,82.18,"mcFridge",false },
	{ -1653.78,-1062.18,12.15,"mcFridge",false },
	{ 413.82,-1498.86,30.18,"mcFridge",false },
	{ 756.32,-768.02,26.34,"mcFridge",false },
	{ 123.22,-1035.91,29.27,"mcFridge",false },
	{ -1636.74,-1092.17,13.08,"oxyStore",false },
	{ -307.63,-164.17,40.42,"imoveisShop",false },
	{ 1655.77,4874.38,42.04,"imoveisShop",false },
	{ -1172.1,-1571.9,4.67,"weedShop",false }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPINFOS
-----------------------------------------------------------------------------------------------------------------------------------------
local shopInfos = {
	["1"] = {
		{
			event = "shops:openSystem",
			label = "Abrir",
			tunnel = "shop"
		},{
			event = "crafting:Ammunation",
			label = "Criar",
			tunnel = "shop"
		}
	},
	["2"] = {
		{
			event = "shops:openSystem",
			label = "Abrir",
			tunnel = "shop"
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- INFORMATIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function Informations(shopName)
	if shopName == "ammunationStore" then
		return shopInfos["1"]
	end

	return shopInfos["2"]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTARGET
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)

	for k,v in pairs(shopList) do
		exports["target"]:AddCircleZone("Shops:"..k,vector3(v[1],v[2],v[3]),0.75,{
			name = "Shops:"..k,
			heading = 3374176
		},{
			shop = k,
			distance = 1.75,
			options = Informations(v[4])
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:OPENSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:openSystem",function(shopId)
	if vSERVER.requestPerm(shopList[shopId][4]) then
		SetNuiFocus(true,true)
		SendNUIMessage({ action = "showNUI", name = shopList[shopId][4], type = vSERVER.getShopType(shopList[shopId][4]) })

		if shopList[shopId][5] then
			TriggerEvent("sounds:source","shop",0.5)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:COFFEEMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:coffeeMachine",function()
	SendNUIMessage({ action = "showNUI", name = "coffeeMachine", type = "Buy" })
	SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:SODAMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:sodaMachine",function()
	SendNUIMessage({ action = "showNUI", name = "sodaMachine", type = "Buy" })
	SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:DONUTMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:donutMachine",function()
	SendNUIMessage({ action = "showNUI", name = "donutMachine", type = "Buy" })
	SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:BURGERMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:burgerMachine",function()
	SendNUIMessage({ action = "showNUI", name = "burgerMachine", type = "Buy" })
	SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:HOTDOGMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:hotdogMachine",function()
	SendNUIMessage({ action = "showNUI", name = "hotdogMachine", type = "Buy" })
	SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:CHIHUAHUA
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:Chihuahua",function()
	SendNUIMessage({ action = "showNUI", name = "Chihuahua", type = "Buy" })
	SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:WATERMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:waterMachine",function()
	SendNUIMessage({ action = "showNUI", name = "waterMachine", type = "Buy" })
	SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:MEDICBAG
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("shops:medicBag")
AddEventHandler("shops:medicBag",function()
	if vSERVER.requestPerm("pharmacyParamedic") then
		SetNuiFocus(true,true)
		SendNUIMessage({ action = "showNUI", name = "pharmacyParamedic", type = "Buy" })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:MECHANICBOX
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("shops:mechanicBox")
AddEventHandler("shops:mechanicBox",function()
	if vSERVER.requestPerm("mechanicBuy") then
		SetNuiFocus(true,true)
		SendNUIMessage({ action = "showNUI", name = "mechanicBuy", type = "Buy" })
	end
end)