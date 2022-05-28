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
vCLIENT = Tunnel.getInterface("shops")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local shops = {
	["animalStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["cat"] = 25000,
			["husky"] = 25000,
			["poodle"] = 25000,
			["pug"] = 25000,
			["retriever"] = 25000,
			["rottweiler"] = 25000,
			["shepherd"] = 25000,
			["westy"] = 25000
		}
	},
	["departamentStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["notepad"] = 10,
			["energetic"] = 15,
			["hamburger"] = 25,
			["emptybottle"] = 30,
			["cigarette"] = 10,
			["lighter"] = 175,
			["chocolate"] = 15,
			["sandwich"] = 15,
			["chandon"] = 15,
			["dewars"] = 15,
			["hennessy"] = 15,
			["absolut"] = 15,
			["tacos"] = 22,
			["cola"] = 15,
			["soda"] = 15,
			["coffee"] = 20,
			["bread"] = 5,
			["cheese"] = 10,
			["sugar"] = 6
		}
	},
	["mercadoCentral"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["teddy"] = 75,
			["rose"] = 25,
			["rope"] = 875,
			["firecracker"] = 100,
			["radio"] = 975,
			["cellphone"] = 575,
			["binoculars"] = 275,
			["camera"] = 275,
			["vape"] = 4750
		}
	},
	["mechanicTools"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["advtoolbox"] = 1425,
			["toolbox"] = 575,
			["WEAPON_WRENCH"] = 725,
			["lockpick"] = 525,
			["lockpick2"] = 525,
			["tyres"] = 325,
			["WEAPON_CROWBAR"] = 725
		}
	},
	["mechanicBuy"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["perm"] = "Mechanic",
		["list"] = {
			["advtoolbox"] = 712,
			["toolbox"] = 287,
			["WEAPON_WRENCH"] = 525,
			["lockpick"] = 325,
			["lockpick2"] = 325,
			["tyres"] = 125,
			["WEAPON_CROWBAR"] = 525
		}
	},
	["weedShop"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["silk"] = 3
		}
	},
	["oxyStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["oxy"] = 75
		}
	},
	["identityStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["identity"] = 5000
		}
	},
	["fidentityStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["fidentity"] = 10000
		}
	},
	["pharmacyStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["gauze"] = 225,
			["analgesic"] = 125,
			["sinkalmy"] = 375,
			["ritmoneury"] = 475,
			["adrenaline"] = 975
		}
	},
	["pharmacyParamedic"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["perm"] = "Paramedic",
		["list"] = {
			["gauze"] = 112,
			["bandage"] = 87,
			["analgesic"] = 62,
			["medkit"] = 255,
			["sinkalmy"] = 187,
			["ritmoneury"] = 237,
			["wheelchair"] = 2750,
			["badge02"] = 1500
		}
	},
	["ammunationStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["GADGET_PARACHUTE"] = 475,
			["WEAPON_HATCHET"] = 975,
			["WEAPON_BAT"] = 975,
			["WEAPON_BATTLEAXE"] = 975,
			["WEAPON_GOLFCLUB"] = 975,
			["WEAPON_HAMMER"] = 725,
			["WEAPON_MACHETE"] = 975,
			["WEAPON_POOLCUE"] = 975,
			["WEAPON_STONE_HATCHET"] = 975,
			["WEAPON_KNUCKLE"] = 975,
			["WEAPON_FLASHLIGHT"] = 675
		}
	},
	["premiumStore"] = {
		["mode"] = "Buy",
		["type"] = "Premium",
		["list"] = {
			["newchars"] = 75,
			["chip"] = 60,
			["gemstone"] = 1,
			["newlocate"] = 100,
			["premiumplate"] = 50,
			["premium"] = 75,
			["namechange"] = 50
		}
	},
	["imoveisShop"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["homecont05"] = 125000,
			["homecont07"] = 75000,
			["homecont09"] = 175000,
			["homecont04"] = 175000,
			["homecont08"] = 250000,
			["homecont03"] = 75000,
			["homecont01"] = 125000,
			["homecont10"] = 100000,
			["homecont06"] = 250000,
			["homecont02"] = 300000
		}
	},
	["huntingSell"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["banana"] = 6,
			["coffee"] = 6,
			["meat"] = 20,
			["leather"] = 25,
			["animalfat"] = 10,
			["orange"] = 6,
			["passion"] = 6,
			["strawberry"] = 6,
			["animalpelt"] = 25,
			["tange"] = 6,
			["tomato"] = 8,
			["grape"] = 6
		}
	},
	["fishDepartament"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["chocolate"] = 15,
			["bait"] = 4,
			["fishingrod"] = 725
		}
	},
	["fishingSell"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["octopus"] = 20,
			["shrimp"] = 20,
			["carp"] = 18,
			["horsefish"] = 18,
			["tilapia"] = 20,
			["codfish"] = 22,
			["catfish"] = 22,
			["goldenfish"] = 23,
			["pirarucu"] = 23,
			["pacu"] = 25,
			["tambaqui"] = 23
		}
	},
	["casinoBuy"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["chips"] = 1
		}
	},
	["casinoSell"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["chips"] = 1
		}
	},
	["huntingStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["switchblade"] = 525,
			["WEAPON_MUSKET"] = 3250,
			["WEAPON_SNIPERRIFLE"] = 7250,
			["WEAPON_MUSKET_AMMO"] = 7
		}
	},
	["recyclingSell"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["notepad"] = 5,
			["plastic"] = 8,
			["glass"] = 8,
			["rubber"] = 8,
			["aluminum"] = 10,
			["bucket"] = 50,
			["copper"] = 10,
			["radio"] = 485,
			["rope"] = 435,
			["switchblade"] = 215,
			["cellphone"] = 285,
			["binoculars"] = 135,
			["emptybottle"] = 15,
			["camera"] = 135,
			["vape"] = 2375,
			["rose"] = 15,
			["lighter"] = 75,
			["teddy"] = 35,
			["tyres"] = 100,
			["bait"] = 2,
			["firecracker"] = 50,
			["fishingrod"] = 365,
			["divingsuit"] = 485,
			["newspaper"] = 15,
			["silvercoin"] = 5,
			["goldcoin"] = 10
		}
	},
	["minerShop"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["emerald"] = 100,
			["diamond"] = 75,
			["ruby"] = 45,
			["sapphire"] = 40,
			["amethyst"] = 35,
			["amber"] = 20,
			["turquoise"] = 25
		}
	},
	["coffeeMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["coffee"] = 20
		}
	},
	["sodaMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["cola"] = 15,
			["soda"] = 15
		}
	},
	["donutMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["donut"] = 15,
			["chocolate"] = 15
		}
	},
	["burgerMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["hamburger"] = 25
		}
	},
	["hotdogMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["hotdog"] = 15
		}
	},
	["Chihuahua"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["hotdog"] = 15,
			["cola"] = 15,
			["coffee"] = 20,
			["hamburger"] = 15,
			["soda"] = 15
		}
	},
	["waterMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["water"] = 30
		}
	},
	["policeStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["perm"] = "Police",
		["list"] = {
			["vest"] = 325,
			["gsrkit"] = 35,
			["gdtkit"] = 35,
			["handcuff"] = 325,
			["WEAPON_SMG"] = 2250,
			["WEAPON_PUMPSHOTGUN"] = 2250,
			["WEAPON_CARBINERIFLE"] = 4250,
			["WEAPON_CARBINERIFLE_MK2"] = 5250,
			["WEAPON_STUNGUN"] = 1250,
			["WEAPON_COMBATPISTOL"] = 2250,
			["WEAPON_HEAVYPISTOL"] = 3250,
			["WEAPON_NIGHTSTICK"] = 325,
			["WEAPON_PISTOL_AMMO"] = 14,
			["WEAPON_SMG_AMMO"] = 16,
			["WEAPON_RIFLE_AMMO"] = 18,
			["WEAPON_SHOTGUN_AMMO"] = 16,
			["badge01"] = 1500
		}
	},
	["weaponsStore"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["pistolbody"] = 425,
			["riflebody"] = 625,
			["smgbody"] = 525
		}
	},
	["ilegalToys"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["eraser"] = 40,
			["deck"] = 40,
			["dices"] = 20,
			["floppy"] = 30,
			["domino"] = 35,
			["horseshoe"] = 45,
			["legos"] = 45,
			["ominitrix"] = 45
		}
	},
	["ilegalHouse"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["lampshade"] = 60,
			["cup"] = 70,
			["switch"] = 20,
			["blender"] = 45,
			["mouse"] = 45,
			["pan"] = 70,
			["playstation"] = 50,
			["dish"] = 45,
			["keyboard"] = 45,
			["brick"] = 20,
			["fan"] = 45,
			["xbox"] = 50
		}
	},
	["ilegalCosmetics"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["goldring"] = 70,
			["silverring"] = 45,
			["spray02"] = 45,
			["bracelet"] = 50,
			["slipper"] = 40,
			["spray01"] = 45,
			["spray03"] = 45,
			["spray04"] = 45,
			["brush"] = 45,
			["watch"] = 50,
			["rimel"] = 45,
			["soap"] = 40,
			["sneakers"] = 60,
			["dildo"] = 45
		}
	},
	["ilegalCriminal"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["pliers"] = 40,
			["goldbar"] = 450,
			["card01"] = 275,
			["card02"] = 275,
			["card05"] = 315,
			["card03"] = 300,
			["card04"] = 225,
			["brokenpick"] = 40,
			["pager"] = 110,
			["pendrive"] = 275
		}
	},
	["mcFridge"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["dewars"] = 10,
			["chandon"] = 15,
			["hennessy"] = 13,
			["absolut"] = 11,
			["energetic"] = 15,
			["soda"] = 15,
			["cola"] = 15,
			["sandwich"] = 15,
			["fries"] = 15,
			["donut"] = 15
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTPERM
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestPerm(shopType)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getFines(user_id) > 0 then
			TriggerClientEvent("Notify",source,"amarelo","Multas pendentes encontradas.",3000)
			return false
		end

		if vRP.wantedReturn(user_id) then
			return false
		end

		if shops[shopType]["perm"] ~= nil then
			if not vRP.hasPermission(user_id,shops[shopType]["perm"]) then
				return false
			end
		end

		return true
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestShop(name)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local shopSlots = 20
		local inventoryShop = {}
		for k,v in pairs(shops[name]["list"]) do
			table.insert(inventoryShop,{ key = k, price = parseInt(v), name = itemName(k), index = itemIndex(k), peso = itemWeight(k), type = itemType(k), max = itemMaxAmount(k), desc = itemDescription(k), economy = itemEconomy(k) })
		end

		local inventoryUser = {}
		local inventory = vRP.userInventory(user_id)
		for k,v in pairs(inventory) do
			v["amount"] = parseInt(v["amount"])
			v["name"] = itemName(v["item"])
			v["peso"] = itemWeight(v["item"])
			v["index"] = itemIndex(v["item"])
			v["max"] = itemMaxAmount(v["item"])
			v["type"] = itemType(v["item"])
			v["desc"] = itemDescription(v["item"])
			v["economy"] = itemEconomy(v["item"])
			v["key"] = v["item"]
			v["slot"] = k

			local splitName = splitString(v["item"],"-")
			if splitName[2] ~= nil then
				v["durability"] = parseInt(os.time() - splitName[2])
				v["days"] = itemDurability(v["item"])
				v["serial"] = splitName[3]
			else
				v["durability"] = 0
				v["days"] = 1
			end

			inventoryUser[k] = v
		end

		if parseInt(#inventoryShop) > 20 then
			shopSlots = parseInt(#inventoryShop)
		end

		return inventoryShop,inventoryUser,vRP.inventoryWeight(user_id),vRP.getBackpack(user_id),shopSlots
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETSHOPTYPE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.getShopType(name)
    return shops[name]["mode"]
end---------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.functionShops(shopType,shopItem,shopAmount,slot)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if shopAmount == nil then shopAmount = 1 end
		if shopAmount <= 0 then shopAmount = 1 end

		local inventory = vRP.userInventory(user_id)
		if (inventory[tostring(slot)] and inventory[tostring(slot)]["item"] == shopItem) or inventory[tostring(slot)] == nil then
			if shops[shopType]["mode"] == "Buy" then
				if vRP.checkMaxItens(user_id,shopItem,shopAmount) then
					TriggerClientEvent("Notify",source,"amarelo","Limite atingido.",3000)
					vCLIENT.updateShops(source,"requestShop")
					return
				end

				if (vRP.inventoryWeight(user_id) + (itemWeight(shopItem) * parseInt(shopAmount))) <= vRP.getBackpack(user_id) then
					if shops[shopType]["type"] == "Cash" then
						if shops[shopType]["list"][shopItem] then
							if vRP.paymentFull(user_id,shops[shopType]["list"][shopItem] * shopAmount) then
								vRP.generateItem(user_id,shopItem,parseInt(shopAmount),false,slot)
								TriggerClientEvent("sounds:source",source,"cash",0.1)
							else
								TriggerClientEvent("Notify",source,"vermelho","Dólares insuficientes.",5000)
							end
						end
					elseif shops[shopType]["type"] == "Consume" then
						if vRP.tryGetInventoryItem(user_id,shops[shopType]["item"],parseInt(shops[shopType]["list"][shopItem] * shopAmount)) then
							vRP.generateItem(user_id,shopItem,parseInt(shopAmount),false,slot)
							TriggerClientEvent("sounds:source",source,"cash",0.1)
						else
							TriggerClientEvent("Notify",source,"vermelho","Insuficiente "..itemName(shops[shopType]["item"])..".",5000)
						end
					elseif shops[shopType]["type"] == "Premium" then
						if vRP.paymentGems(user_id,shops[shopType]["list"][shopItem] * shopAmount) then
							TriggerClientEvent("sounds:source",source,"cash",0.1)
							vRP.generateItem(user_id,shopItem,parseInt(shopAmount),false,slot)
							TriggerClientEvent("Notify",source,"verde","Comprou <b>"..parseFormat(shopAmount).."x "..itemName(shopItem).."</b> por <b>"..parseFormat(shops[shopType]["list"][shopItem] * shopAmount).." Gemas</b>.",5000)
						else
							TriggerClientEvent("Notify",source,"vermelho","Gemas Insuficientes.",5000)
						end
					end
				else
					TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
				end
			elseif shops[shopType]["mode"] == "Sell" then
				local splitName = splitString(shopItem,"-")

				if shops[shopType]["list"][splitName[1]] then
					if vRP.checkBroken(shopItem) then
						TriggerClientEvent("Notify",source,"vermelho","Itens quebrados não podem ser vendidos.",5000)
						vCLIENT.updateShops(source,"requestShop")
						return
					end

					if shops[shopType]["type"] == "Cash" then
						if vRP.tryGetInventoryItem(user_id,shopItem,parseInt(shopAmount),true,slot) then
							vRP.generateItem(user_id,"dollars",parseInt(shops[shopType]["list"][splitName[1]] * shopAmount),false)
							TriggerClientEvent("sounds:source",source,"cash",0.1)
						end
					elseif shops[shopType]["type"] == "Consume" then
						if vRP.tryGetInventoryItem(user_id,shopItem,parseInt(shopAmount),true,slot) then
							vRP.generateItem(user_id,shops[shopType]["item"],parseInt(shops[shopType]["list"][splitName[1]] * shopAmount),false)
							TriggerClientEvent("sounds:source",source,"cash",0.1)
						end
					end
				end
			end
		end

		vCLIENT.updateShops(source,"requestShop")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("shops:populateSlot")
AddEventHandler("shops:populateSlot",function(nameItem,slot,target,amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if amount == nil then amount = 1 end
		if amount <= 0 then amount = 1 end

		if vRP.tryGetInventoryItem(user_id,nameItem,amount,false,slot) then
			vRP.giveInventoryItem(user_id,nameItem,amount,false,target)
			vCLIENT.updateShops(source,"requestShop")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("shops:updateSlot")
AddEventHandler("shops:updateSlot",function(nameItem,slot,target,amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if amount == nil then amount = 1 end
		if amount <= 0 then amount = 1 end

		local inventory = vRP.userInventory(user_id)
		if inventory[tostring(slot)] and inventory[tostring(target)] and inventory[tostring(slot)]["item"] == inventory[tostring(target)]["item"] then
			if vRP.tryGetInventoryItem(user_id,nameItem,amount,false,slot) then
				vRP.giveInventoryItem(user_id,nameItem,amount,false,target)
			end
		else
			vRP.swapSlot(user_id,slot,target)
		end

		vCLIENT.updateShops(source,"requestShop")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:DIVINGSUIT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("shops:divingSuit")
AddEventHandler("shops:divingSuit",function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.request(source,"Comprar a <b>Roupa de Mergulho</b> pagando <b>$975</b>?",30) then
			if vRP.paymentFull(user_id,975) then
				vRP.generateItem(user_id,"divingsuit",1,true)
			else
				TriggerClientEvent("Notify",source,"vermelho","Dólares insuficientes.",5000)
			end
		end
	end
end)