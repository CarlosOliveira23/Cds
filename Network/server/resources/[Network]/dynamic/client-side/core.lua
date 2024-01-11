-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPS = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("dynamic")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local menuOpen = false
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
RegisterNUICallback("clicked",function(Data,Callback)
	if Data["trigger"] and Data["trigger"] ~= "" then
		if Data["server"] == "true" then
			TriggerServerEvent(Data["trigger"],Data["param"])
		else
			TriggerEvent(Data["trigger"],Data["param"])
		end
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("close",function(Data,Callback)
	SetNuiFocus(false,false)
	menuOpen = false

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DYNAMIC:CLOSESYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("dynamic:closeSystem")
AddEventHandler("dynamic:closeSystem",function()
	if menuOpen then
		SendNUIMessage({ close = true })
		SetNuiFocus(false,false)
		menuOpen = false
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GLOBALFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("globalFunctions",function()
	if not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and not LocalPlayer["state"]["Prison"] and not Dynamic and not IsPauseMenuActive() then
		local Ped = PlayerPedId()
		local Coords = GetEntityCoords(Ped)

		if GetEntityHealth(Ped) > 100 then
			if LocalPlayer["state"]["Premium"] or LocalPlayer["state"]["PremiumOuro"] or LocalPlayer["state"]["PremiumPrata"]then
			exports["dynamic"]:AddButton("Vestir Platinum","Vestir-se com as vestimentas guardadas.","player:Outfit","aplicarplatina","wardrobepremium",true)
			exports["dynamic"]:AddButton("Salvar Platinum","Salvar suas vestimentas do corpo.","player:Outfit","salvarplatina","wardrobepremium",true)
			exports["dynamic"]:AddButton("Vestir Ouro","Vestir-se com as vestimentas guardadas.","player:Outfit","aplicarouro","wardrobepremium2",true)
			exports["dynamic"]:AddButton("Salvar Ouro","Salvar suas vestimentas do corpo.","player:Outfit","salvarouro","wardrobepremium2",true)
			exports["dynamic"]:AddButton("Vestir Prata","Vestir-se com as vestimentas guardadas.","player:Outfit","aplicarprata","wardrobepremium3",true)
			exports["dynamic"]:AddButton("Salvar Prata","Salvar suas vestimentas do corpo.","player:Outfit","salvarprata","wardrobepremium3",true)
			exports["dynamic"]:AddButton("Remover Roupas","Remover suas vestimentas do corpo.","player:Outfit","remover","wardrobepremium",true)
			exports["dynamic"]:AddButton("Remover Roupas","Remover suas vestimentas do corpo.","player:Outfit","remover","wardrobepremium2",true)
			exports["dynamic"]:AddButton("Remover Roupas","Remover suas vestimentas do corpo.","player:Outfit","remover","wardrobepremium3",true)
			exports["dynamic"]:SubMenu("Roupas Premium","Colocar/Retirar roupas.","wardrobepremium")
			exports["dynamic"]:SubMenu("Roupas Premium Ouro","Colocar/Retirar roupas.","wardrobepremium2")
			exports["dynamic"]:SubMenu("Roupas Premium Prata","Colocar/Retirar roupas.","wardrobepremium3")
		end

			exports["dynamic"]:AddButton("Vestir","Vestir-se com as vestimentas guardadas.","player:Outfit","aplicar","wardrobe",true)
			exports["dynamic"]:AddButton("Guardar","Salvar suas vestimentas do corpo.","player:Outfit","salvar","wardrobe",true)
			exports["dynamic"]:AddButton("Remover","Remover suas vestimentas do corpo.","player:Outfit","remover","wardrobe",true)
			exports["dynamic"]:SubMenu("Armário","Colocar/Retirar roupas.","wardrobe")

			exports["dynamic"]:AddButton("Chapéu","Colocar/Retirar o chapéu.","player:Outfit","Hat","clothes",true)
			exports["dynamic"]:AddButton("Máscara","Colocar/Retirar a máscara.","player:Outfit","Mask","clothes",true)
			exports["dynamic"]:AddButton("Óculos","Colocar/Retirar o óculos.","player:Outfit","Glasses","clothes",true)
			exports["dynamic"]:AddButton("Camisa","Colocar/Retirar a camisa.","player:Outfit","Shirt","clothes",true)
			exports["dynamic"]:AddButton("Jaqueta","Colocar/Retirar a jaqueta.","player:Outfit","Torso","clothes",true)
			exports["dynamic"]:AddButton("Mãos","Ajustas as mãos.","player:Outfit","Arms","clothes",true)
			exports["dynamic"]:AddButton("Colete","Colocar/Retirar o colete.","player:Outfit","Vest","clothes",true)
			exports["dynamic"]:AddButton("Calça","Colocar/Retirar a calça.","player:Outfit","Pants","clothes",true)
			exports["dynamic"]:AddButton("Sapatos","Colocar/Retirar o sapato.","player:Outfit","Shoes","clothes",true)
			exports["dynamic"]:AddButton("Acessórios","Colocar/Retirar os acessórios.","player:Outfit","Accessory","clothes",true)
			exports["dynamic"]:SubMenu("Roupas","Colocar/Retirar roupas.","clothes")

			local Vehicle = vRP.ClosestVehicle(7)
			local LastVehicle = GetLastDrivenVehicle()
			if IsEntityAVehicle(Vehicle) then
				if not IsPedInAnyVehicle(Ped) then
					if GetEntityModel(LastVehicle) == GetHashKey("flatbed") and not IsPedInAnyVehicle(Ped) then
						exports["dynamic"]:AddButton("Rebocar","Colocar o veículo na prancha.","towdriver:invokeTow","","others",false)
					end

					if vRP.ClosestPed(3) then
						exports["dynamic"]:AddButton("Colocar no Veículo","Colocar no veículo mais próximo.","player:cvFunctions","cv","closestpeds",true)
						exports["dynamic"]:AddButton("Remover do Veículo","Remover do veículo mais próximo.","player:cvFunctions","rv","closestpeds",true)

						exports["dynamic"]:SubMenu("Jogador","Pessoa mais próxima de você.","closestpeds")
					end
				else
					exports["dynamic"]:AddButton("Sentar no Motorista","Sentar no banco do motorista.","player:seatPlayer","0","vehicle",false)
					exports["dynamic"]:AddButton("Sentar no Passageiro","Sentar no banco do passageiro.","player:seatPlayer","1","vehicle",false)
					exports["dynamic"]:AddButton("Sentar em Outros","Sentar no banco do passageiro.","player:seatPlayer","2","vehicle",false)
					exports["dynamic"]:AddButton("Mexer nos Vidros","Levantar/Abaixar os vidros.","player:Windows","","vehicle",false)

					exports["dynamic"]:SubMenu("Veículo","Funções do veículo.","vehicle")
				end

				exports["dynamic"]:AddButton("Porta do Motorista","Abrir porta do motorista.","player:Doors","1","doors",true)
				exports["dynamic"]:AddButton("Porta do Passageiro","Abrir porta do passageiro.","player:Doors","2","doors",true)
				exports["dynamic"]:AddButton("Porta Traseira Esquerda","Abrir porta traseira esquerda.","player:Doors","3","doors",true)
				exports["dynamic"]:AddButton("Porta Traseira Direita","Abrir porta traseira direita.","player:Doors","4","doors",true)
				exports["dynamic"]:AddButton("Porta-Malas","Abrir porta-malas.","player:Doors","5","doors",true)
				exports["dynamic"]:AddButton("Capô","Abrir capô.","player:Doors","6","doors",true)

				exports["dynamic"]:SubMenu("Portas","Portas do veículo.","doors")
			end

			exports["dynamic"]:AddButton("Propriedades","Marcar/Desmarcar propriedades no mapa.","propertys:Blips","","others",false)    ---player:status
			--exports["dynamic"]:AddButton("Armazéns", "Marcar/Desmarcar armazéns no mapa.", "warehouse:Blips", "", "others", false)
			exports["dynamic"]:AddButton("Ferimentos","Verificar ferimentos no corpo.","paramedic:Injuries","","others",false)
			exports["dynamic"]:AddButton("Desbugar","Recarregar o personagem.","barbershop:Debug","","others",true)
			--exports["dynamic"]:AddButton("Comercialização","Iniciar/Finalizar venda de drogas.","drugs:toggleService","","others",false)
			exports["dynamic"]:SubMenu("Outros","Todas as funções do personagem.","others")

			exports["dynamic"]:openMenu()
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TENCODEFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tencodeFunctions", function()
	if LocalPlayer["state"]["Police"] or LocalPlayer["state"]["Core"] and not IsPauseMenuActive() then
		if not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and not menuOpen and LocalPlayer["state"]["Route"] < 900000 then
			exports["dynamic"]:AddButton("QTI", "Deslocamento.", "dynamic:Tencode", "1", false, true)
			exports["dynamic"]:AddButton("QTH", "Localização.", "dynamic:Tencode", "2", false, true)
			exports["dynamic"]:AddButton("QRR", "Apoio com prioridade.", "dynamic:Tencode", "3", false, true)
			exports["dynamic"]:AddButton("QRT", "Oficial desmaiado/ferido.", "dynamic:Tencode", "4", false, true)
			exports["dynamic"]:openMenu()
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- EMERGENCYFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("emergencyFunctions", function()
	if (LocalPlayer["state"]["Police"] or LocalPlayer["state"]["Core"] or LocalPlayer["state"]["Paramedic"] or LocalPlayer["state"]["Mechanic"]) and not IsPauseMenuActive() and not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and not LocalPlayer["state"]["Prison"] and not Dynamic then
		local Ped = PlayerPedId()
		if LocalPlayer["state"]["Police"] then
			if GetEntityHealth(Ped) > 100 and not IsPedInAnyVehicle(Ped) then
				exports["dynamic"]:AddButton("Anunciar Police", "Fazer um anúncio para todos os moradores.", "dynamic:EmergencyAnnounce2", "", false, true)

				exports["dynamic"]:AddButton("Carregar", "Carregar a pessoa mais próxima.", "inventory:Carry", "", "player", true)
				exports["dynamic"]:AddButton("Colocar no Veículo", "Colocar no veículo mais próximo.", "player:cvFunctions", "cv", "player", true)
				exports["dynamic"]:AddButton("Remover do Veículo", "Remover do veículo mais próximo.", "player:cvFunctions", "rv", "player", true)
				exports["dynamic"]:AddButton("Remover Chapéu", "Remover da pessoa mais próxima.", "skinshop:Remove", "Hat", "player", true)
				exports["dynamic"]:AddButton("Remover Máscara", "Remover da pessoa mais próxima.", "skinshop:Remove", "Mask", "player", true)
				exports["dynamic"]:AddButton("Remover Óculos", "Remover da pessoa mais próxima.", "skinshop:Remove", "Glasses", "player", true)
				exports["dynamic"]:SubMenu("Jogador", "Pessoa mais próxima de você.", "player")

				exports["dynamic"]:AddButton("Recruta", "Fardamento de Recruta.", "player:Preset", "1", "prePolice", true)
				exports["dynamic"]:AddButton("Oficial", "Fardamento de oficial.", "player:Preset", "2", "prePolice", true)
				exports["dynamic"]:AddButton("Oficial 2", "Fardamento de oficial.", "player:Preset", "3", "prePolice", true)      --- NAO DESCOMENTAR --
				exports["dynamic"]:AddButton("GTM", "Fardamento de GTM.", "player:Preset", "4", "prePolice", true)
				exports["dynamic"]:AddButton("GAR", "Fardamento de GAR.", "player:Preset", "5", "prePolice", true)
				exports["dynamic"]:AddButton("DIP", "Fardamento de DIP.", "player:Preset", "6", "prePolice", true)
				exports["dynamic"]:AddButton("DIP - Delegado", "Fardamento de DIP.", "player:Preset", "7", "prePolice", true)
				exports["dynamic"]:AddButton("CORE", "Fardamento de CORE", "player:Preset", "8", "prePolice", true)
				exports["dynamic"]:AddButton("CORE 2", "Fardamento de CORE.", "player:Preset", "9", "prePolice", true)
				exports["dynamic"]:AddButton("GAEP", "Fardamento de GAEP.", "player:Preset", "10", "prePolice", true)
				exports["dynamic"]:AddButton("Comando", "Fardamento do Comando.", "player:Preset", "11", "prePolice", true)
				exports["dynamic"]:SubMenu("Fardamentos", "Todos os fardamentos policiais.", "prePolice")
			end

			exports["dynamic"]:AddButton("Computador", "Computador de bordo policial.", "police:Mdt", "", false, false)

			exports["dynamic"]:openMenu()
		elseif LocalPlayer["state"]["Mechanic"] then
			if GetEntityHealth(Ped) > 100 and not IsPedInAnyVehicle(Ped) then
				exports["dynamic"]:AddButton("Anunciar Mecanico", "Fazer um anúncio para todos os moradores.", "dynamic:AnnounceMec", "", false, true)

				exports["dynamic"]:AddButton("MECANICO", "Fardamento de MECHANIC", "player:Preset", "15", "preMechanic", true)
				exports["dynamic"]:SubMenu("Fardamentos", "Todos os fardamentos Mecanicos", "preMechanic")
			end

			---exports["dynamic"]:AddButton("Computador", "Computador de bordo policial.", "police:Mdt", "", false, false)

			exports["dynamic"]:openMenu()
		elseif LocalPlayer["state"]["Core"] then
				if GetEntityHealth(Ped) > 100 and not IsPedInAnyVehicle(Ped) then
					exports["dynamic"]:AddButton("Anunciar Police", "Fazer um anúncio para todos os moradores.", "dynamic:EmergencyAnnounce2", "", false, true)
	
					exports["dynamic"]:AddButton("Carregar", "Carregar a pessoa mais próxima.", "inventory:Carry", "", "player", true)
					exports["dynamic"]:AddButton("Colocar no Veículo", "Colocar no veículo mais próximo.", "player:cvFunctions", "cv", "player", true)
					exports["dynamic"]:AddButton("Remover do Veículo", "Remover do veículo mais próximo.", "player:cvFunctions", "rv", "player", true)
					exports["dynamic"]:AddButton("Remover Chapéu", "Remover da pessoa mais próxima.", "skinshop:Remove", "Hat", "player", true)
					exports["dynamic"]:AddButton("Remover Máscara", "Remover da pessoa mais próxima.", "skinshop:Remove", "Mask", "player", true)
					exports["dynamic"]:AddButton("Remover Óculos", "Remover da pessoa mais próxima.", "skinshop:Remove", "Glasses", "player", true)
					exports["dynamic"]:SubMenu("Jogador", "Pessoa mais próxima de você.", "player")
	
					exports["dynamic"]:AddButton("CORE", "Fardamento de CORE", "player:Preset", "8", "prePolice", true)
					exports["dynamic"]:AddButton("CORE 2", "Fardamento de CORE.", "player:Preset", "9", "prePolice", true)
					exports["dynamic"]:AddButton("GAEP", "Fardamento de GAEP.", "player:Preset", "10", "prePolice", true)
					--exports["dynamic"]:AddButton("Comando", "Fardamento do Comando.", "player:Preset", "11", "prePolice", true)
					exports["dynamic"]:SubMenu("Fardamentos", "Todos os fardamentos policiais.", "prePolice")
				end
	
				exports["dynamic"]:AddButton("Computador", "Computador de bordo policial.", "police:Mdt", "", false, false)
	
				exports["dynamic"]:openMenu()
		elseif LocalPlayer["state"]["Paramedic"] then
			if GetEntityHealth(Ped) > 100 and not IsPedInAnyVehicle(Ped) then
				exports["dynamic"]:AddButton("Anuncio Paramedic", "Fazer um anúncio para todos os moradores.", "dynamic:EmergencyAnnounceMedic", "", false, true)
				exports["dynamic"]:AddButton("Carregar", "Carregar a pessoa mais próxima.", "inventory:Carry", "", "player", true)
				exports["dynamic"]:AddButton("Colocar no Veículo", "Colocar no veículo mais próximo.", "player:cvFunctions", "cv", "player", true)
				exports["dynamic"]:AddButton("Remover do Veículo", "Remover do veículo mais próximo.", "player:cvFunctions", "rv", "player", true)
				exports["dynamic"]:AddButton("Remover Chapéu", "Remover da pessoa mais próxima.", "skinshop:Remove", "Hat", "player", true)
				exports["dynamic"]:AddButton("Remover Máscara", "Remover da pessoa mais próxima.", "skinshop:Remove", "Mask", "player", true)
				exports["dynamic"]:AddButton("Remover Óculos", "Remover da pessoa mais próxima.", "skinshop:Remove", "Glasses", "player", true)
				exports["dynamic"]:SubMenu("Jogador", "Pessoa mais próxima de você.", "player")

				exports["dynamic"]:AddButton("Medical Center", "Fardamento de doutor.", "player:Preset", "12", "preMedic", true)
				exports["dynamic"]:SubMenu("Fardamentos", "Todos os fardamentos médicos.", "preMedic")

				exports["dynamic"]:openMenu()
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMINFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("adminFunctions", function()
	if LocalPlayer["state"]["Admin"] and not IsPauseMenuActive() then
		if not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and not Dynamic and MumbleIsConnected() then
			local Ped = PlayerPedId()
			if LocalPlayer["state"]["Admin"] then
				exports["dynamic"]:SubMenu("Gerênciamento🔨", "Clique para mais informações.", "admin")
				exports["dynamic"]:AddButton("Whitelist", "Editar Whitelist de um ID.", "admin:Dynamic", "wl", "admin", true)
				exports["dynamic"]:AddButton("God", "Deixar o ID com tudo 100%.", "admin:Dynamic", "god", "admin", true)
				exports["dynamic"]:AddButton("Armour", "Deixar o ID com tudo Colete 100%.", "admin:Dynamic", "armour", "admin", true)
				exports["dynamic"]:AddButton("Announce", "Enviar um anúncio para todos.", "admin:Dynamic", "announce", "admin", true)
				exports["dynamic"]:AddButton("Rename", "Renomeie algum ID.", "admin:Dynamic", "rename", "admin", true)
				exports["dynamic"]:AddButton("Kick", "Expuldar o ID.", "admin:Dynamic", "kick", "admin", true)
				exports["dynamic"]:AddButton("Ban", "Banir o ID.", "admin:Dynamic", "ban", "admin", true)
				exports["dynamic"]:AddButton("Unban", "Desbanir o ID.", "admin:Dynamic", "unban", "admin", true)
				--exports["dynamic"]:AddButton("Clearprison", "Limpar prisão do ID.", "admin:Dynamic", "clearprison", "admin", true)

				exports["dynamic"]:SubMenu("Trolls Admins🤣", "Clique para mais informações.", "trolls")
				exports["dynamic"]:AddButton("Neymar⚽", "Derrubar Players", "admin:Dynamic", "ney", "trolls", true)
				exports["dynamic"]:AddButton("Voa Passarinho 🪂", "Mandar Players pras Alturas", "admin:Dynamic", "voar", "trolls", true)
				exports["dynamic"]:AddButton("Explodir 🔥", "Explodir Players", "admin:Dynamic", "explodir", "trolls", true)
				exports["dynamic"]:AddButton("Foguinho 🔥", "Colocar fogo em Players", "admin:Dynamic", "fogo", "trolls", true)
				exports["dynamic"]:AddButton("Congelar ⛄", "Congelar Players", "admin:Dynamic", "gelo", "trolls", true)

				exports["dynamic"]:SubMenu("Clima🌞", "Clique para mais informações.", "weather")
				exports["dynamic"]:AddButton("Timeset", "Mudar o Clima do jogo.", "admin:Dynamic", "timeset", "weather", true)
				--exports["dynamic"]:AddButton("Temperatureset", "Mudar a Temperatura do jogo.", "admin:Dynamic", "temperatureset", "weather", true)
				--exports["dynamic"]:AddButton("Blackoutset", "Ativar/Desativar o Blackout.", "admin:Dynamic", "blackoutset", "weather", true)

				exports["dynamic"]:SubMenu("Grupos📑", "Clique para mais informações.", "groups")
				exports["dynamic"]:AddButton("Ugroups", "Veja quais grupos do ID.", "admin:Dynamic", "ugroups", "groups", true)
				exports["dynamic"]:AddButton("Group", "Dar um grupo para o ID.", "admin:Dynamic", "group", "groups", true)
				exports["dynamic"]:AddButton("Ungroup", "Remover o grupo de um ID.", "admin:Dynamic", "ungroup", "groups", true)

				exports["dynamic"]:SubMenu("Personagens🤝🏼", "Clique para mais informações.", "peds")
				exports["dynamic"]:AddButton("Skin", "Mude a Skin do ID.", "admin:Dynamic", "skin", "peds", true)
				exports["dynamic"]:AddButton("Resetskin", "Resete a Skin do ID.", "admin:Dynamic", "resetskin", "peds", true)
				exports["dynamic"]:AddButton("Delete", "Delete a conta do ID.", "admin:Dynamic", "delete", "peds", true)

				exports["dynamic"]:SubMenu("Veículos🚗", "Clique para mais informações.", "vehicles")
				exports["dynamic"]:AddButton("Tuning", "Tunar o veículo atual.", "admin:Dynamic", "tuning", "vehicles", true)
				exports["dynamic"]:AddButton("Deletar Veiculo", "Deletar o Veiculo mais Proximo.", "admin:Dynamic", "dv", "vehicles", true)
				exports["dynamic"]:AddButton("Fix", "Arrumar o veículo atual.", "admin:Dynamic", "fix", "vehicles", true)
				exports["dynamic"]:AddButton("Fuel", "Defina a Gasolina no veículo atual.", "admin:Dynamic", "fuel", "vehicles", true)
				exports["dynamic"]:AddButton("Hash", "Pegar a Hash do veículo atual.", "admin:Dynamic", "hash", "vehicles", true)

				exports["dynamic"]:SubMenu("Financeiros💰", "Clique para mais informações.", "wallet")
				exports["dynamic"]:AddButton("Setbank", "Dar dinheiro para o ID.", "admin:Dynamic", "setbank", "wallet", true)
				exports["dynamic"]:AddButton("Rembank", "Remover dinheiro do ID.", "admin:Dynamic", "rembank", "wallet", true)
				exports["dynamic"]:AddButton("Setar Gemstones", "Inserir gemstones no ID.", "admin:Dynamic", "gem", "wallet", true)

				exports["dynamic"]:SubMenu("Spawn Itens⭐", "Clique para mais informações.", "item")
				exports["dynamic"]:AddButton("Clearinv", "Limpe o inventário do ID.", "admin:Dynamic", "clearinv", "item", true)
				exports["dynamic"]:AddButton("Item", "Pegar Itens para você.", "admin:Dynamic", "item", "item", true)
				exports["dynamic"]:AddButton("Item2", "Dar Itens para o ID.", "admin:Dynamic", "item2", "item", true)
				exports["dynamic"]:AddButton("Itemall", "Dar Itens para todos conectados.", "admin:Dynamic", "itemall", "item", true)

				exports["dynamic"]:SubMenu("Comandos Admins🔐", "Clique para mais informações.", "basic")
				exports["dynamic"]:AddButton("Blips", "Ativar/Desativar os Blips.", "admin:Dynamic", "blips", "basic", true)
				exports["dynamic"]:AddButton("Nc", "Ativar/Desativar o NoClip.", "admin:Dynamic", "nc", "basic", true)
				exports["dynamic"]:AddButton("Flash", "Ativar/Desativar o efeito Flash.", "admin:Dynamic", "flash", "basic", true)
				exports["dynamic"]:AddButton("Cds", "Pegue sua coordenada atual.", "admin:Dynamic", "cds", "basic", true)
				exports["dynamic"]:AddButton("Tpcds", "Teletransporte para uma coordenada.", "admin:Dynamic", "tpcds", "basic", true)
				exports["dynamic"]:AddButton("Tptome", "Teletransporte um ID para você.", "admin:Dynamic", "tptome", "basic", true)
				exports["dynamic"]:AddButton("Tpto", "Teletransporte para um ID.", "admin:Dynamic", "tpto", "basic", true)
				exports["dynamic"]:AddButton("Tpway", "Teletransporte para uma marcação no GPS.", "admin:Dynamic", "tpway", "basic", true)
				--exports["dynamic"]:AddButton("Limparea", "Limpar a área próxima a você.", "admin:Dynamic", "limparea", "basic", true) 
				exports["dynamic"]:AddButton("Debug", "Ativar/Desativar o Debug.", "admin:Dynamic", "debug", "basic", true)
				exports["dynamic"]:AddButton("Players", "Verifique quantos onlines existem.", "admin:Dynamic", "players", "basic", true)
				--exports["dynamic"]:AddButton("PlayersConnected", "Verifique os players onlines.", "admin:Dynamic", "playersconnected", "basic", true)

				exports["dynamic"]:openMenu()
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYMAPPING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("globalFunctions","Abrir menu principal.","keyboard","F9")
RegisterKeyMapping("tencodeFunctions","Abrir menu de chamados policiais.","keyboard","F3")
RegisterKeyMapping("emergencyFunctions","Abrir menu de emergencial.","keyboard","F10")
RegisterKeyMapping("adminFunctions", "Abrir menu de administração.", "keyboard", "INSERT")