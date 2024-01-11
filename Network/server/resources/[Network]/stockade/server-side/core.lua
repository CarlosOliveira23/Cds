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
Tunnel.bindInterface("stockade",Kaduzera)
vCLIENT = Tunnel.getInterface("stockade")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local stockadeNet = 0
local stockadeTimer = 120000
-----------------------------------------------------------------------------------------------------------------------------------------
-- VERIFY
-----------------------------------------------------------------------------------------------------------------------------------------
function Kaduzera.Check()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Service,Total = vRP.NumPermission("Police")
		if Total <= 0 then
			TriggerClientEvent("Notify",source,"amarelo","Sistema indisponivel.",5000)
			return false
		end

		local Consult = vRP.InventoryItemAmount(Passport,"card05")
		if Consult[1] >= 1 then
			if not vRP.CheckDamaged(Consult[2]) then
				if vRP.TakeItem(Passport,Consult[2],1) then
			        return true
				end
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOCKADEINSERT
-----------------------------------------------------------------------------------------------------------------------------------------
function Kaduzera.stockadeInsert(vehNet)
	stockadeNet = parseInt(vehNet)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("stockade:explodeVehicle")
AddEventHandler("stockade:explodeVehicle",function()
	stockadeNet = 0
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOCKADENET
-----------------------------------------------------------------------------------------------------------------------------------------
function stockadeNet()
	return stockadeNet
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXPORTS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("stockadeNet",stockadeNet)