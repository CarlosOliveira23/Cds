-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Hypex = {}
Tunnel.bindInterface("dynamic",Hypex)
vKEYBOARD = Tunnel.getInterface("keyboard")
-----------------------------------------------------------------------------------------------------------------------------------------
-- WORKS
-----------------------------------------------------------------------------------------------------------------------------------------
local Works = {
	["Driver"] = "Motorista",
	["Delivery"] = "Entregador",

	["Dismantle"] = "Desmanche",
	["Tows"] = "Reboque",

	["Transporter"] = "Transportador",
	["Lumberman"] = "Lenhador"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXPERIENCE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hypex.Experience()
	local source = source
	local Passport = vRP.Passport(source)
	local Datatable = vRP.Datatable(Passport)
	if Passport and Datatable then
		local Experiences = {}

		for Index,v in pairs(Works) do
			if Datatable[Index] then
				Experiences[v] = Datatable[Index]
			else
				Experiences[v] = 0
			end
		end

		return Experiences
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DYNAMIC:EMERGENCYANNOUNCE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("dynamic:EmergencyAnnounceMedic")
AddEventHandler("dynamic:EmergencyAnnounceMedic",function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Paramedic") then
			TriggerClientEvent("dynamic:closeSystem",source)
			local Keyboard = vKEYBOARD.keyDouble(source,"Mensagem:","Nome:")
			if Keyboard then
				TriggerClientEvent("Notify",-1,"blood"," "..Keyboard[1].."<br><b>Enviado Por: <b>"..Keyboard[2].."</b>",45000)
				TriggerEvent("Discord","AvisoMed","**Aviso Medico**\n\n**Passaporte:** "..Passport.."\n**Mensagem do Anuncio:** "..Keyboard[1].."\n**Nome que Colocou:** "..Keyboard[2].."\n**Horário:** "..os.date("%H:%M:%S"),3553599)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DYNAMIC:EMERGENCYANNOUNCE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("dynamic:EmergencyAnnounce")
AddEventHandler("dynamic:EmergencyAnnounce",function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Police") or vRP.HasGroup(Passport,"Paramedic") then
			TriggerClientEvent("dynamic:closeSystem",source)
			local Keyboard = vKEYBOARD.keyDouble(source,"Mensagem:","Nome:")
			if Keyboard then
				TriggerClientEvent("Notify",-1,"police"," "..Keyboard[1].."<br></br>Enviado Por: <b>"..Keyboard[2].."</b>",45000)
				TriggerEvent("Discord","Avisopm","**Aviso Policial F10**\n\n**Passaporte:** "..Passport.."\n**Mensagem do Anuncio:** "..Keyboard[1].."\n**Nome que Colocou:** "..Keyboard[2].."\n**Horário:** "..os.date("%H:%M:%S"),3553599)
			end
		end
	end
end)

RegisterServerEvent("dynamic:EmergencyAnnounce2")
AddEventHandler("dynamic:EmergencyAnnounce2", function()
    local source = source
    local Passport = vRP.Passport(source)
    if Passport then
        local identity = vRP.Identity(source)
        if vRP.HasGroup(Passport, "Police") or vRP.HasGroup(Passport, "Paramedic") or vRP.HasGroup(Passport, "Core") then
            TriggerClientEvent("dynamic:closeSystem", source)
            local Keyboard = vKEYBOARD.keyArea(source,"Mensagem:")
			if Keyboard then
                local playerName = vRP.FullName(Passport)
                local originalMessage = Keyboard[1]
                local finalMessage = originalMessage .. "<br></br>Enviada Por: " .. playerName
                TriggerClientEvent("Notify", -1, "police", finalMessage.."</b>",30000)
            end
        end
    end
end)

RegisterServerEvent("dynamic:AnnounceMec")
AddEventHandler("dynamic:AnnounceMec", function()
    local source = source
    local Passport = vRP.Passport(source)
    if Passport then
        local identity = vRP.Identity(source)
        if vRP.HasGroup(Passport, "Mechanic") then
            TriggerClientEvent("dynamic:closeSystem", source)
            local Keyboard = vKEYBOARD.keyArea(source,"Mensagem:")
			if Keyboard then
                local playerName = vRP.FullName(Passport)
                local originalMessage = Keyboard[1]
                local finalMessage = originalMessage .. "<br></br>Enviada Por: " .. playerName
                TriggerClientEvent("Notify", -1, "mecanico", finalMessage.."</b>",45000)
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TENCODES
-----------------------------------------------------------------------------------------------------------------------------------------
local Tencodes = {
	[1] = {
		tag = "QTI",
		text = "Abordagem de trânsito",
		blip = 77
	},
	[2] = {
		tag = "QTH",
		text = "Localização",
		blip = 1
	},
	[3] = {
		tag = "QRR",
		text = "Apoio com prioridade",
		blip = 38
	},
	[4] = {
		tag = "QRT",
		text = "Oficial desmaiado/ferido",
		blip = 6
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DYNAMIC:TENCODE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("dynamic:Tencode")
AddEventHandler("dynamic:Tencode",function(Code)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Ped = GetPlayerPed(source)
		local Coords = GetEntityCoords(Ped)
		local Identity = vRP.Identity(Passport)
		local Service = vRP.NumPermission("Police") and vRP.NumPermission("Core")
		for Passports,Sources in pairs(Service) do
			async(function()
				if Code ~= 4 then
					vRPC.PlaySound(Sources,"Event_Start_Text","GTAO_FM_Events_Soundset")
				end

				TriggerClientEvent("NotifyPush",Sources,{ code = Tencodes[parseInt(Code)]["tag"], title = Tencodes[parseInt(Code)]["text"], x = Coords["x"], y = Coords["y"], z = Coords["z"], name = Identity["name"].." "..Identity["name2"], time = "Recebido às "..os.date("%H:%M"), blipColor = Tencodes[parseInt(Code)]["blip"] })
			end)
		end
	end
end)