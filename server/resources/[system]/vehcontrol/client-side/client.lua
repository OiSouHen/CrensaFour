---------------------------------------------------------------------
local count_bcast_timer = 0
local delay_bcast_timer = 1000
---------------------------------------------------------------------
local count_sndclean_timer = 0
---------------------------------------------------------------------
local actv_lxsrnmute_temp = false
local srntone_temp = 0
local dsrn_mute = true
---------------------------------------------------------------------
local state_lxsiren = {}
local state_airmanu = {}
---------------------------------------------------------------------
local snd_lxsiren = {}
local snd_airmanu = {}
---------------------------------------------------------------------
local eModelsWithFireSrn = {
	"FIRETRUK"
}
---------------------------------------------------------------------
local eModelsWithPcall = {
	"AMBULANCE",
	"FIRETRUK",
	"LGUARD"
}
---------------------------------------------------------------------
function useFiretruckSiren(veh)
	local model = GetEntityModel(veh)
	for i = 1,#eModelsWithFireSrn,1 do
		if model == GetHashKey(eModelsWithFireSrn[i]) then
			return true
		end
	end

	return false
end
---------------------------------------------------------------------
function TogMuteDfltSrnForVeh(veh,toggle)
	if DoesEntityExist(veh) and not IsEntityDead(veh) then
		DisableVehicleImpactExplosionActivation(veh,toggle)
	end
end
---------------------------------------------------------------------
function SetLxSirenStateForVeh(veh,newstate)
	if DoesEntityExist(veh) and not IsEntityDead(veh) then
		if newstate ~= state_lxsiren[veh] then
			if snd_lxsiren[veh] ~= nil then
				StopSound(snd_lxsiren[veh])
				ReleaseSoundId(snd_lxsiren[veh])
				snd_lxsiren[veh] = nil
			end

			if newstate == 1 then
				snd_lxsiren[veh] = GetSoundId()	
				PlaySoundFromEntity(snd_lxsiren[veh],"RESIDENT_VEHICLES_SIREN_WAIL_03",veh,0,0,0)
				TogMuteDfltSrnForVeh(veh,true)
			elseif newstate == 2 then
				snd_lxsiren[veh] = GetSoundId()
				PlaySoundFromEntity(snd_lxsiren[veh],"RESIDENT_VEHICLES_SIREN_QUICK_03",veh,0,0,0)
				TogMuteDfltSrnForVeh(veh,true)
			elseif newstate == 3 then
				snd_lxsiren[veh] = GetSoundId()
				PlaySoundFromEntity(snd_lxsiren[veh],"RESIDENT_VEHICLES_SIREN_FIRETRUCK_QUICK_01",veh,0,0,0)
				TogMuteDfltSrnForVeh(veh,true)
			elseif newstate == 4 then
				snd_lxsiren[veh] = GetSoundId()
				PlaySoundFromEntity(snd_lxsiren[veh],"RESIDENT_VEHICLES_SIREN_WAIL_01",veh,0,0,0)
				TogMuteDfltSrnForVeh(veh,true)
			elseif newstate == 5 then
				snd_lxsiren[veh] = GetSoundId()
				PlaySoundFromEntity(snd_lxsiren[veh],"RESIDENT_VEHICLES_SIREN_WAIL_02",veh,0,0,0)
				TogMuteDfltSrnForVeh(veh,true)
			elseif newstate == 6 then
				snd_lxsiren[veh] = GetSoundId()
				PlaySoundFromEntity(snd_lxsiren[veh],"RESIDENT_VEHICLES_SIREN_QUICK_01",veh,0,0,0)
				TogMuteDfltSrnForVeh(veh,true)
			elseif newstate == 7 then
				snd_lxsiren[veh] = GetSoundId()
				PlaySoundFromEntity(snd_lxsiren[veh],"RESIDENT_VEHICLES_SIREN_QUICK_02",veh,0,0,0)
				TogMuteDfltSrnForVeh(veh,true)
			else
				TogMuteDfltSrnForVeh(veh,true)
			end

			state_lxsiren[veh] = newstate
		end
	end
