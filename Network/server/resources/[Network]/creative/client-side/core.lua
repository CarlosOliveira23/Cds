-----------------------------------------------------------------------------------------------------------------------------------------
-- kadu
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPS = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Kaduzera = {}
Tunnel.bindInterface("creative",Kaduzera)
vSERVER = Tunnel.getInterface("creative")
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
local Blips = {
	-- Ammunation (Framework)
	{ 1692.62,3759.50,34.70,76,6,"Loja de Armas",0.4 },
	{ 252.89,-49.25,69.94,76,6,"Loja de Armas",0.4 },
	{ 843.28,-1034.02,28.19,76,6,"Loja de Armas",0.4 },
	{ -331.35,6083.45,31.45,76,6,"Loja de Armas",0.4 },
	{ -663.15,-934.92,21.82,76,6,"Loja de Armas",0.4 },
	{ -1305.18,-393.48,36.69,76,6,"Loja de Armas",0.4 },
	{ -1118.80,2698.22,18.55,76,6,"Loja de Armas",0.4 },
	{ 2568.83,293.89,108.73,76,6,"Loja de Armas",0.4 },
	{ -3172.68,1087.10,20.83,76,6,"Loja de Armas",0.4 },
	{ 21.32,-1106.44,29.79,76,6,"Loja de Armas",0.4 },
	{ 811.19,-2157.67,29.61,76,6,"Loja de Armas",0.4 },
	-- Barbershop (Framework)
	{ -815.12,-184.15,37.57,71,62,"Barbearia",0.5 },
	{ 138.13,-1706.46,29.3,71,62,"Barbearia",0.5 },
	{ -1280.92,-1117.07,7.0,71,62,"Barbearia",0.5 },
	{ 1930.54,3732.06,32.85,71,62,"Barbearia",0.5 },
	{ 1214.2,-473.18,66.21,71,62,"Barbearia",0.5 },
	{ -33.61,-154.52,57.08,71,62,"Barbearia",0.5 },
	{ -276.65,6226.76,31.7,71,62,"Barbearia",0.5 },
	-- Boats (Framework)
	{ -1728.06,-1050.69,1.71,266,62,"Embarcações",0.5 },
	{ 1966.36,3975.86,31.51,266,62,"Embarcações",0.5 },
	{ -776.72,-1495.02,2.29,266,62,"Embarcações",0.5 },
	{ -893.97,5687.78,3.29,266,62,"Embarcações",0.5 },
	-- Departament (Framework)
	{ 25.68,-1346.6,29.5,52,36,"Loja de Departamento",0.5 },
	{ 2556.47,382.05,108.63,52,36,"Loja de Departamento",0.5 },
	{ 1163.55,-323.02,69.21,52,36,"Loja de Departamento",0.5 },
	{ -707.31,-913.75,19.22,52,36,"Loja de Departamento",0.5 },
	{ -47.72,-1757.23,29.43,52,36,"Loja de Departamento",0.5 },
	{ 373.89,326.86,103.57,52,36,"Loja de Departamento",0.5 },
	{ -3242.95,1001.28,12.84,52,36,"Loja de Departamento",0.5 },
	{ 1729.3,6415.48,35.04,52,36,"Loja de Departamento",0.5 },
	{ 548.0,2670.35,42.16,52,36,"Loja de Departamento",0.5 },
	{ 1960.69,3741.34,32.35,52,36,"Loja de Departamento",0.5 },
	{ 2677.92,3280.85,55.25,52,36,"Loja de Departamento",0.5 },
	{ 1698.5,4924.09,42.07,52,36,"Loja de Departamento",0.5 },
	{ -1820.82,793.21,138.12,52,36,"Loja de Departamento",0.5 },
	{ 1393.21,3605.26,34.99,52,36,"Loja de Departamento",0.5 },
	{ -2967.78,390.92,15.05,52,36,"Loja de Departamento",0.5 },
	{ -3040.14,585.44,7.91,52,36,"Loja de Departamento",0.5 },
	{ 1135.56,-982.24,46.42,52,36,"Loja de Departamento",0.5 },
	{ 1166.0,2709.45,38.16,52,36,"Loja de Departamento",0.5 },
	{ -1487.21,-378.99,40.17,52,36,"Loja de Departamento",0.5 },
	{ -1222.76,-907.21,12.33,52,36,"Loja de Departamento",0.5 },
	-- Garages (Framework)
	{ 55.43,-876.19,30.66,357,33,"Garagem",0.6 },
    { 598.04,2741.27,42.07,357,65,"Garagem",0.6 },
    { -136.36,6357.03,31.49,357,33,"Garagem",0.6 },
    { 596.40,90.65,93.12,357,65,"Garagem",0.6 },
    { -340.76,265.97,85.67,357,65,"Garagem",0.6 },
    { -2030.01,-465.97,11.60,357,65,"Garagem",0.6 },
    { -1184.92,-1510.00,4.64,357,65,"Garagem",0.6 },
    { -348.88,-874.02,31.31,357,65,"Garagem",0.6 },
    { 1035.89,-763.89,57.99,357,65,"Garagem",0.6 },
    { -796.63,-2022.77,9.16,357,65,"Garagem",0.6 },
    { 453.27,-1146.76,29.52,357,65,"Garagem",0.6 },
    { -1159.48,-739.32,19.89,357,65,"Garagem",0.6 },
    { 1725.21,4711.77,42.11,357,65,"Garagem",0.6 },
    { 1624.05,3566.14,35.15,357,33,"Garagem",0.6 },
	-- Pharmacy (Framework)
	{ -172.21,6385.85,31.49,403,5,"Farmácia",0.7 },
	{ 114.66,-6.14,67.8,403,5,"Farmácia",0.7 },
	{ 1690.07,3581.68,35.62,403,5,"Farmácia",0.7 },  
	{ 326.5,-1074.43,29.47,403,5,"Farmácia",0.7 },      
	-- Skinshop (Framework)
	{ 75.35,-1392.92,29.38,366,62,"Loja de Roupas",0.5 },
	{ -710.15,-152.36,37.42,366,62,"Loja de Roupas",0.5 },
	{ -163.73,-303.62,39.74,366,62,"Loja de Roupas",0.5 },
	{ -822.38,-1073.52,11.33,366,62,"Loja de Roupas",0.5 },
	{ -1193.13,-767.93,17.32,366,62,"Loja de Roupas",0.5 },
	{ -1449.83,-237.01,49.82,366,62,"Loja de Roupas",0.5 },
	{ 4.83,6512.44,31.88,366,62,"Loja de Roupas",0.5 },
	{ 1693.95,4822.78,42.07,366,62,"Loja de Roupas",0.5 },
	{ 125.82,-223.82,54.56,366,62,"Loja de Roupas",0.5 },
	{ 614.2,2762.83,42.09,366,62,"Loja de Roupas",0.5 },
	{ 1196.72,2710.26,38.23,366,62,"Loja de Roupas",0.5 },
	{ -3170.53,1043.68,20.87,366,62,"Loja de Roupas",0.5 },
	{ -1101.42,2710.63,19.11,366,62,"Loja de Roupas",0.5 },
	{ 425.6,-806.25,29.5,366,62,"Loja de Roupas",0.5 },
	{ -1118.03,-1439.38,5.11,366,62,"Loja de Roupas",0.5 },
	-- Tattooshop (Framework)
	{ 1322.93,-1652.29,52.27,75,13,"Loja de Tatuagem",0.5 },
	{ -1154.42,-1425.9,4.95,75,13,"Loja de Tatuagem",0.5 },
	{ 322.84,180.16,103.58,75,13,"Loja de Tatuagem",0.5 },
	{ -3169.62,1075.8,20.83,75,13,"Loja de Tatuagem",0.5 },
	{ 1864.07,3747.9,33.03,75,13,"Loja de Tatuagem",0.5 },
	{ -293.57,6199.85,31.48,75,13,"Loja de Tatuagem",0.5 },
	-- Central
	{ 562.36,2741.56,42.87,273,11,"Animal Park",0.5 },
	{ -61.1,-1093.52,26.49,225,62,"Benefactor",0.4 },
	--{ 918.69,50.33,80.9,617,62,"Diamond Casino",0.6 },
	{ 1655.27,4874.31,42.04,374,11,"Imobiliária",0.5 },
	{ -308.09,-163.93,40.42,374,11,"Imobiliária",0.5 },
	{ -1082.22,-247.54,37.77,439,73,"Life Invader",0.6 },
	{ 45.79,-1748.82,29.6,78,11,"Megamall",0.5 },
	{ -535.04,-221.34,37.64,267,5,"Prefeitura",0.6 },
	{ -741.56,5594.94,41.66,36,62,"Teleférico",0.6 },
	{ 454.46,5571.95,781.19,36,62,"Teleférico",0.6 },
	{ -604.39,-933.23,23.86,184,62,"Weazel News",0.6 },
	-- Public
	{ -907.26,-2046.19,9.3,60,18,"Departamento Policial",0.6 },
	{ 825.13,-1290.13,28.22,60,18,"Departamento Policial",0.6 },
	{ 1851.45,3686.71,34.26,60,18,"Departamento Policial",0.6 },
	{ -448.18,6011.68,31.71,60,18,"Departamento Policial",0.6 },
	{ 1155.43,-1521.37,34.85,80,38,"Hospital",0.5 },
	{ 1839.43,3672.86,34.27,80,38,"Hospital",0.5 },
	{ -247.42,6331.39,32.42,80,38,"Hospital",0.5 },
	{ 822.3,-996.27,26.27,402,26,"Mecânica",0.8 },
	-- Restaurants
	{ -1816.72,-1193.76,14.31,439,62,"Restaurante",0.5 },
	{ -368.86,264.62,84.84,77,62,"Last Train",0.5 },
	{ 2009.16,3719.74,32.12,77,62,"Last Train",0.5 },
	-- Works
	{ -1204.85,-1564.27,4.6,126,13,"Academia",0.6 },
	{ 2416.44,4993.82,46.22,76,62,"Emprego Agricultor",0.4 },
	--{ -1593.08,5202.9,4.31,141,62,"Emprego Caçador",0.7 },    --- Desativado por enquanto
	--{ -679.13,5839.52,17.3,141,62,"Emprego Caçador",0.7 }, --- Desativado por enquanto
	{ 1239.91,-3257.19,7.09,67,62,"Emprego Caminhoneiro",0.5 },
	{ -191.61,-1154.2,23.05,357,9,"Emprego Impound",0.6 },
	{ -839.76,5402.67,34.61,285,62,"Emprego Lenhador",0.5 },
	{ 82.54,-1553.28,29.59,318,62,"Emprego Lixeiro",0.6 },
	{ 287.36,2843.6,44.7,318,62,"Emprego Lixeiro",0.6 },
	{ -413.97,6171.58,31.48,318,62,"Emprego Lixeiro",0.6 },
	{ 2953.93,2787.49,41.5,617,62,"Emprego Minerador",0.6 },
	{ 452.99,-607.74,28.59,513,62,"Emprego Motorista",0.5 },
	{ 1530.61,3777.49,34.51,68,62,"The Boat House",0.5 },
	{ -428.56,-1728.33,19.79,467,11,"Venda Reciclagem",0.6 },
	{ 180.07,2793.29,45.65,467,11,"Venda Reciclagem",0.6 },
	{ -195.42,6264.62,31.49,467,11,"Venda Reciclagem",0.6 },
	{ -9.17,-657.0,33.45,67,62,"Emprego Transportador",0.6 },
	{ 1126.53,-644.34,56.77,88,2,"Emprego Faxineiro",0.5 },     ---- 895.21,-179.7,74.7,235.28
	{ 1043.13,698.81,158.84,88,2,"Venda de Frutas",0.5 },
	{ 1792.32,4594.69,37.68,88,2,"Venda de Frutas",0.5 },   
	{ 895.21,-179.7,74.7,209,0,"Emprego Taxista",0.5 },      
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        InvalidateIdleCam()
        InvalidateVehicleIdleCam()

        SetCreateRandomCops(false)
        CancelCurrentPoliceReport()
        SetCreateRandomCopsOnScenarios(false)
        SetCreateRandomCopsNotOnScenarios(false)

        SetPedInfiniteAmmoClip(PlayerPedId(),false)

        SetVehicleModelIsSuppressed(GetHashKey("jet"),true)
        SetVehicleModelIsSuppressed(GetHashKey("besra"),true)
        SetVehicleModelIsSuppressed(GetHashKey("luxor"),true)
        SetVehicleModelIsSuppressed(GetHashKey("blimp"),true)
		SetVehicleModelIsSuppressed(GetHashKey("blimp2"),true)
		SetVehicleModelIsSuppressed(GetHashKey("blimp3"),true)
        SetVehicleModelIsSuppressed(GetHashKey("polmav"),true)
        SetVehicleModelIsSuppressed(GetHashKey("buzzard2"),true)
        SetVehicleModelIsSuppressed(GetHashKey("mammatus"),true)
		SetVehicleModelIsSuppressed(GetHashKey("ambulance"),true)
        SetVehicleModelIsSuppressed(GetHashKey("firetruk"),true)
        SetPedModelIsSuppressed(GetHashKey("s_m_y_prismuscl_01"),true)
        SetPedModelIsSuppressed(GetHashKey("u_m_y_prisoner_01"),true)
        SetPedModelIsSuppressed(GetHashKey("s_m_y_prisoner_01"),true)

        Wait(1000)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		SetWeaponDamageModifierThisFrame("WEAPON_BAT",0.25)
		SetWeaponDamageModifierThisFrame("WEAPON_KATANA",0.25)
		SetWeaponDamageModifierThisFrame("WEAPON_HAMMER",0.25)
		SetWeaponDamageModifierThisFrame("WEAPON_WRENCH",0.25)
		SetWeaponDamageModifierThisFrame("WEAPON_UNARMED",0.25)
		SetWeaponDamageModifierThisFrame("WEAPON_HATCHET",0.25)
		SetWeaponDamageModifierThisFrame("WEAPON_CROWBAR",0.25)
		SetWeaponDamageModifierThisFrame("WEAPON_MACHETE",0.25)
		SetWeaponDamageModifierThisFrame("WEAPON_POOLCUE",0.25)
		SetWeaponDamageModifierThisFrame("WEAPON_KNUCKLE",0.25)
		SetWeaponDamageModifierThisFrame("WEAPON_KARAMBIT",0.25)
		SetWeaponDamageModifierThisFrame("WEAPON_GOLFCLUB",0.25)
		SetWeaponDamageModifierThisFrame("WEAPON_BATTLEAXE",0.25)
		SetWeaponDamageModifierThisFrame("WEAPON_FLASHLIGHT",0.25)
		SetWeaponDamageModifierThisFrame("WEAPON_NIGHTSTICK",0.35)
		SetWeaponDamageModifierThisFrame("WEAPON_STONE_HATCHET",0.25)
		SetWeaponDamageModifierThisFrame("WEAPON_SMOKEGRENADE",0.0)

		RemoveAllPickupsOfType("PICKUP_WEAPON_KNIFE")
		RemoveAllPickupsOfType("PICKUP_WEAPON_PISTOL")
		RemoveAllPickupsOfType("PICKUP_WEAPON_MINISMG")
		RemoveAllPickupsOfType("PICKUP_WEAPON_MICROSMG")
		RemoveAllPickupsOfType("PICKUP_WEAPON_PUMPSHOTGUN")
		RemoveAllPickupsOfType("PICKUP_WEAPON_CARBINERIFLE")
		RemoveAllPickupsOfType("PICKUP_WEAPON_SAWNOFFSHOTGUN")

		HideHudComponentThisFrame(1)
		HideHudComponentThisFrame(2)
		HideHudComponentThisFrame(3)
		HideHudComponentThisFrame(4)
		HideHudComponentThisFrame(5)
		HideHudComponentThisFrame(6)
		HideHudComponentThisFrame(7)
		HideHudComponentThisFrame(8)
		HideHudComponentThisFrame(9)
		HideHudComponentThisFrame(10)
		HideHudComponentThisFrame(11)
		HideHudComponentThisFrame(12)
		HideHudComponentThisFrame(13)
		HideHudComponentThisFrame(15)
		HideHudComponentThisFrame(17)
		HideHudComponentThisFrame(18)
		HideHudComponentThisFrame(19)
		HideHudComponentThisFrame(20)
		HideHudComponentThisFrame(21)
		HideHudComponentThisFrame(22)

		DisableControlAction(1,37,true)
		DisableControlAction(1,204,true)
		DisableControlAction(1,211,true)
		DisableControlAction(1,349,true)
		DisableControlAction(1,192,true)
		DisableControlAction(1,157,true)
		DisableControlAction(1,158,true)
		DisableControlAction(1,159,true)
		DisableControlAction(1,160,true)
		DisableControlAction(1,161,true)
		DisableControlAction(1,162,true)
		DisableControlAction(1,163,true)
		DisableControlAction(1,164,true)
		DisableControlAction(1,165,true)

		SetVehicleDensityMultiplierThisFrame(0.05)
		SetRandomVehicleDensityMultiplierThisFrame(0.05)
		SetParkedVehicleDensityMultiplierThisFrame(2.0)
		SetScenarioPedDensityMultiplierThisFrame(10.0,15.0)
		SetPedDensityMultiplierThisFrame(1.0)

		if IsPedArmed(PlayerPedId(),6) then
			DisableControlAction(1,140,true)
			DisableControlAction(1,141,true)
			DisableControlAction(1,142,true)
		end

		if GetPlayerWantedLevel(PlayerId()) ~= 0 then
			ClearPlayerWantedLevel(PlayerId())
		end

		DisablePlayerVehicleRewards(PlayerId())

		SetWeatherTypeNow(GlobalState["Weather"])
		SetWeatherTypePersist(GlobalState["Weather"])
		SetWeatherTypeNowPersist(GlobalState["Weather"])
		NetworkOverrideClockTime(GlobalState["Hours"],GlobalState["Minutes"],00)

		Wait(0)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TELEPORT
-----------------------------------------------------------------------------------------------------------------------------------------
local Teleport = {
	{ vec3(330.19,-601.21,43.29),vec3(343.65,-581.77,28.8) },
	{ vec3(343.65,-581.77,28.8),vec3(330.19,-601.21,43.29) },

	{ vec3(327.16,-603.53,43.29),vec3(338.97,-583.85,74.16) },
	{ vec3(338.97,-583.85,74.16),vec3(327.16,-603.53,43.29) },

	{ vec3(-741.07,5593.13,41.66),vec3(446.19,5568.79,781.19) },
	{ vec3(446.19,5568.79,781.19),vec3(-741.07,5593.13,41.66) },

	{ vec3(-740.78,5597.04,41.66),vec3(446.37,5575.02,781.19) },
	{ vec3(446.37,5575.02,781.19),vec3(-740.78,5597.04,41.66) },

	{ vec3(-71.05,-801.01,44.23),vec3(-75.0,-824.54,321.29) },
	{ vec3(-75.0,-824.54,321.29),vec3(-71.05,-801.01,44.23) },

	{ vec3(236.23,229.27,97.11),vec3(234.24,229.94,97.11) },
	{ vec3(234.24,229.94,97.11),vec3(236.23,229.27,97.11) },

	{ vec3(1016.89,31.96,70.45),vec3(964.78,58.69,112.56) },
	{ vec3(964.78,58.69,112.56),vec3(1016.89,31.96,70.45) },

	{ vec3(604.73,5.44,97.86),vec3(565.61,4.9,103.22) },
	{ vec3(565.61,4.9,103.22),vec3(604.73,5.44,97.86) },

	{ vec3(3540.84,3676.98,28.12),vec3(3540.61,3675.3,20.99) },
	{ vec3(3540.61,3675.3,20.99),vec3(3540.84,3676.98,28.12) },

	{ vec3(10.07,-668.16,33.45),vec3(0.91,-703.18,16.13) }, -- COLETAR MALOTES
	{ vec3(0.91,-703.18,16.13),vec3(10.07,-668.16,33.45) },
	-- Bobcat
	{ vec3(888.31,-2130.51,31.22),vec3(888.53,-2128.69,31.22) },
	{ vec3(888.53,-2128.69,31.22),vec3(888.31,-2130.51,31.22) },
	----  cassino
	{ vec3(946.65,40.58,75.32),vec3(1089.63,205.86,-49.0) },
	{ vec3(1089.63,205.86,-49.0),vec3(946.65,40.58,75.32) }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTELEPORT
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()
		if not IsPedInAnyVehicle(Ped) then
			local Coords = GetEntityCoords(Ped)

			for Number = 1,#Teleport do
				if #(Coords - Teleport[Number][1]) <= 1 then
					TimeDistance = 1

					if IsControlJustPressed(1,38) then
						SetEntityCoords(Ped,Teleport[Number][2])
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ALPHAS
-----------------------------------------------------------------------------------------------------------------------------------------
local Alphas = {
	-- Ilegal
	{ vec3(-472.08, 6287.5, 14.63), 200, 59, 20.0 },

	-- Pescaria
	{ vec3(-1227.49, 4389.84, 5.12), 200, 30, 100.0 },

	-- Caça   ( nao utilizado no momento)
	--{ vec3(2203.71, 5595.54, 53.73), 150, 61, 400.0 },
	--{ vec3(2116.84, 1943.06, 93.63), 150, 61, 400.0 },
	--{ vec3(-2096.91, 2341.5, 33.28), 150, 61, 400.0 },

	-- Influence
	{ vec3(1272.26, -1712.57, 54.76), 150, 38, 120.0 },
	{ vec3(95.58, -1985.56, 20.44), 150, 50, 120.0 },
	{ vec3(-31.47, -1434.84, 31.49), 150, 2, 120.0 },
	{ vec3(347.45, -2069.06, 20.89), 150, 33, 120.0 },
	{ vec3(512.29, -1803.52, 28.51), 150, 10, 120.0 },
	{ vec3(230.55, -1753.35, 28.98), 150, 6, 120.0 },
	{ vec3(-1247.92,-1433.51,8.14), 150, 1, 120.0 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	for Number = 1,#Alphas do
		local Blip = AddBlipForRadius(Alphas[Number][1]["x"],Alphas[Number][1]["y"],Alphas[Number][1]["z"],Alphas[Number][4])
		SetBlipAlpha(Blip,Alphas[Number][2])
		SetBlipColour(Blip,Alphas[Number][3])
	end

	for Number = 1,#Blips do
		local Blip = AddBlipForCoord(Blips[Number][1],Blips[Number][2],Blips[Number][3])
		SetBlipSprite(Blip,Blips[Number][4])
		SetBlipDisplay(Blip,4)
		SetBlipHighDetail(Blip,true)
		SetBlipAsShortRange(Blip,true)
		SetBlipColour(Blip,Blips[Number][5])
		SetBlipScale(Blip,Blips[Number][7])
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Blips[Number][6])
		EndTextCommandSetBlipName(Blip)
	end

	local Tables = {}

	for Number = 1,#Teleport do
		Tables[#Tables + 1] = { Teleport[Number][1]["x"],Teleport[Number][1]["y"],Teleport[Number][1]["z"],2.5,"E","Porta de Acesso","Pressione para acessar" }
	end

	TriggerEvent("hoverfy:Insert",Tables)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ISLAND
-----------------------------------------------------------------------------------------------------------------------------------------
local Island = {
	"h4_islandairstrip",
	"h4_islandairstrip_props",
	"h4_islandx_mansion",
	"h4_islandx_mansion_props",
	"h4_islandx_props",
	"h4_islandxdock",
	"h4_islandxdock_props",
	"h4_islandxdock_props_2",
	"h4_islandxtower",
	"h4_islandx_maindock",
	"h4_islandx_maindock_props",
	"h4_islandx_maindock_props_2",
	"h4_IslandX_Mansion_Vault",
	"h4_islandairstrip_propsb",
	"h4_beach",
	"h4_beach_props",
	"h4_beach_bar_props",
	"h4_islandx_barrack_props",
	"h4_islandx_checkpoint",
	"h4_islandx_checkpoint_props",
	"h4_islandx_Mansion_Office",
	"h4_islandx_Mansion_LockUp_01",
	"h4_islandx_Mansion_LockUp_02",
	"h4_islandx_Mansion_LockUp_03",
	"h4_islandairstrip_hangar_props",
	"h4_IslandX_Mansion_B",
	"h4_islandairstrip_doorsclosed",
	"h4_Underwater_Gate_Closed",
	"h4_mansion_gate_closed",
	"h4_aa_guns",
	"h4_IslandX_Mansion_GuardFence",
	"h4_IslandX_Mansion_Entrance_Fence",
	"h4_IslandX_Mansion_B_Side_Fence",
	"h4_IslandX_Mansion_Lights",
	"h4_islandxcanal_props",
	"h4_beach_props_party",
	"h4_islandX_Terrain_props_06_a",
	"h4_islandX_Terrain_props_06_b",
	"h4_islandX_Terrain_props_06_c",
	"h4_islandX_Terrain_props_05_a",
	"h4_islandX_Terrain_props_05_b",
	"h4_islandX_Terrain_props_05_c",
	"h4_islandX_Terrain_props_05_d",
	"h4_islandX_Terrain_props_05_e",
	"h4_islandX_Terrain_props_05_f",
	"h4_islandx_terrain_01",
	"h4_islandx_terrain_02",
	"h4_islandx_terrain_03",
	"h4_islandx_terrain_04",
	"h4_islandx_terrain_05",
	"h4_islandx_terrain_06",
	"h4_ne_ipl_00",
	"h4_ne_ipl_01",
	"h4_ne_ipl_02",
	"h4_ne_ipl_03",
	"h4_ne_ipl_04",
	"h4_ne_ipl_05",
	"h4_ne_ipl_06",
	"h4_ne_ipl_07",
	"h4_ne_ipl_08",
	"h4_ne_ipl_09",
	"h4_nw_ipl_00",
	"h4_nw_ipl_01",
	"h4_nw_ipl_02",
	"h4_nw_ipl_03",
	"h4_nw_ipl_04",
	"h4_nw_ipl_05",
	"h4_nw_ipl_06",
	"h4_nw_ipl_07",
	"h4_nw_ipl_08",
	"h4_nw_ipl_09",
	"h4_se_ipl_00",
	"h4_se_ipl_01",
	"h4_se_ipl_02",
	"h4_se_ipl_03",
	"h4_se_ipl_04",
	"h4_se_ipl_05",
	"h4_se_ipl_06",
	"h4_se_ipl_07",
	"h4_se_ipl_08",
	"h4_se_ipl_09",
	"h4_sw_ipl_00",
	"h4_sw_ipl_01",
	"h4_sw_ipl_02",
	"h4_sw_ipl_03",
	"h4_sw_ipl_04",
	"h4_sw_ipl_05",
	"h4_sw_ipl_06",
	"h4_sw_ipl_07",
	"h4_sw_ipl_08",
	"h4_sw_ipl_09",
	"h4_islandx_mansion",
	"h4_islandxtower_veg",
	"h4_islandx_sea_mines",
	"h4_islandx",
	"h4_islandx_barrack_hatch",
	"h4_islandxdock_water_hatch",
	"h4_beach_party"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADCAYO
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	local CayoPerico = false

	while true do
		local Ped = PlayerPedId()
		local Coords = GetEntityCoords(Ped)

		if #(Coords - vec3(4840.57,-5174.42,2.0)) <= 2000 then
			if not CayoPerico then
				for _,v in pairs(Island) do
					RequestIpl(v)
				end

				SetIslandHopperEnabled("HeistIsland",true)
				SetAiGlobalPathNodesType(1)
				SetDeepOceanScaler(0.0)
				LoadGlobalWaterType(1)
				CayoPerico = true
			end
		else
			if CayoPerico then
				for _,v in pairs(Island) do
					RemoveIpl(v)
				end

				SetIslandHopperEnabled("HeistIsland",false)
				SetAiGlobalPathNodesType(0)
				SetDeepOceanScaler(1.0)
				LoadGlobalWaterType(0)
				CayoPerico = false
			end
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADRAPPEL
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()
		if IsPedInAnyHeli(Ped) then
			TimeDistance = 1

			local Vehicle = GetVehiclePedIsUsing(Ped)
			if IsControlJustPressed(1,154) and not IsAnyPedRappellingFromHeli(Vehicle) and (GetPedInVehicleSeat(Vehicle,1) == Ped or GetPedInVehicleSeat(Vehicle,2) == Ped) then
				TaskRappelFromHeli(Ped,1)
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- IPLOADER
-----------------------------------------------------------------------------------------------------------------------------------------
local InfoList = {
	{
		["Props"] = {
			"swap_clean_apt",
			"layer_debra_pic",
			"layer_whiskey",
			"swap_sofa_A"
		},
		["Coords"] = vec3(-1150.70,-1520.70,10.60)
	},{
		["Props"] = {
			"csr_beforeMission",
			"csr_inMission"
		},
		["Coords"] = vec3(-47.10,-1115.30,26.50)
	},{
		["Props"] = {
			"V_Michael_bed_tidy",
			"V_Michael_M_items",
			"V_Michael_D_items",
			"V_Michael_S_items",
			"V_Michael_L_Items"
		},
		["Coords"] = vec3(-802.30,175.00,72.80)
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADIPLOADER
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	for _,v in pairs(InfoList) do
		local Interior = GetInteriorAtCoords(v["Coords"])
		LoadInterior(Interior)

		if v["Props"] then
			for _,i in pairs(v["Props"]) do
				EnableInteriorProp(Interior,i)
			end
		end

		RefreshInterior(Interior)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHCAMERA
-----------------------------------------------------------------------------------------------------------------------------------------
local fov_max = 80.0
local fov_min = 10.0
local speed_lr = 3.0
local speed_ud = 3.0
local zoomspeed = 2.0
local vehCamera = false
local fov = (fov_max + fov_min) * 0.5
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADCAMERA
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		local ped = PlayerPedId()
		if IsPedInAnyHeli(ped) then
			timeDistance = 1

			local veh = GetVehiclePedIsUsing(ped)
			SetVehicleRadioEnabled(veh,false)

			if IsControlJustPressed(1,51) then
				TriggerEvent("hudActived",false)
				vehCamera = true
			end

			if IsControlJustPressed(1,154) then
				if GetPedInVehicleSeat(veh,1) == ped or GetPedInVehicleSeat(veh,2) == ped then
					TaskRappelFromHeli(ped,1)
				end
			end

			if vehCamera then
				SetTimecycleModifierStrength(0.3)
				SetTimecycleModifier("heliGunCam")

				local scaleform = RequestScaleformMovie("HELI_CAM")
				while not HasScaleformMovieLoaded(scaleform) do
					Citizen.Wait(1)
				end

				local cam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA",true)
				AttachCamToEntity(cam,veh,0.0,0.0,-1.5,true)
				SetCamRot(cam,0.0,0.0,GetEntityHeading(veh))
				SetCamFov(cam,fov)
				RenderScriptCams(true,false,0,1,0)
				PushScaleformMovieFunction(scaleform,"SET_CAM_LOGO")
				PushScaleformMovieFunctionParameterInt(0)
				PopScaleformMovieFunctionVoid()

				while vehCamera do
					if IsControlJustPressed(1,51) then
						TriggerEvent("hudActived",true)
						vehCamera = false
					end

					local zoomvalue = (1.0 / (fov_max - fov_min)) * (fov - fov_min)
					CheckInputRotation(cam,zoomvalue)
					HandleZoom(cam)
					HideHudAndRadarThisFrame()
					HideHudComponentThisFrame(19)
					PushScaleformMovieFunction(scaleform,"SET_ALT_FOV_HEADING")
					PushScaleformMovieFunctionParameterFloat(GetEntityCoords(veh).z)
					PushScaleformMovieFunctionParameterFloat(zoomvalue)
					PushScaleformMovieFunctionParameterFloat(GetCamRot(cam,2).z)
					PopScaleformMovieFunctionVoid()
					DrawScaleformMovieFullscreen(scaleform,255,255,255,255)

					Citizen.Wait(1)
				end

				ClearTimecycleModifier()
				fov = (fov_max + fov_min) * 0.5
				RenderScriptCams(false,false,0,1,0)
				SetScaleformMovieAsNoLongerNeeded(scaleform)
				DestroyCam(cam,false)
				SetNightvision(false)
				SetSeethrough(false)
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKINPUTROTATION
-----------------------------------------------------------------------------------------------------------------------------------------
function CheckInputRotation(cam,zoomvalue)
	local rightAxisX = GetDisabledControlNormal(0,220)
	local rightAxisY = GetDisabledControlNormal(0,221)
	local rotation = GetCamRot(cam,2)
	if rightAxisX ~= 0.0 or rightAxisY ~= 0.0 then
		new_z = rotation.z + rightAxisX * -1.0 * (speed_ud) * (zoomvalue + 0.1)
		new_x = math.max(math.min(20.0,rotation.x + rightAxisY * -1.0 * (3.0) * (zoomvalue + 0.1)),-89.5)
		SetCamRot(cam,new_x,0.0,new_z,2)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HANDLEZOOM
-----------------------------------------------------------------------------------------------------------------------------------------
function HandleZoom(cam)
	if IsControlJustPressed(1,241) then
		fov = math.max(fov - zoomspeed,fov_min)
	end

	if IsControlJustPressed(1,242) then
		fov = math.min(fov + zoomspeed,fov_max)
	end

	local current_fov = GetCamFov(cam)
	if math.abs(fov - current_fov) < 0.1 then
		fov = current_fov
	end

	SetCamFov(cam,current_fov + (fov - current_fov) * 0.05)
end




------------------------------------------------------------------------------------------------------------------------------------------
----------- MAPA ILHA by Kaduzera Community
------------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
	  Citizen.Wait(0)
		SetRadarAsExteriorThisFrame()
		SetRadarAsInteriorThisFrame("h4_fake_islandx",vec(4700.0,-5145.0),0,0)
	end
end)





--[[function spawnNPC(x, y, z, weaponModel)
    local modelHash = GetHashKey("mp_m_bogdangoon")
    
    RequestModel(modelHash)
    
    while not HasModelLoaded(modelHash) do
        Wait(500)
    end

    local npc = CreatePed(4, modelHash, x, y, z, 0.0, true, false)

    -- Adiciona a arma especificada ao NPC
    local weaponHash = GetHashKey(weaponModel)
    GiveWeaponToPed(npc, weaponHash, 1000, false, true)

    -- Torna o NPC invencível
    -- SetEntityInvincible(npc, true)

    -- Evita que o NPC cause dano a outros NPCs
    NetworkSetEntityCanBeDamaged(npc, false)

    -- Obtém o identificador do jogador local
    local localPlayer = PlayerId()

    -- Inicia a tarefa de combate somente se o alvo for o jogador local
    TaskCombatPedToPed(npc, localPlayer, 0, 16, 1)

    -- Faz o NPC ficar parado no local
    TaskStandStill(npc, -1)
end

-- Local de spawn dos NPCs
local spawnLocation = vector3(-803.85, -2661.58, 13.82)

-- Número de NPCs a serem spawnados
local numNPCs = 10

-- Lista de armamentos possíveis (substitua conforme necessário)
local weapons = {
    "WEAPON_PISTOL_MK2",
    "WEAPON_SPECIALCARBINE",
    "WEAPON_SPECIALCARBINE_MK2",
    -- Adicione mais armas se desejar
}

-- Função principal
Citizen.CreateThread(function()
    for i = 1, numNPCs do
        local offsetX = math.random(-5, 5)
        local offsetY = math.random(-5, 5)
        local spawnPoint = spawnLocation + vector3(offsetX, offsetY, 0.0)
        local randomWeapon = weapons[math.random(1, #weapons)]
        spawnNPC(spawnPoint.x, spawnPoint.y, spawnPoint.z, randomWeapon)
        Wait(500)
    end
end) ]]---


local ColorLuzes = {
	------------------------[   BALLAS      ]----------------------------------------------------------
		{103.01, -1938.72, 30.80, 148, 0, 211, 50.0, 1.0},
	
	------------------------[   MOTOCLUB    ]----------------------------------------------------------
		{982.03,-112.44,74.14, 0,0,255, 50.0, 1.0},
	
	------------------------[   LOS VAGOS   ]----------------------------------------------------------
		{336.98, -2042.08, 31.30, 255, 255, 0, 50.0, 1.0},
	
	------------------------[    GROOVE     ]----------------------------------------------------------
		{-22.89, -1456.09, 30.64, 0, 128, 0, 50.0, 1.0},
	
	------------------------[    PRAÇA      ]----------------------------------------------------------
		{191.14, -926.19, 50.68, 65, 105, 225, 75.0, 0.5}, --
		{1290.98,-1731.24,69.72, 21, 0, 211, 50.0, 1.0},
		
	------------------------[   PLAY BOY    ]----------------------------------------------------------
		{-1468.41, 169.88, 54.55, 148, 0, 211, 50.0, 1.0},
		{-1464.11, 120.56, 53.01, 255, 0, 0, 50.0, 1.0},
		{-1456.54, 212.32, 57.86, 50, 205, 50, 50.0, 1.0},
------------------------[   ARVORES NATAL   ]----------------------------------------------------------
		{ 284.47, 146.63, 115.47, 148, 0, 211, 10.0, 1.0},
		{ 346.04, 160.59, 115.27, 0, 128, 0, 10.0, 1.0},
		{ 315.46,171.47,114.04, 255, 255, 0, 10.0, 1.0},
		{ 273.41,186.88,104.76, 0, 128, 0, 10.0, 1.0},
	}
	---------------------------------------------------------------------------------------------------   346.04,160.59,115.27,85.04
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(0)
			for k,v in ipairs(ColorLuzes) do
				local x,y,z,n,g,s,range,intensity = table.unpack(v)
				if GetClockHours() > 20 or GetClockHours() < 6 then
					DrawLightWithRangeAndShadow(x, y, z, n, g, s, range, intensity, 0.1)
				end
			end
		end
	end)