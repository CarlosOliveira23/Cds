-----------------------------------------------------------------------------------------------------------------------------------------
-- DRUGSINFLUENCES
-----------------------------------------------------------------------------------------------------------------------------------------
DrugsInfluences = {
	{ 1272.26, -1712.57, 54.76, 250 },
	{ 95.58, -1985.56, 20.44, 250 },
	{ -31.47, -1434.84, 31.49, 250 },
	{ 347.45, -2069.06, 20.89, 250 },
	{ 512.29, -1803.52, 28.51, 250 },
	{ 230.55, -1753.35, 28.98, 250 },
    { -1253.68, -1436.69, 7.85, 250 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRUGSLIST
-----------------------------------------------------------------------------------------------------------------------------------------
DrugsList = {
	["cocaine"] = {
		Price = { ["Min"] = 500, ["Max"] = 500},
		Amount = { ["Min"] = 1, ["Max"] = 1 }
	},
	["crack"] = {
		Price = { ["Min"] = 450, ["Max"] = 650},
		Amount = { ["Min"] = 2, ["Max"] = 4 }
	},
	["heroin"] = {
		Price = { ["Min"] = 450, ["Max"] = 650},
		Amount = { ["Min"] = 2, ["Max"] = 4 }
	},
	["joint"] = {
		Price = { ["Min"] = 450, ["Max"] = 650},
		Amount = { ["Min"] = 2, ["Max"] = 4 }
	},
	["lean"] = {
		Price = { ["Min"] = 450, ["Max"] = 650},
		Amount = { ["Min"] = 2, ["Max"] = 4 }
	},
	["metadone"] = {
		Price = { ["Min"] = 450, ["Max"] = 650},
		Amount = { ["Min"] = 2, ["Max"] = 4 }
	},
	["meth"] = {
		Price = { ["Min"] = 450, ["Max"] = 650},
		Amount = { ["Min"] = 5, ["Max"] = 5 }
	},
	["oxy"] = {
		Price = { ["Min"] = 450, ["Max"] = 650},
		Amount = { ["Min"] = 2, ["Max"] = 4 }
	},
	["sonhodogomes"] = {
		Price = { ["Min"] = 450, ["Max"] = 650},
		Amount = { ["Min"] = 2, ["Max"] = 4 }
	},
	["donhodokadu"] = {
		Price = { ["Min"] = 450, ["Max"] = 650},
		Amount = { ["Min"] = 2, ["Max"] = 4 }
	},
	["lancaperfume"] = {
		Price = { ["Min"] = 450, ["Max"] = 650},
		Amount = { ["Min"] = 2, ["Max"] = 4 }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKDRUGS
-----------------------------------------------------------------------------------------------------------------------------------------
function Kaduzera.CheckDrugs()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		for k,v in pairs(DrugsList) do
			local Amount = math.random(v["Amount"]["Min"],v["Amount"]["Max"])
			local Price = math.random(v["Price"]["Min"],v["Price"]["Max"])

			local Consult = vRP.InventoryItemAmount(Passport,k)
			if Consult[1] >= Amount then
				Drugs[Passport] = { Consult[2],Amount,Price * Amount }
				return true
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTDRUGS
-----------------------------------------------------------------------------------------------------------------------------------------
function Kaduzera.PaymentDrugs()
	local source = source
	local Passport = vRP.Passport(source)
    local Points = 0
    local Percentage = 90

	if Passport and not Active[Passport] and Drugs[Passport] and vRP.TakeItem(Passport,Drugs[Passport][1],Drugs[Passport][2]) then
		Active[Passport] = true

		local Valuation = Drugs[Passport][3]

		if Buffs["Dexterity"][Passport] and Buffs["Dexterity"][Passport] > os.time() then
			Valuation = Valuation + (Valuation * 0.1)
		end

		local Ped = GetPlayerPed(source)
		local Coords = GetEntityCoords(Ped)

		for k,v in pairs(DrugsInfluences) do
			local Distance = #(Coords - vec3(v[1],v[2],v[3]))
			if Distance <= v[4] then
				Valuation = Valuation + (Valuation * 0.5)
			end
		end

		TriggerClientEvent("player:Residuals", source, "Resíduo Orgânico.")

		if math.random(100) >= 50 then
			vRP.GenerateItem(Passport, "dollarsroll", Valuation, true)
		else
			vRP.GenerateItem(Passport, "dollars", Valuation, true)
		end

		-- Adjust Percentage based on your logic
		Percentage = Percentage - Points

		if Percentage <= 10 then
			Percentage = 10
		end

		local Ped = GetPlayerPed(source)
		local Coords = GetEntityCoords(Ped)
		for k,v in pairs(DrugsInfluences) do
			local Distance = #(Coords - vec3(v[1],v[2],v[3]))
			if Distance <= v[4] then
				-- Check if the random number falls within the Percentage
				if math.random(100) <= Percentage then
					local Service = vRP.NumPermission("Police")
					for Passports, Sources in pairs(Service) do
						async(function()
							TriggerClientEvent("sounds:source", Sources, "crime", 0.25)
							TriggerClientEvent("NotifyPush", Sources, { code = 20, title = "Venda de Drogas", x = Coords["x"], y = Coords["y"], z = Coords["z"], criminal = "Ligação Anônima", color = 16 })
						end)
					end
				end
			end
		end

		Active[Passport] = nil
		Drugs[Passport] = nil
	end
end
