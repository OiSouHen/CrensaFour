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
Tunnel.bindInterface("blipsystem",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local userList = {}
local userBlips = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- COLORS
-----------------------------------------------------------------------------------------------------------------------------------------
local Colors = {
	["Corrections"] = 60,
	["Ranger"] = 69,
	["State"] = 7,
	["Lspd"] = 38,
	["Sheriff"] = 47,
	["Paramedic"] = 6,
	["Prisioneiro"] = 33,
	["Corredor"] = 32
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPSYSTEM:BLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("blipsystem:Blips")
AddEventHandler("blipsystem:Blips",function(userTable)
	userList = userTable

	for k,v in pairs(userList) do
		if DoesBlipExist(userBlips[k]) then
			SetBlipCoords(userBlips[k],v[1]["x"],v[1]["y"],v[1]["z"])
		else
			local Source = GetPlayerFromServerId(k)
			local Ped = GetPlayerPed(Source)
								
			userBlips[k] = AddBlipForEntity(Ped)
			SetBlipSprite(userBlips[k],1)
			SetBlipDisplay(userBlips[k],4)
			SetBlipShowCone(userBlips[k],true)
			SetBlipAsShortRange(userBlips[k],true)
			SetBlipColour(userBlips[k],Colors[v[2]])
			SetBlipScale(userBlips[k],0.7)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("! "..v[2])
			EndTextCommandSetBlipName(userBlips[k])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPSYSTEM:CLEAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("blipsystem:Clear")
AddEventHandler("blipsystem:Clear",function()
	for k,v in pairs(userBlips) do
		RemoveBlip(userBlips[k])
	end

	userBlips = {}
	userList = {}
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPSYSTEM:REMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("blipsystem:Remove")
AddEventHandler("blipsystem:Remove",function(source)
	if DoesBlipExist(userBlips[source]) then
		RemoveBlip(userBlips[source])
		userBlips[source] = nil
		userList[source] = nil
	end
end)