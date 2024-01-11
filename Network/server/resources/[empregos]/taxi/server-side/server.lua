-----------------------------------------------------------------------------------------------------------------------------------------
-- kadu
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Kaduzera = {}
Tunnel.bindInterface("taxi",Kaduzera)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
function Kaduzera.paymentService()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local value = math.random(100,100)
		vRP.GenerateItem(Passport,"dollars",value,true)

		if vRP.HasGroup(Passport,"Premium") then
			vRP.GenerateItem(Passport,"dollars",value * 0.3,true)
		elseif vRP.HasGroup(Passport,"PremiumOuro") then
			vRP.GenerateItem(Passport,"dollars",value * 0.2,true)
		elseif vRP.HasGroup(Passport,"PremiumPrata") then
			vRP.GenerateItem(Passport,"dollars",value * 0.1,true)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INITSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
function Kaduzera.initService(status)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if status then
			vRP.SetPermission(source,"Taxi")
		else
			vRP.RemovePermission(source,"Taxi")
		end
	end

	return true
end