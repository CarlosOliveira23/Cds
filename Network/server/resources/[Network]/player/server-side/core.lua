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
Tunnel.bindInterface("player",Kaduzera)
vCLIENT = Tunnel.getInterface("player")
vSKINSHOP = Tunnel.getInterface("skinshop")
vKEYBOARD = Tunnel.getInterface("keyboard")
-----------------------------------------------------------------------------------------------------------------------------------------
-- /mascara
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('mascara', function(source, args, rawCommand)
    local Passport = vRP.Passport(source)
    local vida = vRP.GetHealth(source)

    if vRP.GetHealth(source) <= 100 then
        TriggerClientEvent('Notify', source, 'vermelho', 'Você não pode fazer isso em coma.', 7500)
        return
    end
    if not Player(source)["state"]["Handcuff"] then
        if Passport then
            TriggerClientEvent("setmascara", source, args[1], args[2])
        end
    end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- NEY
------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('ney',function(source,args,rawCommand)
	local Passport = vRP.Passport(source)
    local OtherPassport = tonumber(args[1])
    local nsource = vRP.Source(OtherPassport)
	if Passport then
		if vRP.HasPermission(Passport,'Admin',1) then
			vCLIENT.neyMar(nsource)
		end
	end
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TROLL
------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('troll',function(source,args,rawCommand)
	local Passport = vRP.Passport(source)
    local OtherPassport = tonumber(args[1])
    local nsource = vRP.Source(OtherPassport)
	if Passport then
		if vRP.HasPermission(Passport,'Admin',1) then
			vCLIENT.makeFly(nsource)
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKS
-----------------------------------------------------------------------------------------------------------------------------------------
function Kaduzera.checkRoupas()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.ConsultItem(Passport,"mask",1) or vRP.HasPermission(Passport,"Admin") or vRP.HasPermission(Passport,"PremiumOuro") or vRP.HasPermission(Passport,"Premium") or vRP.HasPermission(Passport,"PremiumPrata") then
			return true 
		else
			TriggerClientEvent("Notify",source,'vermelho',"Você não possui o item <b>ROUPAS</b>.",7500) 
			return false
		end
	end
end

function Kaduzera.CheckBooster()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasPermission(Passport, 'Premium') then
			return true 
		else
			TriggerClientEvent("Notif2=y2",source,'vermelho',"Você não possui <b>Booster</b>.",7500) 
			return false
		end
	end
end

function Kaduzera.CheckVip(qualVip)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasPermission(Passport, 'Premium') then return true end
		if qualVip == 'ambos' then
			if vRP.HasPermission(Passport, 'Premium') or vRP.HasPermission(Passport, 'PremiumOuro') or vRP.HasPermission(Passport, 'PremiumPrata') then
				return true
			end
		end
		return false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CARRYPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
local playerCarry = {}
function Kaduzera.CarryPlayer()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasService(Passport,"Paramedic") or vRP.HasService(Passport,"Police") or vRP.HasGroup(Passport,"Admin",1) then
			if not vRP.InsideVehicle(source) then
				if playerCarry[Passport] then
					TriggerClientEvent("player:playerCarry",playerCarry[Passport],source)
					TriggerClientEvent("player:Commands",playerCarry[Passport],false)
					playerCarry[Passport] = nil
				else
					local ClosestPed = vRPC.ClosestPed(source,2)
					if ClosestPed then
						playerCarry[Passport] = ClosestPed

						TriggerClientEvent("player:playerCarry",playerCarry[Passport],source)
						TriggerClientEvent("player:Commands",playerCarry[Passport],true)
					end
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:INFORMATIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:Informations")
AddEventHandler("player:Informations",function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if not vRP.HasGroup(Passport,"Police") and not vRP.HasGroup(Passport,"Paramedic") then
			if vRP.Request(source,"Quer receber informações por <b>$10.000</b>?","Sim, por favor","Não, decido depois") then
				if vRP.ConsultItem(Passport,"dollarsroll",10000) and vRP.TakeItem(Passport,"dollarsroll",10000) then
					local Paramedic = vRP.NumPermission("Paramedic")
					local Police = vRP.NumPermission(Passport,"Police")

		    	    TriggerClientEvent("Notify",source,"amarelo","Há <b>"..parseInt(Paramedic).."</b> Paramedicos em serviço",10000)
					TriggerClientEvent("Notify",source,"amarelo","Há <b>"..parseInt(Police).."</b> Policiais em serviço",10000)
				else
					TriggerClientEvent("Notify",source,"vermelho","Vcoê não possui <b>10.000 Rolo de Dólares</b>",10000)
				end
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Não há nada pra você aqui",10000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("skin",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and Message[1] and Message[2] then
		if vRP.HasGroup(Passport,"Admin") then
			local ClosestPed = vRP.Source(Message[1])
			if ClosestPed then
				vRPC.Skin(ClosestPed,Message[2])
				vRP.SkinCharacter(parseInt(Message[1]),Message[2])
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DUITEXTURES
-----------------------------------------------------------------------------------------------------------------------------------------
local DuiTextures = {
	["MRPD"] = {
		["Distance"] = 1.50,
		["Dimension"] = 1.25,
		["Label"] = "Quadro Branco",
		["Coords"] = vec3(439.47,-985.85,35.99),
		["Link"] = "https://kadu-rp.com/Quadro.png",
		["Dict"] = "prop_planning_b1",
		["Texture"] = "prop_base_white_01b",
		["Width"] = 550,
		["Weight"] = 450
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:TEXTURE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:Texture")
AddEventHandler("player:Texture",function(Name)
	local source = source
	local Keyboard = vKEYBOARD.keySingle(source,"Link:")
	if Keyboard then
		DuiTextures[Name]["Link"] = Keyboard[1]
		TriggerClientEvent("player:DuiUpdate",-1,Name,DuiTextures[Name])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:STRESS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:Stress")
AddEventHandler("player:Stress",function(Number)
	local source = source
	local Number = parseInt(Number)
	local Passport = vRP.Passport(source)
	if Passport then
		vRP.DowngradeStress(Passport,Number)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("me",function(source,Message,History)
	local Passport = vRP.Passport(source)
	if Passport and Message[1] then
		local message = string.sub(History:sub(4),1,100)

		local Players = vRPC.Players(source)
		for _,v in pairs(Players) do
			async(function()
				TriggerClientEvent("showme:pressMe",v,source,message,10)
			end)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- E
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("e",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and vRP.GetHealth(source) > 100 then
		if Message[2] == "friend" then
			local ClosestPed = vRPC.ClosestPed(source,2)
			if ClosestPed then
				if vRP.GetHealth(ClosestPed) > 100 and not Player(ClosestPed)["state"]["Handcuff"] then
					local Identity = vRP.Identity(Passport)
					if vRP.Request(ClosestPed,"Pedido de <b>"..Identity["name"].."</b> da animação <b>"..Message[1].."</b>?","Sim, iniciar animação","Não, sai fora") then
						TriggerClientEvent("emotes",ClosestPed,Message[1])
						TriggerClientEvent("emotes",source,Message[1])
					end
				end
			end
		else
			TriggerClientEvent("emotes",source,Message[1])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- E2
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("e2",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and vRP.GetHealth(source) > 100 then
		local ClosestPed = vRPC.ClosestPed(source,2)
		if ClosestPed then
			if vRP.HasService(Passport,"Paramedic") then
				TriggerClientEvent("emotes",ClosestPed,Message[1])
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- E3
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("e3",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and vRP.GetHealth(source) > 100 then
		if vRP.HasGroup(Passport,"Admin",2) then
			local Players = vRPC.ClosestPeds(source,50)
			for _,v in pairs(Players) do
				async(function()
					TriggerClientEvent("emotes",v,Message[1])
				end)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:DOORS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:Doors")
AddEventHandler("player:Doors",function(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Vehicle,Network = vRPC.VehicleList(source,5)
		if Vehicle then
			local Players = vRPC.Players(source)
			for _,v in pairs(Players) do
				async(function()
					TriggerClientEvent("player:syncDoors",v,Network,Number)
				end)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- 911
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("911",function(source,Message,History)
	local Passport = vRP.Passport(source)
	if Passport and Message[1] and vRP.GetHealth(source) > 100 then
		if vRP.HasService(Passport,"Police") then
			local Identity = vRP.Identity(Passport)
			local Service = vRP.NumPermission("Police")
			for Passports,Sources in pairs(Service) do
				async(function()
					TriggerClientEvent("chat:ClientMessage",Sources,Identity["name"],History:sub(4))
				end)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- 112
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("112",function(source,Message,History)
	local Passport = vRP.Passport(source)
	if Passport and Message[1] and vRP.GetHealth(source) > 100 then
		if vRP.HasService(Passport,"Paramedic") then
			local Identity = vRP.Identity(Passport)
			local Service = vRP.NumPermission("Paramedic")
			for Passports,Sources in pairs(Service) do
				async(function()
					TriggerClientEvent("Datatable",Sources,Identity["name"].." "..Identity["name2"],History:sub(4))
				end)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOTSFIRED
-----------------------------------------------------------------------------------------------------------------------------------------
function Kaduzera.shotsFired(Vehicle)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Vehicle then
			Vehicle = "Disparos de um veículo"
		else
			Vehicle = "Disparos com arma de fogo"
		end

		local Ped = GetPlayerPed(source)
		local Coords = GetEntityCoords(Ped)
		local Service = vRP.NumPermission("Police")
		for Passports,Sources in pairs(Service) do
			async(function()
				TriggerClientEvent("NotifyPush",Sources,{ code = 10, title = Vehicle, x = Coords["x"], y = Coords["y"], z = Coords["z"], blipColor = 6 })
			end)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CARRYPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
local playerCarry = {}
RegisterServerEvent("player:carryPlayer")
AddEventHandler("player:carryPlayer",function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if not vRP.InsideVehicle(source) then
			if playerCarry[Passport] then
				TriggerClientEvent("player:playerCarry",playerCarry[Passport],source)
				TriggerClientEvent("player:Commands",playerCarry[Passport],false)
				playerCarry[Passport] = nil
			else
				local ClosestPed = vRPC.ClosestPed(source,2)
				if ClosestPed then
					playerCarry[Passport] = ClosestPed

					TriggerClientEvent("player:playerCarry",playerCarry[Passport],source)
					TriggerClientEvent("player:Commands",playerCarry[Passport],true)
				end
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CVFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:cvFunctions")
AddEventHandler("player:cvFunctions",function(Mode)
	local Distance = 1
	local source = source

	if Mode == "rv" then
		Distance = 10
	end

	local ClosestPed = vRPC.ClosestPed(source,Distance)
	if ClosestPed then
		local Passport = vRP.Passport(source)
		local Consult = vRP.InventoryItemAmount(Passport,"rope")
		if vRP.HasService(Passport,"Emergency") or Consult[1] >= 1 then
			local Vehicle,Network = vRPC.VehicleList(source,5)
			if Vehicle then
				local Networked = NetworkGetEntityFromNetworkId(Network)
				local Door = GetVehicleDoorLockStatus(Networked)

				if parseInt(Door) <= 1 then
					if Mode == "rv" then
						vCLIENT.removeVehicle(ClosestPed)
					elseif Mode == "cv" then
						vCLIENT.putVehicle(ClosestPed,Network)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRESET
-----------------------------------------------------------------------------------------------------------------------------------------
local preset = {
	["1"] = {
		["mp_m_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 23, texture = 0 },
			["vest"] = { item = 16, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = -1, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 24, texture = 0 },
			["torso"] = { item = 24, texture = 0 },
			["accessory"] = { item = 20, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 0, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		},
		["mp_f_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 17, texture = 0 },
			["vest"] = { item = 18, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 22, texture = 0 },
			["torso"] = { item = 23, texture = 0 },
			["accessory"] = { item = 14, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 14, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		}
	},
	["2"] = {
		["mp_m_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 23, texture = 0 },
			["vest"] = { item = 24, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = -1, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 24, texture = 0 },
			["torso"] = { item = 26, texture = 0 },
			["accessory"] = { item = 20, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 11, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		},
		["mp_f_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 17, texture = 0 },
			["vest"] = { item = 15, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 22, texture = 0 },
			["torso"] = { item = 20, texture = 0 },
			["accessory"] = { item = 14, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 14, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		}
	},
	["3"] = {
		["mp_m_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 23, texture = 0 },
			["vest"] = { item = 24, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = -1, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 24, texture = 0 },
			["torso"] = { item = 27, texture = 0 },
			["accessory"] = { item = 20, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 12, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		},
		["mp_f_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 17, texture = 0 },
			["vest"] = { item = 15, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 22, texture = 0 },
			["torso"] = { item = 21, texture = 0 },
			["accessory"] = { item = 14, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 14, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		}
	},
	["4"] = {
		["mp_m_freemode_01"] = {
			["hat"] = { item = 25, texture = 0 },
			["pants"] = { item = 21, texture = 0 },
			["vest"] = { item = 28, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = -1, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 31, texture = 0 },
			["torso"] = { item = 31, texture = 0 },
			["accessory"] = { item = 20, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 12, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		},
		["mp_f_freemode_01"] = {
			["hat"] = { item = 32, texture = 2 },
			["pants"] = { item = 19, texture = 0 },
			["vest"] = { item = 13, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = -1, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 25, texture = 0 },
			["torso"] = { item = 26, texture = 7 },
			["accessory"] = { item = 14, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 7, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		}
	},
	["5"] = {
		["mp_m_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 19, texture = 0 },
			["vest"] = { item = 13, texture = 1 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 17, texture = 0 },
			["torso"] = { item = 32, texture = 	3 },
			["accessory"] = { item = 20, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 0, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		},
		["mp_f_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 16, texture = 0 },
			["vest"] = { item = 14, texture = 1 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 25, texture = 0 },
			["torso"] = { item = 16, texture = 5 },
			["accessory"] = { item = 14, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 14, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		}
	},
	["6"] = {
		["mp_m_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 36, texture = 6 },
			["vest"] = { item = 12, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 42, texture = 2 },
			["tshirt"] = { item = 25, texture = 0 },
			["torso"] = { item = 33, texture = 4 },
			["accessory"] = { item = 21, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 0, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		},
		["mp_f_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 0, texture = 0 },
			["vest"] = { item = 12, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 1, texture = 0 },
			["tshirt"] = { item = 16, texture = 0 },
			["torso"] = { item = 27, texture = 0 },
			["accessory"] = { item = 11, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 14, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		}
	},
	["7"] = {
		["mp_m_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 140, texture = 3 },
			["vest"] = { item = 14, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 35, texture = 0 },
			["tshirt"] = { item = 25, texture = 1 },
			["torso"] = { item = 32, texture = 2 },
			["accessory"] = { item = 19, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 0, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		},
		["mp_f_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 141, texture = 3 },
			["vest"] = { item = 12, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 16, texture = 0 },
			["torso"] = { item = 27, texture = 0 },
			["accessory"] = { item = 10, texture = 1 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 14, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		}
	},
	["8"] = {
		["mp_m_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 19, texture = 0 },
			["vest"] = { item = 11, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 25, texture = 0 },
			["torso"] = { item = 17, texture = 1 },
			["accessory"] = { item = 19, texture = 1 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 201, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		},
		["mp_f_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 16, texture = 0 },
			["vest"] = { item = 21, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 16, texture = 0 },
			["torso"] = { item = 16, texture = 0 },
			["accessory"] = { item = 10, texture = 1 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 14, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		}
	},
	["9"] = {
		["mp_m_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 19, texture = 1 },
			["vest"] = { item = 11, texture = 1 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 158, texture = 0 },
			["tshirt"] = { item = 25, texture = 1 },
			["torso"] = { item = 17, texture = 2 },
			["accessory"] = { item = 19, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 201, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		},
		["mp_f_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 16, texture = 0 },
			["vest"] = { item = 21, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 16, texture = 0 },
			["torso"] = { item = 26, texture = 0 },
			["accessory"] = { item = 10, texture = 1 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 53, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		}
	},
	["10"] = {
		["mp_m_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 19, texture = 0 },
			["vest"] = { item = 13, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 29, texture = 0 },
			["torso"] = { item = 32, texture = 1 },
			["accessory"] = { item = 19, texture = 1 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 201, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		},
		["mp_f_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 16, texture = 0 },
			["vest"] = { item = 14, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 19, texture = 0 },
			["torso"] = { item = 16, texture = 4 },
			["accessory"] = { item = 10, texture = 1 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 57, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		}
	},
	["11"] = {
		["mp_m_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 19, texture = 0 },
			["vest"] = { item = 0, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 195, texture = 1 },
			["torso"] = { item = 23, texture = 5 },
			["accessory"] = { item = 20, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 197, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		},
		["mp_f_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 16, texture = 0 },
			["vest"] = { item = 9, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 16, texture = 0 },
			["torso"] = { item = 23, texture = 3 },
			["accessory"] = { item = 10, texture = 1 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 57, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		}
	},

	-- PARAMEDIC

	["12"] = {
		["mp_m_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 34, texture = 5 },
			["vest"] = { item = 0, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 42, texture = 2 },
			["tshirt"] = { item = 10, texture = 0 },
			["torso"] = { item = 317, texture = 4 },
			["accessory"] = { item = 139, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 82, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		},
		["mp_f_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 28, texture = 0 },
			["vest"] = { item = 0, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 159, texture = 0 },
			["tshirt"] = { item = 56, texture = 0 },
			["torso"] = { item = 118, texture = 7 },
			["accessory"] = { item = 110, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 101, texture = 1 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		}
	},
	["13"] = {
		["mp_m_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 19, texture = 0 },
			["vest"] = { item = 0, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 10, texture = 1 },
			["torso"] = { item = 317, texture = 4 },
			["accessory"] = { item = 20, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 203, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		},
		["mp_f_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 16, texture = 0 },
			["vest"] = { item = 9, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 25, texture = 2 },
			["tshirt"] = { item = 16, texture = 0 },
			["torso"] = { item = 23, texture = 3 },
			["accessory"] = { item = 10, texture = 1 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 57, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		}
	},
	-- UWU CAFE
	["14"] = {
		["mp_m_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 19, texture = 0 },
			["vest"] = { item = 0, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 195, texture = 1 },
			["torso"] = { item = 23, texture = 5 },
			["accessory"] = { item = 20, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 203, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		},
		["mp_f_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 160, texture = 3 },
			["vest"] = { item = 0, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 81, texture = 2 },
			["tshirt"] = { item = 203, texture = 0 },
			["torso"] = { item = 395, texture = 2 },
			["accessory"] = { item = 37, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 9, texture = 0 },
			["glass"] = { item = 46, texture = 3 },
			["ear"] = { item = -1, texture = 0 }
		}
	},
	["15"] = {
		["mp_m_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 49, texture = 0 },
			["vest"] = { item = 0, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 227, texture = 0 },
			["torso"] = { item = 89, texture = 0 },
			["accessory"] = { item = 20, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 18, texture = 0 },
			["glass"] = { item = 35, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		},
		["mp_f_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 44, texture = 0 },
			["vest"] = { item = 0, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 0, texture = 0 },
			["shoes"] = { item = 27, texture = 0 },
			["tshirt"] = { item = 279, texture = 0 },
			["torso"] = { item = 121, texture = 0 },
			["accessory"] = { item = 0, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 18, texture = 0 },
			["glass"] = { item = 43, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:PRESET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:Preset")
AddEventHandler("player:Preset",function(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasService(Passport,"Emergency") or vRP.HasGroup(Passport,"Police") or vRP.HasGroup(Passport,"Mechanic") then
			local Model = vRP.ModelPlayer(source)

			if Model == "mp_m_freemode_01" or "mp_f_freemode_01" then
				TriggerClientEvent("skinshop:Apply",source,preset[Number][Model])
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CHECKTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:checkTrunk")
AddEventHandler("player:checkTrunk",function()
	local source = source
	local ClosestPed = vRPC.ClosestPed(source,2)
	if ClosestPed then
		TriggerClientEvent("player:checkTrunk",ClosestPed)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CHECKTRASH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:checkTrash")
AddEventHandler("player:checkTrash",function()
	local source = source
	local ClosestPed = vRPC.ClosestPed(source,2)
	if ClosestPed then
		TriggerClientEvent("player:checkTrash",ClosestPed)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CHECKSHOES
-----------------------------------------------------------------------------------------------------------------------------------------
local UniqueShoes = {}
RegisterServerEvent("player:checkShoes")
AddEventHandler("player:checkShoes",function(Entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if not UniqueShoes[Entity] then
			UniqueShoes[Entity] = os.time()
		end

		if os.time() >= UniqueShoes[Entity] then
			if vSKINSHOP.checkShoes(Entity) then
				vRP.GenerateItem(Passport,"WEAPON_SHOES",2,true)
				UniqueShoes[Entity] = os.time() + 300
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OUTFIT - REMOVER
-----------------------------------------------------------------------------------------------------------------------------------------
local removeFit = {
	["homem"] = {
		["hat"] = { item = -1, texture = 0 },
		["pants"] = { item = 14, texture = 0 },
		["vest"] = { item = 0, texture = 0 },
		["backpack"] = { item = 0, texture = 0 },
		["bracelet"] = { item = -1, texture = 0 },
		["decals"] = { item = 0, texture = 0 },
		["mask"] = { item = 0, texture = 0 },
		["shoes"] = { item = 5, texture = 0 },
		["tshirt"] = { item = 15, texture = 0 },
		["torso"] = { item = 15, texture = 0 },
		["accessory"] = { item = 0, texture = 0 },
		["watch"] = { item = -1, texture = 0 },
		["arms"] = { item = 15, texture = 0 },
		["glass"] = { item = 0, texture = 0 },
		["ear"] = { item = -1, texture = 0 }
	},
	["mulher"] = {
		["hat"] = { item = -1, texture = 0 },
		["pants"] = { item = 14, texture = 0 },
		["vest"] = { item = 0, texture = 0 },
		["backpack"] = { item = 0, texture = 0 },
		["bracelet"] = { item = -1, texture = 0 },
		["decals"] = { item = 0, texture = 0 },
		["mask"] = { item = 0, texture = 0 },
		["shoes"] = { item = 5, texture = 0 },
		["tshirt"] = { item = 15, texture = 0 },
		["torso"] = { item = 15, texture = 0 },
		["accessory"] = { item = 0, texture = 0 },
		["watch"] = { item = -1, texture = 0 },
		["arms"] = { item = 15, texture = 0 },
		["glass"] = { item = 0, texture = 0 },
		["ear"] = { item = -1, texture = 0 }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:PRESET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:Preset")
AddEventHandler("player:Preset", function(Number)
    local source = source
    local Passport = vRP.Passport(source)

    if Passport then
        if vRP.HasService(Passport, "Emergency") or vRP.HasGroup(Passport, "Core") then
            local Model = vRP.ModelPlayer(source)
			vRPC.playAnim(source, true, {"clothingshirt", "try_shirt_positive_d"}, true)

			Citizen.Wait(5000)
            if Model == "mp_m_freemode_01" or Model == "mp_f_freemode_01" then
                TriggerClientEvent("skinshop:Apply", source, preset[Number][Model])
				vRPC.stopAnim(source,true)
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CHECKTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:checkTrunk")
AddEventHandler("player:checkTrunk",function()
	local source = source
	local ClosestPed = vRPC.ClosestPed(source,2)
	if ClosestPed then
		TriggerClientEvent("player:checkTrunk",ClosestPed)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CHECKTRASH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:checkTrash")
AddEventHandler("player:checkTrash",function()
	local source = source
	local ClosestPed = vRPC.ClosestPed(source,2)
	if ClosestPed then
		TriggerClientEvent("player:checkTrash",ClosestPed)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CHECKSHOES
-----------------------------------------------------------------------------------------------------------------------------------------
local UniqueShoes = {}
RegisterServerEvent("player:checkShoes")
AddEventHandler("player:checkShoes",function(Entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if not UniqueShoes[Entity] then
			UniqueShoes[Entity] = os.time()
		end

		if os.time() >= UniqueShoes[Entity] then
			if vSKINSHOP.checkShoes(Entity) then
				vRP.GenerateItem(Passport,"WEAPON_SHOES",2,true)
				UniqueShoes[Entity] = os.time() + 300
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OUTFIT - REMOVER
-----------------------------------------------------------------------------------------------------------------------------------------
local removeFit = {
	["homem"] = {
		["hat"] = { item = -1, texture = 0 },
		["pants"] = { item = 14, texture = 0 },
		["vest"] = { item = 0, texture = 0 },
		["backpack"] = { item = 0, texture = 0 },
		["bracelet"] = { item = -1, texture = 0 },
		["decals"] = { item = 0, texture = 0 },
		["mask"] = { item = 0, texture = 0 },
		["shoes"] = { item = 5, texture = 0 },
		["tshirt"] = { item = 15, texture = 0 },
		["torso"] = { item = 15, texture = 0 },
		["accessory"] = { item = 0, texture = 0 },
		["watch"] = { item = -1, texture = 0 },
		["arms"] = { item = 15, texture = 0 },
		["glass"] = { item = 0, texture = 0 },
		["ear"] = { item = -1, texture = 0 }
	},
	["mulher"] = {
		["hat"] = { item = -1, texture = 0 },
		["pants"] = { item = 14, texture = 0 },
		["vest"] = { item = 0, texture = 0 },
		["backpack"] = { item = 0, texture = 0 },
		["bracelet"] = { item = -1, texture = 0 },
		["decals"] = { item = 0, texture = 0 },
		["mask"] = { item = 0, texture = 0 },
		["shoes"] = { item = 5, texture = 0 },
		["tshirt"] = { item = 15, texture = 0 },
		["torso"] = { item = 15, texture = 0 },
		["accessory"] = { item = 0, texture = 0 },
		["watch"] = { item = -1, texture = 0 },
		["arms"] = { item = 15, texture = 0 },
		["glass"] = { item = 0, texture = 0 },
		["ear"] = { item = -1, texture = 0 }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:OUTFIT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:Outfit")
AddEventHandler("player:Outfit", function(Mode)
    local source = source
    local Passport = vRP.Passport(source)

    if Passport and not exports["hud"]:Reposed(Passport) and not exports["hud"]:Wanted(Passport) then
        if Mode == "aplicar" then
            local result = vRP.GetSrvData("Outfit:" .. Passport)
            if result and result["pants"] ~= nil then  -- Adicionei a verificação para result não ser nil
				vRPC.playAnim(source, true, {"clothingshirt", "try_shirt_positive_d"}, true)

            		-- Delay de 5 Segundos de animação
            	Citizen.Wait(5000)
                TriggerClientEvent("skinshop:Apply", source, result)
				vRPC.stopAnim(source,true)
                TriggerClientEvent("Notify", source, "verde", "Roupas aplicadas.", 3000)
            else
                TriggerClientEvent("Notify", source, "amarelo", "Roupas não encontradas.", 3000)
            end
        elseif Mode == "salvar" then
            local custom = vSKINSHOP.getCustomization(source)
            if custom then
                vRP.SetSrvData("Outfit:" .. Passport, custom)
                TriggerClientEvent("Notify", source, "verde", "Roupas salvas.", 3000)
            end
        elseif Mode == "aplicarplatina" then
            if vRP.HasPermission(Passport, "Premium", 1) then
                local Result = vRP.GetSrvData("PremiumPlatinum1:" .. Passport, true)
                if Result and Result["pants"] then  -- Adicionei a verificação para Result não ser nil
                    vRPC.playAnim(source, true, {"clothingshirt", "try_shirt_positive_d"}, true)

            		-- Delay de 5 Segundos de animação
            		Citizen.Wait(5000)
                    TriggerClientEvent("skinshop:Apply", source, Result)
					vRPC.stopAnim(source,true)
                    TriggerClientEvent("Notify", source, "verde", "Roupas Platinum aplicadas.", 5000)
                else
                    TriggerClientEvent("Notify", source, "amarelo", "Roupas Platinum não encontradas.", 5000)
                end
            else
                TriggerClientEvent("Notify", source, "vermelho", "Você não tem permissão para aplicar roupas Platinum.", 5000)
            end
        elseif Mode == "salvarplatina" then
            if vRP.HasPermission(Passport, "Premium", 1) then
                local Custom = vSKINSHOP.Customization(source)
                if Custom then
                    vRP.SetSrvData("PremiumPlatinum1:" .. Passport, Custom, true)
                    TriggerClientEvent("Notify", source, "verde", "Roupas Platinum salvas.", 5000)
                end
            else
                TriggerClientEvent("Notify", source, "vermelho", "Você não tem permissão para salvar roupas Platinum.", 5000)
            end
        elseif Mode == "aplicarouro" then
            if vRP.HasPermission(Passport, "Premium", 1) or vRP.HasPermission(Passport, "PremiumOuro", 1) then
                local Result = vRP.GetSrvData("PremiumOuro2:" .. Passport, true)
                if Result and Result["pants"] then  -- Adicionei a verificação para Result não ser nil
                    vRPC.playAnim(source, true, {"clothingshirt", "try_shirt_positive_d"}, true)

            		-- Delay de 5 Segundos de animação
            		Citizen.Wait(5000)
                    TriggerClientEvent("skinshop:Apply", source, Result)
					vRPC.stopAnim(source,true)
                    TriggerClientEvent("Notify", source, "verde", "Roupas Ouro aplicadas.", 5000)
                else
                    TriggerClientEvent("Notify", source, "amarelo", "Roupas Ouro não encontradas.", 5000)
                end
            else
                TriggerClientEvent("Notify", source, "vermelho", "Você não tem permissão para aplicar roupas Ouro.", 5000)
            end
        elseif Mode == "salvarouro" then
            if vRP.HasPermission(Passport, "Premium", 1) or vRP.HasPermission(Passport, "PremiumOuro", 1) then
                local Custom = vSKINSHOP.Customization(source)
                if Custom then
                    vRP.SetSrvData("PremiumOuro2:" .. Passport, Custom, true)
                    TriggerClientEvent("Notify", source, "verde", "Roupas Ouro salvas.", 5000)
                end
            else
                TriggerClientEvent("Notify", source, "vermelho", "Você não tem permissão para salvar roupas Ouro.", 5000)
            end
		elseif Mode == "aplicarprata" then
            if vRP.HasPermission(Passport, "Premium", 1) or vRP.HasPermission(Passport, "PremiumOuro", 1) or vRP.HasPermission(Passport, "PremiumPrata", 1) then
                local Result = vRP.GetSrvData("PremiumPrata3:" .. Passport, true)
                if Result and Result["pants"] then  -- Adicionei a verificação para Result não ser nil
					vRPC.playAnim(source, true, {"clothingshirt", "try_shirt_positive_d"}, true)

            		-- Delay de 5 Segundos de animação
            		Citizen.Wait(5000)
                    TriggerClientEvent("skinshop:Apply", source, Result)
					vRPC.stopAnim(source,true)
                    TriggerClientEvent("Notify", source, "verde", "Roupas Prata aplicadas.", 5000)
                else
                    TriggerClientEvent("Notify", source, "amarelo", "Roupas Prata não encontradas.", 5000)
                end
            else
                TriggerClientEvent("Notify", source, "vermelho", "Você não tem permissão para aplicar roupas Prata.", 5000)
            end
        elseif Mode == "salvarprata" then
            if vRP.HasPermission(Passport, "Premium", 3) or vRP.HasPermission(Passport, "PremiumOuro", 1) or vRP.HasPermission(Passport, "PremiumPrata", 1) then
                local Custom = vSKINSHOP.Customization(source)
                if Custom then
                    vRP.SetSrvData("PremiumPrata3:" .. Passport, Custom, true)
                    TriggerClientEvent("Notify", source, "verde", "Roupas Prata salvas.", 5000)
                end
            else
                TriggerClientEvent("Notify", source, "vermelho", "Você não tem permissão para salvar roupas Prata.", 5000)
            end
        elseif Mode == "remover" then
            local Model = vRP.ModelPlayer(source)
            if Model == "mp_m_freemode_01" then
                TriggerClientEvent("skinshop:Apply", source, removeFit["homem"])
                TriggerClientEvent("Notify", source, "verde", "Roupas Removidas", 3000)
            elseif Model == "mp_f_freemode_01" then
                TriggerClientEvent("skinshop:Apply", source, removeFit["mulher"])
                TriggerClientEvent("Notify", source, "verde", "Roupas Removidas", 3000)
            end
        else
            TriggerClientEvent("skinshop:set" .. Mode, source)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:DEBUG
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:Debug")
AddEventHandler("player:Debug",function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Debug[Passport] or os.time() > Debug[Passport] then
		TriggerClientEvent("barbershop:Apply", source, vRP.UserData(Passport, "Barbershop"))
		TriggerClientEvent("skinshop:Apply", source, vRP.UserData(Passport, "Clothings"))
		TriggerClientEvent("tattooshop:Apply", source, vRP.UserData(Passport, "Tatuagens"))
		TriggerClientEvent("target:Debug", source)

		TriggerClientEvent("Notify", source, "verde", "Você refrescou o seu personagem.", 5000)

		Debug[Passport] = os.time() + 300
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEATH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:Death")
AddEventHandler("player:Death",function(nsource)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and source ~= nsource then
		local OtherPassport = vRP.Passport(nsource)
		if OtherPassport then
			if GetPlayerRoutingBucket(source) < 900000 then
				TriggerEvent("Discord","Deaths","**Matou:** "..Passport.."\n**Morreu:** "..OtherPassport,3092790)
			else
				local Name = "Individuo Indigente"
				local Name2 = "Individuo Indigente"
				local Identity = vRP.Identity(Passport)
				local nIdentity = vRP.Identity(OtherPassport)

				if Identity and nIdentity then
					Name = Identity["name"].." "..Identity["name2"]
					Name2 = nIdentity["name"].." "..nIdentity["name2"]

					TriggerClientEvent("Notify",source,"amarelo","<b>"..Name.."</b> matou <b>"..Name2.."</b>",10000)
					TriggerClientEvent("Notify",nsource,"amarelo","<b>"..Name.."</b> matou <b>"..Name2.."</b>",10000)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CHARGE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:Charge")
AddEventHandler("player:Charge", function(Entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local OtherPassport = vRP.Passport(Entity)
		local Identity = vRP.Identity(OtherPassport)
		if Identity then
			local Keyboard = vKEYBOARD.keySingle(source, "Valor:")
			if Keyboard then
				if vRP.Request(Entity,"Aceitar a cobrança de <b>$" .. parseInt(Keyboard[1]) .. "</b> feita por <b>" .. vRP.FullName(Passport).."</b>?") then
					if vRP.GetBank(Entity) >= parseInt(Keyboard[1]) then
						TriggerClientEvent("NotifyItens", Entity, { "-", "dollars", parseInt(Keyboard[1]), "Dólares" })
						vRP.RemoveBank(OtherPassport, Keyboard[1])
						vRP.GiveBank(Passport, Keyboard[1])
					else
						TriggerClientEvent("Notify", Entity, "vermelho", "<b>Saldo</b> insuficiente.", 5000)
						TriggerClientEvent("Notify", source, "vermelho", "<b>" ..vRP.FullName(OtherPassport) .. "</b> não possúi saldo suficiente.", 5000)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:LIKE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:Like")
AddEventHandler("player:Like",function(Entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local OtherPassport = vRP.Passport(Entity)
		local Identity = vRP.Identity(OtherPassport)
		if Identity then
			if vRP.TakeItem(Passport,"dollars",100,true) then
				vRP.GiveLikes(OtherPassport,1)
			else
				TriggerClientEvent("Notify",source,"amarelo","Você precisa de <b>100x "..itemName("dollars").."</b>.",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:UNLIKE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:UnLike")
AddEventHandler("player:UnLike",function(Entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local OtherPassport = vRP.Passport(Entity)
		local Identity = vRP.Identity(OtherPassport)
		if Identity then
			if vRP.TakeItem(Passport,"dollars",100,true) then
				vRP.GiveUnLikes(OtherPassport,1)
			else
				TriggerClientEvent("Notify",source,"amarelo","Você precisa de <b>100x "..itemName("dollars").."</b>.",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETREPUTATION
-----------------------------------------------------------------------------------------------------------------------------------------
function Kaduzera.GetReputation(source)
	local Passport = vRP.Passport(source)
	if Passport then
		local Reputation = {
			[1] = vRP.GetLikes(Passport),
			[2] = vRP.GetUnLikes(Passport)
		}

		return Reputation
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- BIKEPACK
-----------------------------------------------------------------------------------------------------------------------------------------
function Kaduzera.Bikepack()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local amountWeight = 10
		local myWeight = vRP.GetWeight(Passport)

		if parseInt(myWeight) < 45 then
			amountWeight = 15
		elseif parseInt(myWeight) >= 45 and parseInt(myWeight) <= 79 then
			amountWeight = 10
		elseif parseInt(myWeight) >= 80 and parseInt(myWeight) <= 95 then
			amountWeight = 5
		elseif parseInt(myWeight) >= 100 and parseInt(myWeight) <= 148 then
			amountWeight = 2
		elseif parseInt(myWeight) >= 150 then
			amountWeight = 1
		end

		vRP.SetWeight(Passport,amountWeight)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CHECKTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:checkTrunk")
AddEventHandler("player:checkTrunk",function()
	local source = source
	local ClosestPed = vRPC.ClosestPed(source,2)
	if ClosestPed then
		TriggerClientEvent("player:checkTrunk",ClosestPed)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CHECKTRASH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:checkTrash")
AddEventHandler("player:checkTrash",function()
	local source = source
	local ClosestPed = vRPC.ClosestPed(source,2)
	if ClosestPed then
		TriggerClientEvent("player:checkTrash",ClosestPed)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CHECKSHOES
-----------------------------------------------------------------------------------------------------------------------------------------
local UniqueShoes = {}
RegisterServerEvent("player:checkShoes")
AddEventHandler("player:checkShoes",function(Entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if not UniqueShoes[Entity] then
			UniqueShoes[Entity] = os.time()
		end

		if os.time() >= UniqueShoes[Entity] then
			if vSKINSHOP.checkShoes(Entity) then
				vRP.GenerateItem(Passport,"WEAPON_SHOES",2,true)
				UniqueShoes[Entity] = os.time() + 300
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OUTFIT - REMOVER
-----------------------------------------------------------------------------------------------------------------------------------------
local removeFit = {
	["homem"] = {
		["hat"] = { item = -1, texture = 0 },
		["pants"] = { item = 14, texture = 0 },
		["vest"] = { item = 0, texture = 0 },
		["backpack"] = { item = 0, texture = 0 },
		["bracelet"] = { item = -1, texture = 0 },
		["decals"] = { item = 0, texture = 0 },
		["mask"] = { item = 0, texture = 0 },
		["shoes"] = { item = 5, texture = 0 },
		["tshirt"] = { item = 15, texture = 0 },
		["torso"] = { item = 15, texture = 0 },
		["accessory"] = { item = 0, texture = 0 },
		["watch"] = { item = -1, texture = 0 },
		["arms"] = { item = 15, texture = 0 },
		["glass"] = { item = 0, texture = 0 },
		["ear"] = { item = -1, texture = 0 }
	},
	["mulher"] = {
		["hat"] = { item = -1, texture = 0 },
		["pants"] = { item = 14, texture = 0 },
		["vest"] = { item = 0, texture = 0 },
		["backpack"] = { item = 0, texture = 0 },
		["bracelet"] = { item = -1, texture = 0 },
		["decals"] = { item = 0, texture = 0 },
		["mask"] = { item = 0, texture = 0 },
		["shoes"] = { item = 5, texture = 0 },
		["tshirt"] = { item = 15, texture = 0 },
		["torso"] = { item = 15, texture = 0 },
		["accessory"] = { item = 0, texture = 0 },
		["watch"] = { item = -1, texture = 0 },
		["arms"] = { item = 15, texture = 0 },
		["glass"] = { item = 0, texture = 0 },
		["ear"] = { item = -1, texture = 0 }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:PRESET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:Preset")
AddEventHandler("player:Preset", function(Number)
    local source = source
    local Passport = vRP.Passport(source)

    if Passport then
        if vRP.HasService(Passport, "Emergency") or vRP.HasGroup(Passport, "Core") then
            local Model = vRP.ModelPlayer(source)
			vRPC.playAnim(source, true, {"clothingshirt", "try_shirt_positive_d"}, true)

			Citizen.Wait(5000)
            if Model == "mp_m_freemode_01" or Model == "mp_f_freemode_01" then
                TriggerClientEvent("skinshop:Apply", source, preset[Number][Model])
				vRPC.stopAnim(source,true)
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Connect",function(Passport,source)
	TriggerClientEvent("player:DuiTable",source,DuiTextures)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport)
	if playerCarry[Passport] then
		TriggerClientEvent("player:Commands",playerCarry[Passport],false)
		playerCarry[Passport] = nil
	end
end)