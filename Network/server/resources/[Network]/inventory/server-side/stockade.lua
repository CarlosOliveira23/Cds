-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
Stockades = {}
local Cooldown = os.time() + 3600
local Value = math.random(12000,15000)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:STOCKADE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Stockade")
AddEventHandler("inventory:Stockade",function(Vehicle)
	local source = source
	local Plate = Vehicle[1]
	local Passport = vRP.Passport(source)
	local Service,Total = vRP.NumPermission("Police")
	if not Active[Passport] then
		if not vRP.PassportPlate(Plate) then
			if Total >= 1 then
				vRPC.playAnim(source,false,{ "anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer" },true)
				TriggerClientEvent("Notify",source,"amarelo","Roube 5 Vezes até o Cofre Ficar Vazio!.",10000)
				
				if vTASKBAR.taskLockpick(source) then
					if not Stockades[Plate] then
						Stockades[Plate] = 2
						Cooldown = os.time() + 3600

						local Coords = vRP.GetEntityCoords(source)
						local Service = vRP.NumPermission("Police")
						for Passports,Sources in pairs(Service) do
							async(function()
								TriggerClientEvent("sounds:Private",Sources,"crime",0.5)
								TriggerClientEvent("NotifyPush",Sources,{ code = 31, title = "Roubo a Carro Forte", x = Coords["x"], y = Coords["y"], z = Coords["z"], color = 44, red = true })
							end)
						end
					end

					if Stockades[Plate] <= 0 then
						TriggerClientEvent("Notify",source,"amarelo","Compartimento vazio.",5000)
						vRPC.Destroy(source)
						return false
					end

					if not vCLIENT.checkWeapon(source,"WEAPON_CROWBAR") then
						TriggerClientEvent("Notify",source,"amarelo","Coloque o <b>Pé de Cabra</b> equipado na sua mão.",10000)
						vRPC.Destroy(source)
						return
					end

					Active[Passport] = os.time() + 10
					Stockades[Plate] = Stockades[Plate] - 1
					Player(source)["state"]["Buttons"] = true
					TriggerClientEvent("Progress",source,"Roubando",10000)
					vRPC.playAnim(source,false,{"oddjobs@shop_robbery@rob_till","loop"},true)

					repeat
						if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
							Active[Passport] = nil
							vRPC.Destroy(source)
							Player(source)["state"]["Buttons"] = false

							if math.random(100) >= 50 then
								vRP.GenerateItem(Passport,"dollarsroll",Value,true)
							else
								vRP.GenerateItem(Passport,"dollars",Value,true)
							end
							
						end

						Wait(100)
					until not Active[Passport]
				else
					vRPC.Destroy(source)
				end
			else
				TriggerClientEvent("Notify", source, "vermelho", "Contingente indisponível.", 5000)
			end
		else
			TriggerClientEvent("Notify", source, "amarelo", "Veículo protegido pela seguradora.",5000)
		end
	end
end)