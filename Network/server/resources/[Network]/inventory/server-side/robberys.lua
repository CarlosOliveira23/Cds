-----------------------------------------------------------------------------------------------------------------------------------------
-- BANKS
-----------------------------------------------------------------------------------------------------------------------------------------
local BanksPermission = "Police" and "Core"
local BanksRadio = "701"
local BanksNeed = 1
local BanksItem = "gold_pure"
local BanksAmount = math.random(150, 300)
local BankshopRequired = "card05"
local BankshopRequiredAmount = 1
-----------------------------------------------------------------------------------------------------------------------------------------
-- BARBERSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
local BarbershopPermission = "Police" and "Core" and "Core"
local BarbershopRadio = "601"
local BarbershopNeed = 0
local BarbershopItem = "dollarsroll"
local BarbershopAmount = math.random(5000, 6000)
local BarbershopRequired = "card04"
local BarbershopRequiredAmount = 1
-----------------------------------------------------------------------------------------------------------------------------------------
-- tattos
-----------------------------------------------------------------------------------------------------------------------------------------
local TattoosPermission = "Police" and "Core"
local TattoosRadio = "101"
local TattoosNeed = 1
local TattoosItem = "dollarsroll"
local TattoosAmount = math.random(5000, 6000)
local TattoosRequired = "card02"
local TattoosRequiredAmount = 1
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOTHES
-----------------------------------------------------------------------------------------------------------------------------------------
local ClothePermission = "Police" and "Core"
local ClotheRadio = "101"
local ClotheNeed = 3
local ClotheItem = "dollarsroll"
local ClotheAmount = math.random(5000, 6000)
local ClotheRequired = "card02"
local ClotheRequiredAmount = 1
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
local WeaponPermission = "Police" and "Core"
local WeaponRadio = "101"
local WeaponNeed = 3
local WeaponItem = "dollarsroll"
local WeaponAmount = math.random(5000, 6000)
local WeaponRequired = "card02"
local WeaponRequiredAmount = 1
-----------------------------------------------------------------------------------------------------------------------------------------
-- FLEECAS
-----------------------------------------------------------------------------------------------------------------------------------------
local FleecasPermission = "Police" and "Core"
local FleecasRadio = "301"
local FleecasNeed = 1
local FleecasItem = "dollarsroll"
local FleecasAmount = math.random(7000, 14000)
local FleecasRequired = "card03"
local FleecasRequiredAmount = 1
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEPARTMENT
-----------------------------------------------------------------------------------------------------------------------------------------
local DepartmentPermission = "Police" and "Core"
local DepartmentRadio = "401"
local DepartmentNeed = 1
local DepartmentItem = "dollarsroll"
local DepartmentAmount = math.random(5000, 6000)
local DepartmentRequired = "card01"
local DepartmentRequiredAmount = 1
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:ROBBERYS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Robberys")
AddEventHandler("inventory:Robberys", function(Type)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		if not RobberyType[Type] then
			RobberyType[Type] = os.time()
		end

		if os.time() >= RobberyType[Type] then
			if Type == "banks" then
				local Service, Total = vRP.NumPermission(BanksPermission)
				if Total >= BarbershopNeed then
					local Consult = vRP.InventoryItemAmount(Passport, BankshopRequired)
					if Consult[1] >= BankshopRequiredAmount then
						if vRP.Device(source, 30) then
							TriggerClientEvent("Notify", source, "azul","Rádio da Negociação: <b>" .. BanksRadio .. "</b>", 10000)

							local Coords = vRP.GetEntityCoords(source)
							for Passports, Sources in pairs(Service) do
								async(function()
									TriggerClientEvent("sounds:Private", Sources, "crime", 0.5)

									TriggerClientEvent("NotifyPush", Sources, { code = 31, title = "Roubo ao Banco", x = Coords["x"], y = Coords["y"], z = Coords["z"], criminal = "Rádio da Negociação: " .. BanksRadio, blipColor = 22 })
								end)
							end

							vRPC.AnimActive(source)

							Active[Passport] = os.time() + 30
							RobberyType[Type] = os.time() + 3600
							TriggerClientEvent("Progress", source, "Roubando", 30000)

							Player(source)["state"]["Buttons"] = true
							TriggerClientEvent("inventory:Close", source)
							vRPC.playAnim(source, false, { "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer" }, true)

							repeat
								if os.time() >= parseInt(Active[Passport]) then
									Active[Passport] = nil

									TriggerEvent("Wanted", source, Passport, 300)
									vRP.GenerateItem(Passport, BanksItem, BanksAmount, true)
									TriggerClientEvent("player:Residuals", source, "Resíduo de Arrombamento.")

									vRPC.stopAnim(source, false)
									vRP.UpgradeStress(Passport, math.random(2))
									Player(source)["state"]["Buttons"] = false
								end

								Wait(100)
							until not Active[Passport]
						else
							RobberyType[Type] = os.time() + 30
						end
					else
						TriggerClientEvent("Notify", source, "amarelo", "Você precisa colocar o <b>" .. itemName(BanksWeaponRequired) .. "</b> em mãos.", 5000)
					end
				else
					TriggerClientEvent("Notify", source, "amarelo", "Contingente indisponível.", 5000)
				end
			elseif Type == "barbershop" then
				local Service, Total = vRP.NumPermission(BarbershopPermission)
				if Total >= BarbershopNeed then
					local Consult = vRP.InventoryItemAmount(Passport, BarbershopRequired)
					if Consult[1] >= BarbershopRequiredAmount then
						if not vRP.CheckDamaged(Consult[2]) then
							if vRP.Device(source, 30) then
								if vRP.TakeItem(Passport, Consult[2], BarbershopRequiredAmount, true) then
									TriggerClientEvent("Notify", source, "azul","Rádio da Negociação: <b>" .. BarbershopRadio .. "</b>", 10000)

									local Coords = vRP.GetEntityCoords(source)
									for Passports, Sources in pairs(Service) do
										async(function()
											TriggerClientEvent("sounds:Private", Sources, "crime", 0.5)

											TriggerClientEvent("NotifyPush", Sources, { code = 31, title = "Roubo a Barbearia", x = Coords["x"], y = Coords["y"], z = Coords["z"], criminal = "Rádio da Negociação: " .. BarbershopRadio, blipColor = 22 })
										end)
									end

									vRPC.AnimActive(source)

									Active[Passport] = os.time() + 30
									RobberyType[Type] = os.time() + 3600
									TriggerClientEvent("Progress", source, "Roubando", 30000)

									Player(source)["state"]["Buttons"] = true
									TriggerClientEvent("inventory:Close", source)
									vRPC.playAnim(source, false, { "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer" }, true)

									repeat
										if os.time() >= parseInt(Active[Passport]) then
											Active[Passport] = nil

											TriggerEvent("Wanted", source, Passport, 300)
											vRP.GenerateItem(Passport, BarbershopItem, BarbershopAmount, true)
											TriggerClientEvent("player:Residuals", source, "Resíduo de Arrombamento.")

											vRPC.stopAnim(source, false)
											vRP.UpgradeStress(Passport, math.random(2))
											Player(source)["state"]["Buttons"] = false
										end

										Wait(100)
									until not Active[Passport]
								end
							else
								RobberyType[Type] = os.time() + 30
							end
						else
							TriggerClientEvent("Notify", source, "vermelho", "<b>" .. itemName(BarbershopRequired) .. "</b> danificado.", 5000)
						end
					else
						TriggerClientEvent("Notify", source, "amarelo", "Precisa de <b>" .. parseInt(BarbershopRequiredAmount) .. "x " .. itemName(BarbershopRequired) .. "</b>.", 5000)
					end
				else
					TriggerClientEvent("Notify", source, "amarelo", "Contingente indisponível.", 5000)
				end
			elseif Type == "tattooshop" then
				local Service, Total = vRP.NumPermission(TattoosPermission)
				if Total >= TattoosNeed then
					local Consult = vRP.InventoryItemAmount(Passport, TattoosRequired)
					if Consult[1] >= TattoosRequiredAmount then
						if not vRP.CheckDamaged(Consult[2]) then
							if vRP.Device(source, 30) then
								if vRP.TakeItem(Passport, Consult[2], TattoosRequiredAmount, true) then
									TriggerClientEvent("Notify", source, "azul","Rádio da Negociação: <b>" .. TattoosRadio .. "</b>", 10000)

									local Coords = vRP.GetEntityCoords(source)
									for Passports, Sources in pairs(Service) do
										async(function()
											TriggerClientEvent("sounds:Private", Sources, "crime", 0.5)

											TriggerClientEvent("NotifyPush", Sources, { code = 31, title = "Roubo a Tatuagem", x = Coords["x"], y = Coords["y"], z = Coords["z"], criminal = "Rádio da Negociação: " .. TattoosRadio, blipColor = 22 })
										end)
									end

									vRPC.AnimActive(source)

									Active[Passport] = os.time() + 30
									RobberyType[Type] = os.time() + 3600
									TriggerClientEvent("Progress", source, "Roubando", 30000)

									Player(source)["state"]["Buttons"] = true
									TriggerClientEvent("inventory:Close", source)
									vRPC.playAnim(source, false, { "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer" }, true)

									repeat
										if os.time() >= parseInt(Active[Passport]) then
											Active[Passport] = nil

											TriggerEvent("Wanted", source, Passport, 300)
											vRP.GenerateItem(Passport, TattoosItem, TattoosAmount, true)
											TriggerClientEvent("player:Residuals", source, "Resíduo de Arrombamento.")

											vRPC.stopAnim(source, false)
											vRP.UpgradeStress(Passport, math.random(2))
											Player(source)["state"]["Buttons"] = false
										end

										Wait(100)
									until not Active[Passport]
								end
							else
								RobberyType[Type] = os.time() + 30
							end
						else
							TriggerClientEvent("Notify", source, "vermelho", "<b>" .. itemName(TattoosRequired) .. "</b> danificado.", 5000)
						end
					else
						TriggerClientEvent("Notify", source, "amarelo", "Precisa de <b>" .. parseInt(TattoosRequiredAmount) .. "x " .. itemName(TattoosRequired) .. "</b>.", 5000)
					end
				else
					TriggerClientEvent("Notify", source, "amarelo", "Contingente indisponível.", 5000)
				end
			elseif Type == "clotheshop" then
				local Service, Total = vRP.NumPermission(ClothePermission)
				if Total >= ClotheNeed then
					local Consult = vRP.InventoryItemAmount(Passport, ClotheRequired)
					if Consult[1] >= TattoosRequiredAmount then
						if not vRP.CheckDamaged(Consult[2]) then
							if vRP.Device(source, 30) then
								if vRP.TakeItem(Passport, Consult[2], ClotheRequiredAmount, true) then
									TriggerClientEvent("Notify", source, "azul","Rádio da Negociação: <b>" .. ClotheRadio .. "</b>", 10000)

									local Coords = vRP.GetEntityCoords(source)
									for Passports, Sources in pairs(Service) do
										async(function()
											TriggerClientEvent("sounds:Private", Sources, "crime", 0.5)

											TriggerClientEvent("NotifyPush", Sources, { code = 31, title = "Roubo a Loja de Roupa", x = Coords["x"], y = Coords["y"], z = Coords["z"], criminal = "Rádio da Negociação: " .. ClotheRadio, blipColor = 22 })
										end)
									end

									vRPC.AnimActive(source)

									Active[Passport] = os.time() + 30
									RobberyType[Type] = os.time() + 3600
									TriggerClientEvent("Progress", source, "Roubando", 30000)

									Player(source)["state"]["Buttons"] = true
									TriggerClientEvent("inventory:Close", source)
									vRPC.playAnim(source, false, { "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer" }, true)

									repeat
										if os.time() >= parseInt(Active[Passport]) then
											Active[Passport] = nil

											TriggerEvent("Wanted", source, Passport, 300)
											vRP.GenerateItem(Passport, ClotheItem, ClotheAmount, true)
											TriggerClientEvent("player:Residuals", source, "Resíduo de Arrombamento.")

											vRPC.stopAnim(source, false)
											vRP.UpgradeStress(Passport, math.random(2))
											Player(source)["state"]["Buttons"] = false
										end

										Wait(100)
									until not Active[Passport]
								end
							else
								RobberyType[Type] = os.time() + 30
							end
						else
							TriggerClientEvent("Notify", source, "vermelho", "<b>" .. itemName(TattoosRequired) .. "</b> danificado.", 5000)
						end
					else
						TriggerClientEvent("Notify", source, "amarelo", "Precisa de <b>" .. parseInt(TattoosRequiredAmount) .. "x " .. itemName(TattoosRequired) .. "</b>.", 5000)
					end
				else
					TriggerClientEvent("Notify", source, "amarelo", "Contingente indisponível.",  5000)
				end
			elseif Type == "weaponshop" then
				local Service, Total = vRP.NumPermission(WeaponPermission)
				if Total >= WeaponNeed then
					local Consult = vRP.InventoryItemAmount(Passport, WeaponRequired)
					if Consult[1] >= WeaponRequiredAmount then
						if not vRP.CheckDamaged(Consult[2]) then
							if vRP.Device(source, 30) then
								if vRP.TakeItem(Passport, Consult[2], WeaponRequiredAmount, true) then
									TriggerClientEvent("Notify", source, "azul","Rádio da Negociação: <b>" .. WeaponRadio .. "</b>", 10000)

									local Coords = vRP.GetEntityCoords(source)
									for Passports, Sources in pairs(Service) do
										async(function()
											TriggerClientEvent("sounds:Private", Sources, "crime", 0.5)

											TriggerClientEvent("NotifyPush", Sources, { code = 31, title = "Roubo a Loja de Armas", x = Coords["x"], y = Coords["y"], z = Coords["z"], criminal = "Rádio da Negociação: " .. WeaponRadio, blipColor = 22 })
										end)
									end

									vRPC.AnimActive(source)

									Active[Passport] = os.time() + 30
									RobberyType[Type] = os.time() + 3600
									TriggerClientEvent("Progress", source, "Roubando", 30000)

									Player(source)["state"]["Buttons"] = true
									TriggerClientEvent("inventory:Close", source)
									vRPC.playAnim(source, false, { "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer" }, true)

									repeat
										if os.time() >= parseInt(Active[Passport]) then
											Active[Passport] = nil

											TriggerEvent("Wanted", source, Passport, 300)
											vRP.GenerateItem(Passport, WeaponItem, WeaponAmount, true)
											TriggerClientEvent("player:Residuals", source, "Resíduo de Arrombamento.")

											vRPC.stopAnim(source, false)
											vRP.UpgradeStress(Passport, math.random(2))
											Player(source)["state"]["Buttons"] = false
										end

										Wait(100)
									until not Active[Passport]
								end
							else
								RobberyType[Type] = os.time() + 30
							end
						else
							TriggerClientEvent("Notify", source, "vermelho", "<b>" .. itemName(WeaponRequired) .. "</b> danificado.", 5000)
						end
					else
						TriggerClientEvent("Notify", source, "amarelo", "Precisa de <b>" .. parseInt(WeaponRequiredAmount) .. "x " .. itemName(WeaponRequired) .. "</b>.", 5000)
					end
				else
					TriggerClientEvent("Notify", source, "amarelo", "Contingente indisponível.", 5000)
				end
			elseif Type == "fleecas" then
				local Service, Total = vRP.NumPermission(FleecasPermission)
				if Total >= FleecasNeed then
					local Consult = vRP.InventoryItemAmount(Passport, FleecasRequired)
					if Consult[1] >= FleecasRequiredAmount then
						if not vRP.CheckDamaged(Consult[2]) then
							if vRP.Device(source, 30) then
								if vRP.TakeItem(Passport, Consult[2], FleecasRequiredAmount, true) then
									TriggerClientEvent("Notify", source, "azul","Rádio da Negociação: <b>" .. FleecasRadio .. "</b>",  10000)

									local Coords = vRP.GetEntityCoords(source)
									for Passports, Sources in pairs(Service) do
										async(function()
											TriggerClientEvent("sounds:Private", Sources, "crime", 0.5)

											TriggerClientEvent("NotifyPush", Sources, { code = 31, title = "Roubo a Banco Fleeca", x = Coords["x"], y = Coords["y"], z = Coords["z"], criminal = "Rádio da Negociação: " .. FleecasRadio, blipColor = 22 })
										end)
									end

									vRPC.AnimActive(source)

									Active[Passport] = os.time() + 30
									RobberyType[Type] = os.time() + 3600
									TriggerClientEvent("Progress", source, "Roubando", 30000)

									Player(source)["state"]["Buttons"] = true
									TriggerClientEvent("inventory:Close", source)
									vRPC.playAnim(source, false, { "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer" }, true)

									repeat
										if os.time() >= parseInt(Active[Passport]) then
											Active[Passport] = nil

											TriggerEvent("Wanted", source, Passport, 300)
											vRP.GenerateItem(Passport, FleecasItem, FleecasAmount, true)
											TriggerClientEvent("player:Residuals", source, "Resíduo de Arrombamento.")

											vRPC.stopAnim(source, false)
											vRP.UpgradeStress(Passport, math.random(2))
											Player(source)["state"]["Buttons"] = false
										end

										Wait(100)
									until not Active[Passport]
								end
							else
								RobberyType[Type] = os.time() + 30
							end
						else
							TriggerClientEvent("Notify", source, "vermelho", "<b>" .. itemName(FleecasRequired) .. "</b> danificado.",  5000)
						end
					else
						TriggerClientEvent("Notify", source, "amarelo", "Precisa de <b>" .. parseInt(FleecasRequiredAmount) .. "x " .. itemName(FleecasRequired) .. "</b>.", 5000)
					end
				else
					TriggerClientEvent("Notify", source, "amarelo", "Contingente indisponível.", 5000)
				end
			elseif Type == "departmentshop" then
				local Service, Total = vRP.NumPermission(DepartmentPermission)
				if Total >= DepartmentNeed then
					local Consult = vRP.InventoryItemAmount(Passport, DepartmentRequired)
					if Consult[1] >= DepartmentRequiredAmount then
						if not vRP.CheckDamaged(Consult[2]) then
							if vRP.Device(source, 30) then
								if vRP.TakeItem(Passport, Consult[2], DepartmentRequiredAmount, true) then
									TriggerClientEvent("Notify", source, "azul","Rádio da Negociação: <b>" .. DepartmentRadio .. "</b>",10000)

									local Coords = vRP.GetEntityCoords(source)
									for Passports, Sources in pairs(Service) do
										async(function()
											TriggerClientEvent("sounds:Private", Sources, "crime", 0.5)

											TriggerClientEvent("NotifyPush", Sources, { code = 31, title = "Roubo a Loja de Departamento", x = Coords["x"], y = Coords["y"], z = Coords["z"], criminal = "Rádio da Negociação: " .. DepartmentRadio, blipColor = 22 })
										end)
									end

									vRPC.AnimActive(source)

									Active[Passport] = os.time() + 30
									RobberyType[Type] = os.time() + 3600
									TriggerClientEvent("Progress", source, "Roubando", 30000)

									Player(source)["state"]["Buttons"] = true
									TriggerClientEvent("inventory:Close", source)
									vRPC.playAnim(source, false, { "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer" }, true)

									repeat
										if os.time() >= parseInt(Active[Passport]) then
											Active[Passport] = nil

											TriggerEvent("Wanted", source, Passport, 300)
											vRP.GenerateItem(Passport, DepartmentItem, DepartmentAmount, true)
											TriggerClientEvent("player:Residuals", source, "Resíduo de Arrombamento.")

											vRPC.stopAnim(source, false)
											vRP.UpgradeStress(Passport, math.random(2))
											Player(source)["state"]["Buttons"] = false
										end

										Wait(100)
									until not Active[Passport]
								end
							else
								RobberyType[Type] = os.time() + 30
							end
						else
							TriggerClientEvent("Notify", source, "vermelho", "<b>" .. itemName(DepartmentRequired) .. "</b> danificado.", 5000)
						end
					else
						TriggerClientEvent("Notify", source, "amarelo", "Precisa de <b>" .. parseInt(DepartmentRequiredAmount) .. "x " .. itemName(DepartmentRequired) .. "</b>.", 5000)
					end
				else
					TriggerClientEvent("Notify", source, "amarelo", "Contingente indisponível.", 5000)
				end
			end
		else
			local Cooldown = MinimalTimers(RobberyType[Type] - os.time())
			TriggerClientEvent("Notify", source, "azul", "Aguarde <b>" .. Cooldown .. "</b>.", 5000)
		end
	end
end)