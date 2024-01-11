-----------------------------------------------------------------------------------------------------------------------------------------
-- kadu
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Kaduzera = {}
Tunnel.bindInterface("admin",Kaduzera)
vCLIENT = Tunnel.getInterface("admin")
vKEYBOARD = Tunnel.getInterface("keyboard")



RegisterNetEvent("kaduzera:blips")
AddEventHandler("kaduzera:blips", function(players)
    Blipmin = not Blipmin

    while Blipmin do
        local players = GetPlayers()

        for _, player in ipairs(players) do
            local playerID = GlobalState["Players"][player]
            if playerID then
                local fullName = vRP.FullName(playerID) -- FullName(Passport)
                local ped = GetPlayerPed(player)
                DrawText3D(GetEntityCoords(ped), "~o~ID:~w~ " .. playerID .. "     ~g~Vida:~w~ " .. GetEntityHealth(ped) .. "     ~y~Colete:~w~ " .. GetPedArmour(ped).. "     ~b~Nome:~w~ " .. fullName, 0.425)
            end
        end

        Wait(0)
    end
end)

RegisterCommand("kadu2", function(source)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport, "Admin", 3) then
            TriggerClientEvent("kaduzera:blips", source)
        end
    end
end)





-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETE ALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("deleteall",function(source,Message,rawCmd)
    local Passport = vRP.Passport(source)
    if not vRP.HasGroup(Passport,"Admin") then
        return
    end

    if not Message[1] then
        return
    end

    if Message[1] == "objects" then
        for _i,item in pairs(GetAllObjects()) do
            DeleteEntity(item)
        end
        vRPC.removeObjects(source)
        vRPC.removeActived(source)
        TriggerClientEvent("Notify",source,"amarelo","Todos os objetos foram <b>DELETADOS</b> com sucesso",10000)
    elseif Message[1] == "npcs" then
        for _,pedHandle in pairs(GetAllPeds()) do
            DeleteEntity(pedHandle)
        end
        TriggerClientEvent("Notify",source,"amarelo","Todos os npcs foram <b>DELETADOS</b> com sucesso",10000)
    elseif Message[1] == "vehicles" then
        for _,vehicles in pairs(GetAllVehicles()) do
            DeleteEntity(vehicles)
        end
        TriggerClientEvent("Notify",source,"amarelo","Todos os veículos foram <b>DELETADOS</b> com sucesso",10000)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIMPAREA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("limpararea", function(source, args)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport, "Admin",2) then
            local Ped = GetPlayerPed(source)
            local Coords = GetEntityCoords(Ped)
            vCLIENT.Limparea(source, Coords)
        else
            TriggerClientEvent("Notify", source, "amarelo", "Você não tem permissões para isso.", 5000)
        end
    else
        TriggerClientEvent("Notify", source, "vermelho", "Area Limpa.", 5000)
    end
end)

RegisterCommand("mundo2", function(source, Message)
    local Passport = vRP.Passport(source)
    if vRP.HasGroup(Passport, "Admin", 1) then
        if #args == 1 then
            local routingBucket = tonumber(Message[1])
            if routingBucket then
                SetPlayerRoutingBucket(Passport, routingBucket)
            else
                -- Mensagem de erro para o caso de o argumento não ser um número válido.
                TriggerClientEvent("Notify", source, "vermelho", "use /mundo 1,2 ou 3", 5000)
            end
        else
            -- Mensagem de erro para o caso de a sintaxe do comando estar errada.
            --TriggerEvent('chatMessage', '^1Erro: Use /mundo [bucket]', {255, 0, 0})
        end
    else
        -- Mensagem de erro para jogadores que não têm a permissão "Admin".
        TriggerClientEvent("Notify", source, "vermelho", "Voce nao tem permissão para usar isso.", 5000)
    end
end, false)

RegisterCommand("mundo", function(source, args)
    local Passport = source
    if vRP.HasGroup(Passport, "Admin", 1) then
        if #args == 2 then
            local targetPlayerId = tonumber(args[1])
            local routingBucket = tonumber(args[2])
            if targetPlayerId and routingBucket then
                SetPlayerRoutingBucket(targetPlayerId, routingBucket)
                local notification = " Jogador: " .. targetPlayerId .. " definido para a dimensão: " .. routingBucket
                TriggerClientEvent("Notify", source, "verde", notification,10000) -- Envia a notificação em vermelho para o jogador que executa o comando
            else
                -- Mensagem de erro para o caso de os argumentos não serem números válidos.
                TriggerClientEvent("Notify", source, "vermelho", "^1Erro: Use /mundo2 [ID do jogador] [dimensão]",7500)
            end
        else
            -- Mensagem de erro para o caso de a sintaxe do comando estar errada.
            TriggerClientEvent("Notify", source, "vermelho", "^1Erro: Use /mundo2 [ID do jogador] [bucket]",10000)
        end
    else
        -- Mensagem de erro para jogadores que não têm a permissão "Admin".
        TriggerClientEvent("Notify", source, "vermelho", "^1Erro: Você não tem permissão para usar este comando.",7500)
    end
end, false)

