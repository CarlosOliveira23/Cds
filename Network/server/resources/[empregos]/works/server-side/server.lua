-----------------------------------------------------------------------------------------------------------------------------------------
-- kadu
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("works",cRP)
vCLIENT = Tunnel.getInterface("works")
-----------------------------------------------------------------------------------------------------------------------------------------
-- WORKS
-----------------------------------------------------------------------------------------------------------------------------------------
local works = {
	["Colheita"] = {
		["coords"] = { 2416.24,4993.75,46.22 },
		["upgradeStress"] = 1,
		["routeCollect"] = false,
		["routeDelivery"] = false,
		["usingVehicle"] = false,
		["collectRandom"] = true,
		["collectText"] = "COLETAR",
		["deliveryText"] = "ENTREGAR",
		["collectButtonDistance"] = 2,
		["collectShowDistance"] = 100,
		["collectDuration"] = 5000,
		["collectAnim"] = { false,"amb@prop_human_movie_bulb@base","base",true },
		["collectConsume"] = {
			["min"] = 2,
			["max"] = 4
		},
		["collectCoords"] = {
			{ 2390.31,5004.73,45.76 },
			{ 2390.27,4992.74,45.22 },
			{ 2377.94,5003.94,44.64 },
			{ 2376.49,5016.37,45.39 },
			{ 2369.75,5011.4,44.4 },
			{ 2361.04,5001.74,43.42 },
			{ 2361.9,4989.12,43.34 },
			{ 2361.82,4976.85,43.24 },
			{ 2349.59,4976.11,42.78 },
			{ 2336.77,4976.02,42.61 },
			{ 2318.25,4984.08,41.77 },
			{ 2331.02,4995.78,42.11 },
			{ 2344.32,5007.47,42.71 },
			{ 2357.17,5020.13,43.86 },
			{ 2344.15,5022.73,43.54 },
			{ 2331.39,5007.76,42.36 },
			{ 2317.39,4993.94,42.06 },
			{ 2305.24,4996.86,42.29 },
			{ 2316.61,5008.62,42.53 },
			{ 2330.4,5021.44,42.88 },
			{ 2316.85,5024.13,43.39 }
		},
		["deliveryItem"] = {
			"banana",
			"passion",
			"grape",
			"tange",
			"orange",
			"apple",
			"strawberry",
			"acerola",
			"guarana"
		}
	},
	["Lenhador"] = {
		["coords"] = { -841.52,5401.32,34.61,297.64 },
		["upgradeStress"] = 1,
		["routeCollect"] = false,
		["routeDelivery"] = false,
		["usingVehicle"] = false,
		["collectRandom"] = true,
		["collectText"] = "CORTAR ÁRVORE",
		["deliveryText"] = "ENTREGAR",
		["collectButtonDistance"] = 2,
		["collectShowDistance"] = 1000,
		["collectDuration"] = 10000,
		["collectAnim"] = { false,"melee@hatchet@streamed_core","plyr_front_takedown_b",true },
		["collectConsume"] = {
			["min"] = 2,
			["max"] = 4
		},
		["collectCoords"] = {
			{ -652.94,5455.72,51.75 },
			{ -644.0,5460.24,53.25 },
			{ -632.3,5466.16,53.7 },
			{ -629.19,5470.25,53.7 },
			{ -627.38,5473.18,53.36 },
			{ -590.99,5494.37,54.07 },
			{ -585.42,5492.09,55.25 },
			{ -596.86,5474.38,56.19 },
			{ -582.06,5470.59,59.43 },
			{ -578.72,5468.75,60.24 },
			{ -566.7,5501.9,57.74 }
		},
		["deliveryItem"] = {
			"woodlog",
		}
	},
	--[["AgricultorTrigo"] = {
		["coords"] = { 2301.09,5064.78,45.81 },
		["upgradeStress"] = 1,
		["routeCollect"] = false,
		["routeDelivery"] = false,
		["usingVehicle"] = false,
		["collectRandom"] = false,
		["collectText"] = "COLETAR",
		["deliveryText"] = "ENTREGAR",
		["collectButtonDistance"] = 1,
		["collectShowDistance"] = 100,
		["collectDuration"] = 10000,
		["collectAnim"] = { false,"amb@world_human_gardener_plant@female@base","base_female",true },
		["collectConsume"] = {
			["min"] = 3,
			["max"] = 5
		},
		["collectCoords"] = {
			{ 2295.92,5064.95,46.17 },
			{ 2293.8,5067.14,46.34 },
			{ 2291.75,5069.28,46.49 },
			{ 2289.82,5071.4,46.64 },
			{ 2287.77,5073.64,46.81 },
			{ 2285.02,5076.56,46.98 },
			{ 2282.33,5079.04,47.04 },
			{ 2279.87,5081.56,47.15 },
			{ 2277.08,5084.23,47.25 },
			{ 2274.59,5086.94,47.43 },
			{ 2271.21,5083.77,46.69 },
			{ 2273.74,5081.23,46.71 },
			{ 2276.23,5078.6,46.74 },
			{ 2278.77,5076.02,46.67 },
			{ 2281.35,5073.42,46.54 },
			{ 2284.08,5070.68,46.35 },
			{ 2286.32,5068.42,46.27 },
			{ 2288.38,5066.38,46.19 },
			{ 2290.48,5064.27,46.1 },
			{ 2292.53,5062.15,46.0 },
			{ 2289.37,5058.53,45.73 },
			{ 2287.34,5060.77,45.81 },
			{ 2285.25,5062.94,45.87 },
			{ 2283.34,5064.88,45.92 },
			{ 2281.23,5067.01,45.97 },
			{ 2278.48,5069.65,46.12 },
			{ 2275.85,5072.31,46.22 },
			{ 2273.2,5075.1,46.3 },
			{ 2270.63,5077.6,46.35 },
			{ 2268.22,5080.12,46.42 },
			{ 2264.55,5077.09,46.17 },
			{ 2267.13,5074.58,46.08 },
			{ 2269.68,5072.01,45.97 },
			{ 2272.24,5069.44,45.85 },
			{ 2274.91,5066.72,45.71 },
			{ 2277.57,5064.04,45.53 },
			{ 2279.65,5061.88,45.46 },
			{ 2281.6,5059.89,45.43 },
			{ 2283.83,5057.62,45.39 },
			{ 2285.91,5055.53,45.34 },
			{ 2283.01,5051.97,44.97 },
			{ 2280.89,5053.97,45.06 },
			{ 2278.69,5056.37,45.12 },
			{ 2276.64,5058.28,45.17 },
			{ 2274.56,5060.46,45.24 },
			{ 2271.93,5063.1,45.33 },
			{ 2269.32,5065.73,45.49 },
			{ 2266.67,5068.45,45.68 },
			{ 2264.29,5070.97,45.87 },
			{ 2261.75,5073.62,46.05 }
		},
		["deliveryItem"] = "wheat"
	},
		["leiteiro"] = {
		["coords"] = { 2445.58,4810.2,35.0 },
		["upgradeStress"] = 1,
		["routeCollect"] = false,
		["routeDelivery"] = false,
		["usingVehicle"] = false,
		["collectRandom"] = false,
		["collectText"] = "COLETAR",
		["deliveryText"] = "ENTREGAR",
		["collectButtonDistance"] = 1,
		["collectShowDistance"] = 100,
		["collectDuration"] = 10000,
		["collectAnim"] = { false,"amb@world_human_gardener_plant@female@base","base_female",true },
		["collectConsume"] = {
			["min"] = 3,
			["max"] = 5
		},
		["collectCoords"] = {
			{ 2432.68,4802.08,34.79 },
			{ 2440.07,4795.05,34.64 },
			{ 2448.15,4786.99,34.64 },
			{ 2456.23,4778.18,34.51 },
			{ 2463.72,4770.12,34.37 },
			{ 2472.93,4761.43,34.31 },
			{ 2494.32,4762.99,34.37 },
			{ 2502.53,4754.37,34.31 },
			{ 2510.84,4746.44,34.31 },
			{ 2519.19,4737.79,34.31 },
			{ 2440.3,4736.87,34.29 },
			{ 2433.45,4744.74,34.31 },
			{ 2425.03,4752.06,34.31 },
			{ 2416.95,4760.64,34.31 },
			{ 2409.05,4768.41,34.31 },
			{ 2401.05,4777.31,34.53 }
		},
		["deliveryItem"] = "milkbottle2"
	},
	
	["ovos"] = {
		["coords"] = { -68.04,6253.73,31.09 },
		["upgradeStress"] = 1,
		["routeCollect"] = false,
		["routeDelivery"] = false,
		["usingVehicle"] = false,
		["collectRandom"] = false,
		["collectText"] = "COLETAR",
		["deliveryText"] = "ENTREGAR",
		["collectButtonDistance"] = 1,
		["collectShowDistance"] = 100,
		["collectDuration"] = 10000,
		["collectAnim"] = { false,"amb@world_human_gardener_plant@female@base","base_female",true },
		["collectConsume"] = {
			["min"] = 3,
			["max"] = 5
		},
		["collectCoords"] = {
			{ -60.05,6238.49,31.09 },
			{ -62.69,6242.46,31.09 },
			{ -61.8,6241.07,31.09 },
			{ -64.72,6245.74,31.09 },
			{ -66.46,6248.37,31.09 },
			{ -67.95,6248.67,31.09 },
			{ -70.1,6248.84,31.07 },
			{ -66.26,6236.71,31.09 },
			{ -64.37,6234.74,31.09 }
		},
		["deliveryItem"] = "ovo"
	},

	["AgricultorHorticolas"] = {
		["coords"] = { 1993.26,4855.72,43.79 },
		["upgradeStress"] = 1,
		["routeCollect"] = false,
		["routeDelivery"] = false,
		["usingVehicle"] = false,
		["collectRandom"] = true,
		["collectText"] = "COLETAR",
		["deliveryText"] = "ENTREGAR",
		["collectButtonDistance"] = 1,
		["collectShowDistance"] = 100,
		["collectDuration"] = 10000,
		["collectAnim"] = { false,"amb@prop_human_movie_bulb@base","base",true },
		["collectConsume"] = {
			["min"] = 2,
			["max"] = 4
		},
		["collectCoords"] = {
			{ 1988.71,4849.61,43.98 },
			{ 1990.84,4847.41,43.99 },
			{ 1993.46,4843.57,43.91 },
			{ 2002.65,4835.13,43.25 },
			{ 2006.02,4831.72,43.05 },
			{ 2008.24,4829.49,42.8 },
			{ 2005.93,4830.69,43.0 }
		},
		["deliveryItem"] = {
			"tomato",
			"alface",
			"cebola"
		}
	},
	["Minerador"] = {
		["coords"] = { 2965.19,2755.93,43.25 },
		["upgradeStress"] = 3,
		["routeCollect"] = false,
		["routeDelivery"] = false,
		["usingVehicle"] = false,
		["collectRandom"] = true,
		["collectText"] = "MINERAR",
		["deliveryText"] = "ENTREGAR",
		["collectButtonDistance"] = 1,
		["collectShowDistance"] = 500,
		["collectDuration"] = 10000,
		["collectAnim"] = { false,"amb@world_human_const_drill@male@drill@base", "base","prop_tool_jackham",true },
		["collectConsume"] = {
			["min"] = 2,
			["max"] = 4
		},
		["collectCoords"] = {
			{ 2948.23,2728.04,47.11,93.55 },
			{ 2948.29,2731.72,45.88,343.0 },
			{ 2944.7,2733.59,46.15,294.81 },
			{ 2948.64,2738.76,45.06,294.81 },
			{ 2939.36,2741.48,44.65,306.15 },
			{ 2942.84,2741.13,44.96,308.98 },
			{ 2940.15,2746.45,43.78,11.34 },
			{ 2937.04,2756.76,44.08,297.64 },
			{ 2943.09,2756.39,43.52,269.3 },
			{ 2947.59,2754.69,43.91,249.45 },
			{ 2954.06,2754.47,43.96,215.44 },
			{ 2955.42,2755.8,44.13,325.99 },
			{ 2959.48,2758.98,42.53,325.99 },
			{ 2972.13,2774.23,39.33,348.67 },
			{ 2968.32,2774.02,38.67,73.71 },
			{ 2969.02,2775.37,39.58,306.15 },
			{ 2964.59,2773.86,39.98,70.87 },
			{ 2957.62,2772.82,40.34,90.71 },
			{ 2955.71,2772.99,40.02,82.21 },
			{ 2953.71,2770.29,39.53,124.73 },
			{ 2952.41,2768.01,40.02,201.26 },
			{ 2948.58,2767.28,39.8,104.89 },
			{ 2946.6,2765.2,40.24,300.48 },
			{ 2939.27,2768.89,39.7,48.19 },
			{ 2937.79,2771.33,39.85,25.52 },
			{ 2938.63,2774.6,39.73,343.0 },
			{ 2937.13,2774.59,39.73,51.03 },
			{ 2934.33,2784.1,39.95,325.99 },
			{ 2930.31,2786.42,40.04,328.82 },
			{ 2927.86,2789.21,40.66,204.1 },
			{ 2927.81,2790.06,40.51,300.48 },
			{ 2926.38,2791.82,41.15,5.67 },
			{ 2925.41,2795.36,41.23,144.57 },
			{ 2925.53,2795.89,41.35,351.5 },
			{ 2921.5,2798.4,42.34,85.04 },
			{ 2918.4,2800.28,41.72,56.7 },
			{ 2926.21,2813.53,45.7,328.82 },
			{ 2930.79,2817.13,45.71,192.76 },
			{ 2937.08,2813.97,43.91,229.61 },
			{ 2938.12,2813.24,43.49,53.86 },
			{ 2944.81,2818.91,43.25,110.56 },
			{ 2944.99,2820.06,43.47,2.84 },
			{ 2947.53,2820.84,43.42,184.26 },
			{ 2950.63,2816.66,42.83,226.78 },
			{ 2955.78,2819.32,43.03,311.82 },
			{ 2958.77,2819.77,43.54,266.46 },
			{ 2928.07,2767.59,44.31,206.93 },
			{ 2929.57,2765.68,44.42,76.54 }
		},
		["deliveryItem"] = {
			"gemstone"
		}
	},]]--
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local collectAmount = {}
local paymentAmount = {}
local deliveryAmount = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- COLLECTCONSUME
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.collectConsume(serviceName)
	local source = source
	local Passport = vRP.Passport(source)
	local License = vRP.Identities(source)
	local Account = vRP.Account(License)
	if Passport then
		if works[serviceName]["collectRandom"] then
			local amountItem = 0
			local selectItem = ""

			local randomItem = math.random(#works[serviceName]["deliveryItem"])
			selectItem = works[serviceName]["deliveryItem"][randomItem]
			amountItem = math.random(works[serviceName]["collectConsume"]["min"],works[serviceName]["collectConsume"]["max"])

			if (vRP.InventoryWeight(Passport) + (itemWeight(selectItem) * parseInt(amountItem))) <= vRP.GetWeight(Passport) then			
				vRP.GenerateItem(Passport,selectItem,amountItem,true)

				if works[serviceName]["upgradeStress"] > 0 then
					vRP.UpgradeStress(Passport,works[serviceName]["upgradeStress"])
				end

				return true
			else
				TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
			end
		else
			local deliveryItem = works[serviceName]["deliveryItem"]
			collectAmount[Passport] = math.random(works[serviceName]["collectConsume"]["min"],works[serviceName]["collectConsume"]["max"])

			if (vRP.InventoryWeight(Passport) + (itemWeight(deliveryItem) * parseInt(collectAmount[Passport]))) <= vRP.GetWeight(Passport) then	
				vRP.GenerateItem(Passport,deliveryItem,collectAmount[Passport],true)

				if deliveryItem == "dollars" then
					if vRP.LicensePremium(License) then
						vRP.GenerateItem(Passport,deliveryItem,collectAmount[Passport] * 0.10,true)
					end
				end

				if works[serviceName]["upgradeStress"] > 0 then
					vRP.UpgradeStress(Passport,works[serviceName]["upgradeStress"])
				end

				collectAmount[Passport] = nil

				return true
			else
				TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELIVERYCONSUME
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.deliveryConsume(serviceName)
	local source = source
	local Passport = vRP.Passport(source)
	local License = vRP.Identities(source)
	local Account = vRP.Account(License)
	if Passport then
		local deliveryItem = works[serviceName]["deliveryPayment"]["item"]
		deliveryAmount[Passport] = math.random(works[serviceName]["deliveryConsume"]["min"],works[serviceName]["deliveryConsume"]["max"])
		paymentAmount[Passport] = math.random(works[serviceName]["deliveryPayment"]["min"],works[serviceName]["deliveryPayment"]["max"])

		if (vRP.InventoryWeight(Passport) + (itemWeight(deliveryItem) * parseInt(paymentAmount[Passport]))) <= vRP.GetWeight(Passport) then		
			if vRP.tryGetInventoryItem(Passport,works[serviceName]["deliveryItem"],deliveryAmount[Passport]) then
				local paymentPrice = parseInt(paymentAmount[Passport] * deliveryAmount[Passport])

				vRP.GenerateItem(Passport,deliveryItem,paymentPrice,true)

				if deliveryItem == "dollars" then
					if vRP.LicensePremium(License) then
						vRP.GenerateItem(Passport,deliveryItem,paymentPrice * 0.10,true)
					end
				end

				deliveryAmount[Passport] = nil
				paymentAmount[Passport] = nil

				if works[serviceName]["upgradeStress"] > 0 then
					vRP.UpgradeStress(Passport,works[serviceName]["upgradeStress"])
				end

				return true
			else
				TriggerClientEvent("Notify",source,"amarelo","Precisa de <b>"..parseFormat(deliveryAmount[Passport]).."x "..itemName(works[serviceName]["deliveryItem"]).."</b> para entregar.",5000)
			end
		else
			TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkPermission(serviceName)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if works[serviceName]["perm"] == nil then
			return true
		end

		if vRP.HasGroup(Passport,works[serviceName]["perm"]) then
			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Connect",function(Passport,source)
	vCLIENT.updateworks(source,works)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENSURE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ensureworks",function(source,args,rawCommand)
	local Passport = vRP.Passport(source)
	if Passport then
		TriggerClientEvent("Notify",source,"amarelo","Script Recarregado",3000)
		if vRP.HasGroup(Passport,"Admin",1) then
			vCLIENT.updateworks(-1,works)
			vCLIENT.updateworks(source,works)
		end
	end
end)