end
---------------------------------------------------------------------
function SetAirManuStateForVeh(veh,newstate)
	if DoesEntityExist(veh) and not IsEntityDead(veh) then
		if newstate ~= state_airmanu[veh] then
			if snd_airmanu[veh] ~= nil then
				StopSound(snd_airmanu[veh])
				ReleaseSoundId(snd_airmanu[veh])
				snd_airmanu[veh] = nil
			end

			if newstate == 1 then
				snd_airmanu[veh] = GetSoundId()
				PlaySoundFromEntity(snd_airmanu[veh],"RESIDENT_VEHICLES_SIREN_WAIL_03",veh,0,0,0)
			elseif newstate == 2 then
				snd_airmanu[veh] = GetSoundId()
				PlaySoundFromEntity(snd_airmanu[veh],"RESIDENT_VEHICLES_SIREN_QUICK_03",veh,0,0,0)
			elseif newstate == 3 then
				snd_airmanu[veh] = GetSoundId()
				PlaySoundFromEntity(snd_airmanu[veh],"RESIDENT_VEHICLES_SIREN_FIRETRUCK_QUICK_01",veh,0,0,0)
			elseif newstate == 4 then
				snd_airmanu[veh] = GetSoundId()
				PlaySoundFromEntity(snd_airmanu[veh],"RESIDENT_VEHICLES_SIREN_WAIL_01",veh,0,0,0)
			elseif newstate == 5 then
				snd_airmanu[veh] = GetSoundId()
				PlaySoundFromEntity(snd_airmanu[veh],"RESIDENT_VEHICLES_SIREN_WAIL_02",veh,0,0,0)
			elseif newstate == 6 then
				snd_airmanu[veh] = GetSoundId()
				PlaySoundFromEntity(snd_airmanu[veh],"RESIDENT_VEHICLES_SIREN_QUICK_01",veh,0,0,0)
			elseif newstate == 7 then
				snd_airmanu[veh] = GetSoundId()
				PlaySoundFromEntity(snd_airmanu[veh],"RESIDENT_VEHICLES_SIREN_QUICK_02",veh,0,0,0)
			end

			state_airmanu[veh] = newstate
		end
	end