-----------------------------------------------------------------------------------------------------------------------------------------
-- Checar a quantidade de players e ids online.     ~ admin/server-side/core.lua
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("pon",function(source,args,rawCommand)
    local Passport = vRP.Passport(source)
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
        TriggerClientEvent("Notify",source,"amarelo","TOTAL ONLINE : <b>"..quantidade.."</b><br>ID's ONLINE : <b>"..players.."</b>",5000)
    end
end)
RegisterCommand("ptr", function(source)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport, "Admin",4) then
            local id, Police = vRP.NumPermission("Police")
            local id, Mecanico = vRP.NumPermission("Mechanic")
            local id, Paramedico = vRP.NumPermission("Paramedic")
            
            local message = "POLICIAIS ONLINE : <b>" .. Police .. "</b><br>MEDICOS ONLINE : <b>" .. Paramedico .. "</b><br>MECANICOS ONLINE : <b>" .. Mecanico .. "</b>"
            TriggerClientEvent("Notify", source, "azul", message, 5000)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLACKOUT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("blackout", function(source, args)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
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
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BARBERSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tatu",function(source)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",3) then
			TriggerClientEvent("tattooshop:Open",source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BARBERSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("barbearia",function(source)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",3) then
			TriggerClientEvent("barbershop:Open",source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKINSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("skinshop",function(source)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",3) then
			TriggerClientEvent("skinshop:Open",source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- freecam
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cam",function(source)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",3) then
			TriggerClientEvent("freecam:Active",source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDBACK - 
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("addback",function(source,args,rawCommand)
    local Passport = vRP.Passport(source)
    if Passport and args[1] then
        if vRP.HasGroup(Passport,"Admin",1) then
            local OtherPassport = parseInt(args[1])
            local PesoBack = parseInt(args[2])
            vRP.SetWeight(OtherPassport,PesoBack)
            TriggerClientEvent("Notify",source,"verde","Mochila adicionado para <b>"..OtherPassport.."</b> em "..PesoBack.."KG.",5000)
			TriggerEvent("Discord","Addback","**Add Back**\n\n**Passaporte:** "..Passport.."\n**Para o ID :** "..args[1].."\n**Kilos Setados :** "..args[2].."kg \n**Horário:** "..os.date("%H:%M:%S"),3553599)
        end
    end
end)

RegisterCommand("algemar", function(source, Message)
    local Passport = vRP.Passport(source)
    if Passport and Message[1] then
        if vRP.HasGroup(Passport, "Admin", 1) then
            local OtherPassport = tonumber(Message[1])
            local PlayerState = Player(OtherPassport)

            if PlayerState then
                if PlayerState["state"]["Handcuff"] then
                    PlayerState["state"]["Handcuff"] = false
					vRPC.stopAnim(source,true)
                    TriggerClientEvent("Notify", source, "verde", "Você desalgemou o jogador com ID " .. OtherPassport, 5000)
                else
                    PlayerState["state"]["Handcuff"] = true
					TriggerClientEvent("Hud:RadioClean",OtherPassport)
                    TriggerClientEvent("Notify", source, "verde", "Você algemou o jogador com ID " .. OtherPassport, 5000)
                end
                TriggerClientEvent("sounds:source", source, "cuff", 0.5)
            else
                TriggerClientEvent("Notify", source, "vermelho", "ID do jogador inválido.", 5000)
            end
        else
            TriggerClientEvent("Notify", source, "vermelho", "Você não tem permissão para usar este comando.", 5000)
        end
    else
        TriggerClientEvent("Notify", source, "vermelho", "Você não possui um passaporte válido para usar este comando.", 5000)
    end
end, false)


-----------------------------------------------------------------------------------------------------------------------------------------
-- REMBACK - 
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("remback",function(source,args,rawCommand)
    local Passport = vRP.Passport(source)
    if Passport and args[1] then
        if vRP.HasGroup(Passport,"Admin",1) then
            local OtherPassport = parseInt(args[1])
            local PesoBack = parseInt(args[2])
            vRP.RemoveWeight(OtherPassport,PesoBack)
            TriggerClientEvent("Notify",source,"verde","Mochila removida de <b>"..OtherPassport.."</b> em "..PesoBack.."KG.",5000)
			TriggerEvent("Discord","Remback","**Rem Back**\n\n**Passaporte:** "..Passport.."\n**Retirou do ID :** "..args[1].."\n**Kilos Retirados :** "..args[2].."kg \n**Horário:** "..os.date("%H:%M:%S"),3553599)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDCAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("addcar",function(source,Message)
	local source = source
	local Passport = vRP.Passport(source)
	local Sources = vRP.Source(Message[1])
	if vRP.HasGroup(Passport,"Admin",2) then
		if Passport and Message[1] and Message[2] then
			vRP.Query("vehicles/addVehicles",{ Passport = parseInt(Message[1]), vehicle = Message[2], plate = vRP.GeneratePlate(), work = tostring(false) })
			TriggerClientEvent("Notify",source,"verde","Adicionado o veiculo <b>"..Message[2].."</b> na garagem de ID <b>"..Message[1].."</b>.",10000)
			TriggerClientEvent("Notify",Sources,"verde","Adicionado o veiculo <b>"..Message[2].."</b> em sua garagem<b> .",10000)
			TriggerEvent("Discord","Addcar","**Add Car**\n\n**Passaporte:** "..Passport.."\n**Adicionou Carro :** "..Message[2].."\n**Na Garagem do ID :** "..Message[1].." \n**Horário:** "..os.date("%H:%M:%S"),3553599)
		end
	end
end)
RegisterCommand("remcar",function(source,Message)
	local source = source
	local Passport = vRP.Passport(source)
	if vRP.HasGroup(Passport,"Admin",2) then
		if Passport and Message[1] and Message[2] then
			vRP.Query("vehicles/removeVehicles",{ Passport = parseInt(Message[1]), vehicle = Message[2]})
			TriggerClientEvent("Notify",source,"verde","Retirado o veiculo <b>"..Message[2].."</b> da garagem de ID <b>"..Message[1].."</b>.",10000)
			TriggerEvent("Discord","Remcar","**Rem Car**\n\n**Passaporte:** "..Passport.."\n**Retirou Carro :** "..Message[2].."\n**Da Garagem do ID :** "..Message[1].." \n**Horário:** "..os.date("%H:%M:%S"),3553599)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANNOUNCE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("anuncio", function(source, args)
    local source = source
    local Passport = vRP.Passport(source)
    if Passport then
        local identity = vRP.Identity(source)
        if vRP.HasGroup(Passport, "Admin",3) then
            local message = vKEYBOARD.keyArea(source, "Mensagem:")
            if message and message[1] then
                --local playerName = Governador
                local finalMessage = message[1] .. "<br></br>Enviada Por: Governador"
                TriggerClientEvent("Notify", -1, "verde", finalMessage .. "</b>", 45000)
            else
                TriggerClientEvent("Notify", source, "vermelho", "A mensagem não pode estar vazia.", 5000)
            end
        else
            TriggerClientEvent("Notify", source, "vermelho", "Você não tem permissões para isso.", 5000)
        end
    end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- ANNOUNCE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("avisopm",function(source)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",1) or vRP.HasGroup(Passport,"Police") then
			local Keyboard = vKEYBOARD.keyArea(source,"Mensagem:")
			if Keyboard then
				TriggerClientEvent("Notify",-1,"police",Keyboard[1],30000)
				TriggerEvent("Discord","Avisopm","**Aviso PM**\n\n**Passaporte:** "..Passport.."\n**Enviou no Avisopm:** "..Keyboard[1].."\n**Horário:** "..os.date("%H:%M:%S"),3553599)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANNOUNCE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("avisomec",function(source)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",1) or vRP.HasGroup(Passport,"Mechanic") then
			local Keyboard = vKEYBOARD.keyArea(source,"Mensagem:")
			if Keyboard then
				TriggerClientEvent("Notify",-1,"mecanico",Keyboard[1],30000)
				TriggerEvent("Discord","Avisomec","**Aviso MEC**\n\n**Passaporte:** "..Passport.."\n**Enviou no AvisoMEC:** "..Keyboard[1].."\n**Horário:** "..os.date("%H:%M:%S"),3553599)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEBUG
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("debug",function(source)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",1) then
			TriggerClientEvent("ToggleDebug",source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MODMAIL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("modmail",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",2) and parseInt(Message[1]) > 0 then
			local OtherPassport = parseInt(Message[1])
			local ClosestPed = vRP.Source(OtherPassport)
			if ClosestPed then
			    local Keyboard = vKEYBOARD.keyTertiary(source,"Mensagem:","Cor:","Tempo (em MS):")
			        if Keyboard then
			        TriggerClientEvent("Notify",ClosestPed,Keyboard[2],Keyboard[1],Keyboard[3])
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESTARTED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("restarte",function(source,Message,History)
	if source == 0 then
		GlobalState["Weather"] = "THUNDER"
		TriggerClientEvent("Notify",-1,"amarelo","Um grande terremoto se aproxima, abriguem-se enquanto há tempo pois o terremoto chegará em" ..History:sub(9).. " minutos.",60000)
		print("Terremoto anunciado")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESTARTEDCANCEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("restartecancel",function(source)
	if source == 0 then
		GlobalState["Weather"] = "EXTRASUNNY"
		TriggerClientEvent("Notify",-1,"amarelo","Nosso sistema meteorológico detectou que o terremoto passou por agora, porém o mesmo pode voltar a qualquer momento",60000)
		print("Terremoto cancelado")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UGROUPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ugroups",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and parseInt(Message[1]) > 0 then
		local Messages = ""
		local Groups = vRP.Groups()
		local OtherPassport = Message[1]
		for Permission,_ in pairs(Groups) do
			local Data = vRP.DataGroups(Permission)
			if Data[OtherPassport] then
				Messages = Messages..Permission.."<br>"
			end
		end

		if Messages ~= "" then
			TriggerClientEvent("Notify",source,"verde",Messages,30000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPCDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("wl",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		local OtherPassport = parseInt(Message[1])
		if vRP.HasGroup(Passport,"Admin",4) and OtherPassport > 0 then
			TriggerClientEvent("Notify",source,"verde","ID: <b>"..Message[1].."</b> Liberado <b>",5000)
			vRP.Query("accounts/updateWhitelist",{ id = Message[1], whitelist = 1 })
			TriggerEvent("Discord","wl","**al**\n\n**Passaporte:** "..Passport.."\n**Aprovou ID:** "..Message[1]" Na Whitelist",3553599)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEARINV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("clearinv",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",3) and parseInt(Message[1]) > 0 then
			TriggerClientEvent("Notify",source,"verde","Limpeza concluída.",5000)
			vRP.ClearInventory(Message[1])

			TriggerEvent("Discord","Clearinv","**clearinv**\n\n**Passaporte:** "..Passport.."\n**Limpou Inventario do ID:** "..Message[1],3553599)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEARCHEST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("clearchest",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",1) and Message[1] then
			local Consult = vRP.Query("chests/GetChests",{ name = Message[1] })
			if Consult[1] then
				TriggerClientEvent("Notify",source,"verde","Limpeza concluída.",5000)
				vRP.SetSrvData("Chest:"..Message[1],{},true)
				
				TriggerEvent("Discord","Clearchest","**clearchest**\n\n**Passaporte:** "..Passport.."\n**Chest:** "..Message[2],3553599)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("gem",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",1) and parseInt(Message[1]) > 0 and parseInt(Message[2]) > 0 then
			local Amount = parseInt(Message[2])
			local OtherPassport = parseInt(Message[1])
			local Identity = vRP.Identity(OtherPassport)
			if Identity then
				TriggerClientEvent("Notify",source,"verde","Gemas entregues.",5000)
				vRP.Query("accounts/AddGems",{ license = Identity["license"], gems = Amount })
				vRP.UpgradeGemstone(Passport,Amount)
				TriggerEvent("Discord","Gemstone","**Source:** "..source.."\n**Passaporte:** "..Passport.."\n**Para:** "..OtherPassport.."\n**Gemas:** "..Amount.."\n**Address:** "..GetPlayerEndpoint(source),3092790)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("addgem",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",1) and parseInt(Message[1]) > 0 and parseInt(Message[2]) > 0 then
			local Amount = parseInt(Message[2])
			local OtherPassport = parseInt(Message[1])
			local Identity = vRP.Identity(OtherPassport)
			if Identity then
				TriggerClientEvent("Notify",source,"verde","Gemas entregues.",5000)
				vRP.UpgradeGemstone(OtherPassport,Amount)
				
				local OtherSource = vRP.Source(OtherPassport)
				if OtherSource then
					TriggerClientEvent("Notify",OtherSource,"azul","Você recebeu <b>"..Amount.."x Gemas</b>.",5000)
				end
				
				TriggerEvent("Discord","Gemstone","**Source:** "..source.."\n**Passaporte:** "..Passport.."\n**Para:** "..OtherPassport.."\n**Gemas:** "..Amount.."\n**Address:** "..GetPlayerEndpoint(source),3092790)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
local Blips = {}

RegisterCommand("blips", function(source)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport, "Admin", 1) or vRP.HasGroup(Passport, "Staff", 1) then
            local Text = ""

            if not Blips[Passport] then
                Blips[Passport] = true
                Text = "Ativado"
				TriggerEvent("Discord", "Blips", "**blips**\n\n**Passaporte:** " .. Passport .. "\n**Situação:** " .. Text .. " \n**Horário:** " .. os.date("%H:%M:%S"), 3553599)
            else
                Blips[Passport] = nil
                Text = "Desativado"
				TriggerEvent("Discord", "Blips", "**blips**\n\n**Passaporte:** " .. Passport .. "\n**Situação:** " .. Text .. " \n**Horário:** " .. os.date("%H:%M:%S"), 3553599)
            end

            vRPC.BlipAdmin(source)

            if Blips[Passport] then
            else
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("god",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",4) then
			if Message[1] then
				TriggerEvent("Discord","God","**Passaporte:** "..Passport.."\n**Comando:** god "..Message[1],0xa3c846)
				local OtherPassport = parseInt(Message[1])
				local ClosestPed = vRP.Source(OtherPassport)
				if ClosestPed then
					vRP.UpgradeThirst(OtherPassport,100)
					vRP.UpgradeHunger(OtherPassport,100)
					vRP.DowngradeStress(OtherPassport,100)
					vRP.Revive(ClosestPed,200)
					TriggerEvent("Discord","God","**god**\n\n**Passaporte:** "..Passport.."\n**Para:** "..OtherPassport.." \n**Horário:** "..os.date("%H:%M:%S"),3553599)
				end
			else
				vRP.Revive(source,200,true)
				vRP.SetArmour(source,99)
				vRP.UpgradeThirst(Passport,100)
				vRP.UpgradeHunger(Passport,100)
				vRP.DowngradeStress(Passport,100)
				TriggerEvent("Discord","God","**god**\n\n**Passaporte:** "..Passport.."\n**Deu God em Si mesmo:** \n**Horário:** "..os.date("%H:%M:%S"),3553599)

				TriggerClientEvent("paramedic:Reset",source)

				vRPC.Destroy(source)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("good",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",1) then
			if Message[1] then
				local OtherPassport = parseInt(Message[1])
				local ClosestPed = vRP.Source(OtherPassport)
				if ClosestPed then
					vRP.UpgradeThirst(OtherPassport,100)
					vRP.UpgradeHunger(OtherPassport,100)
					vRP.DowngradeStress(OtherPassport,100)
					vRP.Revive(ClosestPed,200)
					vRP.SetArmour(source,99)
					TriggerEvent("Discord","God","**god**\n\n**Passaporte:** "..Passport.."\n**Para:** "..OtherPassport.." \n**Horário:** "..os.date("%H:%M:%S"),3553599)
				end
			else
				vRP.Revive(source,200,true)
				vRP.SetArmour(source,99)
				vRP.UpgradeThirst(Passport,100)
				vRP.UpgradeHunger(Passport,100)
				vRP.DowngradeStress(Passport,100)
				TriggerEvent("Discord","God","**god**\n\n**Passaporte:** "..Passport.."\n**Deu God em Si mesmo:** \n**Horário:** "..os.date("%H:%M:%S"),3553599)

				TriggerClientEvent("paramedic:Reset",source)

				vRPC.Destroy(source)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("kill",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",2) then
			if Message[1] then
				TriggerEvent("Discord","God","**Passaporte:** "..Passport.."\n**Comando:** god "..Message[1],0xa3c846)
				local OtherPassport = parseInt(Message[1])
				local ClosestPed = vRP.Source(OtherPassport)
				if ClosestPed then
					vRP.UpgradeThirst(OtherPassport,100)
					vRP.UpgradeHunger(OtherPassport,100)
					vRP.DowngradeStress(OtherPassport,100)
					vRP.Revive(ClosestPed,100)
					TriggerEvent("Discord","God","**god**\n\n**Passaporte:** "..Passport.."\n**Para:** "..OtherPassport.." \n**Horário:** "..os.date("%H:%M:%S"),3553599)
				end
			else
				vRP.Revive(source,100,true)
				vRP.SetArmour(source,99)
				vRP.UpgradeThirst(Passport,100)
				vRP.UpgradeHunger(Passport,100)
				vRP.DowngradeStress(Passport,100)
				TriggerEvent("Discord","God","**god**\n\n**Passaporte:** "..Passport.."\n**Deu God em Si mesmo:** \n**Horário:** "..os.date("%H:%M:%S"),3553599)

				TriggerClientEvent("paramedic:Reset",source)

				vRPC.Destroy(source)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("god2",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",1) or vRP.HasGroup(Passport,"Staff",1) then
			if Message[1] then
				local OtherPassport = parseInt(Message[1])
				local ClosestPed = vRP.Source(OtherPassport)
				if ClosestPed then
					vRP.UpgradeThirst(OtherPassport,100)
					vRP.UpgradeHunger(OtherPassport,100)
					vRP.DowngradeStress(OtherPassport,100)
					vRP.Revive(ClosestPed,150)
					--vRP.SetArmour(source,99)
					TriggerEvent("Discord","God22","**god**\n\n**Passaporte:** "..Passport.."\n**Para:** "..OtherPassport.." \n**Horário:** "..os.date("%H:%M:%S"),3553599)
				end
			else
				vRP.Revive(source,150,true)
				--vRP.SetArmour(source,99)
				vRP.UpgradeThirst(Passport,100)
				vRP.UpgradeHunger(Passport,100)
				vRP.DowngradeStress(Passport,100)
				TriggerEvent("Discord","God22","**god**\n\n**Passaporte:** "..Passport.."\n**Deu God em Si mesmo:** \n**Horário:** "..os.date("%H:%M:%S"),3553599)

				TriggerClientEvent("paramedic:Reset",source)

				vRPC.Destroy(source)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("item",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",1) then
			if Message[1] and Message[2] and itemBody(Message[1]) ~= nil then
				local Amount = parseInt(Message[2])
				vRP.GenerateItem(Passport,Message[1],Amount,true)
				TriggerClientEvent("inventory:Update",source,"Backpack")
				TriggerEvent("Discord","Item","**item**\n\n**Passaporte:** "..Passport.."\n**Item:** "..Amount.."x "..itemName(Message[1]).." \n**Horário:** "..os.date("%H:%M:%S"),3553599)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEM2
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("item2",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",1) and Message[3] and itemBody(Message[1]) then
			local OtherPassport = parseInt(Message[3])
			if OtherPassport > 0 then
				local Amount = parseInt(Message[2])
				local Item = itemName(Message[1])
				vRP.GenerateItem(Message[3],Message[1],Amount,true)
				TriggerClientEvent("Notify",source,"verde","Você enviou <b>"..Amount.."x "..Item.."</b> para o passaporte <b>"..OtherPassport.."</b>.",5000)
				
				TriggerEvent("Discord","Item2","**item2*\n\n**Passaporte:** "..Passport.."\n**Para:** "..OtherPassport.."\n**Item:** "..Amount.."x "..Item.." \n**Horário:** "..os.date("%H:%M:%S"),3553599)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("delete",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and Message[1] then
		if vRP.HasGroup(Passport,"Admin",1) then
			local OtherPassport = parseInt(Message[1])
			vRP.Query("characters/removeCharacter",{ id = OtherPassport })
			TriggerClientEvent("Notify",source,"verde","Personagem <b>"..OtherPassport.."</b> deletado.",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NC
-----------------------------------------------------------------------------------------------------------------------------------------
local Noclip = {}

RegisterCommand("nc", function(source)
    local Passport = vRP.Passport(source)

    if Passport then
        if vRP.HasGroup(Passport, "Admin", 4) then
            local Text = ""
            local Action = ""

            if not Noclip[Passport] then
                Noclip[Passport] = true
                Text = "Ativado"
                Action = "ativou"
            else
                Noclip[Passport] = false
                Text = "Desativado"
                Action = "desativou"
            end

            TriggerEvent("Discord", "God", "**nc**\n\n**Passaporte:** " .. Passport .. "\n**Situação:** " .. Text .. " \n**Horário:** " .. os.date("%H:%M:%S"), 3553599)
            
            -- Move a chamada da função para cá, após enviar a mensagem
            vRPC.noClip(source, Noclip[Passport])
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KICK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("kick",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",3) and parseInt(Message[1]) > 0 then
			local OtherSource = vRP.Source(Message[1])
			if OtherSource then
				TriggerClientEvent("Notify",source,"amarelo","Passaporte <b>"..Message[1].."</b> expulso.",5000)
				vRP.Kick(OtherSource,"Expulso da cidade.")
				
				TriggerEvent("Discord","Kick","**kick**\n\n**Passaporte:** "..Passport.."\n**Expulsou Passaporte:** "..Message[1].." \n**Horário:** "..os.date("%H:%M:%S"),3553599)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ban",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",3) and parseInt(Message[1]) > 0 and parseInt(Message[2]) > 0 then
			local Days = parseInt(Message[2])
			local OtherPassport = parseInt(Message[1])
			local Identity = vRP.Identity(OtherPassport)
			if Identity then
				vRP.Query("banneds/InsertBanned",{ license = Identity["license"], time = Days })
				TriggerClientEvent("Notify",source,"amarelo","Passaporte <b>"..OtherPassport.."</b> banido por <b>"..Days.."</b> dias.",5000)
				TriggerEvent("Discord","Ban","**ban**\n\n**Passaporte:** "..Passport.."\n**Para:** "..Message[1].."\n**Tempo:** "..Message[2].." dias \n**Horário:** "..os.date("%H:%M:%S"),3553599)
				
				local OtherSource = vRP.Source(OtherPassport)
				if OtherSource then
					vRP.Kick(OtherSource,"Banido.")
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNBAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("unban",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",1) or vRP.HasGroup(Passport,"Staff",1) and parseInt(Message[1]) > 0 then
			local OtherPassport = parseInt(Message[1])
			local Identity = vRP.Identity(OtherPassport)
			if Identity then
				vRP.Query("banneds/RemoveBanned",{ license = Identity["license"] })
				TriggerClientEvent("Notify",source,"verde","Passaporte <b>"..OtherPassport.."</b> desbanido.",5000)
				
				TriggerEvent("Discord","Unban","**unban**\n\n**Passaporte:** "..Passport.."\n**Para:** "..OtherPassport.." \n**Horário:** "..os.date("%H:%M:%S"),3553599)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPCDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tpcds",function(source)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",2) then
			local Keyboard = vKEYBOARD.keySingle(source,"Cordenadas:")
			if Keyboard then
				local Split = splitString(Keyboard[1],",")
				vRP.Teleport(source,Split[1] or 0,Split[2] or 0,Split[3] or 0)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cds",function(source)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",2) or vRP.HasGroup(Passport,"Staff",1) then
			local Ped = GetPlayerPed(source)
			local Coords = GetEntityCoords(Ped)
			local heading = GetEntityHeading(Ped)

			vKEYBOARD.keyCopy(source,"Cordenadas:",mathLength(Coords["x"])..","..mathLength(Coords["y"])..","..mathLength(Coords["z"])..","..mathLength(heading))
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GROUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("group",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if  parseInt(Message[1]) > 0 and Message[2] and parseInt(Message[3]) then
			if Passport == 1 or Passport == 3 or vRP.HasGroup(Passport,"Admin",2) then
				TriggerClientEvent("Notify",source,"verde","Adicionado <b>"..Message[2].."</b> ao passaporte <b>"..Message[1].."</b>.",5000)
				TriggerEvent("Discord","Group","**ID:** "..Passport.."\n**Setou:** "..Message[1].." \n**Grupo:** "..Message[2].." \n**Horário:** "..os.date("%H:%M:%S"),3092790)
				vRP.SetPermission(Message[1],Message[2],Message[3])
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNGROUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ungroup",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",4) and parseInt(Message[1]) > 0 and Message[2] then
			TriggerClientEvent("Notify",source,"verde","Removido <b>"..Message[2].."</b> ao passaporte <b>"..Message[1].."</b>.",5000)
			TriggerEvent("Discord","Ungroup","**ID:** "..Passport.."\n**Removeu:** "..Message[1].." \n**Grupo:** "..Message[2].." \n**Horário:** "..os.date("%H:%M:%S"),3092790)
			vRP.RemovePermission(Message[1],Message[2])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPTOME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tptome",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",4) or vRP.HasGroup(Passport,"Admin",1) and parseInt(Message[1]) > 0 then
			local ClosestPed = vRP.Source(Message[1])
			if ClosestPed then
				local Ped = GetPlayerPed(source)
				local Coords = GetEntityCoords(Ped)
				
				vRP.Teleport(ClosestPed,Coords["x"],Coords["y"],Coords["z"])
				TriggerEvent("Discord","Tptome","**tptome**\n\n**Passaporte:** "..Passport.."\n**Puxou o ID:** "..Message[1].." \n**Horário:** "..os.date("%H:%M:%S"),3553599)
			end
		end
	end
end)
RegisterCommand("godarea",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",2) then
			local Range = parseInt(Message[1])
			if Range then
				local Text = ""
				local Players = vRPC.ClosestPeds(source,Range)
				for _,v in pairs(Players) do
					async(function()
						local OtherPlayer = vRP.Passport(v)
						vRP.UpgradeThirst(OtherPlayer,100)
						vRP.UpgradeHunger(OtherPlayer,100)
						vRP.DowngradeStress(OtherPlayer,100)
						vRP.Revive(v,200)

						TriggerClientEvent("paramedic:Reset",v)

						if Text == "" then
							Text = OtherPlayer
						else
							Text = Text..", "..OtherPlayer
						end
					end)
				end

				TriggerEvent("Discord","Admin","**goda**\n\n**Passaporte:** "..Passport.."\n**Para:** "..Text,3553599)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPTO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tpto",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if  vRP.HasGroup(Passport,"Admin",3) or vRP.HasGroup(Passport,"Admin",1) and parseInt(Message[1]) > 0 then
			local ClosestPed = vRP.Source(Message[1])
			if ClosestPed then
				local Ped = GetPlayerPed(ClosestPed)
				local Coords = GetEntityCoords(Ped)
				vRP.Teleport(source,Coords["x"],Coords["y"],Coords["z"])
				TriggerEvent("Discord","Tpto","**tpto**\n\n**Passaporte:** "..Passport.."\n**Deu TPTO No ID:** "..Message[1].." \n**Horário:** "..os.date("%H:%M:%S"),3553599)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPWAY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tpway",function(source)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",4) then
			vCLIENT.teleportWay(source)
		end
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
-- HASH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("hash",function(source)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",1) then
			local vehicle = vRPC.VehicleHash(source)
			if vehicle then
				vKEYBOARD.keyCopy(source,"Hash do veículo:",Vehicle)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TUNING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tuning", function(source)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport, "Admin", 2) then
            TriggerClientEvent("admin:vehicleTuning", source)
            TriggerClientEvent("Notify", source, "verde", "Veículo modificado com sucesso.", 5000)
            
            -- Registre no Discord
            --local discordMessage = "Veículo Modificado\n\n" .."**Jogador (ID):** " .. source .. "\n".."**Ação:** Modificação de veículo"
            TriggerEvent("Discord", "Tuning", "Veículo Modificado\n\n" .."**Jogador (ID):** " .. source .. "\n".."**Ação:** usou o /tuning", 3553599) -- Substitua o número de cor pelo desejado
        else
            TriggerClientEvent("Notify", source, "amarelo", "Você não tem permissões para isso.", 5000)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ID
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("id", function(source, args, rawCommand)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport, "Admin", 1) and tonumber(args[1]) > 0 then
            local Identity = vRP.Identity(tonumber(args[1]))
            if Identity then
                TriggerClientEvent("Notify", source, "azul", "<b>Passaporte:</b> " .. args[1] .. "<br><b>Nome:</b> " .. Identity["name"] .. " " .. Identity["name2"] .. "<br><b>Telefone:</b> " .. Identity["phone"] .. "<br><b>Banco:</b> $" .. parseFormat(Identity["bank"]),10000)
            end
        end
    end
end, false)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETBANK - NOVO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("setbank", function(source)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport, "Admin", 1) then
            local Keyboard = vKEYBOARD.keyDouble(source, "ID:", "Quantidade:")
            if Keyboard then
                local targetPlayerId = tonumber(Keyboard[1])
                local amount = tonumber(Keyboard[2])
                
                if targetPlayerId and amount then
                    vRP.GiveBank(targetPlayerId, amount)
                    
                    TriggerClientEvent("Notify", source, "verde", "Envio concluído.", 5000)
                    
                    local targetPlayerName = vRP.FullName(Passport)
                    local message = "Você recebeu $" .. amount .. " de " .. vRP.FullName(source) .. " (ID: " .. source .. ")"
                    
                    TriggerClientEvent("Notify", targetPlayerId, "verde", message, 5000)
                    
                    -- Registre no Discord
                    --local discordMessage = "Transação bancária\n\n" .."**Remetente (ID):** " .. source .. "\n" .."**Destinatário (ID):** " .. targetPlayerId .. "\n" .."**Quantidade:** $" .. amount
                    TriggerEvent("Discord", "SetBank", "Transação bancária\n\n" .."**Remetente (ID):** " .. source .. "\n" .."**Destinatário (ID):** " .. targetPlayerId .. "\n" .."**Quantidade:** $" .. amount, 3553599) -- Substitua o número de cor pelo desejado
                else
                    TriggerClientEvent("Notify", source, "amarelo", "ID ou quantidade inválida.", 5000)
                end
            end
        else
            TriggerClientEvent("Notify", source, "vermelho2", "Você não tem permissões para isso.", 5000)
        end
    end
end)
RegisterCommand("removebank", function(source)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport, "Admin", 1) then
            local Keyboard = vKEYBOARD.keyDouble(source, "ID:", "Quantidade:")
            if Keyboard then
                local targetPlayerId = tonumber(Keyboard[1])
                local amount = tonumber(Keyboard[2])

                if targetPlayerId and amount then
                    local success = vRP.RemoveBank(targetPlayerId, amount)

                    if success then
                        TriggerClientEvent("Notify", source, "verde", "Remoção concluída.", 5000)
                        local targetPlayerName = vRP.FullName(Passport)
                        local message = "Você teve $" .. amount .. " removido por " .. vRP.FullName(source) .. " (ID: " .. source .. ")"
                        TriggerClientEvent("Notify", targetPlayerId, "vermelho", message, 5000)

                        -- Registro no Discord
                        TriggerEvent("Discord", "RemoveBank", "Transação bancária - Remoção\n\n" .."**Remetente (ID):** " .. source .. "\n" .."**Destinatário (ID):** " .. targetPlayerId .. "\n" .."**Quantidade removida:** $" .. amount, 15158332) -- Cor vermelha
                    else
                        TriggerClientEvent("Notify", source, "amarelo", "ID ou quantidade inválida.", 5000)
                    end
                else
                    TriggerClientEvent("Notify", source, "amarelo", "Uso incorreto do comando. Use: /removebank [ID] [quantidade]", 5000)
                end
            end
        else
            TriggerClientEvent("Notify", source, "vermelho", "Você não tem permissões para isso.", 5000)
        end
    end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- FIX
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("fix", function(source)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport, "Admin", 3) then
            local Vehicle, Network, Plate = vRPC.VehicleList(source, 10)
            if Vehicle then
                TriggerClientEvent("inventory:repairAdmin", source, Network, Plate)
                TriggerClientEvent("Notify", source, "verde", "Veículo " .. Plate .. " reparado com sucesso.", 5000)
                local playerId = source
                local message = string.format("**ID:%d** reparou o veículo com a placa **%s** com sucesso.", playerId, Plate)
                TriggerEvent("Discord", "Fix", message, 0x00FF00) -- O terceiro parâmetro define a cor (verde neste caso)
            else
                TriggerClientEvent("Notify", source, "amarelo", "Não há veículo próximo ou você não tem permissões para isso.", 5000)
            end
        else
            TriggerClientEvent("Notify", source, "amarelo", "Você não tem permissões para isso.", 5000)
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- LIMPAREA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("limparea",function(source)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",1) then
			local Ped = GetPlayerPed(source)
			local Coords = GetEntityCoords(Ped)
			TriggerClientEvent("syncarea",source,Coords["x"],Coords["y"],Coords["z"],100)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("players",function(source)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",1) or vRP.HasGroup(Passport,"Staff",1) then
			TriggerClientEvent("Notify",source,"azul","<b>Jogadores Conectados:</b> "..GetNumPlayerIndices(),5000)
		end
	end
end)
RegisterCommand("ids",function(source)
	if source ~= 0 then
		local Passport = vRP.Passport(source)
		if not vRP.HasGroup(Passport,"Admin",1) then
			return
		end
	end
	
	local Text = ""
	local List = vRP.Players()
	
	for OtherPlayer,_ in pairs(List) do
		if Text == "" then
			Text = OtherPlayer
		else
			Text = Text..", "..OtherPlayer
		end
	end
	
	if source ~= 0 then
		TriggerClientEvent("Notify",source,"azul","<b>Jogadores Conectados:</b> "..GetNumPlayerIndices()..".",10000)
		TriggerClientEvent("Notify",source,"azul","<b>IDs Conectados:</b> "..Text..".",20000)
	else
		print("^2IDs Conectados:^7 "..Text)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMIN:COORDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("admin:Coords")
AddEventHandler("admin:Coords",function(Coords)
	vRP.Archive("coordenadas.txt",mathLength(Coords["x"])..","..mathLength(Coords["y"])..","..mathLength(Coords["z"]))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CDS
-----------------------------------------------------------------------------------------------------------------------------------------
function Kaduzera.buttonTxt()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",1) then
			local Ped = GetPlayerPed(source)
			local Coords = GetEntityCoords(Ped)
			local heading = GetEntityHeading(Ped)

			vRP.Archive(Passport..".txt",mathLength(Coords["x"])..","..mathLength(Coords["y"])..","..mathLength(Coords["z"])..","..mathLength(heading))
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONSOLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("console",function(source,Message,History)
	if source == 0 then
		TriggerClientEvent("Notify",-1,"amarelo",History:sub(9),10000)
		print("Anuncio")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ONLINES
-----------------------------------------------------------------------------------------------------------------------------------------
ServerName = "Kaduzera Network"  --- name de sua Cidade.
RegisterCommand("onlines",function(source)
	if source == 0 then
		print("Atualmente ^2"..ServerName.." ^0tem ^5"..GetNumPlayerIndices().." Onlines^0.")
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
		if not vRP.HasGroup(Passport,"Admin") then
			return
		end
	end

	TriggerEvent("SaveServer",false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("itemall",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",1) then
			local Text = ""
			local List = vRP.Players()
			
			for OtherPlayer,_ in pairs(List) do
				async(function()
					if Text == "" then
						Text = OtherPlayer
					else
						Text = Text..", "..OtherPlayer
					end
					
					vRP.GenerateItem(OtherPlayer,Message[1],Message[2],true)
				end)
			end
			
			TriggerClientEvent("Notify",source,"verde","Envio concluído e Sua LOG foi Enviado para o Discord",10000)
				
				TriggerEvent("Discord","Itemall","**itemall**\n\n**Passaporte:** "..Passport.."\n**Para:** "..Text.."\n**Item:** "..Message[2].."x "..itemName(Message[1]).." \n**Horário:** "..os.date("%H:%M:%S"),3553599)
			end
		end
	end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RACECOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
local Checkpoint = 0
function Kaduzera.raceCoords(vehCoords,leftCoords,rightCoords)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		Checkpoint = Checkpoint + 1

		vRP.Archive("races.txt","["..Checkpoint.."] = {")

		vRP.Archive("races.txt","{ "..mathLength(vehCoords["x"])..","..mathLength(vehCoords["y"])..","..mathLength(vehCoords["z"]).." },")
		vRP.Archive("races.txt","{ "..mathLength(leftCoords["x"])..","..mathLength(leftCoords["y"])..","..mathLength(leftCoords["z"]).." },")
		vRP.Archive("races.txt","{ "..mathLength(rightCoords["x"])..","..mathLength(rightCoords["y"])..","..mathLength(rightCoords["z"]).." }")

		vRP.Archive("races.txt","},")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPECTATE
-----------------------------------------------------------------------------------------------------------------------------------------
local Spectate = {}
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
			else
				local nsource = vRP.Source(Message[1])
				if nsource then
					local Ped = GetPlayerPed(nsource)
					if DoesEntityExist(Ped) then
						SetEntityDistanceCullingRadius(Ped,999999999.0)
						Wait(1000)
						TriggerClientEvent("admin:initSpectate",source,nsource)
						Spectate[Passport] = nsource
					end
				end
			end
		end
	end
end)
RegisterCommand("testenotify",function(source)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin") then
			TriggerClientEvent("Notify",source,"default","Seu Texto aqui.    - by Kaduzera Community Dia 11/12 Fucionando","Error",15000)
			TriggerClientEvent("Notify",source,"azul","Seu Texto aqui.    - by Kaduzera Community Dia 11/12 Fucionando","Policia",15000)
			TriggerClientEvent("Notify",source,"verde","Seu Texto aqui.    - by Kaduzera Community Dia 11/12 Fucionando","Sucesso",15000)
			TriggerClientEvent("Notify",source,"amarelo","Seu Texto aqui.    - by Kaduzera Community Dia 11/12 Fucionando","Atenção",15000)
			TriggerClientEvent("Notify",source,"vermelho","Seu Texto aqui.    - by Kaduzera Community Dia 11/12 Fucionando","Negado",15000)
			TriggerClientEvent("Notify",source,"blood","Seu Texto aqui.    - by Kaduzera Community",15000)
			TriggerClientEvent("Notify",source,"mecanico","Seu Texto aqui.    - by Kaduzera Community",15000)
			TriggerClientEvent("Notify",source,"hunger","Seu Texto aqui.    - by Kaduzera Community",7500)
			TriggerClientEvent("Notify",source,"thirst","Seu Texto aqui.    - by Kaduzera Community",7500)
			TriggerClientEvent("Notify",source,"police","Seu Texto aqui.    - by Kaduzera Community",7500)
			TriggerClientEvent("Notify",source,"helicrash","Seu Texto aqui.    - by Kaduzera Community",7500)
			TriggerClientEvent("Notify",source,"salario","Seu Texto aqui.    - by Kaduzera Community",7500)
			TriggerClientEvent("Notify",source,"service","Seu Texto aqui.    - by Kaduzera Community",7500)
		end
	end
end)

-------------------------------------------------------------------------------------------------------------------------------------
------ Presente a Cada 30 Minutos conectados by Kaduzera Community
-------------------------------------------------------------------------------------------------------------------------------------
function Kaduzera.ReceberPresentinho()
    local source = source
    local Passport = vRP.Passport(source)
    if Passport then
        local List = {"presente"}   ---- Adicione mais o quanto for necessario...
        local PresenteListado = List[math.random(1, #List)]
        vRP.GenerateItem(Passport, PresenteListado, 1, true)
        TriggerClientEvent("Notify", source, "azul", "Recebeu um <b>" .. PresenteListado .. "</b> do Nosso Querido Papai Noel!!!", 5000)
    end
end


-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport)
	if Spectate[Passport] then
		Spectate[Passport] = nil
	end
end)