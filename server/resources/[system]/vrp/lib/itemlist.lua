-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local itemlist = {
	["bronzeegg"] = {
		["index"] = "bronzeegg",
		["name"] = "Ovo de Bronze",
		["type"] = "Comum",
		["weight"] = 0.0,
		["economy"] = 0
	},
	["silveregg"] = {
		["index"] = "silveregg",
		["name"] = "Ovo de Prata",
		["type"] = "Comum",
		["weight"] = 0.0,
		["economy"] = 0
	},
	["goldegg"] = {
		["index"] = "goldegg",
		["name"] = "Ovo de Ouro",
		["type"] = "Comum",
		["weight"] = 0.0,
		["economy"] = 0
	},
	["gangbox"] = {
		["index"] = "gangbox",
		["name"] = "Encomenda",
		["type"] = "Comum",
		["weight"] = 30.00,
		["economy"] = 0
	},
	["paper"] = {
		["index"] = "paper",
		["name"] = "Papel",
		["type"] = "Comum",
		["weight"] = 0.01,
		["economy"] = 120
	},
	["printer"] = {
		["index"] = "printer",
		["name"] = "Impressora",
		["desc"] = "Utilizada para impressão de Credencial.",
		["type"] = "Usável",
		["durability"] = 3,
		["weight"] = 7.50,
		["economy"] = 525
	},
	["rentalveh"] = {
		["index"] = "rentalveh",
		["name"] = "Aluguel de Veículo",
		["desc"] = "Leve até a concessionária para usa-lo.",
		["type"] = "Usável",
		["weight"] = 0.0,
		["economy"] = 0
	},
	["mushroomteaplus"] = {
		["index"] = "mushroomtea",
		["name"] = "Chá de Cogumelo",
		["desc"] = "Aumenta a mochila em 10Kg.",
		["type"] = "Usável",
		["weight"] = 0.75,
		["economy"] = 325
	},
	["instaverify"] = {
		["index"] = "instaverify",
		["name"] = "Verificado",
		["desc"] = "Ativa o verificado no instagram.",
		["type"] = "Usável",
		["weight"] = 0.0,
		["economy"] = 25000
	},
	["medicpass"] = {
		["index"] = "medicbag",
		["name"] = "Vale - Médico",
		["desc"] = "Leve até um médico para troca-lo.",
		["type"] = "Usável",
		["weight"] = 0.0,
		["economy"] = 0
	},
	["luckywheelpass"] = {
		["index"] = "luckywheelpass",
		["name"] = "Vale - Roda da Fortuna",
		["desc"] = "Leve até o cassino para usa-lo.",
		["type"] = "Comum",
		["weight"] = 0.0,
		["economy"] = 5000
	},
	["mechanicpass"] = {
		["index"] = "mechanicpass",
		["name"] = "Vale - Mecânico",
		["desc"] = "Leve até um mecânico para troca-lo.",
		["type"] = "Usável",
		["weight"] = 0.0,
		["economy"] = 0
	},
	["dessertspass"] = {
		["index"] = "foodpass",
		["name"] = "Vale - Uwu Café",
		["desc"] = "Leve até o restaurante para troca-lo.",
		["type"] = "Usável",
		["weight"] = 0.0,
		["economy"] = 0
	},
	["popsdinerpass"] = {
		["index"] = "foodpass",
		["name"] = "Vale - Pop's Diner",
		["desc"] = "Leve até o restaurante para troca-lo.",
		["type"] = "Usável",
		["weight"] = 0.0,
		["economy"] = 0
	},
	["pizzathispass"] = {
		["index"] = "foodpass",
		["name"] = "Vale - Pizza This",
		["desc"] = "Leve até o restaurante para troca-lo.",
		["type"] = "Usável",
		["weight"] = 0.0,
		["economy"] = 0
	},
	["burgershotpass"] = {
		["index"] = "foodpass",
		["name"] = "Vale - BurgerShot",
		["desc"] = "Leve até o restaurante para troca-lo.",
		["type"] = "Usável",
		["weight"] = 0.0,
		["economy"] = 0
	},
	["c4"] = {
		["index"] = "c4",
		["name"] = "C4",
		["type"] = "Usável",
		["ilegal"] = true,
		["weight"] = 1.0,
		["max"] = 1,
		["economy"] = 625
	},
	["geode"] = {
		["index"] = "geode",
		["name"] = "Geodo",
		["type"] = "Usável",
		["weight"] = 0.75,
		["economy"] = 10
	},
	["pickaxe"] = {
		["index"] = "pickaxe",
		["name"] = "Picareta",
		["type"] = "Comum",
		["durability"] = 7,
		["weight"] = 0.75,
		["economy"] = 525
	},
	["suitcase"] = {
		["index"] = "suitcase",
		["name"] = "Maleta",
		["type"] = "Usável",
		["ilegal"] = true,
		["weight"] = 1.0,
		["economy"] = 275
	},
	["badge01"] = {
		["index"] = "badge01",
		["name"] = "Distintivo",
		["desc"] = "<green>San Andreas Police Department</green>",
		["type"] = "Usável",
		["ilegal"] = true,
		["weight"] = 0.0,
		["economy"] = 10
	},
	["badge02"] = {
		["index"] = "badge02",
		["name"] = "Distintivo",
		["desc"] = "<green>Emergency Medical Services</green>",
		["type"] = "Usável",
		["ilegal"] = true,
		["weight"] = 0.0,
		["economy"] = 10
	},
	["mushroomtea"] = {
		["index"] = "mushroomtea",
		["name"] = "Chá de Cogumelo",
		["desc"] = "Tempo pedalando reduzido para <green>10 minutos</green> por <green>60 minutos</green>, lembrando que o efeito passa desconectando da cidade.",
		["type"] = "Usável",
		["weight"] = 0.75,
		["economy"] = 325
	},
	["nigirizushi"] = {
		["index"] = "nigirizushi",
		["name"] = "Nigirizushi",
		["type"] = "Usável",
		["weight"] = 0.45,
		["scape"] = true,
		["max"] = 3,
		["economy"] = 75
	},
	["sushi"] = {
		["index"] = "sushi",
		["name"] = "Sushi",
		["type"] = "Usável",
		["weight"] = 0.45,
		["scape"] = true,
		["max"] = 3,
		["economy"] = 75
	},
	["cupcake"] = {
		["index"] = "cupcake",
		["name"] = "Cupcake",
		["type"] = "Usável",
		["weight"] = 0.45,
		["scape"] = true,
		["max"] = 3,
		["economy"] = 75
	},
	["milkshake"] = {
		["index"] = "milkshake",
		["name"] = "Milk Shake",
		["type"] = "Usável",
		["weight"] = 0.55,
		["scape"] = true,
		["max"] = 3,
		["economy"] = 125
	},
	["cappuccino"] = {
		["index"] = "cappuccino",
		["name"] = "Cappuccino",
		["type"] = "Usável",
		["weight"] = 0.55,
		["scape"] = true,
		["max"] = 3,
		["economy"] = 155
	},
	["applelove"] = {
		["index"] = "applelove",
		["name"] = "Maça do Amor",
		["type"] = "Usável",
		["weight"] = 0.55,
		["scape"] = true,
		["max"] = 2,
		["economy"] = 75
	},
	["raceticket"] = {
		["index"] = "raceticket",
		["name"] = "Credencial",
		["type"] = "Comum",
		["ilegal"] = true,
		["weight"] = 0.75,
		["economy"] = 125
	},
	["racetrophy"] = {
		["index"] = "racetrophy",
		["name"] = "Troféu",
		["type"] = "Comum",
		["ilegal"] = true,
		["weight"] = 5.25,
		["economy"] = 2250
	},
	["bucket"] = {
		["index"] = "bucket",
		["name"] = "Balde",
		["type"] = "Comum",
		["weight"] = 0.50,
		["economy"] = 175
	},
	["scanner"] = {
		["index"] = "scanner",
		["name"] = "Scanner",
		["type"] = "Usável",
		["durability"] = 7,
		["weight"] = 5.00,
		["economy"] = 6750
	},
	["nitro"] = {
		["index"] = "nitro",
		["name"] = "Nitro",
		["type"] = "Usável",
		["weight"] = 7.25,
		["economy"] = 375
	},
	["postit"] = {
		["index"] = "postit",
		["name"] = "Post-It",
		["type"] = "Usável",
		["weight"] = 0.05,
		["economy"] = 20
	},
	["attachsFlashlight"] = {
		["index"] = "attachsFlashlight",
		["name"] = "Lanterna Tatica",
		["type"] = "Usável",
		["ilegal"] = true,
		["weight"] = 0.75,
		["economy"] = 1750
	},
	["attachsCrosshair"] = {
		["index"] = "attachsCrosshair",
		["name"] = "Mira Holográfica",
		["type"] = "Usável",
		["ilegal"] = true,
		["weight"] = 0.75,
		["economy"] = 1750
	},
	["attachsSilencer"] = {
		["index"] = "attachsSilencer",
		["name"] = "Silenciador",
		["type"] = "Usável",
		["ilegal"] = true,
		["weight"] = 0.75,
		["economy"] = 1750
	},
	["attachsGrip"] = {
		["index"] = "attachsGrip",
		["name"] = "Empunhadura",
		["type"] = "Usável",
		["ilegal"] = true,
		["weight"] = 0.75,
		["economy"] = 1750
	},
	["cheese"] = {
		["index"] = "cheese",
		["name"] = "Queijo",
		["type"] = "Comum",
		["weight"] = 0.75,
		["economy"] = 10
	},
	["silk"] = {
		["index"] = "silk",
		["name"] = "Seda",
		["type"] = "Comum",
		["weight"] = 0.18,
		["economy"] = 5
	},
	["tablecoke"] = {
		["index"] = "tablecoke",
		["name"] = "Mesa de Criação",
		["desc"] = "Utilizada para criação de Cocaína.",
		["type"] = "Usável",
		["durability"] = 7,
		["weight"] = 15.00,
		["ilegal"] = true,
		["economy"] = 1750
	},
	["tablemeth"] = {
		["index"] = "tablemeth",
		["name"] = "Mesa de Criação",
		["desc"] = "Utilizada para criação de Metanfetamina.",
		["type"] = "Usável",
		["durability"] = 7,
		["weight"] = 15.00,
		["ilegal"] = true,
		["economy"] = 1750
	},
	["tableweed"] = {
		["index"] = "tableweed",
		["name"] = "Mesa de Criação",
		["desc"] = "Utilizada para criação de Baseados.",
		["type"] = "Usável",
		["durability"] = 7,
		["weight"] = 15.00,
		["ilegal"] = true,
		["economy"] = 1750
	},
	["campfire"] = {
		["index"] = "campfire",
		["name"] = "Fogueira",
		["type"] = "Usável",
		["weight"] = 10.00,
		["economy"] = 675
	},
	["barrier"] = {
		["index"] = "barrier",
		["name"] = "Barreira",
		["type"] = "Usável",
		["weight"] = 4.25,
		["ilegal"] = true,
		["economy"] = 250
	},
	["mechanicbox"] = {
		["index"] = "mechanicbox",
		["name"] = "Caixa de Ferramentas",
		["type"] = "Usável",
		["durability"] = 7,
		["weight"] = 6.25,
		["economy"] = 525
	},
	["medicbag"] = {
		["index"] = "medicbag",
		["name"] = "Bolsa Médica",
		["type"] = "Usável",
		["durability"] = 7,
		["weight"] = 2.25,
		["economy"] = 425
	},
	["medicbed"] = {
		["index"] = "medicbed",
		["name"] = "Maca Médica",
		["type"] = "Usável",
		["durability"] = 7,
		["weight"] = 7.25,
		["economy"] = 725
	},
	["chair01"] = {
		["index"] = "chair01",
		["name"] = "Cadeira",
		["type"] = "Usável",
		["durability"] = 7,
		["weight"] = 7.25,
		["economy"] = 750
	},
	["techtrash"] = {
		["index"] = "techtrash",
		["name"] = "Lixo Eletrônico",
		["type"] = "Comum",
		["weight"] = 0.65,
		["economy"] = 125
	},
	["tarp"] = {
		["index"] = "tarp",
		["name"] = "Lona",
		["type"] = "Comum",
		["weight"] = 0.45,
		["economy"] = 50
	},
	["sheetmetal"] = {
		["index"] = "sheetmetal",
		["name"] = "Chapa de Metal",
		["type"] = "Comum",
		["weight"] = 0.75,
		["economy"] = 50
	},
	["roadsigns"] = {
		["index"] = "roadsigns",
		["name"] = "Placas de Trânsito",
		["type"] = "Comum",
		["weight"] = 0.10,
		["economy"] = 50
	},
	["leather"] = {
		["index"] = "leather",
		["name"] = "Couro",
		["type"] = "Comum",
		["weight"] = 0.05,
		["economy"] = 20
	},
	["explosives"] = {
		["index"] = "explosives",
		["name"] = "Explosivos",
		["type"] = "Comum",
		["weight"] = 0.15,
		["ilegal"] = true,
		["economy"] = 75
	},
	["animalfat"] = {
		["index"] = "animalfat",
		["name"] = "Gordura Animal",
		["type"] = "Comum",
		["weight"] = 0.02,
		["economy"] = 10
	},
	["fidentity"] = {
		["index"] = "identity",
		["name"] = "Passaporte",
		["type"] = "Usável",
		["weight"] = 0.10,
		["economy"] = 10000
	},
	["identity"] = {
		["index"] = "identity",
		["name"] = "Passaporte",
		["type"] = "Usável",
		["weight"] = 0.10,
		["economy"] = 5000
	},
	["blocksignal"] = {
		["index"] = "blocksignal",
		["name"] = "Bloqueador de Sinal",
		["type"] = "Usável",
		["weight"] = 0.55,
		["ilegal"] = true,
		["economy"] = 325
	},
	["pistolbody"] = {
		["index"] = "pistolbody",
		["name"] = "Corpo de Pistola",
		["type"] = "Comum",
		["weight"] = 0.25,
		["ilegal"] = true,
		["economy"] = 425
	},
	["smgbody"] = {
		["index"] = "smgbody",
		["name"] = "Corpo de Sub-Metralhadora",
		["type"] = "Comum",
		["weight"] = 0.25,
		["ilegal"] = true,
		["economy"] = 525
	},
	["riflebody"] = {
		["index"] = "riflebody",
		["name"] = "Corpo de Rifle",
		["type"] = "Comum",
		["weight"] = 0.25,
		["ilegal"] = true,
		["economy"] = 625
	},
	["cotton"] = {
		["index"] = "cotton",
		["name"] = "Algodão",
		["type"] = "Comum",
		["weight"] = 0.25,
		["economy"] = 45
	},
	["plaster"] = {
		["index"] = "plaster",
		["name"] = "Esparadrapo",
		["type"] = "Comum",
		["weight"] = 0.35,
		["economy"] = 35
	},
	["sulfuric"] = {
		["index"] = "sulfuric",
		["name"] = "Ácido Sulfúrico",
		["type"] = "Usável",
		["weight"] = 0.45,
		["economy"] = 30
	},
	["saline"] = {
		["index"] = "saline",
		["name"] = "Soro Fisiológico",
		["type"] = "Comum",
		["weight"] = 0.45,
		["economy"] = 25
	},
	["defibrillator"] = {
		["index"] = "defibrillator",
		["name"] = "Desfibrilador",
		["type"] = "Usável",
		["durability"] = 3,
		["weight"] = 3.25,
		["ilegal"] = true,
		["economy"] = 325
	},
	["alcohol"] = {
		["index"] = "alcohol",
		["name"] = "Álcool",
		["type"] = "Comum",
		["weight"] = 0.75,
		["economy"] = 40
	},
	["notebook"] = {
		["index"] = "notebook",
		["name"] = "Notebook",
		["type"] = "Usável",
		["durability"] = 3,
		["weight"] = 7.25,
		["economy"] = 3750
	},
	["syringe"] = {
		["index"] = "adrenaline",
		["name"] = "Seringa",
		["type"] = "Comum",
		["weight"] = 0.10,
		["economy"] = 2
	},
	["syringe01"] = {
		["index"] = "syringe",
		["name"] = "Seringa A+",
		["type"] = "Comum",
		["weight"] = 0.10,
		["economy"] = 10
	},
	["syringe02"] = {
		["index"] = "syringe",
		["name"] = "Seringa B+",
		["type"] = "Comum",
		["weight"] = 0.10,
		["economy"] = 10
	},
	["syringe03"] = {
		["index"] = "syringe",
		["name"] = "Seringa A-",
		["type"] = "Comum",
		["weight"] = 0.10,
		["economy"] = 10
	},
	["syringe04"] = {
		["index"] = "syringe",
		["name"] = "Seringa B-",
		["type"] = "Comum",
		["weight"] = 0.10,
		["economy"] = 10
	},
	["streetbox"] = {
		["index"] = "streetbox",
		["name"] = "Caixa",
		["type"] = "Comum",
		["weight"] = 1.00,
		["max"] = 2,
		["economy"] = 120
	},
	["bsburger"] = {
		["index"] = "bsburger",
		["name"] = "Caixa de Hamburger",
		["type"] = "Comum",
		["weight"] = 0.15,
		["max"] = 1,
		["economy"] = 10
	},
	["bsjuice"] = {
		["index"] = "bsjuice",
		["name"] = "Copo de Suco",
		["type"] = "Comum",
		["weight"] = 0.15,
		["max"] = 1,
		["economy"] = 10
	},
	["bsbox"] = {
		["index"] = "bsbox",
		["name"] = "Combo",
		["type"] = "Comum",
		["weight"] = 1.00,
		["max"] = 2,
		["economy"] = 120
	},
	["bsbox2"] = {
		["index"] = "bsbox",
		["name"] = "Combo + Brinquedo",
		["type"] = "Comum",
		["weight"] = 1.00,
		["max"] = 2,
		["economy"] = 270
	},
	["wheelchair"] = {
		["index"] = "wheelchair",
		["name"] = "Cadeira de Rodas",
		["type"] = "Usável",
		["weight"] = 7.50,
		["economy"] = 2750
	},
	["vehkey"] = {
		["index"] = "vehkey",
		["name"] = "Chave Cópia",
		["type"] = "Usável",
		["weight"] = 0.75,
		["economy"] = 0
	},
	["evidence01"] = {
		["index"] = "evidence01",
		["name"] = "Evidência",
		["type"] = "Usável",
		["weight"] = 0.05,
		["ilegal"] = true,
		["economy"] = 0
	},
	["evidence02"] = {
		["index"] = "evidence02",
		["name"] = "Evidência",
		["type"] = "Usável",
		["weight"] = 0.05,
		["ilegal"] = true,
		["economy"] = 0
	},
	["evidence03"] = {
		["index"] = "evidence03",
		["name"] = "Evidência",
		["type"] = "Usável",
		["weight"] = 0.05,
		["ilegal"] = true,
		["economy"] = 0
	},
	["evidence04"] = {
		["index"] = "evidence04",
		["name"] = "Evidência",
		["type"] = "Usável",
		["weight"] = 0.05,
		["ilegal"] = true,
		["economy"] = 0
	},
	["rottweiler"] = {
		["index"] = "rottweiler",
		["name"] = "Coleira de Rottweiler",
		["type"] = "Animal",
		["weight"] = 1.25,
		["economy"] = 25000
	},
	["husky"] = {
		["index"] = "husky",
		["name"] = "Coleira de Husky",
		["type"] = "Animal",
		["weight"] = 1.25,
		["economy"] = 25000
	},
	["shepherd"] = {
		["index"] = "shepherd",
		["name"] = "Coleira de Shepherd",
		["type"] = "Animal",
		["weight"] = 1.25,
		["economy"] = 25000
	},
	["retriever"] = {
		["index"] = "retriever",
		["name"] = "Coleira de Retriever",
		["type"] = "Animal",
		["weight"] = 1.25,
		["economy"] = 25000
	},
	["poodle"] = {
		["index"] = "poodle",
		["name"] = "Coleira de Poodle",
		["type"] = "Animal",
		["weight"] = 1.25,
		["economy"] = 25000
	},
	["pug"] = {
		["index"] = "pug",
		["name"] = "Coleira de Pug",
		["type"] = "Animal",
		["weight"] = 1.25,
		["economy"] = 25000
	},
	["westy"] = {
		["index"] = "westy",
		["name"] = "Coleira de Westy",
		["type"] = "Animal",
		["weight"] = 1.25,
		["economy"] = 25000
	},
	["cat"] = {
		["index"] = "cat",
		["name"] = "Coleira de Gato",
		["type"] = "Animal",
		["weight"] = 1.25,
		["economy"] = 25000
	},
	["card01"] = {
		["index"] = "card01",
		["name"] = "Cartão Comum",
		["desc"] = "Roubar Lojas de Departamento.",
		["type"] = "Comum",
		["durability"] = 7,
		["weight"] = 0.10,
		["ilegal"] = true,
		["economy"] = 325
	},
	["card02"] = {
		["index"] = "card02",
		["name"] = "Cartão In-Comum",
		["desc"] = "Roubar Lojas de Armas.",
		["type"] = "Comum",
		["durability"] = 7,
		["weight"] = 0.10,
		["ilegal"] = true,
		["economy"] = 325
	},
	["card03"] = {
		["index"] = "card03",
		["name"] = "Cartão Normal",
		["desc"] = "Roubar Bancos Fleeca.",
		["type"] = "Comum",
		["durability"] = 7,
		["weight"] = 0.10,
		["ilegal"] = true,
		["economy"] = 375
	},
	["card04"] = {
		["index"] = "card04",
		["name"] = "Cartão Raro",
		["desc"] = "Roubar Barbearias.",
		["type"] = "Comum",
		["durability"] = 7,
		["weight"] = 0.10,
		["ilegal"] = true,
		["economy"] = 275
	},
	["card05"] = {
		["index"] = "card05",
		["name"] = "Cartão Lendário",
		["desc"] = "Roubar Bancos.",
		["type"] = "Comum",
		["durability"] = 7,
		["weight"] = 0.10,
		["ilegal"] = true,
		["economy"] = 425
	},
	["gemstone"] = {
		["index"] = "gemstone",
		["name"] = "Gemstone",
		["type"] = "Usável",
		["weight"] = 0.10,
		["economy"] = 1250
	},
	["radio"] = {
		["index"] = "radio",
		["name"] = "Rádio",
		["type"] = "Usável",
		["durability"] = 7,
		["weight"] = 0.75,
		["economy"] = 975
	},
	["vest"] = {
		["index"] = "vest",
		["name"] = "Colete",
		["type"] = "Usável",
		["durability"] = 3,
		["weight"] = 2.25,
		["ilegal"] = true,
		["max"] = 1,
		["economy"] = 750
	},
	["bandage"] = {
		["index"] = "bandage",
		["name"] = "Bandagem",
		["type"] = "Usável",
		["weight"] = 0.10,
		["max"] = 3,
		["economy"] = 175
	},
	["medkit"] = {
		["index"] = "medkit",
		["name"] = "Kit Médico",
		["type"] = "Usável",
		["weight"] = 0.45,
		["max"] = 1,
		["economy"] = 575
	},
	["adrenaline"] = {
		["index"] = "adrenaline",
		["name"] = "Adrenalina",
		["type"] = "Usável",
		["weight"] = 0.35,
		["economy"] = 975
	},
	["pouch"] = {
		["index"] = "pouch",
		["name"] = "Malote",
		["type"] = "Comum",
		["weight"] = 1.75,
		["economy"] = 80
	},
	["woodlog"] = {
		["index"] = "woodlog",
		["name"] = "Tora de Madeira",
		["type"] = "Comum",
		["weight"] = 0.75,
		["economy"] = 40
	},
	["fishingrod"] = {
		["index"] = "fishingrod",
		["name"] = "Vara de Pescar",
		["type"] = "Usável",
		["durability"] = 7,
		["weight"] = 2.75,
		["economy"] = 725
	},
	["switchblade"] = {
		["index"] = "switchblade",
		["name"] = "Canivete",
		["type"] = "Usável",
		["desc"] = "Utilizada para remoção de carne.",
		["durability"] = 7,
		["weight"] = 0.75,
		["economy"] = 525
	},
	["octopus"] = {
		["index"] = "octopus",
		["name"] = "Polvo",
		["type"] = "Comum",
		["weight"] = 0.75,
		["economy"] = 14
	},
	["shrimp"] = {
		["index"] = "shrimp",
		["name"] = "Camarão",
		["type"] = "Comum",
		["weight"] = 0.50,
		["economy"] = 14
	},
	["carp"] = {
		["index"] = "carp",
		["name"] = "Carpa",
		["type"] = "Usável",
		["weight"] = 0.50,
		["economy"] = 12
	},
	["codfish"] = {
		["index"] = "codfish",
		["name"] = "Bacalhau",
		["type"] = "Usável",
		["weight"] = 0.50,
		["economy"] = 16
	},
	["catfish"] = {
		["index"] = "catfish",
		["name"] = "Bagre",
		["type"] = "Usável",
		["weight"] = 0.50,
		["economy"] = 16
	},
	["goldenfish"] = {
		["index"] = "goldenfish",
		["name"] = "Dourado",
		["type"] = "Usável",
		["weight"] = 0.25,
		["economy"] = 18
	},
	["horsefish"] = {
		["index"] = "horsefish",
		["name"] = "Cavala",
		["type"] = "Usável",
		["weight"] = 0.50,
		["economy"] = 12
	},
	["tilapia"] = {
		["index"] = "tilapia",
		["name"] = "Tilápia",
		["type"] = "Usável",
		["weight"] = 0.25,
		["economy"] = 14
	},
	["pacu"] = {
		["index"] = "pacu",
		["name"] = "Pacu",
		["type"] = "Usável",
		["weight"] = 0.50,
		["economy"] = 18
	},
	["pirarucu"] = {
		["index"] = "pirarucu",
		["name"] = "Pirarucu",
		["type"] = "Usável",
		["weight"] = 0.25,
		["economy"] = 18
	},
	["tambaqui"] = {
		["index"] = "tambaqui",
		["name"] = "Tambaqui",
		["type"] = "Usável",
		["weight"] = 0.75,
		["economy"] = 18
	},
	["bait"] = {
		["index"] = "bait",
		["name"] = "Isca",
		["type"] = "Comum",
		["weight"] = 0.25,
		["economy"] = 4
	},
	["animalpelt"] = {
		["index"] = "animalpelt",
		["name"] = "Pele Animal",
		["type"] = "Comum",
		["weight"] = 0.10,
		["economy"] = 25
	},
	["joint"] = {
		["index"] = "joint",
		["name"] = "Baseado",
		["type"] = "Usável",
		["weight"] = 0.50,
		["ilegal"] = true,
		["economy"] = 35
	},
	["weedleaf"] = {
		["index"] = "weedleaf",
		["name"] = "Folha de Maconha",
		["type"] = "Comum",
		["weight"] = 0.50,
		["ilegal"] = true,
		["economy"] = 5
	},
	["codeine"] = {
		["index"] = "codeine",
		["name"] = "Codeína",
		["type"] = "Comum",
		["weight"] = 0.10,
		["economy"] = 35
	},
	["amphetamine"] = {
		["index"] = "amphetamine",
		["name"] = "Anfetamina",
		["type"] = "Comum",
		["weight"] = 0.10,
		["ilegal"] = true,
		["economy"] = 45
	},
	["cocaine"] = {
		["index"] = "cocaine",
		["name"] = "Cocaína",
		["type"] = "Usável",
		["weight"] = 0.50,
		["ilegal"] = true,
		["economy"] = 35
	},
	["cokeleaf"] = {
		["index"] = "cokeleaf",
		["name"] = "Folha de Coca",
		["type"] = "Comum",
		["weight"] = 0.10,
		["ilegal"] = true,
		["economy"] = 5
	},
	["meth"] = {
		["index"] = "meth",
		["name"] = "Metanfetamina",
		["type"] = "Usável",
		["weight"] = 0.50,
		["ilegal"] = true,
		["economy"] = 35
	},
	["acetone"] = {
		["index"] = "acetone",
		["name"] = "Acetona",
		["type"] = "Comum",
		["weight"] = 0.10,
		["economy"] = 40
	},
	["drugtoy"] = {
		["index"] = "drugtoy",
		["name"] = "Brinquedo",
		["type"] = "Comum",
		["weight"] = 0.50,
		["ilegal"] = true,
		["economy"] = 125
	},
	["rolepass"] = {
		["index"] = "rolepass",
		["name"] = "Rolepass",
		["type"] = "Usável",
		["weight"] = 0.00,
		["economy"] = 125000
	},
	["premium"] = {
		["index"] = "premium",
		["name"] = "Premium",
		["type"] = "Usável",
		["weight"] = 0.00,
		["economy"] = 93750
	},
	["newlocate"] = {
		["index"] = "newlocate",
		["name"] = "Nacionalidade",
		["type"] = "Usável",
		["desc"] = "Inverte nacionalidade de Sul/Norte.",
		["weight"] = 0.00,
		["economy"] = 125000
	},
	["premiumplate"] = {
		["index"] = "platepremium",
		["name"] = "Placa Premium",
		["type"] = "Usável",
		["desc"] = "Personaliza a placa do veículo.",
		["weight"] = 0.00,
		["economy"] = 62500
	},
	["newchars"] = {
		["index"] = "newchars",
		["name"] = "+1 Personagem",
		["type"] = "Usável",
		["desc"] = "Limite de personagem em +1.",
		["weight"] = 0.00,
		["economy"] = 93750
	},
	["chip"] = {
		["index"] = "chip",
		["name"] = "Chip Telefônico",
		["type"] = "Usável",
		["desc"] = "Troca o número telefônico.",
		["weight"] = 0.00,
		["economy"] = 75000
	},
	["namechange"] = {
		["index"] = "namechange",
		["name"] = "Troca de Nome",
		["type"] = "Usável",
		["desc"] = "Troca o nome do personagem.",
		["weight"] = 0.00,
		["economy"] = 62500
	},
	["contract1"] = {
		["index"] = "contract",
		["name"] = "Contrato de Propriedade",
		["type"] = "Usável",
		["desc"] = "Assinatura de contrato do interior 1.",
		["weight"] = 0.00,
		["economy"] = 125000
	},
	["contract2"] = {
		["index"] = "contract",
		["name"] = "Contrato de Propriedade",
		["type"] = "Usável",
		["desc"] = "Assinatura de contrato do interior 2.",
		["weight"] = 0.00,
		["economy"] = 300000
	},
	["contract3"] = {
		["index"] = "contract",
		["name"] = "Contrato de Propriedade",
		["type"] = "Usável",
		["desc"] = "Assinatura de contrato do interior 3.",
		["weight"] = 0.00,
		["economy"] = 75000
	},
	["contract4"] = {
		["index"] = "contract",
		["name"] = "Contrato de Propriedade",
		["type"] = "Usável",
		["desc"] = "Assinatura de contrato do interior 4.",
		["weight"] = 0.00,
		["economy"] = 175000
	},
	["contract5"] = {
		["index"] = "contract",
		["name"] = "Contrato de Propriedade",
		["type"] = "Usável",
		["desc"] = "Assinatura de contrato do interior 5.",
		["weight"] = 0.00,
		["economy"] = 125000
	},
	["contract6"] = {
		["index"] = "contract",
		["name"] = "Contrato de Propriedade",
		["type"] = "Usável",
		["desc"] = "Assinatura de contrato do interior 6.",
		["weight"] = 0.00,
		["economy"] = 250000
	},
	["contract7"] = {
		["index"] = "contract",
		["name"] = "Contrato de Propriedade",
		["type"] = "Usável",
		["desc"] = "Assinatura de contrato do interior 7.",
		["weight"] = 0.00,
		["economy"] = 75000
	},
	["contract8"] = {
		["index"] = "contract",
		["name"] = "Contrato de Propriedade",
		["type"] = "Usável",
		["desc"] = "Assinatura de contrato do interior 8.",
		["weight"] = 0.00,
		["economy"] = 250000
	},
	["contract9"] = {
		["index"] = "contract",
		["name"] = "Contrato de Propriedade",
		["type"] = "Usável",
		["desc"] = "Assinatura de contrato do interior 9.",
		["weight"] = 0.00,
		["economy"] = 175000
	},
	["contract10"] = {
		["index"] = "contract",
		["name"] = "Contrato de Propriedade",
		["type"] = "Usável",
		["desc"] = "Assinatura de contrato do container.",
		["weight"] = 0.00,
		["economy"] = 100000
	},
	["energetic"] = {
		["index"] = "energetic",
		["name"] = "Energético",
		["type"] = "Usável",
		["weight"] = 0.25,
		["max"] = 5,
		["economy"] = 15
	},
	["milkbottle"] = {
		["index"] = "milkbottle",
		["name"] = "Garrafa de Leite",
		["type"] = "Usável",
		["weight"] = 0.15,
		["scape"] = true,
		["max"] = 5,
		["economy"] = 35
	},
	["guarananatural"] = {
		["index"] = "guarananatural",
		["name"] = "Guaraná Natural",
		["type"] = "Usável",
		["weight"] = 0.15,
		["scape"] = true,
		["max"] = 3,
		["economy"] = 100
	},
	["water"] = {
		["index"] = "water",
		["name"] = "Água",
		["type"] = "Usável",
		["weight"] = 0.15,
		["scape"] = true,
		["max"] = 3,
		["economy"] = 30
	},
	["emptybottle"] = {
		["index"] = "emptybottle",
		["name"] = "Garrafa Vazia",
		["type"] = "Comum",
		["weight"] = 0.10,
		["scape"] = true,
		["max"] = 5,
		["economy"] = 30
	},
	["coffee"] = {
		["index"] = "coffee",
		["name"] = "Copo de Café",
		["type"] = "Usável",
		["weight"] = 0.15,
		["max"] = 3,
		["economy"] = 20
	},
	["coffeemilk"] = {
		["index"] = "coffeemilk",
		["name"] = "Café com Leite",
		["type"] = "Usável",
		["weight"] = 0.15,
		["max"] = 3,
		["economy"] = 95
	},
	["cola"] = {
		["index"] = "cola",
		["name"] = "Cola",
		["type"] = "Usável",
		["weight"] = 0.15,
		["max"] = 3,
		["economy"] = 15
	},
	["tacos"] = {
		["index"] = "tacos",
		["name"] = "Tacos",
		["type"] = "Usável",
		["weight"] = 0.25,
		["max"] = 3,
		["economy"] = 22
	},
	["fries"] = {
		["index"] = "fries",
		["name"] = "Fritas",
		["type"] = "Usável",
		["weight"] = 0.15,
		["max"] = 3,
		["economy"] = 125
	},
	["soda"] = {
		["index"] = "soda",
		["name"] = "Sprunk",
		["type"] = "Usável",
		["weight"] = 0.15,
		["max"] = 3,
		["economy"] = 15
	},
	["apple"] = {
		["index"] = "apple",
		["name"] = "Maça",
		["type"] = "Usável",
		["weight"] = 0.25,
		["economy"] = 10
	},
	["orange"] = {
		["index"] = "orange",
		["name"] = "Laranja",
		["type"] = "Usável",
		["weight"] = 0.25,
		["economy"] = 10
	},
	["strawberry"] = {
		["index"] = "strawberry",
		["name"] = "Morango",
		["type"] = "Usável",
		["weight"] = 0.15,
		["economy"] = 10
	},
	["coffee2"] = {
		["index"] = "coffee2",
		["name"] = "Grão de Café",
		["type"] = "Usável",
		["weight"] = 0.10,
		["economy"] = 10
	},
	["grape"] = {
		["index"] = "grape",
		["name"] = "Uva",
		["type"] = "Usável",
		["weight"] = 0.15,
		["economy"] = 10
	},
	["tange"] = {
		["index"] = "tange",
		["name"] = "Tangerina",
		["type"] = "Usável",
		["weight"] = 0.25,
		["economy"] = 10
	},
	["banana"] = {
		["index"] = "banana",
		["name"] = "Banana",
		["type"] = "Usável",
		["weight"] = 0.25,
		["economy"] = 10
	},
	["guarana"] = {
		["index"] = "guarana",
		["name"] = "Guaraná",
		["type"] = "Usável",
		["weight"] = 0.25,
		["economy"] = 10
	},
	["acerola"] = {
		["index"] = "acerola",
		["name"] = "Acerola",
		["type"] = "Usável",
		["weight"] = 0.25,
		["economy"] = 10
	},
	["passion"] = {
		["index"] = "passion",
		["name"] = "Maracujá",
		["type"] = "Usável",
		["weight"] = 0.25,
		["economy"] = 10
	},
	["tomato"] = {
		["index"] = "tomato",
		["name"] = "Tomate",
		["type"] = "Usável",
		["weight"] = 0.15,
		["economy"] = 10
	},
	["mushroom"] = {
		["index"] = "mushroom",
		["name"] = "Cogumelo",
		["type"] = "Usável",
		["weight"] = 0.15,
		["economy"] = 10
	},
	["sugar"] = {
		["index"] = "sugar",
		["name"] = "Açucar",
		["type"] = "Comum",
		["weight"] = 0.10,
		["economy"] = 6
	},
	["cookies"] = {
		["index"] = "cookies",
		["name"] = "Cookies",
		["type"] = "Usável",
		["weight"] = 0.25,
		["scape"] = true,
		["max"] = 3,
		["economy"] = 55
	},
	["orangejuice"] = {
		["index"] = "orangejuice",
		["name"] = "Suco de Laranja",
		["type"] = "Usável",
		["weight"] = 0.75,
		["scape"] = true,
		["max"] = 3,
		["economy"] = 125
	},
	["tangejuice"] = {
		["index"] = "tangejuice",
		["name"] = "Suco de Tangerina",
		["type"] = "Usável",
		["weight"] = 0.45,
		["scape"] = true,
		["max"] = 3,
		["economy"] = 125
	},
	["grapejuice"] = {
		["index"] = "grapejuice",
		["name"] = "Suco de Uva",
		["type"] = "Usável",
		["weight"] = 0.45,
		["scape"] = true,
		["max"] = 3,
		["economy"] = 125
	},
	["strawberryjuice"] = {
		["index"] = "strawberryjuice",
		["name"] = "Suco de Morango",
		["type"] = "Usável",
		["weight"] = 0.45,
		["scape"] = true,
		["max"] = 3,
		["economy"] = 125
	},
	["bananajuice"] = {
		["index"] = "bananajuice",
		["name"] = "Suco de Banana",
		["type"] = "Usável",
		["weight"] = 0.45,
		["scape"] = true,
		["max"] = 3,
		["economy"] = 125
	},
	["acerolajuice"] = {
		["index"] = "acerolajuice",
		["name"] = "Suco de Acerola",
		["type"] = "Usável",
		["weight"] = 0.45,
		["scape"] = true,
		["max"] = 3,
		["economy"] = 125
	},
	["passionjuice"] = {
		["index"] = "passionjuice",
		["name"] = "Suco de Maracujá",
		["type"] = "Usável",
		["weight"] = 0.45,
		["scape"] = true,
		["max"] = 3,
		["economy"] = 125
	},
	["bread"] = {
		["index"] = "bread",
		["name"] = "Pão",
		["type"] = "Comum",
		["weight"] = 0.25,
		["economy"] = 5
	},
	["ketchup"] = {
		["index"] = "ketchup",
		["name"] = "Ketchup",
		["type"] = "Comum",
		["weight"] = 0.25,
		["economy"] = 75
	},
	["cannedsoup"] = {
		["index"] = "cannedsoup",
		["name"] = "Sopa em Lata",
		["type"] = "Usável",
		["weight"] = 0.25,
		["ilegal"] = true,
		["economy"] = 55
	},
	["canofbeans"] = {
		["index"] = "canofbeans",
		["name"] = "Lata de Feijão",
		["type"] = "Usável",
		["weight"] = 0.25,
		["ilegal"] = true,
		["economy"] = 55
	},
	["meat"] = {
		["index"] = "meat",
		["name"] = "Carne Animal",
		["type"] = "Comum",
		["weight"] = 0.75,
		["economy"] = 16
	},
	["fishfillet"] = {
		["index"] = "fishfillet",
		["name"] = "Filé de Peixe",
		["type"] = "Comum",
		["weight"] = 0.75,
		["economy"] = 10
	},
	["marshmallow"] = {
		["index"] = "marshmallow",
		["name"] = "Marshmallow",
		["type"] = "Usável",
		["weight"] = 0.15,
		["scape"] = true,
		["max"] = 3,
		["economy"] = 35
	},
	["cookedfishfillet"] = {
		["index"] = "cookedfishfillet",
		["name"] = "Filé de Peixe Cozido",
		["type"] = "Usável",
		["weight"] = 0.35,
		["scape"] = true,
		["max"] = 3,
		["economy"] = 35
	},
	["cookedmeat"] = {
		["index"] = "cookedmeat",
		["name"] = "Carne Animal Cozida",
		["type"] = "Usável",
		["weight"] = 0.35,
		["scape"] = true,
		["max"] = 3,
		["economy"] = 35
	},
	["hamburger"] = {
		["index"] = "hamburger",
		["name"] = "Hambúrguer",
		["type"] = "Usável",
		["weight"] = 0.35,
		["max"] = 3,
		["economy"] = 25
	},
	["hamburger2"] = {
		["index"] = "hamburger2",
		["name"] = "Hambúrguer Artesanal",
		["type"] = "Usável",
		["weight"] = 0.55,
		["scape"] = true,
		["max"] = 3,
		["economy"] = 150
	},
	["onionrings"] = {
		["index"] = "onionrings",
		["name"] = "Anéis de Cebola",
		["type"] = "Usável",
		["weight"] = 0.55,
		["scape"] = true,
		["max"] = 3,
		["economy"] = 95
	},
	["chickenfries"] = {
		["index"] = "chickenfries",
		["name"] = "Frango Frito",
		["type"] = "Usável",
		["weight"] = 0.55,
		["scape"] = true,
		["max"] = 3,
		["economy"] = 125
	},
	["pizzamozzarella"] = {
		["index"] = "pizzamozzarella",
		["name"] = "Pizza de Muçarela",
		["type"] = "Usável",
		["weight"] = 0.35,
		["scape"] = true,
		["max"] = 3,
		["economy"] = 150
	},
	["pizzamushroom"] = {
		["index"] = "pizzamushroom",
		["name"] = "Pizza de Cogumelo",
		["type"] = "Usável",
		["weight"] = 0.35,
		["scape"] = true,
		["max"] = 3,
		["economy"] = 150
	},
	["pizzabanana"] = {
		["index"] = "pizzabanana",
		["name"] = "Pizza de Banana",
		["type"] = "Usável",
		["weight"] = 0.35,
		["scape"] = true,
		["max"] = 3,
		["economy"] = 150
	},
	["pizzachocolate"] = {
		["index"] = "pizzachocolate",
		["name"] = "Pizza de Chocolate",
		["type"] = "Usável",
		["weight"] = 0.35,
		["scape"] = true,
		["max"] = 3,
		["economy"] = 150
	},
	["calzone"] = {
		["index"] = "calzone",
		["name"] = "Calzone",
		["type"] = "Usável",
		["weight"] = 0.35,
		["scape"] = true,
		["max"] = 3,
		["economy"] = 150
	},
	["hotdog"] = {
		["index"] = "hotdog",
		["name"] = "Cachorro-Quente",
		["type"] = "Usável",
		["weight"] = 0.35,
		["max"] = 3,
		["economy"] = 15
	},
	["donut"] = {
		["index"] = "donut",
		["name"] = "Rosquinha",
		["type"] = "Usável",
		["weight"] = 0.25,
		["max"] = 3,
		["economy"] = 15
	},
	["plate"] = {
		["index"] = "plate",
		["name"] = "Placa",
		["type"] = "Comum",
		["weight"] = 0.50,
		["ilegal"] = true,
		["economy"] = 525
	},
	["lockpick"] = {
		["index"] = "lockpick",
		["name"] = "Lockpick de Alumínio",
		["desc"] = "Utilizada para roubar veículos.",
		["type"] = "Usável",
		["durability"] = 3,
		["weight"] = 1.25,
		["ilegal"] = true,
		["economy"] = 575
	},
	["lockpick2"] = {
		["index"] = "lockpick2",
		["name"] = "Lockpick de Cobre",
		["desc"] = "Utilizada para roubar propriedades.",
		["type"] = "Usável",
		["durability"] = 3,
		["weight"] = 1.25,
		["ilegal"] = true,
		["economy"] = 575
	},
	["brokenpick"] = {
		["index"] = "brokenpick",
		["name"] = "Lockpick Quebrado",
		["type"] = "Comum",
		["weight"] = 1.25,
		["ilegal"] = true,
		["economy"] = 55
	},
	["toolbox"] = {
		["index"] = "toolbox",
		["name"] = "Ferramentas Básicas",
		["type"] = "Usável",
		["weight"] = 1.75,
		["max"] = 2,
		["economy"] = 625
	},
	["advtoolbox"] = {
		["index"] = "toolbox",
		["name"] = "Ferramentas Avançadas",
		["type"] = "Usável",
		["weight"] = 2.25,
		["charges"] = 3,
		["max"] = 1,
		["economy"] = 1525
	},
	["notepad"] = {
		["index"] = "notepad",
		["name"] = "Bloco de Notas",
		["type"] = "Usável",
		["weight"] = 0.25,
		["economy"] = 10
	},
	["tyres"] = {
		["index"] = "tyres",
		["name"] = "Pneu",
		["type"] = "Usável",
		["weight"] = 1.50,
		["max"] = 4,
		["economy"] = 225
	},
	["cellphone"] = {
		["index"] = "cellphone",
		["name"] = "Celular",
		["type"] = "Usável",
		["durability"] = 14,
		["weight"] = 0.75,
		["economy"] = 575
	},
	["divingsuit"] = {
		["index"] = "divingsuit",
		["name"] = "Roupa de Mergulho",
		["type"] = "Usável",
		["durability"] = 14,
		["weight"] = 4.75,
		["economy"] = 975
	},
	["handcuff"] = {
		["index"] = "handcuff",
		["name"] = "Algemas",
		["type"] = "Usável",
		["durability"] = 7,
		["weight"] = 0.75,
		["ilegal"] = true,
		["economy"] = 5750
	},
	["rope"] = {
		["index"] = "rope",
		["name"] = "Cordas",
		["type"] = "Usável",
		["durability"] = 7,
		["weight"] = 1.50,
		["economy"] = 875
	},
	["hood"] = {
		["index"] = "hood",
		["name"] = "Capuz",
		["type"] = "Usável",
		["durability"] = 7,
		["weight"] = 1.50,
		["ilegal"] = true,
		["economy"] = 5750
	},
	["plastic"] = {
		["index"] = "plastic",
		["name"] = "Plástico",
		["type"] = "Comum",
		["weight"] = 0.075,
		["economy"] = 20
	},
	["glass"] = {
		["index"] = "glass",
		["name"] = "Vidro",
		["type"] = "Comum",
		["weight"] = 0.075,
		["economy"] = 20
	},
	["rubber"] = {
		["index"] = "rubber",
		["name"] = "Borracha",
		["type"] = "Comum",
		["weight"] = 0.050,
		["economy"] = 20
	},
	["aluminum"] = {
		["index"] = "aluminum",
		["name"] = "Alumínio",
		["type"] = "Comum",
		["weight"] = 0.075,
		["economy"] = 30
	},
	["copper"] = {
		["index"] = "copper",
		["name"] = "Cobre",
		["type"] = "Comum",
		["weight"] = 0.075,
		["economy"] = 30
	},
	["newspaper"] = {
		["index"] = "newspaper",
		["name"] = "Jornal",
		["type"] = "Comum",
		["weight"] = 0.375,
		["economy"] = 60
	},
	["ritmoneury"] = {
		["index"] = "ritmoneury",
		["name"] = "Ritmoneury",
		["type"] = "Usável",
		["weight"] = 0.25,
		["max"] = 2,
		["economy"] = 475
	},
	["sinkalmy"] = {
		["index"] = "sinkalmy",
		["name"] = "Sinkalmy",
		["type"] = "Usável",
		["weight"] = 0.25,
		["max"] = 2,
		["economy"] = 375
	},
	["cigarette"] = {
		["index"] = "cigarette",
		["name"] = "Cigarro",
		["type"] = "Usável",
		["weight"] = 0.05,
		["max"] = 5,
		["economy"] = 10
	},
	["lighter"] = {
		["index"] = "lighter",
		["name"] = "Isqueiro",
		["durability"] = 7,
		["type"] = "Comum",
		["weight"] = 0.25,
		["economy"] = 175
	},
	["vape"] = {
		["index"] = "vape",
		["name"] = "Vape",
		["type"] = "Usável",
		["durability"] = 14,
		["weight"] = 0.75,
		["economy"] = 4750
	},
	["dollars"] = {
		["index"] = "dollars",
		["name"] = "Dólares",
		["type"] = "Comum",
		["weight"] = 0.0,
		["ilegal"] = true,
		["economy"] = 1
	},
	["battery"] = {
		["index"] = "battery",
		["name"] = "Pilhas",
		["type"] = "Comum",
		["weight"] = 0.20,
		["economy"] = 90
	},
	["elastic"] = {
		["index"] = "elastic",
		["name"] = "Elástico",
		["type"] = "Comum",
		["weight"] = 0.10,
		["economy"] = 60
	},
	["plasticbottle"] = {
		["index"] = "plasticbottle",
		["name"] = "Garrafa Plástica",
		["type"] = "Comum",
		["weight"] = 0.20,
		["economy"] = 60
	},
	["glassbottle"] = {
		["index"] = "glassbottle",
		["name"] = "Garrafa de Vidro",
		["type"] = "Comum",
		["weight"] = 0.50,
		["economy"] = 60
	},
	["metalcan"] = {
		["index"] = "metalcan",
		["name"] = "Lata de Metal",
		["type"] = "Comum",
		["weight"] = 0.20,
		["economy"] = 90
	},
	["chocolate"] = {
		["index"] = "chocolate",
		["name"] = "Chocolate",
		["type"] = "Usável",
		["weight"] = 0.10,
		["scape"] = true,
		["max"] = 3,
		["economy"] = 15
	},
	["sandwich"] = {
		["index"] = "sandwich",
		["name"] = "Sanduiche",
		["type"] = "Usável",
		["weight"] = 0.25,
		["max"] = 3,
		["economy"] = 15
	},
	["rose"] = {
		["index"] = "rose",
		["name"] = "Rosa",
		["type"] = "Usável",
		["weight"] = 0.15,
		["economy"] = 25
	},
	["teddy"] = {
		["index"] = "teddy",
		["name"] = "Teddy",
		["type"] = "Usável",
		["weight"] = 0.75,
		["economy"] = 75
	},
	["absolut"] = {
		["index"] = "absolut",
		["name"] = "Absolut",
		["type"] = "Usável",
		["weight"] = 0.25,
		["economy"] = 15
	},
	["chandon"] = {
		["index"] = "chandon",
		["name"] = "Chandon",
		["type"] = "Usável",
		["weight"] = 0.35,
		["economy"] = 15
	},
	["dewars"] = {
		["index"] = "dewars",
		["name"] = "Dewars",
		["type"] = "Usável",
		["weight"] = 0.25,
		["economy"] = 15
	},
	["hennessy"] = {
		["index"] = "hennessy",
		["name"] = "Hennessy",
		["type"] = "Usável",
		["weight"] = 0.25,
		["economy"] = 15
	},
	["goldbar"] = {
		["index"] = "goldbar",
		["name"] = "Barra de Ouro",
		["type"] = "Comum",
		["weight"] = 0.25,
		["ilegal"] = true,
		["economy"] = 525
	},
	["binoculars"] = {
		["index"] = "binoculars",
		["name"] = "Binóculos",
		["type"] = "Usável",
		["weight"] = 0.75,
		["economy"] = 275
	},
	["camera"] = {
		["index"] = "camera",
		["name"] = "Câmera",
		["type"] = "Usável",
		["weight"] = 2.25,
		["economy"] = 275
	},
	["WEAPON_HATCHET"] = {
		["index"] = "hatchet",
		["name"] = "Machado",
		["type"] = "Armamento",
		["durability"] = 7,
		["weight"] = 0.75,
		["ilegal"] = true,
		["economy"] = 975
	},
	["WEAPON_BAT"] = {
		["index"] = "bat",
		["name"] = "Bastão de Beisebol",
		["type"] = "Armamento",
		["durability"] = 7,
		["weight"] = 0.75,
		["ilegal"] = true,
		["economy"] = 975
	},
	["WEAPON_KATANA"] = {
		["index"] = "katana",
		["name"] = "Katana",
		["type"] = "Armamento",
		["durability"] = 3,
		["weight"] = 0.75,
		["ilegal"] = true,
		["economy"] = 1225
	},
	["WEAPON_BATTLEAXE"] = {
		["index"] = "battleaxe",
		["name"] = "Machado de Batalha",
		["type"] = "Armamento",
		["durability"] = 7,
		["weight"] = 0.75,
		["ilegal"] = true,
		["economy"] = 975
	},
	["WEAPON_CROWBAR"] = {
		["index"] = "crowbar",
		["name"] = "Pé de Cabra",
		["type"] = "Armamento",
		["durability"] = 7,
		["weight"] = 0.75,
		["ilegal"] = true,
		["economy"] = 725
	},
	["WEAPON_GOLFCLUB"] = {
		["index"] = "golfclub",
		["name"] = "Taco de Golf",
		["type"] = "Armamento",
		["durability"] = 7,
		["weight"] = 0.75,
		["ilegal"] = true,
		["economy"] = 975
	},
	["WEAPON_HAMMER"] = {
		["index"] = "hammer",
		["name"] = "Martelo",
		["type"] = "Armamento",
		["durability"] = 7,
		["weight"] = 0.75,
		["ilegal"] = true,
		["economy"] = 975
	},
	["WEAPON_MACHETE"] = {
		["index"] = "machete",
		["name"] = "Facão",
		["type"] = "Armamento",
		["durability"] = 7,
		["weight"] = 0.75,
		["ilegal"] = true,
		["economy"] = 975
	},
	["WEAPON_POOLCUE"] = {
		["index"] = "poolcue",
		["name"] = "Taco de Sinuca",
		["type"] = "Armamento",
		["durability"] = 7,
		["weight"] = 0.75,
		["ilegal"] = true,
		["economy"] = 975
	},
	["WEAPON_STONE_HATCHET"] = {
		["index"] = "stonehatchet",
		["name"] = "Machado de Pedra",
		["type"] = "Armamento",
		["durability"] = 7,
		["weight"] = 0.75,
		["ilegal"] = true,
		["economy"] = 975
	},
	["WEAPON_WRENCH"] = {
		["index"] = "wrench",
		["name"] = "Chave Inglesa",
		["type"] = "Armamento",
		["durability"] = 7,
		["weight"] = 0.75,
		["ilegal"] = true,
		["economy"] = 725
	},
	["WEAPON_KNUCKLE"] = {
		["index"] = "knuckle",
		["name"] = "Soco Inglês",
		["type"] = "Armamento",
		["durability"] = 7,
		["weight"] = 0.75,
		["ilegal"] = true,
		["economy"] = 975
	},
	["WEAPON_FLASHLIGHT"] = {
		["index"] = "flashlight",
		["name"] = "Lanterna",
		["type"] = "Armamento",
		["durability"] = 7,
		["weight"] = 0.75,
		["ilegal"] = true,
		["economy"] = 675
	},
	["WEAPON_NIGHTSTICK"] = {
		["index"] = "nightstick",
		["name"] = "Cassetete",
		["type"] = "Armamento",
		["durability"] = 7,
		["weight"] = 0.75,
		["ilegal"] = true,
		["economy"] = 125
	},
	["WEAPON_PISTOL"] = {
		["index"] = "m1911",
		["name"] = "M1911",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_PISTOL_AMMO",
		["durability"] = 14,
		["vehicle"] = true,
		["weight"] = 1.25,
		["ilegal"] = true,
		["economy"] = 5750
	},
	["WEAPON_PISTOL_MK2"] = {
		["index"] = "fiveseven",
		["name"] = "FN Five Seven",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_PISTOL_AMMO",
		["durability"] = 14,
		["vehicle"] = true,
		["weight"] = 1.50,
		["ilegal"] = true,
		["economy"] = 6225
	},
	["WEAPON_COMPACTRIFLE"] = {
		["index"] = "akcompact",
		["name"] = "AK Compact",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_RIFLE_AMMO",
		["durability"] = 14,
		["weight"] = 2.25,
		["ilegal"] = true,
		["economy"] = 13250
	},
	["WEAPON_APPISTOL"] = {
		["index"] = "kochvp9",
		["name"] = "Koch Vp9",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_PISTOL_AMMO",
		["durability"] = 14,
		["vehicle"] = true,
		["weight"] = 1.25,
		["ilegal"] = true,
		["economy"] = 6250
	},
	["WEAPON_HEAVYPISTOL"] = {
		["index"] = "atifx45",
		["name"] = "Ati FX45",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_PISTOL_AMMO",
		["durability"] = 14,
		["vehicle"] = true,
		["weight"] = 1.50,
		["ilegal"] = true,
		["economy"] = 725
	},
	["WEAPON_MACHINEPISTOL"] = {
		["index"] = "tec9",
		["name"] = "Tec-9",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_SMG_AMMO",
		["durability"] = 14,
		["vehicle"] = true,
		["weight"] = 1.75,
		["ilegal"] = true,
		["economy"] = 8250
	},
	["WEAPON_MICROSMG"] = {
		["index"] = "uzi",
		["name"] = "Uzi",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_SMG_AMMO",
		["durability"] = 14,
		["vehicle"] = true,
		["weight"] = 1.25,
		["ilegal"] = true,
		["economy"] = 13250
	},
	["WEAPON_MINISMG"] = {
		["index"] = "skorpionv61",
		["name"] = "Skorpion V61",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_SMG_AMMO",
		["durability"] = 14,
		["vehicle"] = true,
		["weight"] = 1.75,
		["ilegal"] = true,
		["economy"] = 13250
	},
	["WEAPON_SNSPISTOL"] = {
		["index"] = "amt380",
		["name"] = "AMT 380",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_PISTOL_AMMO",
		["durability"] = 14,
		["vehicle"] = true,
		["weight"] = 1.00,
		["ilegal"] = true,
		["economy"] = 4750
	},
	["WEAPON_SNSPISTOL_MK2"] = {
		["index"] = "hkp7m10",
		["name"] = "HK P7M10",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_PISTOL_AMMO",
		["durability"] = 14,
		["vehicle"] = true,
		["weight"] = 1.25,
		["ilegal"] = true,
		["economy"] = 5250
	},
	["WEAPON_VINTAGEPISTOL"] = {
		["index"] = "m1922",
		["name"] = "M1922",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_PISTOL_AMMO",
		["durability"] = 14,
		["vehicle"] = true,
		["weight"] = 1.25,
		["ilegal"] = true,
		["economy"] = 4750
	},
	["WEAPON_PISTOL50"] = {
		["index"] = "desert",
		["name"] = "Desert Eagle",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_PISTOL_AMMO",
		["durability"] = 14,
		["vehicle"] = true,
		["weight"] = 1.50,
		["ilegal"] = true,
		["economy"] = 8250
	},
	["WEAPON_REVOLVER"] = {
		["index"] = "magnum",
		["name"] = "Magnum 44",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_PISTOL_AMMO",
		["durability"] = 14,
		["vehicle"] = true,
		["weight"] = 1.50,
		["ilegal"] = true,
		["economy"] = 8250
	},
	["WEAPON_COMBATPISTOL"] = {
		["index"] = "glock",
		["name"] = "Glock",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_PISTOL_AMMO",
		["durability"] = 14,
		["vehicle"] = true,
		["weight"] = 1.25,
		["ilegal"] = true,
		["economy"] = 625
	},
	["WEAPON_CARBINERIFLE"] = {
		["index"] = "m4a1",
		["name"] = "M4A1",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_RIFLE_AMMO",
		["durability"] = 21,
		["weight"] = 7.75,
		["ilegal"] = true,
		["economy"] = 775
	},
	["WEAPON_CARBINERIFLE_MK2"] = {
		["index"] = "m4a4",
		["name"] = "M4A4",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_RIFLE_AMMO",
		["durability"] = 21,
		["weight"] = 8.50,
		["ilegal"] = true,
		["economy"] = 925
	},
	["WEAPON_ADVANCEDRIFLE"] = {
		["index"] = "tar21",
		["name"] = "Tar-21",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_RIFLE_AMMO",
		["durability"] = 21,
		["weight"] = 7.75,
		["ilegal"] = true,
		["economy"] = 25000
	},
	["WEAPON_BULLPUPRIFLE"] = {
		["index"] = "qbz95",
		["name"] = "QBZ-95",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_RIFLE_AMMO",
		["durability"] = 21,
		["weight"] = 7.75,
		["ilegal"] = true,
		["economy"] = 25000
	},
	["WEAPON_BULLPUPRIFLE_MK2"] = {
		["index"] = "l85",
		["name"] = "L85",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_RIFLE_AMMO",
		["durability"] = 21,
		["weight"] = 7.75,
		["ilegal"] = true,
		["economy"] = 25000
	},
	["WEAPON_SPECIALCARBINE"] = {
		["index"] = "g36c",
		["name"] = "G36C",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_RIFLE_AMMO",
		["durability"] = 21,
		["weight"] = 8.25,
		["ilegal"] = true,
		["economy"] = 25000
	},
	["WEAPON_SPECIALCARBINE_MK2"] = {
		["index"] = "sigsauer556",
		["name"] = "Sig Sauer 556",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_RIFLE_AMMO",
		["durability"] = 21,
		["weight"] = 8.25,
		["ilegal"] = true,
		["economy"] = 25000
	},
	["WEAPON_PUMPSHOTGUN"] = {
		["index"] = "mossberg590",
		["name"] = "Mossberg 590",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_SHOTGUN_AMMO",
		["durability"] = 21,
		["weight"] = 7.25,
		["ilegal"] = true,
		["economy"] = 775
	},
	["WEAPON_PUMPSHOTGUN_MK2"] = {
		["index"] = "mossberg590a1",
		["name"] = "Mossberg 590A1",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_SHOTGUN_AMMO",
		["durability"] = 21,
		["weight"] = 7.25,
		["ilegal"] = true,
		["economy"] = 15250
	},
	["WEAPON_MUSKET"] = {
		["index"] = "winchester",
		["name"] = "Winchester 1892",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_MUSKET_AMMO",
		["durability"] = 21,
		["weight"] = 6.25,
		["ilegal"] = true,
		["economy"] = 3250
	},
	["WEAPON_SNIPERRIFLE"] = {
		["index"] = "sauer101",
		["name"] = "Sauer 101",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_MUSKET_AMMO",
		["durability"] = 21,
		["weight"] = 8.25,
		["ilegal"] = true,
		["economy"] = 7250
	},
	["WEAPON_SAWNOFFSHOTGUN"] = {
		["index"] = "mossberg500",
		["name"] = "Mossberg 500",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_SHOTGUN_AMMO",
		["durability"] = 21,
		["weight"] = 5.75,
		["ilegal"] = true,
		["economy"] = 13250
	},
	["WEAPON_SMG"] = {
		["index"] = "mp5",
		["name"] = "MP5",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_SMG_AMMO",
		["durability"] = 21,
		["weight"] = 5.25,
		["ilegal"] = true,
		["economy"] = 775
	},
	["WEAPON_SMG_MK2"] = {
		["index"] = "evo3",
		["name"] = "Evo-3",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_SMG_AMMO",
		["durability"] = 21,
		["weight"] = 5.25,
		["ilegal"] = true,
		["economy"] = 15250
	},
	["WEAPON_ASSAULTRIFLE"] = {
		["index"] = "ak103",
		["name"] = "AK-103",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_RIFLE_AMMO",
		["durability"] = 21,
		["weight"] = 7.75,
		["ilegal"] = true,
		["economy"] = 25000
	},
	["WEAPON_ASSAULTRIFLE_MK2"] = {
		["index"] = "ak74",
		["name"] = "AK-74",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_RIFLE_AMMO",
		["durability"] = 21,
		["weight"] = 7.75,
		["ilegal"] = true,
		["economy"] = 25000
	},
	["WEAPON_ASSAULTSMG"] = {
		["index"] = "steyraug",
		["name"] = "Steyr AUG",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_RIFLE_AMMO",
		["durability"] = 21,
		["weight"] = 5.75,
		["ilegal"] = true,
		["economy"] = 15250
	},
	["WEAPON_GUSENBERG"] = {
		["index"] = "thompson",
		["name"] = "Thompson",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_SMG_AMMO",
		["durability"] = 21,
		["weight"] = 6.25,
		["ilegal"] = true,
		["economy"] = 15250
	},
	["WEAPON_PETROLCAN"] = {
		["index"] = "gallon",
		["name"] = "Galão",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_PETROLCAN_AMMO",
		["weight"] = 1.25,
		["economy"] = 50
	},
	["GADGET_PARACHUTE"] = {
		["index"] = "parachute",
		["name"] = "Paraquedas",
		["type"] = "Usável",
		["weight"] = 2.25,
		["economy"] = 475
	},
	["WEAPON_STUNGUN"] = {
		["index"] = "stungun",
		["name"] = "Tazer",
		["type"] = "Armamento",
		["durability"] = 21,
		["weight"] = 0.75,
		["ilegal"] = true,
		["economy"] = 525
	},
	["WEAPON_PISTOL_AMMO"] = {
		["index"] = "pistolammo",
		["name"] = "Munição de Pistola",
		["type"] = "Munição",
		["weight"] = 0.02,
		["ilegal"] = true,
		["economy"] = 30
	},
	["WEAPON_SMG_AMMO"] = {
		["index"] = "smgammo",
		["name"] = "Munição de Sub",
		["type"] = "Munição",
		["weight"] = 0.03,
		["ilegal"] = true,
		["economy"] = 35
	},
	["WEAPON_RIFLE_AMMO"] = {
		["index"] = "rifleammo",
		["name"] = "Munição de Rifle",
		["type"] = "Munição",
		["weight"] = 0.04,
		["ilegal"] = true,
		["economy"] = 35
	},
	["WEAPON_SHOTGUN_AMMO"] = {
		["index"] = "shotgunammo",
		["name"] = "Munição de Escopeta",
		["type"] = "Munição",
		["weight"] = 0.05,
		["ilegal"] = true,
		["economy"] = 30
	},
	["WEAPON_MUSKET_AMMO"] = {
		["index"] = "musketammo",
		["name"] = "Munição de Mosquete",
		["type"] = "Munição",
		["weight"] = 0.05,
		["ilegal"] = true,
		["economy"] = 7
	},
	["WEAPON_PETROLCAN_AMMO"] = {
		["index"] = "fuel",
		["name"] = "Combustível",
		["type"] = "Munição",
		["weight"] = 0.001,
		["economy"] = 0
	},
	["WEAPON_BRICK"] = {
		["index"] = "brick",
		["name"] = "Tijolo",
		["type"] = "Throwing",
		["weight"] = 0.50,
		["ilegal"] = true,
		["economy"] = 20
	},
	["WEAPON_SHOE"] = {
		["index"] = "sneakers",
		["name"] = "Tênis",
		["type"] = "Throwing",
		["weight"] = 0.50,
		["ilegal"] = true,
		["economy"] = 20
	},
	["WEAPON_MOLOTOV"] = {
		["index"] = "molotov",
		["name"] = "Coquetel Molotov",
		["type"] = "Throwing",
		["weight"] = 0.50,
		["ilegal"] = true,
		["economy"] = 225,
		["max"] = 3
	},
	["WEAPON_SMOKEGRENADE"] = {
		["index"] = "smokegrenade",
		["name"] = "Granada de Fumaça",
		["type"] = "Throwing",
		["weight"] = 0.50,
		["ilegal"] = true,
		["economy"] = 225,
		["max"] = 3
	},
	["pager"] = {
		["index"] = "pager",
		["name"] = "Pager",
		["type"] = "Usável",
		["weight"] = 1.25,
		["ilegal"] = true,
		["economy"] = 125
	},
	["firecracker"] = {
		["index"] = "firecracker",
		["name"] = "Fogos de Artificio",
		["type"] = "Usável",
		["weight"] = 2.25,
		["economy"] = 100
	},
	["analgesic"] = {
		["index"] = "analgesic",
		["name"] = "Analgésico",
		["type"] = "Usável",
		["weight"] = 0.10,
		["max"] = 4,
		["economy"] = 125
	},
	["oxy"] = {
		["index"] = "analgesic",
		["name"] = "Oxy",
		["type"] = "Usável",
		["weight"] = 0.10,
		["ilegal"] = true,
		["max"] = 4,
		["economy"] = 35
	},
	["gauze"] = {
		["index"] = "gauze",
		["name"] = "Gaze",
		["type"] = "Usável",
		["weight"] = 0.07,
		["max"] = 4,
		["economy"] = 225
	},
	["gsrkit"] = {
		["index"] = "gsrkit",
		["name"] = "Kit Residual",
		["type"] = "Usável",
		["weight"] = 0.75,
		["ilegal"] = true,
		["economy"] = 20
	},
	["gdtkit"] = {
		["index"] = "gdtkit",
		["name"] = "Kit Químico",
		["type"] = "Usável",
		["weight"] = 0.75,
		["ilegal"] = true,
		["economy"] = 20
	},
	["emerald"] = {
		["index"] = "emerald",
		["name"] = "Esmeralda",
		["type"] = "Comum",
		["weight"] = 0.85,
		["economy"] = 85
	},
	["diamond"] = {
		["index"] = "diamond",
		["name"] = "Diamante",
		["type"] = "Comum",
		["weight"] = 0.80,
		["economy"] = 75
	},
	["ruby"] = {
		["index"] = "ruby",
		["name"] = "Rubi",
		["type"] = "Comum",
		["weight"] = 0.75,
		["economy"] = 55
	},
	["sapphire"] = {
		["index"] = "sapphire",
		["name"] = "Safira",
		["type"] = "Comum",
		["weight"] = 0.70,
		["economy"] = 45
	},
	["amethyst"] = {
		["index"] = "amethyst",
		["name"] = "Ametista",
		["type"] = "Comum",
		["weight"] = 0.65,
		["economy"] = 40
	},
	["amber"] = {
		["index"] = "amber",
		["name"] = "Âmbar",
		["type"] = "Comum",
		["weight"] = 0.60,
		["economy"] = 35
	},
	["turquoise"] = {
		["index"] = "turquoise",
		["name"] = "Turquesa",
		["type"] = "Comum",
		["weight"] = 0.55,
		["economy"] = 30
	},
	["keyboard"] = {
		["index"] = "keyboard",
		["name"] = "Teclado",
		["type"] = "Comum",
		["weight"] = 0.50,
		["ilegal"] = true,
		["economy"] = 75
	},
	["mouse"] = {
		["index"] = "mouse",
		["name"] = "Mouse",
		["type"] = "Comum",
		["weight"] = 0.25,
		["ilegal"] = true,
		["economy"] = 75
	},
	["silverring"] = {
		["index"] = "silverring",
		["name"] = "Anel de Prata",
		["type"] = "Comum",
		["weight"] = 0.25,
		["ilegal"] = true,
		["economy"] = 75
	},
	["goldring"] = {
		["index"] = "goldring",
		["name"] = "Anel de Ouro",
		["type"] = "Comum",
		["weight"] = 0.25,
		["ilegal"] = true,
		["economy"] = 100
	},
	["silvercoin"] = {
		["index"] = "silvercoin",
		["name"] = "Moeda de Prata",
		["type"] = "Usável",
		["weight"] = 0.01,
		["ilegal"] = true,
		["economy"] = 20
	},
	["goldcoin"] = {
		["index"] = "goldcoin",
		["name"] = "Moeda de Ouro",
		["type"] = "Usável",
		["weight"] = 0.01,
		["ilegal"] = true,
		["economy"] = 40
	},
	["watch"] = {
		["index"] = "watch",
		["name"] = "Relógio",
		["type"] = "Comum",
		["weight"] = 0.25,
		["ilegal"] = true,
		["economy"] = 75
	},
	["playstation"] = {
		["index"] = "playstation",
		["name"] = "Playstation",
		["type"] = "Comum",
		["weight"] = 2.00,
		["ilegal"] = true,
		["economy"] = 75
	},
	["xbox"] = {
		["index"] = "xbox",
		["name"] = "Xbox",
		["type"] = "Comum",
		["weight"] = 1.75,
		["ilegal"] = true,
		["economy"] = 75
	},
	["legos"] = {
		["index"] = "legos",
		["name"] = "Legos",
		["type"] = "Comum",
		["weight"] = 0.25,
		["ilegal"] = true,
		["economy"] = 75
	},
	["ominitrix"] = {
		["index"] = "ominitrix",
		["name"] = "Ominitrix",
		["type"] = "Comum",
		["weight"] = 0.50,
		["ilegal"] = true,
		["economy"] = 75
	},
	["bracelet"] = {
		["index"] = "bracelet",
		["name"] = "Bracelete",
		["type"] = "Comum",
		["weight"] = 0.25,
		["ilegal"] = true,
		["economy"] = 75
	},
	["dildo"] = {
		["index"] = "dildo",
		["name"] = "Vibrador",
		["type"] = "Comum",
		["weight"] = 0.25,
		["ilegal"] = true,
		["economy"] = 75
	},
	["spray01"] = {
		["index"] = "spray01",
		["name"] = "Desodorante 24hrs",
		["type"] = "Comum",
		["weight"] = 0.25,
		["ilegal"] = true,
		["economy"] = 75
	},
	["spray02"] = {
		["index"] = "spray02",
		["name"] = "Antisséptico",
		["type"] = "Comum",
		["weight"] = 0.25,
		["ilegal"] = true,
		["economy"] = 75
	},
	["spray03"] = {
		["index"] = "spray03",
		["name"] = "Desodorante 48hrs",
		["type"] = "Comum",
		["weight"] = 0.25,
		["ilegal"] = true,
		["economy"] = 75
	},
	["spray04"] = {
		["index"] = "spray04",
		["name"] = "Desodorante 72hrs",
		["type"] = "Comum",
		["weight"] = 0.25,
		["ilegal"] = true,
		["economy"] = 75
	},
	["dices"] = {
		["index"] = "dices",
		["name"] = "Dados",
		["type"] = "Usável",
		["weight"] = 0.25,
		["ilegal"] = true,
		["economy"] = 45
	},
	["dish"] = {
		["index"] = "dish",
		["name"] = "Prato",
		["type"] = "Comum",
		["weight"] = 0.25,
		["ilegal"] = true,
		["economy"] = 75
	},
	["pan"] = {
		["index"] = "pan",
		["name"] = "Panela",
		["type"] = "Usável",
		["weight"] = 0.50,
		["ilegal"] = true,
		["economy"] = 100
	},
	["fan"] = {
		["index"] = "fan",
		["name"] = "Ventilador",
		["type"] = "Comum",
		["weight"] = 0.50,
		["ilegal"] = true,
		["economy"] = 75
	},
	["rimel"] = {
		["index"] = "rimel",
		["name"] = "Rímel",
		["type"] = "Comum",
		["weight"] = 0.25,
		["ilegal"] = true,
		["economy"] = 75
	},
	["blender"] = {
		["index"] = "blender",
		["name"] = "Liquidificador",
		["type"] = "Usável",
		["weight"] = 0.50,
		["ilegal"] = true,
		["economy"] = 75
	},
	["switch"] = {
		["index"] = "switch",
		["name"] = "Interruptor",
		["type"] = "Comum",
		["weight"] = 0.25,
		["ilegal"] = true,
		["economy"] = 45
	},
	["horseshoe"] = {
		["index"] = "horseshoe",
		["name"] = "Ferradura",
		["type"] = "Comum",
		["weight"] = 0.25,
		["ilegal"] = true,
		["economy"] = 75
	},
	["brush"] = {
		["index"] = "brush",
		["name"] = "Escova",
		["type"] = "Comum",
		["weight"] = 0.25,
		["ilegal"] = true,
		["economy"] = 75
	},
	["domino"] = {
		["index"] = "domino",
		["name"] = "Dominó",
		["type"] = "Comum",
		["weight"] = 0.25,
		["ilegal"] = true,
		["economy"] = 45
	},
	["floppy"] = {
		["index"] = "floppy",
		["name"] = "Disquete",
		["type"] = "Comum",
		["weight"] = 0.15,
		["ilegal"] = true,
		["economy"] = 45
	},
	["cup"] = {
		["index"] = "cup",
		["name"] = "Cálice",
		["type"] = "Comum",
		["weight"] = 0.25,
		["ilegal"] = true,
		["economy"] = 100
	},
	["deck"] = {
		["index"] = "deck",
		["name"] = "Baralho",
		["type"] = "Usável",
		["weight"] = 0.15,
		["ilegal"] = true,
		["economy"] = 75
	},
	["eraser"] = {
		["index"] = "eraser",
		["name"] = "Apagador",
		["type"] = "Comum",
		["weight"] = 0.15,
		["ilegal"] = true,
		["economy"] = 75
	},
	["pliers"] = {
		["index"] = "pliers",
		["name"] = "Alicate",
		["type"] = "Comum",
		["weight"] = 0.25,
		["ilegal"] = true,
		["economy"] = 55
	},
	["lampshade"] = {
		["index"] = "lampshade",
		["name"] = "Abajur",
		["type"] = "Comum",
		["weight"] = 0.50,
		["ilegal"] = true,
		["economy"] = 75
	},
	["soap"] = {
		["index"] = "soap",
		["name"] = "Sabonete",
		["type"] = "Usável",
		["weight"] = 0.25,
		["ilegal"] = true,
		["economy"] = 75
	},
	["slipper"] = {
		["index"] = "slipper",
		["name"] = "Chinelo",
		["type"] = "Comum",
		["weight"] = 0.50,
		["ilegal"] = true,
		["economy"] = 75
	},
	["pendrive"] = {
		["index"] = "pendrive",
		["name"] = "Pendrive",
		["type"] = "Comum",
		["durability"] = 7,
		["weight"] = 0.25,
		["ilegal"] = true,
		["economy"] = 325
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMBODY
-----------------------------------------------------------------------------------------------------------------------------------------
function itemBody(Item)
	local splitName = splitString(Item,"-")
	local nameItem = splitName[1]

	if itemlist[nameItem] then
		return itemlist[nameItem]
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMINDEX
-----------------------------------------------------------------------------------------------------------------------------------------
function itemIndex(Item)
	local splitName = splitString(Item,"-")
	local nameItem = splitName[1]

	if itemlist[nameItem] then
		return itemlist[nameItem]["index"]
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMNAME
-----------------------------------------------------------------------------------------------------------------------------------------
function itemName(Item)
	local splitName = splitString(Item,"-")
	local nameItem = splitName[1]

	if itemlist[nameItem] then
		return itemlist[nameItem]["name"]
	end

	return "Deletado"
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMTYPE
-----------------------------------------------------------------------------------------------------------------------------------------
function itemType(Item)
	local splitName = splitString(Item,"-")
	local nameItem = splitName[1]

	if itemlist[nameItem] then
		return itemlist[nameItem]["type"]
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMAMMO
-----------------------------------------------------------------------------------------------------------------------------------------
function itemAmmo(Item)
	local splitName = splitString(Item,"-")
	local nameItem = splitName[1]

	if itemlist[nameItem] then
		return itemlist[nameItem]["ammo"]
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function itemVehicle(Item)
	local splitName = splitString(Item,"-")
	local nameItem = splitName[1]

	if itemlist[nameItem] then
		return itemlist[nameItem]["vehicle"] or false
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMWEIGHT
-----------------------------------------------------------------------------------------------------------------------------------------
function itemWeight(Item)
	local splitName = splitString(Item,"-")
	local nameItem = splitName[1]

	if itemlist[nameItem] then
		return itemlist[nameItem]["weight"] or 0.0
	end

	return 0.0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMMAXAMOUNT
-----------------------------------------------------------------------------------------------------------------------------------------
function itemMaxAmount(Item)
	local splitName = splitString(Item,"-")
	local nameItem = splitName[1]

	if itemlist[nameItem] then
		return itemlist[nameItem]["max"] or nil
	end

	return nil
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMSCAPE
-----------------------------------------------------------------------------------------------------------------------------------------
function itemScape(Item)
	local splitName = splitString(Item,"-")
	local nameItem = splitName[1]

	if itemlist[nameItem] then
		return itemlist[nameItem]["scape"] or nil
	end

	return nil
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMDESCRIPTION
-----------------------------------------------------------------------------------------------------------------------------------------
function itemDescription(Item)
	local splitName = splitString(Item,"-")
	local nameItem = splitName[1]

	if itemlist[nameItem] then
		return itemlist[nameItem]["desc"] or nil
	end

	return nil
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMDURABILITY
-----------------------------------------------------------------------------------------------------------------------------------------
function itemDurability(Item)
	local splitName = splitString(Item,"-")
	local nameItem = splitName[1]

	if itemlist[nameItem] then
		return itemlist[nameItem]["durability"] or false
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMCHARGES
-----------------------------------------------------------------------------------------------------------------------------------------
function itemCharges(Item)
	local splitName = splitString(Item,"-")
	local nameItem = splitName[1]

	if itemlist[nameItem] then
		return itemlist[nameItem]["charges"] or nil
	end

	return nil
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMILEGAL
-----------------------------------------------------------------------------------------------------------------------------------------
function itemIlegal(Item)
	local splitName = splitString(Item,"-")
	local nameItem = splitName[1]

	if itemlist[nameItem] then
		return itemlist[nameItem]["ilegal"] or false
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMECONOMY
-----------------------------------------------------------------------------------------------------------------------------------------
function itemEconomy(Item)
	local splitName = splitString(Item,"-")
	local nameItem = splitName[1]

	if itemlist[nameItem] then
		return itemlist[nameItem]["economy"] or nil
	end

	return nil
end