end
---------------------------------------------------------------------
RegisterNetEvent("lvc_TogDfltSrnMuted_c")
AddEventHandler("lvc_TogDfltSrnMuted_c",function(sender,toggle)
	local player = GetPlayerFromServerId(sender)
	local ped = GetPlayerPed(player)
	if DoesEntityExist(ped) and not IsEntityDead(ped) then
		if ped ~= PlayerPedId() then
			if IsPedInAnyVehicle(ped) then
				local veh = GetVehiclePedIsUsing(ped)
				TogMuteDfltSrnForVeh(veh,toggle)
			end
		end
	end
end)
---------------------------------------------------------------------
RegisterNetEvent("lvc_SetLxSirenState_c")
AddEventHandler("lvc_SetLxSirenState_c",function(sender,newstate)
	local player = GetPlayerFromServerId(sender)
	local ped = GetPlayerPed(player)
	if DoesEntityExist(ped) and not IsEntityDead(ped) then
		if ped ~= PlayerPedId() then
			if IsPedInAnyVehicle(ped) then
				local veh = GetVehiclePedIsUsing(ped)
				SetLxSirenStateForVeh(veh,newstate)
			end
		end
	end
end)
---------------------------------------------------------------------
RegisterNetEvent("lvc_SetAirManuState_c")
AddEventHandler("lvc_SetAirManuState_c",function(sender,newstate)
	local player = GetPlayerFromServerId(sender)
	local ped = GetPlayerPed(player)
	if DoesEntityExist(ped) and not IsEntityDead(ped) then
		if ped ~= PlayerPedId() then
			if IsPedInAnyVehicle(ped) then
				local veh = GetVehiclePedIsUsing(ped)
				SetAirManuStateForVeh(veh,newstate)
			end
		end
	end
end)
---------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		if count_sndclean_timer > 400 then
			count_sndclean_timer = 0

			for k, v in pairs(state_lxsiren) do
				if v > 0 then
					if not DoesEntityExist(k) or IsEntityDead(k) then
						if snd_lxsiren[k] ~= nil then
							StopSound(snd_lxsiren[k])
							ReleaseSoundId(snd_lxsiren[k])
							snd_lxsiren[k] = nil
							state_lxsiren[k] = nil
						end
					end
				end
			end

			for k, v in pairs(state_airmanu) do
				if v then
					if not DoesEntityExist(k) or IsEntityDead(k) or IsVehicleSeatFree(k,-1) then
						if snd_airmanu[k] ~= nil then
							StopSound(snd_airmanu[k])
							ReleaseSoundId(snd_airmanu[k])
							snd_airmanu[k] = nil
							state_airmanu[k] = nil
						end
					end
				end
			end
		else
			count_sndclean_timer = count_sndclean_timer + 1
		end

		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			local veh = GetVehiclePedIsUsing(ped)
			if GetPedInVehicleSeat(veh,-1) == ped then
				if GetVehicleClass(veh) == 18 then
					timeDistance = 1
					local actv_manu = false
					local actv_horn = false

					SetVehRadioStation(veh,"OFF")
					DisableControlAction(1,86,true)
					DisableControlAction(1,19,true)
					DisableControlAction(1,85,true)
					DisableControlAction(1,80,true)
					SetVehicleRadioEnabled(veh,false)

					if state_lxsiren[veh] ~= 1 and state_lxsiren[veh] ~= 2 and state_lxsiren[veh] ~= 3 and state_lxsiren[veh] ~= 4 and state_lxsiren[veh] ~= 5 and state_lxsiren[veh] ~= 6 and state_lxsiren[veh] ~= 7 then
						state_lxsiren[veh] = 0
					end

					if state_airmanu[veh] ~= 1 and state_airmanu[veh] ~= 2 and state_airmanu[veh] ~= 3 and state_airmanu[veh] ~= 4 and state_airmanu[veh] ~= 5 and state_airmanu[veh] ~= 6 and state_airmanu[veh] ~= 7 then
						state_airmanu[veh] = 0
					end

					if useFiretruckSiren(veh) and state_lxsiren[veh] == 1 then
						TogMuteDfltSrnForVeh(veh,false)
						dsrn_mute = false
					else
						TogMuteDfltSrnForVeh(veh,true)
						dsrn_mute = true
					end

					if not IsVehicleSirenOn(veh) and state_lxsiren[veh] > 0 then
						SetLxSirenStateForVeh(veh,0)
						count_bcast_timer = delay_bcast_timer
					end

					if not IsPauseMenuActive() then
						if IsDisabledControlJustReleased(0,85) then
							if IsVehicleSirenOn(veh) then
								SetVehicleSiren(veh,false)
							else
								SetVehicleSiren(veh,true)
								count_bcast_timer = delay_bcast_timer
							end
						elseif IsDisabledControlJustReleased(0,19) then
							local cstate = state_lxsiren[veh]
							if cstate == 0 then
								if IsVehicleSirenOn(veh) then
									SetLxSirenStateForVeh(veh,1)
									count_bcast_timer = delay_bcast_timer
								end
							else
								SetLxSirenStateForVeh(veh,0)
								count_bcast_timer = delay_bcast_timer
							end
						end

						if state_lxsiren[veh] > 0 then
							if IsDisabledControlJustReleased(0,80) then
								if IsVehicleSirenOn(veh) then
									local cstate = state_lxsiren[veh]
									local nstate = 1

									if cstate == 1 then
										nstate = 2
									elseif cstate == 2 then
										nstate = 3
									elseif cstate == 3 then
										nstate = 4
									elseif cstate == 4 then
										nstate = 5
									elseif cstate == 5 then
										nstate = 6
									elseif cstate == 6 then
										nstate = 7
									else	
										nstate = 1
									end
									SetLxSirenStateForVeh(veh,nstate)
									count_bcast_timer = delay_bcast_timer
								end
							end
						end

						if state_lxsiren[veh] < 1 then
							if IsDisabledControlPressed(1,80) then
								actv_manu = true
							else
								actv_manu = false
							end
						else
							actv_manu = false
						end

						if IsDisabledControlPressed(1,86) then
							actv_horn = true
						else
							actv_horn = false
						end
					end

					local hmanu_state_new = 0
					if actv_horn and not actv_manu then
						hmanu_state_new = 1
					elseif not actv_horn and actv_manu then
						hmanu_state_new = 2
					elseif actv_horn and actv_manu then
						hmanu_state_new = 3
					end

					if hmanu_state_new == 1 then
						if not useFiretruckSiren(veh) then
							if state_lxsiren[veh] > 0 and not actv_lxsrnmute_temp then
								srntone_temp = state_lxsiren[veh]
								SetLxSirenStateForVeh(veh,0)
								actv_lxsrnmute_temp = true
							end
						end
					else
						if not useFiretruckSiren(veh) then
							if actv_lxsrnmute_temp then
								SetLxSirenStateForVeh(veh,srntone_temp)
								actv_lxsrnmute_temp = false
							end
						end
					end

					if state_airmanu[veh] ~= hmanu_state_new then
						SetAirManuStateForVeh(veh, hmanu_state_new)
						count_bcast_timer = delay_bcast_timer
					end

					if count_bcast_timer > delay_bcast_timer then
						local playerAround = {}
						for _,player in ipairs(GetActivePlayers()) do
							playerAround[#playerAround + 1] = GetPlayerServerId(player)
						end

						count_bcast_timer = 0

						TriggerServerEvent("lvc_TogDfltSrnMuted_s",dsrn_mute,playerAround)
						TriggerServerEvent("lvc_SetLxSirenState_s",state_lxsiren[veh],playerAround)
						TriggerServerEvent("lvc_SetAirManuState_s",state_airmanu[veh],playerAround)
					else
						count_bcast_timer = count_bcast_timer + 1
					end
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)