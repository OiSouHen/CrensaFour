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
Tunnel.bindInterface("dynamic",cRP)
vSERVER = Tunnel.getInterface("dynamic")
vGARAGES = Tunnel.getInterface("garages")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local menuOpen = false
local policeService = false
local paramedicService = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANIMAL
-----------------------------------------------------------------------------------------------------------------------------------------
local animalHash = nil
local animalFollow = false
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
-- ADDBUTTON
-----------------------------------------------------------------------------------------------------------------------------------------
exports("AddButton",function(title,description,trigger,par,id,server)
	SendNUIMessage({ addbutton = true, title = title, description = description, trigger = trigger, par = par, id = id, server = server })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SUBMENU
-----------------------------------------------------------------------------------------------------------------------------------------
exports("SubMenu",function(title,description,id)
	SendNUIMessage({ addmenu = true, title = title, description = description, menuid = id })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENMENU
-----------------------------------------------------------------------------------------------------------------------------------------
exports("openMenu",function()
	SendNUIMessage({ show = true })
	SetNuiFocus(true,true)
	menuOpen = true
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLICKED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("clicked",function(data)
	if data["trigger"] then
		if data["server"] == "true" then
			TriggerServerEvent(data["trigger"],data["param"])
		else
			TriggerEvent(data["trigger"],data["param"])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("close",function()
	SetNuiFocus(false,false)
	menuOpen = false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DYNAMIC:CLOSESYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("dynamic:closeSystem")
AddEventHandler("dynamic:closeSystem",function()
	SendNUIMessage({ close = true })
	SetNuiFocus(false,false)
	menuOpen = false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GLOBALFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("globalFunctions",function(source,args,rawCommand)
	if not exports["player"]:blockCommands() and not exports["player"]:handCuff() and not menuOpen and MumbleIsConnected() then
		local ped = PlayerPedId()
		if GetEntityHealth(ped) > 101 then
			menuOpen = true

			exports["dynamic"]:AddButton("Chapéu","Colocar/Retirar o chapéu.","player:outfitFunctions","Hat","clothes",true)
			exports["dynamic"]:AddButton("Máscara","Colocar/Retirar a máscara.","player:outfitFunctions","Mask","clothes",true)
			exports["dynamic"]:AddButton("Óculos","Colocar/Retirar o óculos.","player:outfitFunctions","Glasses","clothes",true)
			exports["dynamic"]:AddButton("Jaqueta","Colocar/Retirar a jaqueta.","player:outfitFunctions","Jacket","clothes",true)
			exports["dynamic"]:AddButton("Camiseta","Colocar/Retirar a camiseta.","player:outfitFunctions","Shirt","clothes",true)
			exports["dynamic"]:AddButton("Luvas","Colocar/Retirar as luvas.","player:outfitFunctions","Arms","clothes",true)
			exports["dynamic"]:AddButton("Calças","Colocar/Retirar as calças.","player:outfitFunctions","Pants","clothes",true)
			exports["dynamic"]:AddButton("Sapatos","Colocar/Retirar os sapatos.","player:outfitFunctions","Shoes","clothes",true)
			exports["dynamic"]:AddButton("Colete","Colocar/Retirar o colete.","player:outfitFunctions","Vest","clothes",true)
			exports["dynamic"]:AddButton("Acessórios","Colocar/Retirar o acessório.","player:outfitFunctions","Accessory","clothes",true)
			exports["dynamic"]:AddButton("Todas","Retira todas as peças de roupa.","player:outfitFunctions","remover","clothes",true)

			exports["dynamic"]:AddButton("Aplicar Comum","Vestir as roupas comuns.","player:outfitFunctions","aplicar","outfit",true)
			exports["dynamic"]:AddButton("Salvar Comum","Salvar as roupas comuns.","player:outfitFunctions","salvar","outfit",true)
			exports["dynamic"]:AddButton("Aplicar Premium","Vestir as roupas premium.","player:outfitFunctions","preaplicar","outfit",true)
			exports["dynamic"]:AddButton("Salvar Premium","Salvar as roupas premium.","player:outfitFunctions","presalvar","outfit",true)

			if animalHash ~= nil then
				exports["dynamic"]:AddButton("Seguir","Seguir o proprietário.","dynamic:animalFunctions","seguir","animal",false)
				exports["dynamic"]:AddButton("Colocar no Veículo","Colocar o animal no veículo.","dynamic:animalFunctions","colocar","animal",false)
				exports["dynamic"]:AddButton("Remover do Veículo","Remover o animal no veículo.","dynamic:animalFunctions","remover","animal",false)
			end

			exports["dynamic"]:AddButton("Desmanche","Listagem dos veículos.","dismantle:invokeList","","others",true)
			exports["dynamic"]:AddButton("Ferimentos","Verificar ferimentos no corpo.","paramedic:myInjuries","","others",false)

			if not IsPedInAnyVehicle(ped) then
				exports["dynamic"]:AddButton("Rebocar","Colocar veículo na prancha do reboque.","towdriver:invokeTow","","others",false)
				exports["dynamic"]:AddButton("Desbugar","Recarregar o personagem.","barbershop:debug","","others",true)

				exports["dynamic"]:AddButton("Trancar","Trancar a propriedade.","homes:invokeSystem","trancar","propertys",true)
				exports["dynamic"]:AddButton("Garagem","Comprar garagem da propriedade.","homes:invokeSystem","garagem","propertys",true)
				exports["dynamic"]:AddButton("Permissões","Checar permissões da propriedade.","homes:invokeSystem","checar","propertys",true)
				exports["dynamic"]:AddButton("Taxas","Pagar as taxas da propriedade.","homes:invokeSystem","tax","propertys",true)
				exports["dynamic"]:AddButton("Armário","Aumentar o armário da propriedade.","homes:invokeSystem","armario","propertys",true)
				exports["dynamic"]:AddButton("Geladeira","Aumentar a galadeira da propriedade.","homes:invokeSystem","geladeira","propertys",true)
				exports["dynamic"]:AddButton("Vender","Vender a propriedade.","homes:invokeSystem","vender","propertys",true)

				exports["dynamic"]:AddButton("Colocar no Veículo","Colocar no veículo mais próximo.","player:cvFunctions","cv","otherPlayers",true)
				exports["dynamic"]:AddButton("Remover do Veículo","Remover do veículo mais próximo.","player:cvFunctions","rv","otherPlayers",true)
				exports["dynamic"]:AddButton("Checar Porta-Malas","Vericar pessoa dentro do mesmo.","player:checkTrunk","","otherPlayers",true)
				exports["dynamic"]:AddButton("Checar Lixeira","Vericar pessoa dentro da mesma.","player:checkTrash","","otherPlayers",true)

				exports["dynamic"]:SubMenu("Jogador","Pessoa mais próxima de você.","otherPlayers")
			else
				exports["dynamic"]:AddButton("Banco Dianteiro Esquerdo","Sentar no banco do motorista.","player:seatPlayer","0","vehicle",false)
				exports["dynamic"]:AddButton("Banco Dianteiro Direito","Sentar no banco do passageiro.","player:seatPlayer","1","vehicle",false)
				exports["dynamic"]:AddButton("Banco Traseiro Esquerdo","Sentar no banco do passageiro.","player:seatPlayer","2","vehicle",false)
				exports["dynamic"]:AddButton("Banco Traseiro Direito","Sentar no banco do passageiro.","player:seatPlayer","3","vehicle",false)
				exports["dynamic"]:AddButton("Levantar Vidros","Levantar todos os vidros.","player:winsFunctions","1","vehicle",true)
				exports["dynamic"]:AddButton("Abaixar Vidros","Abaixar todos os vidros.","player:winsFunctions","0","vehicle",true)

				exports["dynamic"]:SubMenu("Veículo","Funções do veículo.","vehicle")
			end

			exports["dynamic"]:AddButton("Propriedades","Ativa/Desativa as propriedades no mapa.","homes:togglePropertys","","propertys",false)

			exports["dynamic"]:SubMenu("Roupas","Colocar/Retirar roupas.","clothes")
			exports["dynamic"]:SubMenu("Vestuário","Mudança de roupas rápidas.","outfit")
			exports["dynamic"]:SubMenu("Propriedades","Todas as funções das propriedades.","propertys")

			if animalHash ~= nil then
				exports["dynamic"]:SubMenu("Domésticos","Todas as funções dos animais domésticos.","animal")
			end

			exports["dynamic"]:SubMenu("Outros","Todas as funções do personagem.","others")

			exports["dynamic"]:openMenu()
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- EMERGENCYFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("emergencyFunctions",function(source,args,rawCommand)
	if policeService or paramedicService then
		if not exports["player"]:blockCommands() and not exports["player"]:handCuff() and not menuOpen and MumbleIsConnected() then

			local ped = PlayerPedId()
			if GetEntityHealth(ped) > 101 then
				menuOpen = true

				exports["dynamic"]:AddButton("Serviço","Verificar companheiros em serviço.","player:servicoFunctions","","utilitys",true)

				if not IsPedInAnyVehicle(ped) then
					exports["dynamic"]:AddButton("Carregar pelos Braços","Carregar a pessoa mais próxima.","player:carryFunctions","bracos","player",true)
					exports["dynamic"]:AddButton("Carregar nos Ombros","Carregar a pessoa mais próxima.","player:carryFunctions","ombros","player",true)
					exports["dynamic"]:AddButton("Colocar no Veículo","Colocar no veículo mais próximo.","player:cvFunctions","cv","player",true)
					exports["dynamic"]:AddButton("Remover do Veículo","Remover do veículo mais próximo.","player:cvFunctions","rv","player",true)

					exports["dynamic"]:SubMenu("Jogador","Pessoa mais próxima de você.","player")
				end

				if policeService then
					exports["dynamic"]:AddButton("Computador","Abrir o dispositivo móvel.","police:openSystem","","utilitys",false)
					exports["dynamic"]:AddButton("Barreira","Colocar barreira na frente.","police:insertBarrier","","utilitys",false)
					exports["dynamic"]:AddButton("Invadir","Invadir a residência.","homes:invadeSystem","","utilitys",true)

					exports["dynamic"]:AddButton("Remover Chapéu","Remover da pessoa mais próxima.","skinshop:removeProps","hat","player",true)
					exports["dynamic"]:AddButton("Remover Máscara","Remover da pessoa mais próxima.","skinshop:removeProps","mask","player",true)

					exports["dynamic"]:AddButton("Policia","Fardamento de manga longa.","player:presetFunctions","1","prePolice",true)
					exports["dynamic"]:AddButton("Policia","Fardamento de manga curta.","player:presetFunctions","2","prePolice",true)

					exports["dynamic"]:SubMenu("Fardamentos","Todos os fardamentos policiais.","prePolice")
					exports["dynamic"]:SubMenu("Utilidades","Todas as funções dos policiais.","utilitys")
				elseif paramedicService then
					exports["dynamic"]:AddButton("Medical Center","Fardamento de doutor.","player:presetFunctions","3","preMedic",true)
					exports["dynamic"]:AddButton("Medical Center","Fardamento de paramédico.","player:presetFunctions","4","preMedic",true)
					exports["dynamic"]:AddButton("Medical Center","Fardamento de paramédico interno.","player:presetFunctions","5","preMedic",true)

					exports["dynamic"]:SubMenu("Fardamentos","Todos os fardamentos médicos.","preMedic")
					exports["dynamic"]:SubMenu("Utilidades","Todas as funções dos paramédicos.","utilitys")
				end

				exports["dynamic"]:openMenu()
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYMAPPING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("globalFunctions","Abrir menu principal.","keyboard","F9")
RegisterKeyMapping("emergencyFunctions","Abrir menu de emergencial.","keyboard","F10")
-----------------------------------------------------------------------------------------------------------------------------------------
-- DYNAMIC:ANIMALSPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("dynamic:animalSpawn")
AddEventHandler("dynamic:animalSpawn",function(model)
	if animalHash == nil then
		local ped = PlayerPedId()
		local mHash = GetHashKey(model)

		RequestModel(mHash)
		while not HasModelLoaded(mHash) do
			Citizen.Wait(1)
		end

		local coords = GetOffsetFromEntityInWorldCoords(ped,0.0,1.0,0.0)
		animalHash = CreatePed(28,mHash,coords["x"],coords["y"],coords["z"] - 1,GetEntityHeading(ped),0,1)

		SetPedCanRagdoll(animalHash,false)
		SetEntityInvincible(animalHash,true)
		SetPedFleeAttributes(animalHash,0,0)
		SetBlockingOfNonTemporaryEvents(animalHash,true)
		SetPedRelationshipGroupHash(animalHash,GetHashKey("k9"))
		GiveWeaponToPed(animalHash,GetHashKey("WEAPON_ANIMAL"),200,true,true)

		NetworkRegisterEntityAsNetworked(animalHash)
		while not NetworkGetEntityIsNetworked(animalHash) do
			NetworkRegisterEntityAsNetworked(animalHash)
			Citizen.Wait(1)
		end

		TriggerEvent("dynamic:animalFunctions","seguir")

		vSERVER.animalRegister(NetworkGetNetworkIdFromEntity(animalHash))
	else
		vSERVER.animalCleaner()
		animalFollow = false
		animalHash = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DYNAMIC:ANIMALFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("dynamic:animalFunctions")
AddEventHandler("dynamic:animalFunctions",function(functions)
	if animalHash ~= nil then
		local ped = PlayerPedId()

		if functions == "seguir" then
			if not animalFollow then
				TaskFollowToOffsetOfEntity(animalHash,ped,1.0,1.0,0.0,5.0,-1,2.5,1)
				SetPedKeepTask(animalHash,true)
				animalFollow = true
			else
				SetPedKeepTask(animalHash,false)
				ClearPedTasks(animalHash)
				animalFollow = false
			end
		elseif functions == "colocar" then
			if IsPedInAnyVehicle(ped) and not IsPedOnAnyBike(ped) then
				local vehicle = GetVehiclePedIsUsing(ped)
				if IsVehicleSeatFree(vehicle,0) then
					TaskEnterVehicle(animalHash,vehicle,-1,0,2.0,16,0)
				end
			end
		elseif functions == "remover" then
			if IsPedInAnyVehicle(ped) and not IsPedOnAnyBike(ped) then
				TaskLeaveVehicle(animalHash,GetVehiclePedIsUsing(ped),256)
				TriggerEvent("dynamic:animalFunctions","seguir")
			end
		elseif functions == "deletar" then
			vSERVER.animalCleaner()
			animalFollow = false
			animalHash = nil
		end
	end
end)