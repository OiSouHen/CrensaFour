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
Tunnel.bindInterface("garages",cRP)
vSERVER = Tunnel.getInterface("garages")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local vehPlates = {}
local openGarage = ""
local searchBlip = nil
local spawnSelected = {}
local vehHotwired = false
local anim = "machinic_loop_mechandplayer"
local animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@"
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local garageLocates = {
	["1"] = { x = 55.44, y = -876.17, z = 30.67,
		["1"] = { 60.44,-866.47,30.23,340.16 },
		["2"] = { 57.26,-865.35,30.25,340.16 },
		["3"] = { 54.03,-864.21,30.25,340.16 },
		["4"] = { 50.73,-863.01,30.26,340.16 },
		["5"] = { 60.52,-866.53,30.14,340.16 },
		["6"] = { 50.73,-873.28,30.11,158.75 },
		["7"] = { 47.36,-872.07,30.13,158.75 },
		["8"] = { 44.15,-870.9,30.13,158.75 }
	},
	["2"] = { x = 599.04, y = 2745.33, z = 42.04,
		["1"] = { 604.82,2738.27,41.64,187.09 },
		["2"] = { 601.75,2738.08,41.65,184.26 },
		["3"] = { 598.63,2737.85,41.69,184.26 },
		["4"] = { 595.59,2737.55,41.7,184.26 }
	},
	["3"] = { x = -136.8, y = 6356.84, z = 31.49,
		["1"] = { -133.72,6349.01,31.16,42.52 },
		["2"] = { -136.1,6346.53,31.16,42.52 }
	},
	["4"] = { x = 275.23, y = -345.56, z = 45.17,
		["1"] = { 266.06,-332.07,44.58,252.29 },
		["2"] = { 267.18,-328.9,44.58,252.29 },
		["3"] = { 268.32,-325.67,44.58,252.29 },
		["4"] = { 269.53,-322.4,44.58,252.29 },
		["5"] = { 270.77,-319.14,44.58,252.29 }
	},
	["5"] = { x = 596.43, y = 90.68, z = 93.13,
		["1"] = { 599.82,102.03,92.57,249.45 },
		["2"] = { 598.69,98.42,92.57,249.45 }
	},
	["6"] = { x = -340.57, y = 266.04, z = 85.68,
		["1"] = { -349.47,272.54,84.77,272.13 },
		["2"] = { -349.5,275.91,84.69,272.13 },
		["3"] = { -349.56,279.3,84.62,272.13 },
		["4"] = { -349.67,282.6,84.59,274.97 },
		["5"] = { -349.74,286.16,84.59,272.13 },
		["6"] = { -349.8,289.76,84.6,272.13 },
		["7"] = { -349.85,293.28,84.6,272.13 },
		["8"] = { -349.87,296.72,84.6,272.13 }
	},
	["7"] = { x = -2030.03, y = -465.99, z = 11.59,
		["1"] = { -2037.4,-461.02,11.07,138.9 },
		["2"] = { -2039.78,-459.07,11.07,138.9 },
		["3"] = { -2042.12,-457.1,11.07,138.9 },
		["4"] = { -2044.47,-455.11,11.07,138.9 },
		["5"] = { -2046.85,-453.09,11.07,138.9 },
		["6"] = { -2049.12,-451.17,11.07,138.9 },
		["7"] = { -2051.51,-449.23,11.07,138.9 }
	},
	["8"] = { x = -1184.94, y = -1509.99, z = 4.65,
		["1"] = { -1183.29,-1495.81,4.04,121.89 },
		["2"] = { -1185.23,-1493.28,4.04,121.89 },
		["3"] = { -1186.87,-1490.71,4.04,121.89 },
		["4"] = { -1188.69,-1488.27,4.04,121.89 }
	},
	["9"] = { x = 101.23, y = -1073.64, z = 29.37,
		["1"] = { 105.9,-1063.14,28.88,246.62 },
		["2"] = { 107.42,-1059.61,28.88,246.62 },
		["3"] = { 108.88,-1056.23,28.88,246.62 },
		["4"] = { 110.27,-1052.86,28.88,246.62 }
	},
	["10"] = { x = 213.97, y = -808.43, z = 31.0,
		["1"] = { 221.93,-804.11,30.35,249.45 },
		["2"] = { 222.9,-801.61,30.33,249.45 },
		["3"] = { 223.92,-799.2,30.33,249.45 },
		["4"] = { 224.85,-796.69,30.33,249.45 }
	},
	["11"] = { x = -348.89, y = -874.02, z = 31.31,
		["1"] = { -343.62,-875.51,30.75,167.25 },
		["2"] = { -339.98,-876.27,30.75,167.25 },
		["3"] = { -336.35,-876.98,30.75,167.25 },
		["4"] = { -332.72,-877.71,30.75,167.25 }
	},
	["12"] = { x = 67.72, y = 12.3, z = 69.22,
		["1"] = { 63.87,16.5,68.87,340.16 },
		["2"] = { 60.78,17.6,68.92,340.16 },
		["3"] = { 57.76,18.76,69.03,340.16 },
		["4"] = { 54.8,19.92,69.25,340.16 }
	},
	["13"] = { x = 361.96, y = 297.8, z = 103.88,
		["1"] = { 371.06,284.68,102.94,340.16 },
		["2"] = { 374.8,283.39,102.85,340.16 },
		["3"] = { 378.62,282.06,102.78,340.16 }
	},
	["14"] = { x = 1035.84, y = -763.87, z = 58.0,
		["1"] = { 1046.56,-774.55,57.69,90.71 },
		["2"] = { 1046.56,-778.24,57.68,90.71 },
		["3"] = { 1046.55,-782.0,57.68,90.71 },
		["4"] = { 1046.54,-785.65,57.66,90.71 }
	},
	["15"] = { x = -796.69, y = -2022.85, z = 9.17,
		["1"] = { -779.77,-2040.03,8.56,314.65 },
		["2"] = { -777.36,-2042.58,8.56,314.65 },
		["3"] = { -774.92,-2044.9,8.56,314.65 }
	},
	["16"] = { x = 453.28, y = -1146.77, z = 29.5,
		["1"] = { 467.33,-1151.89,28.96,85.04 },
		["2"] = { 467.16,-1154.75,28.96,85.04 },
		["3"] = { 467.1,-1157.73,28.96,87.88 }
	},
	["17"] = { x = 528.65, y = -146.25, z = 58.37,
		["1"] = { 540.99,-136.2,59.13,178.59 },
		["2"] = { 544.84,-136.25,59.01,178.59 },
		["3"] = { 548.83,-136.31,59.01,181.42 },
		["4"] = { 552.81,-136.41,58.99,178.59 }
	},
	["18"] = { x = -1159.56, y = -739.39, z = 19.88,
		["1"] = { -1144.95,-745.49,19.34,104.89 },
		["2"] = { -1142.76,-748.44,19.19,107.72 },
		["3"] = { -1140.18,-751.41,19.06,107.72 },
		["4"] = { -1137.99,-754.36,18.91,107.72 },
		["5"] = { -1135.43,-757.3,18.75,107.72 },
		["6"] = { -1133.12,-760.4,18.59,107.72 },
		["7"] = { -1130.59,-763.27,18.43,107.72 }
	},
	["19"] = { x = -791.48, y = 336.48, z = 85.7,
		["1"] = { -791.64,331.67,85.38,181.42 }
	},
	["20"] = { x = -800.45, y = 336.61, z = 85.7,
		["1"] = { -800.38,331.9,85.38,181.42 }
	},
	["21"] = { x = 935.95, y = 0.36, z = 78.76,
		["1"] = { 933.29,-3.74,78.44,147.41 }
	},
	["22"] = { x = 1725.21, y = 4711.77, z = 42.11,
		["1"] = { 1722.82,4700.38,42.28,87.88 }
	},
	["23"] = { x = 1624.05, y = 3566.14, z = 35.15,
		["1"] = { 1633.27,3563.91,34.91,303.31 }
	},
--	["24"] = { x = 1143.8, y = 2667.46, z = 38.15,
--		["1"] = { 1137.41,2674.26,37.83,0.0 }
--	}, -- Hotel
	["25"] = { x = -73.35, y = -2004.6, z = 18.27,
		["1"] = { -59.61,-1990.85,17.69,155.91 },
		["2"] = { -63.69,-1989.71,17.69,167.25 },
		["3"] = { -67.6,-1989.01,17.69,170.08 },
		["4"] = { -71.34,-1988.57,17.69,172.92 },
		["5"] = { -74.96,-1988.07,17.69,170.08 },
		["6"] = { -78.64,-1987.63,17.69,170.08 },
		["7"] = { -82.27,-1987.19,17.69,170.08 }
	},
	["41"] = { x = 340.08, y = -576.19, z = 28.8,
		["1"] = { 333.34,-574.76,28.48,340.16 }
	},
	["42"] = { x = 338.19, y = -586.91, z = 74.16,
		["1"] = { 351.76,-588.19,74.16,337.33 }
	},
	["43"] = { x = -253.92, y = 6339.42, z = 32.42,
		["1"] = { -258.47,6347.58,32.1,269.3 },
		["2"] = { -261.6,6344.21,32.1,269.3 },
		["3"] = { -264.97,6340.84,32.1,272.13 }
	},
	["44"] = { x = -271.7, y = 6321.75, z = 32.42,
		["1"] = { -273.13,6329.85,32.1,133.23 }
	},
	["45"] = { x = 1206.15, y = -1474.68, z = 34.85,
		["1"] = { 1196.58,-1468.52,34.93,0.0 },
		["2"] = { 1200.73,-1468.58,34.93,0.0 },
		["3"] = { 1204.83,-1468.62,34.93,0.0 }
	},
	["61"] = { x = 443.49, y = -974.47, z = 25.7,
		["1"] = { 436.84,-986.18,25.38,87.88 },
		["2"] = { 436.8,-988.86,25.38,87.88 },
		["3"] = { 436.86,-991.6,25.38,87.88 },
		["4"] = { 436.88,-994.28,25.38,87.88 },
		["5"] = { 436.9,-997.0,25.38,87.88 },
		["6"] = { 425.97,-997.08,25.38,272.13 },
		["7"] = { 425.98,-994.43,25.38,272.13 },
		["8"] = { 425.99,-991.7,25.38,272.13 },
		["9"] = { 425.94,-989.05,25.38,272.13 },
		["10"] = { 426.07,-984.27,25.38,269.3 },
		["11"] = { 426.06,-981.56,25.38,272.13 },
		["12"] = { 426.07,-978.93,25.38,272.13 },
		["13"] = { 426.0,-976.19,25.38,272.13 },
		["14"] = { 445.85,-986.14,25.38,269.3 },
		["15"] = { 445.88,-988.76,25.38,272.13 },
		["16"] = { 445.86,-991.56,25.38,272.13 },
		["17"] = { 445.93,-994.28,25.38,272.13 },
		["18"] = { 445.92,-997.01,25.38,272.13 }
	},
	["62"] = { x = 463.15, y = -982.33, z = 43.69,
		["1"] = { 449.27,-981.34,43.69,87.88 }
	},
	["63"] = { x = 1839.35, y = 3691.23, z = 33.97,
		["1"] = { 1844.43,3689.35,33.78,303.31 },
		["2"] = { 1846.28,3686.09,33.78,303.31 },
		["3"] = { 1848.23,3682.71,33.78,303.31 }
	},
	["64"] = { x = 1844.42, y = 3707.33, z = 33.97,
		["1"] = { 1853.31,3706.24,33.97,28.35 }
	},
	["65"] = { x = -459.37, y = 6016.01, z = 31.49,
		["1"] = { -469.04,6038.77,31.0,226.78 },
		["2"] = { -472.45,6035.42,31.0,226.78 },
		["3"] = { -476.09,6031.71,31.0,226.78 },
		["4"] = { -479.61,6028.09,31.0,226.78 },
		["5"] = { -482.7,6024.95,31.0,226.78 }
	},
	["66"] = { x = -479.48, y = 6011.12, z = 31.29,
		["1"] = { -475.04,5988.45,31.73,317.49 }
	},
	["67"] = { x = 1840.78, y = 2545.84, z = 45.66,
		["1"] = { 1833.59,2542.09,45.54,272.13 }
	},
	["68"] = { x = 1840.79, y = 2538.28, z = 45.66,
		["1"] = { 1833.59,2542.09,45.54,272.13 }
	},
	["69"] = { x = 377.58, y = 791.66, z = 187.64,
		["1"] = { 374.46,796.86,187.03,178.59 }
	},
	["70"] = { x = 382.12, y = -1617.63, z = 29.28,
		["1"] = { 386.96,-1615.25,28.96,232.45 },
		["2"] = { 388.99,-1612.91,28.96,229.61 },
		["3"] = { 390.91,-1610.57,28.96,232.45 },
		["4"] = { 392.96,-1608.22,28.96,229.61 }
	},
	["71"] = { x = 381.17, y = -1634.05, z = 29.28,
		["1"] = { 384.12,-1623.63,29.67,320.32 }
	},
	["72"] = { x = 392.56, y = -1632.1, z = 29.28,
		["1"] = { 397.13,-1622.63,29.55,320.32 }
	},
	["121"] = { x = -1728.06, y = -1050.69, z = 1.7,
		["1"] = { -1734.05,-1057.01,0.94,133.23 }
	},
	["122"] = { x = 1966.55, y = 3976.15, z = 31.49,
		["1"] = { 1971.66,3985.42,30.13,331.66 }
	},
	["123"] = { x = -776.63, y = -1494.93, z = 2.29,
		["1"] = { -786.5,-1498.89,-0.57,110.56 }
	},
	["124"] = { x = -895.04, y = 5687.46, z = 3.03,
		["1"] = { -907.5,5684.52,0.76,102.05 }
	},
	["125"] = { x = 1509.64, y = 3788.7, z = 33.51,
		["1"] = { 1493.4,3797.23,29.89,50.19 }
	},
	["126"] = { x = 4971.79, y = -5170.93, z = 2.27,
		["1"] = { 4952.76,-5163.61,-0.39,65.2 }
	},
	["141"] = { x = 2434.96, y = 5012.06, z = 46.84,
		["1"] = { 2441.6,5010.56,45.76,277.8 }
	},
	["142"] = { x = 453.74, y = -600.6, z = 28.59,
		["1"] = { 462.81,-606.03,28.49,212.6 },
		["2"] = { 461.54,-612.34,28.49,215.44 },
		["3"] = { 460.98,-619.81,28.49,215.44 }
	},
	["143"] = { x = 84.18, y = -1552.0, z = 29.59,
		["1"] = { 80.56,-1541.11,29.17,48.19 },
		["2"] = { 76.58,-1545.85,29.17,48.19 },
		["3"] = { 72.59,-1550.58,29.17,48.19 }
	},
	["144"] = { x = 355.15, y = 275.79, z = 103.15,
		["1"] = { 359.95,272.31,102.72,340.16 },
		["2"] = { 364.05,270.74,102.68,340.16 },
		["3"] = { 368.1,269.31,102.67,340.16 }
	},
	["145"] = { x = 905.6, y = -165.08, z = 74.11,
		["1"] = { 916.21,-170.61,74.04,99.22 },
		["2"] = { 918.35,-167.18,74.22,99.22 },
		["3"] = { 920.64,-163.54,74.43,99.22 }
	},
	["146"] = { x = -154.58, y = -1174.61, z = 23.99,
		["1"] = { -141.94,-1180.86,23.86,87.88 }
	},
	["147"] = { x = 1731.42, y = 3708.32, z = 34.17,
		["1"] = { 1728.51,3715.11,34.26,19.85 }
	},
	["148"] = { x = -275.07, y = 6120.22, z = 31.32,
		["1"] = { -282.22,6133.17,31.59,226.78 }
	},
	["149"] = { x = 283.93, y = 2849.5, z = 43.64,
		["1"] = { 277.34,2840.0,43.29,28.35 }
	},
	["150"] = { x = -412.39, y = 6171.06, z = 31.48,
		["1"] = { -401.19,6167.31,31.24,317.49 }
	},
	["151"] = { x = 1695.55, y = 4787.69, z = 42.01,
		["1"] = { 1691.56,4782.3,41.52,87.88 },
		["2"] = { 1691.54,4778.38,41.53,87.88 },
		["3"] = { 1691.56,4774.37,41.53,87.88 },
		["4"] = { 1691.57,4770.32,41.53,87.88 },
		["5"] = { 1691.5,4766.35,41.53,87.88 },
		["6"] = { 1691.52,4762.46,41.52,87.88 }
	},
	["152"] = { x = 156.45, y = -3044.33, z = 7.03,
		["1"] = { 165.67,-3043.99,5.98,272.13 },
		["2"] = { 165.67,-3050.43,5.98,272.13 }
	},
	["153"] = { x = -593.07, y = -1058.59, z = 22.34,
		["1"] = { -596.71,-1059.2,22.31,87.88 }
	},
	["154"] = { x = -1924.44, y = 2060.51, z = 140.83,
		["1"] = { -1919.81,2067.46,140.17,226.78 }
	},
	["155"] = { x = -1531.91, y = 74.85, z = 56.75,
		["1"] = { -1527.7,74.11,56.41,5.67 },
		["2"] = { -1523.34,74.73,56.41,8.51 },
		["3"] = { -1537.6,77.08,56.41,317.49 }
	},
	["156"] = { x = -1164.9, y = -896.63, z = 14.02,
		["1"] = { -1163.72,-890.94,14.15,119.06 },
		["2"] = { -1165.58,-887.97,14.15,119.06 }
	},
	["157"] = { x = -614.55, y = -940.48, z = 22.09,
		["1"] = { -616.64,-933.57,22.28,110.56 }
	},
	["158"] = { x = 1601.69, y = 6452.75, z = 25.22,
		["1"] = { 1607.56,6453.29,25.22,167.25 }
	},
	["159"] = { x = 813.63, y = -735.42, z = 27.6,
		["1"] = { 810.02,-732.4,27.62,130.4 }
	},
	["160"] = { x = 553.88, y = -201.27, z = 54.48,
		["1"] = { 546.26,-212.96,52.99,158.75 }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENGARAGE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.openGarage(garageName)
	openGarage = garageName
	SetNuiFocus(true,true)
	TriggerEvent("hud:Active",false)
	SendNUIMessage({ action = "openNUI" })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLEMODS
-----------------------------------------------------------------------------------------------------------------------------------------
function vehicleMods(veh,vehCustom)
	if vehCustom then
		SetVehicleModKit(veh,0)

		if vehCustom["wheeltype"] ~= nil then
			SetVehicleWheelType(veh,vehCustom["wheeltype"])
		end

		for i = 0,16 do
			if vehCustom["mods"][tostring(i)] ~= nil then
				SetVehicleMod(veh,i,vehCustom["mods"][tostring(i)])
			end
		end

		for i = 17,22 do
			if vehCustom["mods"][tostring(i)] ~= nil then
				ToggleVehicleMod(veh,i,vehCustom["mods"][tostring(i)])
			end
		end

		for i = 23,24 do
			if vehCustom["mods"][tostring(i)] ~= nil then
				if vehCustom["var"] == nil then
					vehCustom["var"] = {}
					vehCustom["var"][tostring(i)] = 0
				end

				SetVehicleMod(veh,i,vehCustom["mods"][tostring(i)],vehCustom["var"][tostring(i)])
			end
		end

		for i = 25,48 do
			if vehCustom["mods"][tostring(i)] ~= nil then
				SetVehicleMod(veh,i,vehCustom["mods"][tostring(i)])
			end
		end

		for i = 0,3 do
			SetVehicleNeonLightEnabled(veh,i,vehCustom["neon"][tostring(i)])
		end

		if vehCustom["extras"] ~= nil then
			for i = 1,12 do
				local onoff = tonumber(vehCustom["extras"][i])
				if onoff == 1 then
					SetVehicleExtra(veh,i,0)
				else
					SetVehicleExtra(veh,i,1)
				end
			end
		end

		if vehCustom["liverys"] ~= nil and vehCustom["liverys"] ~= 24  then
			SetVehicleLivery(veh,vehCustom["liverys"])
		end

		if vehCustom["plateIndex"] ~= nil and vehCustom["plateIndex"] ~= 4 then
			SetVehicleNumberPlateTextIndex(veh,vehCustom["plateIndex"])
		end

		SetVehicleXenonLightsColour(veh,vehCustom["xenonColor"])
		SetVehicleColours(veh,vehCustom["colors"][1],vehCustom["colors"][2])
		SetVehicleExtraColours(veh,vehCustom["extracolors"][1],vehCustom["extracolors"][2])
		SetVehicleNeonLightsColour(veh,vehCustom["lights"][1],vehCustom["lights"][2],vehCustom["lights"][3])
		SetVehicleTyreSmokeColor(veh,vehCustom["smokecolor"][1],vehCustom["smokecolor"][2],vehCustom["smokecolor"][3])

		if vehCustom["tint"] ~= nil then
			SetVehicleWindowTint(veh,vehCustom["tint"])
		end

		if vehCustom["dashColour"] ~= nil then
			SetVehicleInteriorColour(veh,vehCustom["dashColour"])
		end

		if vehCustom["interColour"] ~= nil then
			SetVehicleDashboardColour(veh,vehCustom["interColour"])
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWNPOSITION
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.spawnPosition()
	local checkSlot = 0
	local checkPos = nil

	repeat
		checkSlot = checkSlot + 1

		if garageLocates[openGarage][tostring(checkSlot)] ~= nil then
			local _,groundZ = GetGroundZAndNormalFor_3dCoord(garageLocates[openGarage][tostring(checkSlot)][1],garageLocates[openGarage][tostring(checkSlot)][2],garageLocates[openGarage][tostring(checkSlot)][3])
			spawnSelected = { garageLocates[openGarage][tostring(checkSlot)][1],garageLocates[openGarage][tostring(checkSlot)][2],groundZ,garageLocates[openGarage][tostring(checkSlot)][4] }
			checkPos = GetClosestVehicle(spawnSelected[1],spawnSelected[2],spawnSelected[3],2.501,0,71)
		end
	until not DoesEntityExist(checkPos) or garageLocates[openGarage][tostring(checkSlot)] == nil

	if garageLocates[openGarage][tostring(checkSlot)] == nil then
		TriggerEvent("Notify","amarelo","Vagas estão ocupadas.",5000)

		return false
	end

	return true,spawnSelected
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.createVehicle(vehHash,vehNet,vehPlate,vehEngine,vehBody,vehFuel,vehCustom,vehWindows,vehDoors,vehTyres)
	if NetworkDoesNetworkIdExist(vehNet) then
		local nveh = NetToEnt(vehNet)
		if DoesEntityExist(nveh) then
			NetworkRegisterEntityAsNetworked(nveh)
			while not NetworkGetEntityIsNetworked(nveh) do
				NetworkRegisterEntityAsNetworked(nveh)
				Citizen.Wait(1)
			end

			SetNetworkIdCanMigrate(vehNet,true)
			NetworkSetNetworkIdDynamic(vehNet,false)
			SetNetworkIdExistsOnAllMachines(vehNet,true)

			SetVehicleNumberPlateText(nveh,vehPlate)
			SetEntityAsMissionEntity(nveh,true,true)
			SetVehicleHasBeenOwnedByPlayer(nveh,true)
			SetVehicleNeedsToBeHotwired(nveh,false)
			SetVehRadioStation(nveh,"OFF")

			if vehCustom ~= nil then
				local vehMods = json.decode(vehCustom)
				vehicleMods(nveh,vehMods)
			end

			SetVehicleEngineHealth(nveh,vehEngine + 0.0)
			SetVehicleBodyHealth(nveh,vehBody + 0.0)
			SetVehicleFuelLevel(nveh,vehFuel + 0.0)

			if vehWindows then
				if json.decode(vehWindows) ~= nil then
					for k,v in pairs(json.decode(vehWindows)) do
						if not v then
							SmashVehicleWindow(nveh,parseInt(k))
						end
					end
				end
			end

			if vehTyres then
				if json.decode(vehTyres) ~= nil then
					for k,v in pairs(json.decode(vehTyres)) do
						if v < 2 then
							SetVehicleTyreBurst(nveh,parseInt(k),(v == 1),1000.01)
						end
					end
				end
			end

			if vehDoors then
				if json.decode(vehDoors) ~= nil then
					for k,v in pairs(json.decode(vehDoors)) do
						if v then
							SetVehicleDoorBroken(nveh,parseInt(k),parseInt(v))
						end
					end
				end
			end
			
			SetVehicleDoorsLockedForAllPlayers(nveh,true)
			SetVehicleDoorsLocked(nveh,2)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETEVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.deleteVehicle(vehicle)
	if IsEntityAVehicle(vehicle) then
		local vehWindows = {}
		local vehDoors = {}
		local vehTyres = {}

		for i = 0,5 do
			vehDoors[i] = IsVehicleDoorDamaged(vehicle,i)
		end

		for i = 0,5 do
			vehWindows[i] = IsVehicleWindowIntact(vehicle,i)
		end

		for i = 0,7 do
			local tyre_state = 2

			if IsVehicleTyreBurst(vehicle,i,true) then
				tyre_state = 1
			elseif IsVehicleTyreBurst(vehicle,i,false) then
				tyre_state = 0
			end

			vehTyres[i] = tyre_state
		end

		vSERVER.tryDelete(NetworkGetNetworkIdFromEntity(vehicle),GetVehicleEngineHealth(vehicle),GetVehicleBodyHealth(vehicle),GetVehicleFuelLevel(vehicle),vehDoors,vehWindows,vehTyres,GetVehicleNumberPlateText(vehicle),{ GetVehicleHandlingFloat(vehicle,"CHandlingData","fBrakeForce"),GetVehicleHandlingFloat(vehicle,"CHandlingData","fBrakeBiasFront"),GetVehicleHandlingFloat(vehicle,"CHandlingData","fHandBrakeForce") })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("close",function()
	SetNuiFocus(false,false)
	TriggerEvent("hud:Active",true)
	SendNUIMessage({ action = "closeNUI" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MYVEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("myVehicles",function(data,cb)
	local vehicles = vSERVER.myVehicles(openGarage)
	if vehicles then
		cb({ vehicles = vehicles })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWNVEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("spawnVehicles",function(data)
	vSERVER.spawnVehicles(data["name"],openGarage)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETEVEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("deleteVehicles",function(data)
	cRP.deleteVehicle(vRP.nearVehicle(15))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLELOCK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("garages:vehicleLock")
AddEventHandler("garages:vehicleLock",function(vehIndex,vehLock)
	if NetworkDoesNetworkIdExist(vehIndex) then
		local v = NetToEnt(vehIndex)
		if DoesEntityExist(v) then
			if vehLock then
				SetVehicleDoorsLockedForAllPlayers(v,false)
				SetVehicleDoorsLocked(v,1)
			else
				SetVehicleDoorsLockedForAllPlayers(v,true)
				SetVehicleDoorsLocked(v,2)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEARCHBLIP
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.searchBlip(vehCoords)
	if DoesBlipExist(searchBlip) then
		RemoveBlip(searchBlip)
		searchBlip = nil
	end

	searchBlip = AddBlipForCoord(vehCoords["x"],vehCoords["y"],vehCoords["z"])
	SetBlipSprite(searchBlip,225)
	SetBlipColour(searchBlip,2)
	SetBlipScale(searchBlip,0.6)
	SetBlipAsShortRange(searchBlip,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Veículo")
	EndTextCommandSetBlipName(searchBlip)

	SetTimeout(30000,function()
		RemoveBlip(searchBlip)
		searchBlip = nil
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLOCKSIGNAL
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.blockSignal()
	if DoesBlipExist(searchBlip) then
		RemoveBlip(searchBlip)
		searchBlip = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUTTONS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)

	while true do
		local timeDistance = 999
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)
			for k,v in pairs(garageLocates) do
				local distance = #(coords - vector3(v["x"],v["y"],v["z"]))
				if distance <= 15 then
					timeDistance = 1
					DrawMarker(23,v["x"],v["y"],v["z"] - 0.95,0.0,0.0,0.0,0.0,0.0,0.0,1.75,1.75,0.0,46,110,76,100,0,0,0,0)

					if IsControlJustPressed(1,38) and distance <= 1.0 then
						vSERVER.returnGarages(k)
					end
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:SYNCPLATES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("garages:syncPlates")
AddEventHandler("garages:syncPlates",function(vehPlate)
	vehPlates[vehPlate] = true
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:SYNCPLATES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("garages:syncRemlates")
AddEventHandler("garages:syncRemlates",function(vehPlate)
	vehPlates[vehPlate] = nil
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:ALLPLATES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("garages:allPlates")
AddEventHandler("garages:allPlates",function(vehTable)
	vehPlates = vehTable
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTANIMHOTWIRED
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.startAnimHotwired()
	vehHotwired = true

	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do
		Citizen.Wait(1)
	end

	TaskPlayAnim(PlayerPedId(),animDict,anim,3.0,3.0,-1,49,5.0,0,0,0)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOPANIMHOTWIRED
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.stopAnimHotwired(vehicle)
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do
		Citizen.Wait(1)
	end

	vehHotwired = false
	StopAnimTask(PlayerPedId(),animDict,anim,2.0)

	if vehicle ~= nil then
		NetworkRegisterEntityAsNetworked(vehicle)
		while not NetworkGetEntityIsNetworked(vehicle) do
			NetworkRegisterEntityAsNetworked(vehicle)
			Citizen.Wait(1)
		end

		local vehNet = NetworkGetNetworkIdFromEntity(vehicle)

		SetNetworkIdCanMigrate(vehNet,true)
		NetworkSetNetworkIdDynamic(vehNet,false)
		SetNetworkIdExistsOnAllMachines(vehNet,true)

		SetEntityAsMissionEntity(vehicle,true,false)
		SetVehicleHasBeenOwnedByPlayer(vehicle,true)
		SetVehicleNeedsToBeHotwired(vehicle,false)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEHOTWIRED
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.updateHotwired(status)
	vehHotwired = status
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOOPHOTWIRED
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			local vehicle = GetVehiclePedIsUsing(ped)
			local platext = GetVehicleNumberPlateText(vehicle)
			if GetPedInVehicleSeat(vehicle,-1) == ped and not vehPlates[platext] then
				SetVehicleEngineOn(vehicle,false,true,true)
				DisablePlayerFiring(ped,true)
				timeDistance = 1
			end

			if vehHotwired and vehicle then
				DisableControlAction(1,75,true)
				DisableControlAction(1,20,true)
				timeDistance = 1
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:UPDATELOCS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("garages:updateLocs")
AddEventHandler("garages:updateLocs",function(homeName,homeInfos)
	garageLocates[homeName] = homeInfos
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:UPDATEREMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("garages:updateRemove")
AddEventHandler("garages:updateRemove",function(homeName,homeInfos)
	if garageLocates[homeName] then
		garageLocates[homeName] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:ALLLOCS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("garages:allLocs")
AddEventHandler("garages:allLocs",function(garageTable)
	for k,v in pairs(garageTable) do
		garageLocates[k] = v
	end
end)