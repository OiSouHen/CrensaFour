-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Zones = {}
local Models = {}
local success = false
local innerEntity = {}
local playerActive = false
local targetActive = false
local policeService = false
local paramedicService = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCATELOCS
-----------------------------------------------------------------------------------------------------------------------------------------
local locateLocs = {
	{ -832.41,-393.87,31.32,"Desmanche" },
	{ 2645.42,4253.48,44.79,"Desmanche" },
	{ 963.18,-1856.79,31.19,"Desmanche" },
	{ -142.24,-1174.19,23.76,"Reboque" },
	{ 1724.84,3715.31,34.22,"Reboque" },
	{ -305.45,6117.62,31.49,"Reboque" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE:UPDATESERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("police:updateService")
AddEventHandler("police:updateService",function(status)
	policeService = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARAMEDIC:UPDATESERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("paramedic:updateService")
AddEventHandler("paramedic:updateService",function(status)
	paramedicService = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP:PLAYERACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp:playerActive")
AddEventHandler("vrp:playerActive",function()
	playerActive = true
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	RegisterCommand("+entityTarget",playerTargetEnable)
	RegisterCommand("-entityTarget",playerTargetDisable)
	RegisterKeyMapping("+entityTarget","Interação auricular.","keyboard","LMENU")

	AddCircleZone("Trucker",vector3(1239.87,-3257.2,7.09),0.5,{
		name = "Trucker",
		heading = 3374176
	},{
		distance = 1.25,
		options = {
			{
				event = "trucker:initService",
				label = "Trabalhar",
				tunnel = "client"
			}
		}
	})
	
	AddCircleZone("makePaper",vector3(-533.18,5292.15,74.17),0.75,{
		name = "makePaper",
		heading = 3374176
	},{
		distance = 0.75,
		options = {
			{
				event = "inventory:makeProducts",
				label = "Produzir",
				tunnel = "products",
				service = "paper"
			}
		}
	})
	
	AddCircleZone("callTaxi",vector3(-1038.98,-2731.16,20.17),0.75,{
		name = "callTaxi",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "smartphone:callTaxi",
				label = "Chamar Taxi",
				tunnel = "client"
			}
		}
	})
	
	AddCircleZone("bankSalary01",vector3(241.43,225.46,106.29),0.75,{
		name = "bankSalary01",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "bank:openSystem",
				label = "Abrir",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("bankSalary02",vector3(243.21,224.77,106.29),0.75,{
		name = "bankSalary02",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "bank:openSystem",
				label = "Abrir",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("bankSalary03",vector3(246.62,223.61,106.29),0.75,{
		name = "bankSalary03",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "bank:openSystem",
				label = "Abrir",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("bankSalary04",vector3(248.43,222.95,106.29),0.75,{
		name = "bankSalary04",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "bank:openSystem",
				label = "Abrir",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("bankSalary05",vector3(251.79,221.73,106.29),0.75,{
		name = "bankSalary05",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "bank:openSystem",
				label = "Abrir",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("bankSalary06",vector3(253.59,221.08,106.29),0.75,{
		name = "bankSalary06",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "bank:openSystem",
				label = "Abrir",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("bankSalary07",vector3(-113.01,6470.21,31.63),0.75,{
		name = "bankSalary07",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "bank:openSystem",
				label = "Abrir",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("bankSalary08",vector3(-111.99,6469.15,31.63),0.75,{
		name = "bankSalary08",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "bank:openSystem",
				label = "Abrir",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("bankSalary09",vector3(-110.92,6468.1,31.63),0.75,{
		name = "bankSalary09",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "bank:openSystem",
				label = "Abrir",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("Service:Lspd",vector3(441.81,-982.05,30.83),0.25,{
		name = "Service:Lspd",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "player:servicePolice",
				label = "Entrar em Serviço",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("Service:Sheriff-1",vector3(1852.85,3687.79,34.07),0.25,{
		name = "Service:Sheriff-1",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "player:servicePolice",
				label = "Entrar em Serviço",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("Service:Sheriff-2",vector3(-447.28,6013.01,32.41),0.25,{
		name = "Service:Sheriff-2",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "player:servicePolice",
				label = "Entrar em Serviço",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("Service:Corrections",vector3(1840.20,2578.48,46.07),0.25,{
		name = "Service:Corrections",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "player:servicePolice",
				label = "Entrar em Serviço",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("Service:Ranger",vector3(385.43,794.42,187.48),0.25,{
		name = "Service:Ranger",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "player:servicePolice",
				label = "Entrar em Serviço",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("Service:State",vector3(382.01,-1596.39,29.91),0.25,{
		name = "Service:State",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "player:servicePolice",
				label = "Entrar em Serviço",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("Service:Paramedic-1",vector3(310.23,-597.54,43.29),0.25,{
		name = "Service:Paramedic-1",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "player:serviceParamedic",
				label = "Entrar em Serviço",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("Service:Paramedic-2",vector3(1831.79,3672.95,34.27),0.25,{
		name = "Service:Paramedic-2",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "player:serviceParamedic",
				label = "Entrar em Serviço",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("Service:Paramedic-3",vector3(-254.77,6331.03,32.79),0.25,{
		name = "Service:Paramedic-3",
		heading = 3374176
	},{
		distance = 1.5,
		options = {
			{
				event = "player:serviceParamedic",
				label = "Entrar em Serviço",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("Service:Paramedic-4",vector3(1188.05,-1468.31,34.66),0.25,{
		name = "Service:Paramedic-4",
		heading = 3374176
	},{
		distance = 1.5,
		options = {
			{
				event = "player:serviceParamedic",
				label = "Entrar em Serviço",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("Service:Mechanic-1",vector3(126.03,-3007.25,6.85),0.25,{
		name = "Service:Mechanic-1",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "player:serviceMechanic",
				label = "Entrar em Serviço",
				tunnel = "server"
			}
		}
	})
	
	AddCircleZone("Service:Mechanic-2",vector3(542.48,-200.24,54.49),0.25,{
		name = "Service:Mechanic-2",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "player:serviceMechanic",
				label = "Entrar em Serviço",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("treatment01",vector3(-253.92,6331.07,32.42),0.75,{
		name = "treatment01",
		heading = 3374176
	},{
		shop = "Paleto",
		distance = 1.0,
		options = {
			{
				event = "checkin:initCheck",
				label = "Tratamento",
				tunnel = "shop"
			}
		}
	})

	AddCircleZone("treatment02",vector3(1833.21,3676.09,34.27),0.75,{
		name = "treatment02",
		heading = 3374176
	},{
		shop = "Sandy",
		distance = 1.0,
		options = {
			{
				event = "checkin:initCheck",
				label = "Tratamento",
				tunnel = "shop"
			}
		}
	})

	AddCircleZone("treatment03",vector3(307.03,-595.12,43.29),0.75,{
		name = "treatment03",
		heading = 3374176
	},{
		shop = "Santos",
		distance = 1.0,
		options = {
			{
				event = "checkin:initCheck",
				label = "Tratamento",
				tunnel = "shop"
			}
		}
	})

	AddCircleZone("treatment04",vector3(350.92,-587.68,28.8),0.75,{
		name = "treatment04",
		heading = 3374176
	},{
		shop = "Santos",
		distance = 1.0,
		options = {
			{
				event = "checkin:initCheck",
				label = "Tratamento",
				tunnel = "shop"
			}
		}
	})

	AddCircleZone("treatment05",vector3(1768.67,2570.59,45.73),0.75,{
		name = "treatment05",
		heading = 3374176
	},{
		shop = "Bolingbroke",
		distance = 1.0,
		options = {
			{
				event = "checkin:initCheck",
				label = "Tratamento",
				tunnel = "shop"
			}
		}
	})

	AddCircleZone("treatment06",vector3(-469.26,6289.48,13.61),0.75,{
		name = "treatment06",
		heading = 3374176
	},{
		shop = "Clandestine",
		distance = 1.0,
		options = {
			{
				event = "checkin:initCheck",
				label = "Tratamento",
				tunnel = "shop"
			}
		}
	})

	AddTargetModel({ -1691644768,-742198632 },{
		options = {
			{
				event = "inventory:emptyBottle",
				label = "Encher",
				tunnel = "server"
			},
			{
				event = "inventory:Drink",
				label = "Beber",
				tunnel = "server"
			}
		},
		distance = 0.75
	})

	AddTargetModel({ 1631638868,2117668672,-1498379115,-1519439119,-289946279 },{
		options = {
			{
				event = "target:animDeitar",
				label = "Deitar",
				tunnel = "client"
			}
		},
		distance = 1.0
	})
	
	AddTargetModel({ -935625561 },{
		options = {
			{
				event = "target:animDeitar",
				label = "Deitar",
				tunnel = "client"
			},{
				event = "target:bedDestroy",
				label = "Destruir",
				tunnel = "client"
			}
		},
		distance = 1.0
	})

	AddTargetModel({ -171943901,-109356459,1805980844,-99500382,1262298127,1737474779,2040839490,1037469683,867556671,-1521264200,-741944541,-591349326,-293380809,-628719744,-1317098115,1630899471,38932324,-523951410,725259233,764848282,2064599526,536071214,589738836,146905321,47332588,-1118419705,538002882,-377849416,96868307,-1195678770,-853526657,652816835 },{
		options = {
			{
				event = "target:animSentar",
				label = "Sentar",
				tunnel = "client"
			}
		},
		distance = 1.0
	})

	AddTargetModel({ 690372739 },{
		options = {
			{
				event = "shops:coffeeMachine",
				label = "Comprar",
				tunnel = "client"
			}
		},
		distance = 0.75
	})

	AddTargetModel({ -654402915,1421582485 },{
		options = {
			{
				event = "shops:donutMachine",
				label = "Comprar",
				tunnel = "client"
			}
		},
		distance = 0.75
	})

	AddTargetModel({ 992069095,1114264700 },{
		options = {
			{
				event = "shops:sodaMachine",
				label = "Comprar",
				tunnel = "client"
			}
		},
		distance = 0.75
	})

	AddTargetModel({ 1129053052 },{
		options = {
			{
				event = "shops:burgerMachine",
				label = "Comprar",
				tunnel = "client"
			}
		},
		distance = 0.75
	})

	AddTargetModel({ -1581502570 },{
		options = {
			{
				event = "shops:hotdogMachine",
				label = "Comprar",
				tunnel = "client"
			}
		},
		distance = 0.75
	})

	AddTargetModel({ -272361894 },{
		options = {
			{
				event = "shops:Chihuahua",
				label = "Comprar",
				tunnel = "client"
			}
		},
		distance = 0.75
	})

	AddTargetModel({ 1099892058 },{
		options = {
			{
				event = "shops:waterMachine",
				label = "Comprar",
				tunnel = "client"
			}
		},
		distance = 0.75
	})
	
	AddTargetModel({ -832573324,-1430839454,1457690978,1682622302,402729631,-664053099,1794449327,307287994,-1323586730,111281960,-541762431,-745300483,-417505688 },{
		options = {
			{
				event = "inventory:Animals",
				label = "Esfolar",
				tunnel = "client"
			}
		},
		distance = 1.50
	})
	
	AddTargetModel({ 1281992692,1158960338,1511539537,-78626473,-429560270 },{
		options = {
			{
				event = "hup:phoneObject",
				label = "Ligar",
				tunnel = "client"
			}
		},
		distance = 1.0
	})

	AddTargetModel({ 684586828,577432224,-1587184881,-1426008804,-228596739,1437508529,-1096777189,-468629664,1143474856,-2096124444,-115771139,1329570871,-130812911 },{
		options = {
			{
				event = "inventory:verifyObjects",
				label = "Vasculhar",
				tunnel = "police",
				service = "Lixeiro"
			}
		},
		distance = 0.75
	})
	
	AddTargetModel({ -206690185,666561306,218085040,-58485588,1511880420,682791951 },{
		options = {
			{
				event = "inventory:verifyObjects",
				label = "Vasculhar",
				tunnel = "police",
				service = "Lixeiro"
			},
			{
				event = "player:enterTrash",
				label = "Esconder",
				tunnel = "client"
			}
		},
		distance = 0.75
	})

	AddTargetModel({ 1211559620,1363150739,-1186769817,261193082,-756152956,-1383056703,720581693,1287257122,917457845 },{
		options = {
			{
				event = "inventory:verifyObjects",
				label = "Vasculhar",
				tunnel = "police",
				service = "Jornaleiro"
			}
		},
		distance = 0.75
	})

	AddTargetModel({ -2007231801,1339433404,1694452750,1933174915,-462817101,-469694731,-164877493 },{
		options = {
			{
				event = "crafting:fuelShop",
				label = "Combustível",
				tunnel = "client"
			}
		},
		distance = 0.75
	})
	
	AddCircleZone("streetBox",vector3(81.38,-1396.5,29.37),0.5,{
		name = "streetBox",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "works:streetBox",
				label = "Pegar Caixa",
				tunnel = "server"
			}
		}
	})
	
	AddCircleZone("bsjuice01",vector3(-1190.78,-904.23,13.99),0.5,{
		name = "bsjuice01",
		heading = 3374176
	},{
		distance = 1.25,
		options = {
			{
				event = "works:makeJuice",
				label = "Encher Copo",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("bsjuice02",vector3(-1190.12,-905.16,13.99),0.5,{
		name = "bsjuice02",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "works:makeJuice",
				label = "Encher Copo",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("bsjuice03",vector3(1585.82,6459.13,26.02),0.5,{
		name = "bsjuice03",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "works:makeJuice",
				label = "Encher Copo",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("bsjuice04",vector3(810.69,-764.42,26.77),0.5,{
		name = "bsjuice04",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "works:makeJuice",
				label = "Encher Copo",
				tunnel = "server"
			}
		}
	})
	
	AddCircleZone("bsburger01",vector3(-1202.08,-897.21,13.99),0.5,{
		name = "bsburger01",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "works:makeBurger",
				label = "Montar Lanche",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("bsburger02",vector3(-1202.55,-896.55,13.99),0.5,{
		name = "bsburger02",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "works:makeBurger",
				label = "Montar Lanche",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("bsburger03",vector3(1587.93,6458.15,26.02),0.5,{
		name = "bsburger03",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "works:makeBurger",
				label = "Montar Lanche",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("bsburger04",vector3(1587.33,6458.44,26.02),0.5,{
		name = "bsburger04",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "works:makeBurger",
				label = "Montar Lanche",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("bsburger05",vector3(807.67,-762.31,26.77),0.5,{
		name = "bsburger05",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "works:makeBurger",
				label = "Montar Lanche",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("bsburger06",vector3(807.68,-760.2,26.77),0.5,{
		name = "bsburger06",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "works:makeBurger",
				label = "Montar Lanche",
				tunnel = "server"
			}
		}
	})
	
	AddCircleZone("bsbox01",vector3(-1197.91,-892.21,13.99),0.5,{
		name = "bsbox01",
		heading = 3374176
	},{
		distance = 1.25,
		options = {
			{
				event = "works:makeBox",
				label = "Montar Combo",
				tunnel = "server"
			},{
				event = "works:foodBox2",
				label = "Adicionar Brinquedo",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("bsbox02",vector3(1592.02,6456.23,26.02),0.5,{
		name = "bsbox02",
		heading = 3374176
	},{
		distance = 1.25,
		options = {
			{
				event = "works:makeBox",
				label = "Montar Combo",
				tunnel = "server"
			},{
				event = "works:foodBox2",
				label = "Adicionar Brinquedo",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("bsbox03",vector3(812.26,-754.98,26.77),0.5,{
		name = "bsbox03",
		heading = 3374176
	},{
		distance = 1.25,
		options = {
			{
				event = "works:makeBox",
				label = "Montar Combo",
				tunnel = "server"
			},{
				event = "works:foodBox2",
				label = "Adicionar Brinquedo",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("systemHacker",vector3(1275.67,-1710.27,54.76),0.75,{
		name = "systemHacker",
		heading = 3374176
	},{
		distance = 0.75,
		options = {
			{
				event = "stockade:initHacker",
				label = "Hackear Carro Forte",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("divingStore",vector3(1521.08,3780.19,34.46),0.5,{
		name = "divingStore",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "shops:divingSuit",
				label = "Comprar Traje",
				tunnel = "server"
			},{
				event = "hud:rechargeOxigen",
				label = "Reabastecer Oxigênio",
				tunnel = "client"
			}
		}
	})
	
	AddCircleZone("tabletVehicles01",vector3(-38.9,-1100.22,27.26),0.75,{
		name = "tabletVehicles01",
		heading = 3374176
	},{
		shop = "Santos",
		distance = 1.0,
		options = {
			{
				event = "tablet:enterTablet",
				label = "Abrir",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("tabletVehicles02",vector3(-40.37,-1094.57,27.26),0.75,{
		name = "tabletVehicles02",
		heading = 3374176
	},{
		shop = "Santos",
		distance = 1.0,
		options = {
			{
				event = "tablet:enterTablet",
				label = "Abrir",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("tabletVehicles03",vector3(-46.87,-1095.5,27.26),0.75,{
		name = "tabletVehicles03",
		heading = 3374176
	},{
		shop = "Santos",
		distance = 1.0,
		options = {
			{
				event = "tablet:enterTablet",
				label = "Abrir",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("tabletVehicles04",vector3(-51.59,-1094.98,27.26),0.75,{
		name = "tabletVehicles04",
		heading = 3374176
	},{
		shop = "Santos",
		distance = 1.0,
		options = {
			{
				event = "tablet:enterTablet",
				label = "Abrir",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("tabletVehicles05",vector3(-51.15,-1087.13,27.26),0.75,{
		name = "tabletVehicles05",
		heading = 3374176
	},{
		shop = "Santos",
		distance = 1.0,
		options = {
			{
				event = "tablet:enterTablet",
				label = "Abrir",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("tabletVehicles06",vector3(1224.78,2728.01,38.0),0.75,{
		name = "tabletVehicles06",
		heading = 3374176
	},{
		shop = "Sandy",
		distance = 2.0,
		options = {
			{
				event = "tablet:enterTablet",
				label = "Abrir",
				tunnel = "client"
			}
		}
	})
	
	AddTargetModel({ 886033073 },{
		distance = 1.0,
		options = {
			{
				label = "Abrir",
				event = "inventory:verifyObjects",
				service = "smallMedic",
				tunnel = "police"
			}
		}
	})

	AddTargetModel({ 481432069 },{
		distance = 1.0,
		options = {
			{
				label = "Abrir",
				event = "inventory:verifyObjects",
				service = "smallWeapons",
				tunnel = "police"
			}
		}
	})

	AddTargetModel({ -1673979170 },{
		distance = 1.0,
		options = {
			{
				label = "Abrir",
				event = "inventory:verifyObjects",
				service = "smallSupplies",
				tunnel = "police"
			}
		}
	})
	
	AddTargetModel({ -1065766299 },{
		distance = 2.5,
		options = {
			{
				label = "Cozinhar Filé de Peixe",
				event = "inventory:fishFillet",
				tunnel = "server"
			},{
				label = "Cozinhar Carne Animal",
				event = "inventory:animalMeat",
				tunnel = "server"
			},{
				label = "Assar Marshmallow",
				event = "inventory:marshmallow",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("cemiteryMan",vector3(-1745.57,-205.19,57.37),0.75,{
		name = "cemiteryMan",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "cemitery:initBody",
				label = "Conversar",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("casinoWheel",vector3(1112.05,228.11,-49.64),0.5,{
		name = "casinoWheel",
		heading = 3374176
	},{
		distance = 1.5,
		options = {
			{
				event = "luckywheel:Target",
				label = "Roda da Fortuna",
				tunnel = "client"
			}
		}
	})
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICEMENU
-----------------------------------------------------------------------------------------------------------------------------------------
local policeMenu = {
	{
		event = "police:runInspect",
		label = "Revistar",
		tunnel = "police"
	},{
		event = "police:prisonClothes",
		label = "Uniforme do Presídio",
		tunnel = "police"
	},{
		event = "police:ilegalItens",
		label = "Apreender Ilegais",
		tunnel = "police"
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARAMEDICMENU
-----------------------------------------------------------------------------------------------------------------------------------------
local paramedicMenu = {
	{
		event = "paramedic:reanimar",
		label = "Reanimar",
		tunnel = "paramedic"
	},
	{
		event = "paramedic:diagnostico",
		label = "Diagnóstico",
		tunnel = "paramedic"
	},
	{
		event = "paramedic:tratamento",
		label = "Tratamento",
		tunnel = "paramedic"
	},
	{
		event = "paramedic:sangramento",
		label = "Sangramento",
		tunnel = "paramedic"
	},
	{
		event = "paramedic:maca",
		label = "Deitar Paciente",
		tunnel = "paramedic"
	},
	{
		event = "paramedic:presetBurn",
		label = "Roupa de Queimadura",
		tunnel = "paramedic"
	},
	{
		event = "paramedic:presetPlaster",
		label = "Roupa de Gesso",
		tunnel = "paramedic"
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICEVEH
-----------------------------------------------------------------------------------------------------------------------------------------
local policeVeh = {
	{
		event = "police:runPlate",
		label = "Verificar Placa",
		tunnel = "police"
	},
	{
		event = "police:impound",
		label = "Registrar Veículo",
		tunnel = "police"
	},
	{
		event = "police:runArrest",
		label = "Apreender Veículo",
		tunnel = "police"
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERVEH
-----------------------------------------------------------------------------------------------------------------------------------------
local playerVeh = {
	{
		event = "inventory:stealTrunk",
		label = "Arrombar Porta-Malas",
		tunnel = "client"
	},{
		event = "player:enterTrunk",
		label = "Entrar no Porta-Malas",
		tunnel = "client"
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOCKADEVEH
-----------------------------------------------------------------------------------------------------------------------------------------
local stockadeVeh = {
	{
		event = "player:enterTrunk",
		label = "Entrar no Porta-Malas",
		tunnel = "client"
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCATEVEH
-----------------------------------------------------------------------------------------------------------------------------------------
local locateVeh = {
	["Desmanche"] = {
		{
			event = "inventory:Desmanchar",
			label = "Desmanchar",
			tunnel = "police"
		}
	},
	["Reboque"] = {
		{
			event = "towdriver:Tow",
			label = "Rebocar",
			tunnel = "client"
		},{
			event = "impound:Check",
			label = "Impound",
			tunnel = "client"
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERTARGETENABLE
-----------------------------------------------------------------------------------------------------------------------------------------
function playerTargetEnable()
	if playerActive then
	
		if exports["inventory"]:blockInvents() or exports["player"]:blockCommands() or exports["player"]:handCuff() or success or IsPedArmed(PlayerPedId(),6) or IsPedInAnyVehicle(PlayerPedId()) or not MumbleIsConnected() then
			return
		end

		targetActive = true

		SendNUIMessage({ response = "openTarget" })

		while targetActive do
			local ped = PlayerPedId()
			local coords = GetEntityCoords(ped)
			local hit,entCoords,entity = RayCastGamePlayCamera()

			if hit == 1 then
				innerEntity = {}

				if GetEntityType(entity) ~= 0 then
					if IsEntityAVehicle(entity) then
						if #(coords - entCoords) <= 1.0 then
							success = true

							innerEntity = { GetVehicleNumberPlateText(entity),vRP.vehicleModel(GetEntityModel(entity)),entity,VehToNet(entity) }

							if policeService then
								SendNUIMessage({ response = "validTarget", data = policeVeh })
							else
								local locateMenu = false
								for k,v in pairs(locateLocs) do
									local distance = #(coords - vector3(v[1],v[2],v[3]))
									if distance <= 10 then
										locateMenu = v[4]
									end
								end

								if locateMenu then
									SendNUIMessage({ response = "validTarget", data = locateVeh[locateMenu] })
								else
									SendNUIMessage({ response = "validTarget", data = playerVeh })
								end
							end

							while success and targetActive do
								local ped = PlayerPedId()
								local coords = GetEntityCoords(ped)
								local hit,entCoords,entity = RayCastGamePlayCamera()

								DisablePlayerFiring(ped,true)

								if (IsControlJustReleased(1,24) or IsDisabledControlJustReleased(1,24)) then
									SetCursorLocation(0.5,0.5)
									SetNuiFocus(true,true)
								end

								if GetEntityType(entity) == 0 or #(coords - entCoords) > 1.0 then
									success = false
								end

								Citizen.Wait(1)
							end

							SendNUIMessage({ response = "leftTarget" })
						end
					elseif IsPedAPlayer(entity) and policeService then
						if #(coords - entCoords) <= 1.0 then
							local index = NetworkGetPlayerIndexFromPed(entity)
							local source = GetPlayerServerId(index)

							success = true
							innerEntity = { source }
							SendNUIMessage({ response = "validTarget", data = policeMenu })

							while success and targetActive do
								local ped = PlayerPedId()
								local coords = GetEntityCoords(ped)
								local hit,entCoords,entity = RayCastGamePlayCamera()

								DisablePlayerFiring(ped,true)

								if (IsControlJustReleased(1,24) or IsDisabledControlJustReleased(1,24)) then
									SetCursorLocation(0.5,0.5)
									SetNuiFocus(true,true)
								end

								if GetEntityType(entity) == 0 or #(coords - entCoords) > 1.0 then
									success = false
								end

								Citizen.Wait(1)
							end

							SendNUIMessage({ response = "leftTarget" })
						end
					elseif IsPedAPlayer(entity) and paramedicService then
						if #(coords - entCoords) <= 1.0 then
							local index = NetworkGetPlayerIndexFromPed(entity)
							local source = GetPlayerServerId(index)

							success = true
							innerEntity = { source,entity }
							SendNUIMessage({ response = "validTarget", data = paramedicMenu })

							while success and targetActive do
								local ped = PlayerPedId()
								local coords = GetEntityCoords(ped)
								local hit,entCoords,entity = RayCastGamePlayCamera()

								DisablePlayerFiring(ped,true)

								if (IsControlJustReleased(1,24) or IsDisabledControlJustReleased(1,24)) then
									SetCursorLocation(0.5,0.5)
									SetNuiFocus(true,true)
								end

								if GetEntityType(entity) == 0 or #(coords - entCoords) > 1.0 then
									success = false
								end

								Citizen.Wait(1)
							end

							SendNUIMessage({ response = "leftTarget" })
						end
					else
						for k,v in pairs(Models) do
							if DoesEntityExist(entity) then
								if k == GetEntityModel(entity) then
									if #(coords - entCoords) <= Models[k]["distance"] then
										success = true

										if GetPedType(entity) == 28 then
											innerEntity = { entity,k,nil,GetEntityCoords(entity) }
										else
											local netObjects = nil
											if k ~= 1281992692 and k ~= 1158960338 and k ~= 1511539537 then
												NetworkRegisterEntityAsNetworked(entity)
												while not NetworkGetEntityIsNetworked(entity) do
													NetworkRegisterEntityAsNetworked(entity)
													Citizen.Wait(1)
												end

												while not NetworkHasControlOfEntity(entity) do
													NetworkRequestControlOfEntity(entity)
													Citizen.Wait(1)
												end

												netObjects = ObjToNet(entity)
												SetNetworkIdCanMigrate(netObjects,true)
												NetworkSetNetworkIdDynamic(netObjects,false)
												SetNetworkIdExistsOnAllMachines(netObjects,true)
											end

											innerEntity = { entity,k,netObjects,GetEntityCoords(entity) }
										end

										SendNUIMessage({ response = "validTarget", data = Models[k]["options"] })

										while success and targetActive do
											local ped = PlayerPedId()
											local coords = GetEntityCoords(ped)
											local hit,entCoords,entity = RayCastGamePlayCamera()

											DisablePlayerFiring(ped,true)

											if (IsControlJustReleased(1,24) or IsDisabledControlJustReleased(1,24)) then
												SetCursorLocation(0.5,0.5)
												SetNuiFocus(true,true)
											end

											if GetEntityType(entity) == 0 or #(coords - entCoords) > Models[k]["distance"] then
												success = false
											end

											Citizen.Wait(1)
										end

										SendNUIMessage({ response = "leftTarget" })
									end
								end
							end
						end
					end
				end

				for k,v in pairs(Zones) do
					if Zones[k]:isPointInside(entCoords) then
						if #(coords - Zones[k]["center"]) <= v["targetoptions"]["distance"] then
							success = true
							
							SendNUIMessage({ response = "validTarget", data = Zones[k]["targetoptions"]["options"] })

							if v["targetoptions"]["shop"] ~= nil then
								innerEntity = { v["targetoptions"]["shop"] }
							end

							if v["targetoptions"]["shopserver"] ~= nil then
								innerEntity = { v["targetoptions"]["shopserver"] }
							end

							while success and targetActive do
								local ped = PlayerPedId()
								local coords = GetEntityCoords(ped)
								local hit,entCoords,entity = RayCastGamePlayCamera()

								DisablePlayerFiring(ped,true)

								if (IsControlJustReleased(1,24) or IsDisabledControlJustReleased(1,24)) then
									SetCursorLocation(0.5,0.5)
									SetNuiFocus(true,true)
								end

								if not Zones[k]:isPointInside(entCoords) or #(coords - Zones[k]["center"]) > v["targetoptions"]["distance"] then
									success = false
								end

								Citizen.Wait(1)
							end

							SendNUIMessage({ response = "leftTarget" })
						end
					end
				end
			end

			Citizen.Wait(250)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:ANIMDEITAR
-----------------------------------------------------------------------------------------------------------------------------------------
local beds = {
	[1631638868] = { 0.0,0.0 },
	[2117668672] = { 0.0,0.0 },
	[-1498379115] = { 1.0,90.0 },
	[-1519439119] = { 1.0,0.0 },
	[-289946279] = { 1.0,0.0 }
}

RegisterNetEvent("target:animDeitar")
AddEventHandler("target:animDeitar",function()
	if not exports["player"]:blockCommands() and not exports["player"]:handCuff() then
		local ped = PlayerPedId()
		if GetEntityHealth(ped) > 101 then
			local objCoords = GetEntityCoords(innerEntity[1])

			SetEntityCoords(ped,objCoords["x"],objCoords["y"],objCoords["z"] + beds[innerEntity[2]][1],1,0,0,0)
			SetEntityHeading(ped,GetEntityHeading(innerEntity[1]) + beds[innerEntity[2]][2] - 180.0)

			vRP.playAnim(false,{"anim@gangops@morgue@table@","body_search"},true)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:PACIENTEDEITAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:pacienteDeitar")
AddEventHandler("target:pacienteDeitar",function()
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)

	for k,v in pairs(beds) do
		local object = GetClosestObjectOfType(coords["x"],coords["y"],coords["z"],0.9,k,0,0,0)
		if DoesEntityExist(object) then
			local objCoords = GetEntityCoords(object)

			SetEntityCoords(ped,objCoords["x"],objCoords["y"],objCoords["z"] + v[1],1,0,0,0)
			SetEntityHeading(ped,GetEntityHeading(object) + v[2] - 180.0)

			vRP.playAnim(false,{"anim@gangops@morgue@table@","body_search"},true)
			break
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:SENTAR
-----------------------------------------------------------------------------------------------------------------------------------------
local chairs = {
	[-171943901] = 0.0,
	[-109356459] = 0.5,
	[1805980844] = 0.5,
	[-99500382] = 0.3,
	[1262298127] = 0.0,
	[1737474779] = 0.5,
	[2040839490] = 0.0,
	[1037469683] = 0.4,
	[867556671] = 0.4,
	[-1521264200] = 0.0,
	[-741944541] = 0.4,
	[-591349326] = 0.5,
	[-293380809] = 0.5,
	[-628719744] = 0.5,
	[-1317098115] = 0.5,
	[1630899471] = 0.5,
	[38932324] = 0.5,
	[-523951410] = 0.5,
	[725259233] = 0.5,
	[764848282] = 0.5,
	[2064599526] = 0.5,
	[536071214] = 0.5,
	[589738836] = 0.5,
	[146905321] = 0.5,
	[47332588] = 0.5,
	[-1118419705] = 0.5,
	[538002882] = -0.1,
	[-377849416] = 0.5,
	[96868307] = 0.5,
	[-1195678770] = 0.7,
	[-853526657] = -0.1,
	[652816835] = 0.8
}

RegisterNetEvent("target:animSentar")
AddEventHandler("target:animSentar",function()
	if not exports["player"]:blockCommands() and not exports["player"]:handCuff() then
		local ped = PlayerPedId()
		if GetEntityHealth(ped) > 101 then
			local objCoords = GetEntityCoords(innerEntity[1])

			FreezeEntityPosition(innerEntity[1],true)
			SetEntityCoords(ped,objCoords["x"],objCoords["y"],objCoords["z"] + chairs[innerEntity[2]],1,0,0,0)
			if chairs[innerEntity[2]] == 0.7 then
				SetEntityHeading(ped,GetEntityHeading(innerEntity[1]))
			else
				SetEntityHeading(ped,GetEntityHeading(innerEntity[1]) - 180.0)
			end

			vRP.playAnim(false,{ task = "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER" },false)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERTARGETDISABLE
-----------------------------------------------------------------------------------------------------------------------------------------
function playerTargetDisable()
	if success or not targetActive then
		return
	end

	targetActive = false
	SendNUIMessage({ response = "closeTarget" })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SELECTTARGET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("selectTarget",function(data,cb)
	success = false
	targetActive = false
	SetNuiFocus(false,false)
	SendNUIMessage({ response = "closeTarget" })

	if data["tunnel"] == "client" then
		TriggerEvent(data["event"],innerEntity)
	elseif data["tunnel"] == "server" then
		TriggerServerEvent(data["event"],innerEntity)
	elseif data["tunnel"] == "shop" then
		TriggerEvent(data["event"],innerEntity[1])
	elseif data["tunnel"] == "shopserver" then
		TriggerServerEvent(data["event"],innerEntity[1])
	elseif data["tunnel"] == "boxes" then
		TriggerServerEvent(data["event"],innerEntity[1],data["service"])
	elseif data["tunnel"] == "paramedic" then
		TriggerServerEvent(data["event"],innerEntity[1])
	elseif data["tunnel"] == "police" then
		TriggerServerEvent(data["event"],innerEntity,data["service"])
	elseif data["tunnel"] == "products" then
		TriggerServerEvent(data["event"],data["service"])
	elseif data["tunnel"] == "objects" then
		TriggerServerEvent(data["event"],innerEntity[3])
	else
		TriggerServerEvent(data["event"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSETARGET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("closeTarget",function(data,cb)
	success = false
	targetActive = false
	SetNuiFocus(false,false)
	SendNUIMessage({ response = "closeTarget" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESETDEBUG
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:resetDebug")
AddEventHandler("target:resetDebug",function()
	success = false
	targetActive = false
	SetNuiFocus(false,false)
	SendNUIMessage({ response = "closeTarget" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCOORDSFROMCAM
-----------------------------------------------------------------------------------------------------------------------------------------
function GetCoordsFromCam(distance,coords)
	local rotation = GetGameplayCamRot()
	local adjustedRotation = vector3((math.pi / 180) * rotation["x"],(math.pi / 180) * rotation["y"],(math.pi / 180) * rotation["z"])
	local direction = vector3(-math.sin(adjustedRotation[3]) * math.abs(math.cos(adjustedRotation[1])),math.cos(adjustedRotation[3]) * math.abs(math.cos(adjustedRotation[1])),math.sin(adjustedRotation[1]))

	return vector3(coords[1] + direction[1] * distance, coords[2] + direction[2] * distance, coords[3] + direction[3] * distance)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RAYCASTGAMEPLAYCAMERA
-----------------------------------------------------------------------------------------------------------------------------------------
function RayCastGamePlayCamera()
	local ped = PlayerPedId()
	local cameraCoord = GetGameplayCamCoord()
	local camCoords = GetCoordsFromCam(10.0,cameraCoord)
	local handle = StartExpensiveSynchronousShapeTestLosProbe(cameraCoord,camCoords,-1,ped,4)
	local a,hit,coords,b,entity = GetShapeTestResult(handle)

	return hit,coords,entity
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDCIRCLEZONE
-----------------------------------------------------------------------------------------------------------------------------------------
function AddCircleZone(name,center,radius,options,targetoptions)
	Zones[name] = CircleZone:Create(center,radius,options)
	Zones[name]["targetoptions"] = targetoptions
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMCIRCLEZONE
-----------------------------------------------------------------------------------------------------------------------------------------
function RemCircleZone(name)
	if Zones[name] then
		Zones[name] = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDTARGETMODEL
-----------------------------------------------------------------------------------------------------------------------------------------
function AddTargetModel(Model,Options)
	for k,v in pairs(Model) do
		Models[v] = Options
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LABELTEXT
-----------------------------------------------------------------------------------------------------------------------------------------
function LabelText(Name,Text)
	if Zones[Name] then
		Zones[Name]["targetoptions"]["options"][1]["label"] = Text
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDBOXZONE
-----------------------------------------------------------------------------------------------------------------------------------------
function AddBoxZone(name,center,length,width,options,targetoptions)
    Zones[name] = BoxZone:Create(center,length,width,options)
    Zones[name]["targetoptions"] = targetoptions
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXPORTS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("LabelText",LabelText)
exports("AddBoxZone",AddBoxZone)
exports("RemCircleZone",RemCircleZone)
exports("AddCircleZone",AddCircleZone)
exports("AddTargetModel",AddTargetModel)