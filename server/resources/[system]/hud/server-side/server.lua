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
Tunnel.bindInterface("hud",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local vehNitro = {}
local clockHours = 13
local clockMinutes = 0
local weatherSync = "CLEAR"
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADGLOBAL
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		clockMinutes = clockMinutes + 1
		
		if clockMinutes >= 60 then
			clockHours = clockHours + 1
			clockMinutes = 0
			
			if clockHours >= 24 then
				clockHours = 0
				nextWeather()
			end
		end
		
		Citizen.Wait(10000)
		TriggerClientEvent("hud:syncTimers",-1,{ clockHours,clockMinutes,weatherSync })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADWEATHER
-----------------------------------------------------------------------------------------------------------------------------------------
function nextWeather()
    if weatherSync == "CLEAR" or weatherSync == "CLOUDS" or weatherSync == "EXTRASUNNY"  then
        local new = math.random(1,2)
        if new == 1 then
            weatherSync = "CLEARING"
        else
            weatherSync = "OVERCAST"
        end
    elseif weatherSync == "CLEARING" or weatherSync == "OVERCAST" then
        local new = math.random(1,6)
        if new == 1 then
            if weatherSync == "CLEARING" then
				weatherSync = "FOGGY"
			else
				weatherSync = "RAIN"
			end
        elseif new == 2 then
            weatherSync = "CLOUDS"
        elseif new == 3 then
            weatherSync = "CLEAR"
        elseif new == 4 then
            weatherSync = "EXTRASUNNY"
        elseif new == 5 then
            weatherSync = "SMOG"
        else
            weatherSync = "FOGGY"
        end
    elseif weatherSync == "THUNDER" or weatherSync == "RAIN" then
        weatherSync = "CLEARING"
    elseif weatherSync == "SMOG" or weatherSync == "FOGGY" then
        weatherSync = "CLEAR"
    end
    
    TriggerClientEvent("hud:syncTimers",-1,{ clockHours,clockMinutes,weatherSync })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TIMESET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("timeset",function(source,args,rawCommand)
	if exports["chat"]:statusChat(source) then
		local user_id = vRP.getUserId(source)
		if user_id then
			if vRP.hasGroup(user_id,"Admin") then
				clockHours = parseInt(args[1])
				clockMinutes = parseInt(args[2])
				weatherSync = args[3]
				TriggerClientEvent("hud:syncTimers",-1,{ clockHours,clockMinutes,weatherSync })
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATENITRO
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.updateNitro(plate,nitrofuel)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        vRP.execute("vehicles/updateNitro",{ plate = plate, nitro = nitrofuel })
        vehNitro[plate] = parseInt(nitrofuel)

        if vehNitro[plate] == 0 then
            vehNitro[plate] = nil
        end

        GlobalState["Nitro"] = vehNitro
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERSPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source)
	TriggerClientEvent("hud:syncTimers",source,{ clockHours,clockMinutes,weatherSync })
end)