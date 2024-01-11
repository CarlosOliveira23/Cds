-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKGYM
-----------------------------------------------------------------------------------------------------------------------------------------
function Kaduzera.CheckGym()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.GetWeight(Passport) >= 120 then
			TriggerClientEvent("Notify", source, "vermelho", "Você atingiu o seu máximo.", 5000)

			return false
		else
			vRPC.AnimActive(source)

			Player(source)["state"]["Cancel"] = true
			Player(source)["state"]["Buttons"] = true

			TriggerClientEvent("inventory:Close", source)

			return true
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTGYM
-----------------------------------------------------------------------------------------------------------------------------------------
function Kaduzera.StartGym(Amount)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		vRP.UpgradeStress(Passport, math.random(3, 6))
		vRP.DowngradeThirst(Passport, math.random(3, 6))

		local Members = exports["vrp"]:Party(Passport,source,5)
		if parseInt(#Members) >= 2 then
			for _,v in pairs(Members) do
				if vRP.Passport(v["Source"]) then
					vRP.SetWeight(v["Passport"], Amount * 2)
					TriggerClientEvent("Notify", source, "verde", "Você conseguiu <b>+ "..parseInt(Amount * 2).."Kg</b>.", 5000)
				end
			end
		else
			vRP.SetWeight(Passport, Amount)
			TriggerClientEvent("Notify", source, "verde", "Você conseguiu <b>+ "..parseInt(Amount).."Kg</b>.", 5000)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOPGYM
-----------------------------------------------------------------------------------------------------------------------------------------
function Kaduzera.StopGym()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		vRPC.Destroy(source)
		vRPC.Destroy(source, "one")

		Player(source)["state"]["Cancel"] = false
		Player(source)["state"]["Buttons"] = false
	end
end