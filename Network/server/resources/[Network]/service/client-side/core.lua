-----------------------------------------------------------------------------------------------------------------------------------------
-- kadu
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("service")
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIST
-----------------------------------------------------------------------------------------------------------------------------------------
local List = {
	-- Public
	{ vec3(1137.17,-1536.04,35.35),"Paramedic-1",1.0 },
	{ vec3(1831.78,3672.98,34.28),"Paramedic-2",1.0 },
	{ vec3(-254.95,6330.96,32.55),"Paramedic-3",1.0 },
	{ vec3(-919.11,-2028.23,9.31),"Police",1.0 },
	{ vec3(1186.48,2637.88,38.27),"Harmony",1.0 },
	{ vec3(1186.48,2637.88,38.27),"Harmony",1.0 },
	{ vec3(833.19,-942.22,26.47),"Mechanic",1.0 },
	{ vec3(126.03,-3007.26,6.86),"Tuners",1.0 },
	-- Restaurants
	{ vec3(-1840.55,-1183.9,14.24),"Pearls",2.0 },
	{ vec3(837.67,-1289.33,28.3),"Core",2.0 }   --- NÃO MEXA
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	for Number = 1,#List do
		exports["target"]:AddCircleZone("Service:"..List[Number][2],List[Number][1],1.75,{
			name = "Service:"..List[Number][2],
			heading = 0.0
		},{
			shop = Number,
			Distance = List[Number][3],
			options = {
				{
					label = "Entrar em Serviço",
					event = "service:Toggle",
					tunnel = "shop"
				}
			}
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICE:TOGGLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("service:Toggle")
AddEventHandler("service:Toggle",function(Service)
		TriggerServerEvent("service:Toggle",List[Service][2])
	end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICE:LABEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("service:Label")
AddEventHandler("service:Label",function(Service,Text)
	if Service == "Paramedic" then
		exports["target"]:LabelText("Service:Paramedic-1",Text)
		exports["target"]:LabelText("Service:Paramedic-2",Text)
		exports["target"]:LabelText("Service:Paramedic-3",Text)
    elseif Service == "Police" then
		exports["target"]:LabelText("Service:Police",Text)
	elseif Service == "Harmony" then
		exports["target"]:LabelText("Service:Harmony",Text)
	elseif Service == "Mechanic" then
		exports["target"]:LabelText("Service:Mechanic",Text)
	elseif Service == "Tuners" then
		exports["target"]:LabelText("Service:Tuners",Text)
	elseif Service == "Pearls" then
		exports["target"]:LabelText("Service:Pearls",Text)
	elseif Service == "Core" then
		exports["target"]:LabelText("Service:Core",Text)
	else
		exports["target"]:LabelText("Service:"..Service,Text)
	end
end)