-----------------------------------------------------------------------------------------------------------------------------------------
-- kadu
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Kaduzera = {}
Tunnel.bindInterface("admin", Kaduzera)
vCLIENT = Tunnel.getInterface("admin")
vKEYBOARD = Tunnel.getInterface("keyboard")
vGARAGE = Tunnel.getInterface("garages")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Spectate = {}
local Blips = false
local Checkpoint = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- GLOBALSTATE
-----------------------------------------------------------------------------------------------------------------------------------------
GlobalState["Quake"] = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMIN:DYNAMIC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("admin:Dynamic")
AddEventHandler("admin:Dynamic", function(Mode)
	local Passport = vRP.Passport(source)
	if Passport then
		if Mode == "wl" then
			if vRP.HasGroup(Passport,"Admin",1) then
				local Keyboard = vKEYBOARD.keyDouble(source,"ID da Whitelist:","Status: (0 inativa, 1 ativa)")
				if Keyboard then
					TriggerClientEvent("Notify",source,"verde","Whitelist editada.",5000)
					--exports["vrp"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** wl "..Keyboard[1].." "..Keyboard[2],0xa3c846)

					vRP.Query("accounts/updateWhitelist",{ id = Keyboard[1], whitelist = 1 })
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.",5000)
			end
		elseif Mode == "rename" then
			if vRP.HasGroup(Passport,"Admin",2) then
				local Keyboard = vKEYBOARD.keyTertiary(source,"ID:","Nome:","Sobrenome:")
				if Keyboard then
					vRP.UpgradeNames(Keyboard[1],Keyboard[2],Keyboard[3])
					TriggerClientEvent("Notify",source,"verde","Nome atualizado.",5000)
					--exports["vrp"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** rename "..Keyboard[1].." "..Keyboard[2].." "..Keyboard[3],0xa3c846)
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.",5000)
			end
		elseif Mode == "ugroups" then
			if vRP.HasGroup(Passport,"Admin",4) then
				local Keyboard = vKEYBOARD.keySingle(source,"ID:")
				if Keyboard then
					local Result = ""
					local Groups = vRP.Groups()
					local OtherPassport = Keyboard[1]
					for Permission,_ in pairs(Groups) do
						local Data = vRP.DataGroups(Permission)
						if Data[OtherPassport] then
							Result = Result.."<b>Permissão:</b> "..Permission.."<br><b>Nível:</b> "..Data[OtherPassport].."<br>"
						end
					end

					if Result ~= "" then
						TriggerClientEvent("Notify",source,"azul",Result,10000)
					end
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.",5000)
			end
		elseif Mode == "clearinv" then
			if vRP.HasGroup(Passport,"Admin",3) then
				local Keyboard = vKEYBOARD.keySingle(source,"ID:")
				if Keyboard then
					vRP.ClearInventory(Keyboard[1])
					TriggerClientEvent("Notify",source,"verde","Limpeza concluída.",5000)
					--exports["vrp"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** clearinv "..Keyboard[1],0xa3c846)
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.",5000)
			end
		elseif Mode == "gem" then
			if vRP.HasGroup(Passport,"Admin",1) then
				local Keyboard = vKEYBOARD.keyDouble(source,"ID:","Quantidade:")
				if Keyboard then
					local Amount = parseInt(Keyboard[2])
					local OtherPassport = parseInt(Keyboard[1])
					local Identity = vRP.Identity(OtherPassport)
					if Identity then
						TriggerClientEvent("Notify",source,"verde","Gemas entregues.",5000)
						--exports["vrp"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** gem "..Keyboard[1].." "..Keyboard[2],0xa3c846)

						vRP.UpgradeGemstone(OtherPassport,Amount)
					end
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.",5000)
			end
		elseif Mode == "blips" then
			if vRP.HasGroup(Passport,"Admin",2) then
				vRPC.BlipAdmin(source)
			else
				TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.",5000)
			end
		elseif Mode == "debug" then
			if vRP.HasGroup(Passport,"Admin",2) then
				TriggerClientEvent("ToggleDebug",source)
			else
				TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.",5000)
			end
		elseif Mode == "flash" then
			if vRP.HasGroup(Passport,"Admin",2) then
				TriggerClientEvent("admin:Flash", source)
			else
				TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.",5000)
			end
		elseif Mode == "god" then
			if vRP.HasGroup(Passport, "Admin", 4) then
				local Keyboard = vKEYBOARD.keySingle(source, "ID:")
				if Keyboard then
					-----TriggerEvent("Discord", "God", "**Passaporte:** " .. Passport .. "\n**Comando:** god " .. Keyboard[1], 0xa3c846)
					local OtherPassport = tonumber(Keyboard[1])
					local ClosestPed = vRP.Source(OtherPassport)
					if ClosestPed then
						vRP.UpgradeThirst(OtherPassport, 100)
						vRP.UpgradeHunger(OtherPassport, 100)
						vRP.DowngradeStress(OtherPassport, 100)
						vRP.Revive(ClosestPed, 200)
						---TriggerEvent("Discord", "God", "**god**\n\n**Passaporte:** " .. Passport .. "\n**Para: ** ".. vRP.FullName(OtherPassport) .. ".  Passaporte : "..OtherPassport.. " \n**Horário:** " .. os.date("%H:%M:%S"), 3553599)
					end
				else
					TriggerClientEvent("Notify", source, "vermelho", "O ID inserido não é válido.", 5000)
				end
			else
			TriggerClientEvent("Notify", source, "amarelo", "Você não tem permissões para isso.", 5000)
		end
		elseif Mode == "armour" then
			if vRP.HasGroup(Passport,"Admin",2) then
				local Keyboard = vKEYBOARD.keySingle(source,"ID:")
				if Keyboard then
					--exports["vrp"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** armour "..Keyboard[1],0xa3c846)

					local OtherPassport = parseInt(Keyboard[1])
					local ClosestPed = vRP.Source(OtherPassport)
					if ClosestPed then
						vRP.SetArmour(ClosestPed,100)
						---TriggerEvent("Discord", "God", "**Armour Colete**\n\n**Name:** " ..vRP.FullName(Passport).." ID: ".. Passport .. "\n**Setou Colete Para: ** ".. vRP.FullName(OtherPassport) .. " ID : "..OtherPassport.. " \n**Horário:** " .. os.date("%H:%M:%S"), 3553599)
					end
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.",5000)
			end
		elseif Mode == "item" then
			if vRP.HasGroup(Passport,"Admin",1) then
				local Keyboard = vKEYBOARD.keyDouble(source,"Nome do Item:","Quantidade:")
				if Keyboard then
					if itemBody(Keyboard[1]) ~= nil then
						--exports["vrp"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** item "..Keyboard[1].." "..Keyboard[2],0xa3c846)

						if Keyboard[1] == "backpackp" or Keyboard[1] == "backpackm" or Keyboard[1] == "backpackg" then
							vRP.GiveItem(Passport,Keyboard[1].."-"..os.time().."-"..Passport,parseInt(Keyboard[2]),true)
						else
							vRP.GenerateItem(Passport,Keyboard[1],parseInt(Keyboard[2]),true)
							---TriggerEvent("Discord","Item","**item**\n\n**Passaporte:** "..vRP.FullName(Passport).." ID: "..Passport.."\n**Item:** "..Keyboard[2].."x "..itemName(Keyboard[1]).." \n**Horário:** "..os.date("%H:%M:%S"),3553599)
						end
					end
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.",5000)
			end
		elseif Mode == "item2" then
			if vRP.HasGroup(Passport,"Admin",1) then
				local Keyboard = vKEYBOARD.keyTertiary(source,"ID:","Nome do Item:","Quantidade:")
				if Keyboard then
					if itemBody(Keyboard[2]) ~= nil then
						--exports["vrp"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** item2 "..Keyboard[1].." "..Keyboard[2].." "..Keyboard[3],0xa3c846)

						if Keyboard[2] == "backpackp" or Keyboard[2] == "backpackm" or Keyboard[2] == "backpackg" then
							vRP.GiveItem(parseInt(Keyboard[1]),Keyboard[2].."-"..os.time().."-"..parseInt(Keyboard[1]),parseInt(Keyboard[3]),true)
						else
							vRP.GenerateItem(parseInt(Keyboard[1]),Keyboard[2],parseInt(Keyboard[3]),true)
							---TriggerEvent("Discord","God","**item2*\n\n**Nome:** "..vRP.FullName(Passport).." ID: "..Passport.."\n**Para:** "..vRP.FullName(Keyboard[1]).." ID: "..Keyboard[1].."\n**Item:** "..Keyboard[3].."x "..Keyboard[2].." \n**Horário:** "..os.date("%H:%M:%S"),3553599)
						end
					end
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.",5000)
			end
		elseif Mode == "itemall" then
			if vRP.HasGroup(Passport,"Admin",1) then
				local Keyboard = vKEYBOARD.keyDouble(source,"Nome do Item:","Quantidade:")
				if Keyboard then
					if itemBody(Keyboard[1]) ~= nil then
						--exports["vrp"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** itemall "..Keyboard[1].." "..Keyboard[2],0xa3c846)

						local List = vRP.Players()
						for AllPlayers,_ in pairs(List) do
							async(function()
								if Keyboard[1] == "backpackp" or Keyboard[1] == "backpackm" or Keyboard[1] == "backpackg" then
									vRP.GiveItem(AllPlayers,Keyboard[1].."-"..os.time().."-"..AllPlayers,parseInt(Keyboard[2]),true)
								else
									vRP.GenerateItem(AllPlayers,Keyboard[1],parseInt(Keyboard[2]),true)
								end
							end)
						end

						TriggerClientEvent("Notify",source,"verde","Envio concluído.",5000)
					end
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.",5000)
			end
		elseif Mode == "delete" then
			if vRP.HasGroup(Passport,"Admin",2) then
				local Keyboard = vKEYBOARD.keySingle(source,"ID:")
				if Keyboard then
					--exports["vrp"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** unban "..Keyboard[1],0xa3c846)

					TriggerClientEvent("dynamic:closeSystem",source)

					if vRP.Request(source,"Deletar Conta","Você tem certeza?") then
						local OtherPassport = parseInt(Keyboard[1])
						vRP.Query("characters/Delete",{ Passport = OtherPassport })
						TriggerClientEvent("Notify",source,"verde","Personagem <b>"..OtherPassport.."</b> deletado.",5000)
					end
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.",5000)
			end
		elseif Mode == "skin" then
			if vRP.HasGroup(Passport,"Admin",2) then
				local Keyboard = vKEYBOARD.keyDouble(source,"ID:","Skin:")
				if Keyboard then
					local ClosestPed = vRP.Source(Keyboard[1])
					if ClosestPed then
						vRPC.Skin(ClosestPed,Keyboard[2])
						vRP.SkinCharacter(parseInt(Keyboard[1]),Keyboard[2])
						--exports["vrp"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** skin "..Keyboard[1].." "..Keyboard[2],0xa3c846)
						TriggerClientEvent("Notify",source,"verde","Skin <b>"..Keyboard[2].."</b> setada no ID "..parseInt(Keyboard[1])..".",5000)
					end
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.",5000)
			end
		elseif Mode == "resetskin" then
			if vRP.HasGroup(Passport,"Admin",2) then
				local Keyboard = vKEYBOARD.keySingle(source,"ID:")
				if Keyboard then
					local ClosestPed = vRP.Source(Keyboard[1])
					if ClosestPed then
						local OtherPassport = parseInt(Keyboard[1])
						local Identity = vRP.Identity(OtherPassport)
						if Identity then
							if Identity["Sex"] == "M" then
								vRPC.Skin(ClosestPed,"mp_m_freemode_01")
								vRP.SkinCharacter(parseInt(Keyboard[1]),"mp_m_freemode_01")
							elseif Identity["Sex"] == "F" then
								vRPC.Skin(ClosestPed,"mp_f_freemode_01")
								vRP.SkinCharacter(parseInt(Keyboard[1]),"mp_f_freemode_01")
							end

							--exports["vrp"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** resetskin "..Keyboard[1],0xa3c846)
							TriggerClientEvent("Notify",source,"verde","Skin do ID "..parseInt(Keyboard[1]).." foi resetada.",5000)
						end
					end
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.",5000)
			end
		elseif Mode == "nc" then
			if vRP.HasGroup(Passport,"Admin",4) then
				vRPC.noClip(source)
			else
				TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.",5000)
			end
		elseif Mode == "kick" then
			if vRP.HasGroup(Passport,"Admin",3) then
				local Keyboard = vKEYBOARD.keySingle(source,"ID:")
				if Keyboard then
					local OtherSource = vRP.Source(Keyboard[1])
					if OtherSource then
						TriggerClientEvent("Notify",source,"verde","Passaporte <b>"..Keyboard[1].."</b> expulso.",5000)
						--exports["vrp"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** kick "..Keyboard[1],0xa3c846)
						vRP.Kick(OtherSource,"Expulso da cidade.")
					end
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.",5000)
			end
		elseif Mode == "ban" then
			if vRP.HasGroup(Passport,"Admin",3) then
				local Keyboard = vKEYBOARD.keyDouble(source,"ID:","Dias:")
				if Keyboard then
					local Days = parseInt(Keyboard[2])
					local OtherPassport = parseInt(Keyboard[1])
					local Identity = vRP.Identity(OtherPassport)
					if Identity then
						local OtherSource = vRP.Source(OtherPassport)
						if OtherSource then
							local Token = GetPlayerTokens(OtherSource)
							for k,v in pairs(Token) do
								vRP.Kick(OtherPassport,"Banido.")
								vRP.Query("banneds/InsertBanned",{ License = Identity["License"], Token = v, Time = Days })
							end

							--exports["vrp"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** ban "..Keyboard[1].." "..Keyboard[2],0xa3c846)
							TriggerClientEvent("Notify",source,"amarelo","Passaporte <b>"..OtherPassport.."</b> banido por <b>"..Days.."</b> dias.",5000)
						end
					end
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.",5000)
			end
		elseif Mode == "unban" then
			if vRP.HasGroup(Passport,"Admin",2) then
				local Keyboard = vKEYBOARD.keySingle(source,"ID:")
				if Keyboard then
					local OtherPassport = parseInt(Keyboard[1])
					local Identity = vRP.Identity(OtherPassport)
					if Identity then
						vRP.Query("banneds/RemoveBanned",{ License = Identity["License"] })
						--exports["vrp"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** unban "..Keyboard[1],0xa3c846)
						TriggerClientEvent("Notify",source,"verde","Passaporte <b>"..OtherPassport.."</b> desbanido.",5000)
					end
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.",5000)
			end
		elseif Mode == "timeset" then
			if vRP.HasGroup(Passport,"Admin",1) then
				local Keyboard = vKEYBOARD.keyTertiary(source,"Hora:","Minuto:","Clima:")
				if Keyboard then
					GlobalState["Hours"] = parseInt(Keyboard[1])
					GlobalState["Minutes"] = parseInt(Keyboard[2])
					GlobalState["Weather"] = Keyboard[3]
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.",5000)
			end
		elseif Mode == "temperatureset" then
			if vRP.HasGroup(Passport,"Admin",1) then
				local Keyboard = vKEYBOARD.keySingle(source,"Temperatura:")
				if Keyboard then
					GlobalState["Temperature"] = parseInt(Keyboard[1])
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.",5000)
			end
		elseif Mode == "blackoutset" then
			if vRP.HasGroup(Passport,"Admin",1) then
				if GlobalState["Blackout"] then
					GlobalState["Blackout"] = false
					TriggerClientEvent("Notify",source,"amarelo","Modo blackout desativado.",5000)
				else
					GlobalState["Blackout"] = true
					TriggerClientEvent("Notify",source,"verde","Modo blackout ativado.",5000)
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.",5000)
			end
		elseif Mode == "cds" then
			if vRP.HasGroup(Passport,"Admin",2) then
				local Ped = GetPlayerPed(source)
				local Coords = GetEntityCoords(Ped)
				local Heading = GetEntityHeading(Ped)

				vKEYBOARD.keyCopy(source,"Cordenadas:",mathLength(Coords["x"])..","..mathLength(Coords["y"])..","..mathLength(Coords["z"])..","..mathLength(Heading))
			else
				TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.",5000)
			end
		elseif Mode == "tpcds" then
			if vRP.HasGroup(Passport,"Admin",2) then
				local Keyboard = vKEYBOARD.keySingle(source,"Coordenada:")
				if Keyboard then
					local Split = splitString(Keyboard[1],",")
					vRP.Teleport(source,Split[1] or 0,Split[2] or 0,Split[3] or 0)
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.",5000)
			end
		elseif Mode == "group" then
			if vRP.HasGroup(Passport,"Admin",2) then
				local Keyboard = vKEYBOARD.keyTertiary(source,"ID:","Grupo:","Hierarquia:")
				if Keyboard then
					local Level = Keyboard[3]
					local Permission = Keyboard[2]
					local OtherPassport = Keyboard[1]

					if vRP.GroupType(Permission) then
						if not vRP.GetUserType(OtherPassport,"Work") then
							--exports["vrp"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** group "..OtherPassport.." "..Permission.." "..Level,0xa3c846)
							TriggerClientEvent("Notify",source,"verde","Adicionado <b>"..Permission.."</b> ao passaporte <b>"..OtherPassport.."</b>.",5000)
							vRP.SetPermission(OtherPassport,Permission,Level)
						else
							TriggerClientEvent("Notify",source,"amarelo","O passaporte já pertence a outro grupo.",5000)
						end
					else
						--exports["vrp"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** group "..OtherPassport.." "..Permission.." "..Level,0xa3c846)
						TriggerClientEvent("Notify",source,"verde","Adicionado <b>"..Permission.."</b> ao passaporte <b>"..OtherPassport.."</b>.",5000)
						vRP.SetPermission(OtherPassport,Permission,Level)
					end
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.",5000)
			end
		elseif Mode == "ungroup" then
			if vRP.HasGroup(Passport,"Admin",2) then
				local Keyboard = vKEYBOARD.keyDouble(source,"ID:","Grupo:")
				if Keyboard then
					TriggerClientEvent("Notify",source,"verde","Removido <b>"..Keyboard[2].."</b> ao passaporte <b>"..Keyboard[1].."</b>.",5000)
					--exports["vrp"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** ungroup "..Keyboard[1].." "..Keyboard[2],0xa3c846)
					vRP.RemovePermission(Keyboard[1],Keyboard[2])
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.",5000)
			end
		elseif Mode == "tptome" then
			if vRP.HasGroup(Passport,"Admin",4) then
				local Keyboard = vKEYBOARD.keySingle(source, "ID:")
				if Keyboard then
					local ClosestPed = vRP.Source(Keyboard[1])
					if ClosestPed then
						local Ped = GetPlayerPed(source)
						local Coords = GetEntityCoords(Ped)

						vRP.Teleport(ClosestPed, Coords["x"], Coords["y"], Coords["z"])
					end
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.",5000)
			end
		elseif Mode == "tpto" then
			if vRP.HasGroup(Passport,"Admin",4) then
				local Keyboard = vKEYBOARD.keySingle(source, "ID:")
				if Keyboard then
					local ClosestPed = vRP.Source(Keyboard[1])
					if ClosestPed then
						local Ped = GetPlayerPed(ClosestPed)
						local Coords = GetEntityCoords(Ped)
						vRP.Teleport(source, Coords["x"], Coords["y"], Coords["z"])
					end
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.",5000)
			end
		elseif Mode == "tpway" then
			if vRP.HasGroup(Passport,"Admin",4) then
				vCLIENT.teleportWay(source)
			else
				TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.",5000)
			end
		elseif Mode == "tuning" then
			if vRP.HasGroup(Passport,"Admin",2) then
				TriggerClientEvent("admin:Tuning", source)
			else
				TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.",5000)
			end
		elseif Mode == "dv" then
			if vRP.HasGroup(Passport, "Admin", 3) then
				TriggerClientEvent("garages:Delete", source)
			else
				TriggerClientEvent("Notify", source, "vermelho", "Você não tem permissões para deletar veículos.", 5000)
			end
		elseif Mode == "fix" then
			if vRP.HasGroup(Passport,"Admin",3) then
				local Vehicle,Network,Plate = vRPC.VehicleList(source,10)
				if Vehicle then
					local Players = vRPC.Players(source)
					for _,v in pairs(Players) do
						async(function()
							TriggerClientEvent("inventory:repairAdmin",v,Network,Plate)
						end)
					end
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.",5000)
			end
		elseif Mode == "fuel" then
			if vRP.HasGroup(Passport,"Admin",2) then
				if not vRPC.InsideVehicle(source) then
					local Vehicle,Network,Plate = vRPC.VehicleList(source,10)
					if Vehicle then
						local Keyboard = vKEYBOARD.keySingle(source, "Litros:")
						if Keyboard then
							local Networked = NetworkGetEntityFromNetworkId(Network)
							Entity(Networked)["state"]:set("Fuel", Keyboard[1], true)
							TriggerClientEvent("Notify",source,"verde","Veículo com <b>"..parseInt(Keyboard[1]).."% de Gasolina</b>.",5000)
						end
					end
				else
					TriggerClientEvent("Notify",source,"amarelo","Você precisa sair do veículo.",5000)
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.",5000)
			end
		elseif Mode == "limparea" then
			if vRP.HasGroup(Passport,"Admin",2) then
				local Ped = GetPlayerPed(source)
				local Coords = GetEntityCoords(Ped)
				vCLIENT.Limparea(source, Coords)
			else
				TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.",5000)
			end
		elseif Mode == "hash" then
			if vRP.HasGroup(Passport,"Admin",3) then
				local Vehicle = vRPC.VehicleHash(source)
				if Vehicle then
					vKEYBOARD.keyCopy(source,"Hash do veículo:",Vehicle)
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.",5000)
			end
		elseif Mode == "setbank" then
			if vRP.HasGroup(Passport,"Admin",1) then
				local Keyboard = vKEYBOARD.keyDouble(source,"ID:","Quantidade:")
				if Keyboard then
					vRP.GiveBank(Keyboard[1],Keyboard[2])
					TriggerClientEvent("Notify",source,"verde","Envio concluído.",5000)
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.",5000)
			end
		elseif Mode == "rembank" then
			if vRP.HasGroup(Passport,"Admin",1) then
				local Keyboard = vKEYBOARD.keyDouble(source, "ID:", "Quantidade:")
				if Keyboard then
					vRP.RemoveBank(Keyboard[1],Keyboard[2])
					TriggerClientEvent("Notify",source,"verde","Remoção concluída.",5000)
					TriggerClientEvent("NotifyItens",source,{ "-", "dollars", parseFormat(Keyboard[2]), "Dólares" })
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.",5000)
			end
		elseif Mode == "players" then
			if vRP.HasGroup(Passport, "Admin",4) then
				local users = vRP.Players()
				local players = ""
				local quantidade = 0
				for k,v in pairs(users) do
					if k ~= #users then
						players = players..", "
					end
					players = players..k
					quantidade = quantidade + 1
				end
				TriggerClientEvent("Notify",source,"azul","TOTAL ONLINE : <b>"..quantidade.."</b><br>ID's ONLINE : <b>"..players.."</b>",5000)
			end
		elseif Mode == "announce" then
			if vRP.HasGroup(Passport, "Admin",3) then
				local message = vKEYBOARD.keyArea(source, "Mensagem:")
				if message and message[1] then
					local finalMessage = message[1] .. "<br></br>Enviada Por: Governador"
					TriggerClientEvent("Notify", -1, "verde", finalMessage .. "</b>", 45000)
				else
					TriggerClientEvent("Notify", source, "vermelho", "A mensagem não pode estar vazia.", 5000)
				end
			else
				TriggerClientEvent("Notify", source, "vermelho", "Você não tem permissões para isso.", 5000)
			end
		elseif Mode == "setcar" then
			if vRP.HasGroup(Passport,"Admin",2) then
				local Keyboard = vKEYBOARD.keyDouble(source, "ID:", "Veículo:")
				if Keyboard then
					local Consult = vRP.Query("vehicles/selectVehicles",{ Passport = Keyboard[1], vehicle = Keyboard[2] })
					if Consult[1] then
						TriggerClientEvent("Notify",source,"amarelo","O veículo <b>"..Keyboard[2].."</b> já está adicionado.",5000)
						return
					else
						--exports["vrp"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** setcar "..Keyboard[1].." "..Keyboard[2],0xa3c846)
						vRP.Query("vehicles/addVehicles",{ Passport = Keyboard[1], vehicle = Keyboard[2], plate = vRP.GeneratePlate(), work = "false" })
					end
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.",5000)
			end
		elseif Mode == "remcar" then
			if vRP.HasGroup(Passport,"Admin",2) then
				local Keyboard = vKEYBOARD.keyDouble(source,"ID:","Veículo:")
				if Keyboard then
					--exports["vrp"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** remcar "..Keyboard[1].." "..Keyboard[2],0xa3c846)
					TriggerClientEvent("Notify",source,"verde","Veículo removido com sucesso.",5000)
					vRP.Query("vehicles/removeVehicles",{ Passport = Keyboard[1], vehicle = Keyboard[2] })
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.",5000)
			end
		elseif Mode == "ney" then
			if vRP.HasGroup(Passport,"Admin",1) then
				local Keyboard = vKEYBOARD.keySingle(source,"ID:")
				if Keyboard then
					vCLIENT.neyMar(Keyboard[1])
					TriggerClientEvent("Notify",source,"azul","Você Derrubou o #"..vRP.Passport(Passport).." - "..vRP.FullName(Keyboard[1].." com Sucesso"),5000)
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.",5000)
			end
		elseif Mode == "voar" then
			if vRP.HasGroup(Passport,"Admin",1) then
				local Keyboard = vKEYBOARD.keySingle(source,"ID:")
				if Keyboard then
					vCLIENT.makeFly(Keyboard[1])
					TriggerClientEvent("Notify",source,"azul","Você Mandou o #"..vRP.Passport(Passport).." - "..vRP.FullName(Keyboard[1].." Para as Alturas"),5000)
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.",5000)
			end
		elseif Mode == "explodir" then
			if vRP.HasGroup(Passport, "Admin", 1) then
				local Keyboard = vKEYBOARD.keySingle(source, "ID:")
				if Keyboard then
					TriggerClientEvent("Kaduzera:Explodir", Keyboard[1])
					TriggerClientEvent("Notify", source, "azul", "Você Explodiu o #"..vRP.Passport(Passport).." - "..vRP.FullName(Keyboard[1]).." com Sucesso", 5000)
				end
			else
				TriggerClientEvent("Notify", source, "amarelo", "Você não tem permissões para isso.", 5000)
			end	
		elseif Mode == "fogo" then
			if vRP.HasGroup(Passport,"Admin",1) then
				local Keyboard = vKEYBOARD.keySingle(source,"ID:")
				if Keyboard then
					TriggerClientEvent("Kaduzera:Fogo",Keyboard[1])
					TriggerClientEvent("Notify",source,"azul","Você Colocou Fogo no #"..vRP.Passport(Passport).." - "..vRP.FullName(Keyboard[1].." com Sucesso"),5000)
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.",5000)
			end
		elseif Mode == "gelo" then
			if vRP.HasGroup(Passport,"Admin",1) then
				local Keyboard = vKEYBOARD.keySingle(source,"ID:")
				if Keyboard then
					TriggerClientEvent("Kaduzera:Congelar",Keyboard[1])
					TriggerClientEvent("Notify",source,"azul","Você Congelou #"..vRP.Passport(Passport).." - "..vRP.FullName(Keyboard[1].." com Sucesso"),5000)
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.",5000)
			end
		elseif Mode == "clearprison" then
			if vRP.HasGroup(Passport,"Admin",2) then
				local Keyboard = vKEYBOARD.keySingle(source,"ID:")
				if Keyboard then
					local OtherPlayer = vRP.Source(Keyboard[1])
					if OtherPlayer then
						--exports["vrp"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** clearprison "..Keyboard[1],0xa3c846)
						TriggerClientEvent("Notify",source,"verde","Prisão zerada.",5000)
						vRP.Query("characters/CleanPrison",{ Passport = Keyboard[1] })
						Player(OtherPlayer)["state"]["Prison"] = false
					end
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- USOURCE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("usource",function(source,Message)
	local Passport = vRP.Passport(source)
	local OtherSource = parseInt(Message[1])
	if Passport and OtherSource and OtherSource > 0 and vRP.Passport(OtherSource) and vRP.HasGroup(Passport,"Admin") then
		TriggerClientEvent("Notify",source,"azul","<b>Passaporte:</b> "..vRP.Passport(OtherSource),5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KICKALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("kickall",function(source)
	if source ~= 0 then
		local Passport = vRP.Passport(source)
		if not vRP.HasGroup(Passport,"Admin",1) then
			return
		end
	end

	local List = vRP.Players()
	for _,Sources in pairs(List) do
		vRP.Kick(Sources,"Desconectado, a cidade reiniciou.")
		Wait(100)
	end

	TriggerEvent("SaveServer",false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("save",function(source)
	if source ~= 0 then
		local Passport = vRP.Passport(source)
		if not vRP.HasGroup(Passport,"Admin",1) then
			return
		end
	end

	TriggerEvent("SaveServer",false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVEAUTO
-----------------------------------------------------------------------------------------------------------------------------------------
local LastSave = os.time() + 300
CreateThread(function()
	while true do
		Wait(60000)

		if os.time() >= LastSave then
			TriggerEvent("SaveServer",true)
			LastSave = os.time() + 300
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMIN:DOORS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("admin:Doords")
AddEventHandler("admin:Doords",function(Coords,Model,Heading)
	vRP.Archive("coordenadas.txt","Coords = "..Coords..", Hash = "..Model..", Heading = "..Heading)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMIN:COORDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("admin:Coords")
AddEventHandler("admin:Coords",function(Coords)
	vRP.Archive("coordenadas.txt",mathLength(Coords["x"])..","..mathLength(Coords["y"])..","..mathLength(Coords["z"]))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMIN:keyCopyCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("admin:keyCopyCoords")
AddEventHandler("admin:keyCopyCoords",function(Coords)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		vKEYBOARD.keyCopy(source,"Cordenadas:",mathLength(Coords["x"])..","..mathLength(Coords["y"])..","..mathLength(Coords["z"]))
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CDS
-----------------------------------------------------------------------------------------------------------------------------------------
function Kaduzera.buttonTxt()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin") then
			local Ped = GetPlayerPed(source)
			local Coords = GetEntityCoords(Ped)
			local heading = GetEntityHeading(Ped)

			vRP.Archive(Passport..".txt",mathLength(Coords["x"])..","..mathLength(Coords["y"])..","..mathLength(Coords["z"])..","..mathLength(heading))
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RACECONFIG
-----------------------------------------------------------------------------------------------------------------------------------------
function Kaduzera.RaceConfig(Left,Center,Right,Distance)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		vRP.Archive(Passport..".txt","{")

		vRP.Archive(Passport..".txt","['Left'] = vec3("..mathLength(Left["x"])..","..mathLength(Left["y"])..","..mathLength(Left["z"]).."),")
		vRP.Archive(Passport..".txt","['Center'] = vec3("..mathLength(Center["x"])..","..mathLength(Center["y"])..","..mathLength(Center["z"]).."),")
		vRP.Archive(Passport..".txt","['Right'] = vec3("..mathLength(Right["x"])..","..mathLength(Right["y"])..","..mathLength(Right["z"]).."),")
		vRP.Archive(Passport..".txt","['Distance'] = "..Distance)

		vRP.Archive(Passport..".txt","},")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONSOLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("console",function(source,Message,History)
	if source == 0 then
		TriggerClientEvent("Notify",-1,"default",History:sub(9),"Prefeitura",60000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ONLINES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("onlines",function(source)
	if source == 0 then
		print("Atualmente ^2"..ServerName.." ^0tem ^5"..GetNumPlayerIndices().." Onlines^0.")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPWAY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("limbo",function(source)
	local Passport = vRP.Passport(source)
	if Passport and vRP.GetHealth(source) <= 100 then
		vCLIENT.teleportLimbo(source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEVTOOLSKICK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("admin:DevToolsKick")
AddEventHandler("admin:DevToolsKick", function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		vRP.Kick(source,"Expulso da cidade.")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPECTATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("spectate",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",3) then
			if Spectate[Passport] then
				local Ped = GetPlayerPed(Spectate[Passport])
				if DoesEntityExist(Ped) then
					SetEntityDistanceCullingRadius(Ped,0.0)
				end

				TriggerClientEvent("admin:resetSpectate",source)
				Spectate[Passport] = nil

				TriggerClientEvent("Notify",source,"amarelo","Modo espião desativado.",5000)
			else
				local OtherSource = vRP.Source(Message[1])
				if OtherSource then
					local OtherPassport = vRP.Passport(OtherSource)
					local OtherIdentity = vRP.Identity(OtherPassport)
					if OtherPassport and OtherIdentity then
						if vRP.Request(source,"Você realmente deseja espionar <b>"..vRP.FullName(Passport).."</b>?") then
							local Ped = GetPlayerPed(OtherSource)
							if DoesEntityExist(Ped) then
								SetEntityDistanceCullingRadius(Ped,999999999.0)
								Wait(1000)
								TriggerClientEvent("admin:initSpectate",source,OtherSource)
								Spectate[Passport] = OtherSource

								TriggerClientEvent("Notify",source,"verde","Você está espiando <b>"..vRP.FullName(Passport).."</b>.",5000)
							end
						end
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- QUAKE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("quake",function(source)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin") then
			TriggerClientEvent("Notify",-1,"vermelho","Os geólogos informaram para nossa unidade governamental que foi encontrado um abalo de magnitude <b>60</b> na <b>Escala Richter</b>, encontrem abrigo até que o mesmo passe.","Terromoto",60000)
			GlobalState["Quake"] = true
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TESTE
-----------------------------------------------------------------------------------------------------------------------------------------
-- RegisterCommand("teste",function(source)
	-- local Passport = vRP.Passport(source)
	-- if Passport then
		-- if vRP.HasGroup(Passport,"Admin") then
			-- TriggerClientEvent("Notify",source,"default","Texto aqui.",false,5000)
			-- TriggerClientEvent("Notify",source,"azul","Texto aqui.",false,5000)
			-- TriggerClientEvent("Notify",source,"verde","Texto aqui.",5000)
			-- TriggerClientEvent("Notify",source,"amarelo","Texto aqui.",5000)
			-- TriggerClientEvent("Notify",source,"vermelho","Texto aqui.","Aviso",5000)
		-- end
	-- end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport)
	if Spectate[Passport] then
		Spectate[Passport] = nil
	end
end)