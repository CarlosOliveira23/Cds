-----------------------------------------------------------------------------------------------------------------------------------------
-- kadu
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("crafting")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Timer = 0
local Select = ""
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTING
-----------------------------------------------------------------------------------------------------------------------------------------
local Crafting = {
	-- Framework
	["1"] = { vec3(713.66,-961.04,30.4),"Dress" },
	["2"] = { vec3(-382.72,261.91,86.36),"Food" },
	["3"] = { vec3(1991.28,3724.65,34.83),"Food" },
	["4"] = { vec3(82.45,-1553.26,29.59),"Lixeiro" },
	["5"] = { vec3(287.36,2843.6,44.7),"Lixeiro" },
	["6"] = { vec3(-413.68,6171.99,31.48),"Lixeiro" },
	["7"] = { vec3(2921.17,2653.46,43.31),"Mining" },
	["8"] = { vec3(894.5,-962.71,35.63),"Money" },
	["9"] = { vec3(1209.28,-3115.1,5.61),"Weapons" },
	-- Restaurants
	["10"] = { vec3(-1847.16,-1194.05,14.28),"Pearls" },
	-- Contraband
	["11"] = { vec3(1362.9,-2097.07,47.21),"Chiliad" },
	["12"] = { vec3(-134.79,-1609.47,35.03),"Families" },
	["13"] = { vec3(1071.31,-2341.56,30.58),"Highways" },
	["14"] = { vec3(334.16,-2012.4,22.39),"Vagos" },
	-- Favelas
	["15"] = { vec3(1356.56,-259.51,152.02),"Barragem" },
	["16"] = { vec3(3176.13,5142.38,31.51),"Farol" },
	["17"] = { vec3(402.93,756.95,194.62),"Parque" },
	["18"] = { vec3(2175.04,4045.95,34.36),"Sandy" },
	["19"] = { vec3(1550.16,-2454.24,80.37),"Petroleo" },
	["20"] = { vec3(-3110.99,1422.21,29.97),"Praia-1" },
	["21"] = { vec3(-3130.2,1702.83,41.01),"Praia-2" },
	["22"] = { vec3(-601.03,2197.69,126.27),"Zancudo" },
	-- Mafias
	["23"] = { vec3(1400.84,1138.64,109.63),"Madrazzo" },
	["24"] = { vec3(-1543.54,79.91,57.00),"Playboy" },
	["25"] = { vec3(978.61,-91.83,74.85),"TheSouth" },
	["26"] = { vec3(-1871.2,2061.28,135.28),"Vineyard" },
	["27"] = { vec3(95.78,-1293.05,30.06),"Vanilla" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    for Number, v in pairs(Crafting) do
        local craftingName = "Crafting:" .. Number
        local isLixeiroCrafting = (Number == "4" or Number == "5" or Number == "6")

        local options = {
            {
                event = "crafting:Open",
                label = "Abrir",
                tunnel = "shop"
            }
        }

        if isLixeiroCrafting then
            table.insert(options, {
                event = "works:lixeiro",
                label = "Traje Lixeiro",
                tunnel = "server"
            })
        end

        exports["target"]:AddCircleZone(craftingName, v[1], 1.0, {
            name = craftingName,
            heading = 3374176
        }, {
            shop = Number,
            Distance = 1.0,
            options = options
        })
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTING:OPEN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("crafting:Open", function(Number)
	local v = Crafting[Number]
	if v then
		if vSERVER.Permission(v[2]) and vSERVER.Verify() then
			if v[2] ~= Select and GetGameTimer() < Timer then
				TriggerEvent("Notify", "amarelo", "Produção em andamento.", 5000)
			else
				Select = v[2]
				SetNuiFocus(true, true)
				SendNUIMessage({ action = "OpenCraft", data = vSERVER.Request(Select) })
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Close",function(Data,Callback)
	SetNuiFocus(false,false)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OWNED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Owned",function(Data,Callback)
	Callback(vSERVER.Owned(Data["id"],Data["key"]))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Crafting",function(Data,Callback)
	if GetGameTimer() >= Timer then
		Timer = GetGameTimer() + Data["time"] * 1000

		SetTimeout(Data["time"] * 1000,function()
			vSERVER.Crafting(Data["id"],Data["key"],Data["amount"])
		end)

		Callback(true)
	else
		TriggerEvent("Notify","amarelo","Produção em andamento.",5000)
		Callback(false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTING:INVENTORY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("crafting:Inventory")
AddEventHandler("crafting:Inventory",function()
	if "Inventory" ~= Select and GetGameTimer() < Timer then
		TriggerEvent("Notify","amarelo","Produção em andamento.",5000)
		return
	end

	Select = "Barragem"
	SetNuiFocus(true,true)
	SendNUIMessage({ action = "OpenCraft", data = vSERVER.Request("Barragem") })
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTING:PHARMACY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("crafting:Pharmacy")
AddEventHandler("crafting:Pharmacy", function()
	SetNuiFocus(true, true)
	SendNUIMessage({ action = "OpenCraft", data = vSERVER.Request("Barragem") })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTING:MINERMAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("crafting:Minerman")
AddEventHandler("crafting:Minerman", function()
	SetNuiFocus(true, true)
	SendNUIMessage({ action = "showNUI", name = "Mining" })
end)