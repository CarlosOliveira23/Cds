-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Previous = nil
local Treatment = false
local TreatmentTimer = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- BEDS
-----------------------------------------------------------------------------------------------------------------------------------------
local Beds = {
	-- Medical Center Sul
	{ ["Coords"] = vec3(1126.41,-1562.6,34.9), ["Heading"] = 0.0 },
	{ ["Coords"] = vec3(1123.64,-1562.59,34.9), ["Heading"] = 0.0 },
	{ ["Coords"] = vec3(1121.0,-1562.59,34.9), ["Heading"] = 0.0 },
	{ ["Coords"] = vec3(1121.65,-1553.35,34.9), ["Heading"] = 0.0 },
	{ ["Coords"] = vec3(1124.4,-1553.36,34.9), ["Heading"] = 0.0 },
	{ ["Coords"] = vec3(1127.33,-1553.35,34.9), ["Heading"] = 0.0 },
	{ ["Coords"] = vec3(1126.69,-1547.41,34.9), ["Heading"] = 175.75 },
	{ ["Coords"] = vec3(1123.64,-1547.41,34.9), ["Heading"] = 175.75 },
	{ ["Coords"] = vec3(1120.52,-1547.41,34.9), ["Heading"] = 175.75 },
	{ ["Coords"] = vec3(1121.1,-1538.06,34.9), ["Heading"] = 175.75 },
	{ ["Coords"] = vec3(1124.16,-1538.06,34.9), ["Heading"] = 175.75 },
	{ ["Coords"] = vec3(1127.16,-1538.07,34.9), ["Heading"] = 175.75 },
		-- Medical Center Sul ECLIPSE antigo CPX
	{ ["Coords"] = vec3(-668.3,321.73,87.92), ["Heading"] = 175.01 },
	{ ["Coords"] = vec3(-665.38,321.5,87.92), ["Heading"] = 175.01 },
	{ ["Coords"] = vec3(-662.67,321.23,87.92), ["Heading"] = 175.01 },
	{ ["Coords"] = vec3(-659.93,321.04,87.92), ["Heading"] = 175.01 },
	{ ["Coords"] = vec3(-657.01,320.77,87.92), ["Heading"] = 175.01 },
	{ ["Coords"] = vec3(-657.92,314.42,87.92), ["Heading"] = 355.0 },
	{ ["Coords"] = vec3(-661.01,314.42,87.92), ["Heading"] = 355.0 },
	{ ["Coords"] = vec3(-663.84,314.7,87.92), ["Heading"] = 355.0 },
	{ ["Coords"] = vec3(-667.05,314.9,87.92), ["Heading"] = 355.0 },
	{ ["Coords"] = vec3(-671.58,315.3,87.92), ["Heading"] = 355.0 },
	{ ["Coords"] = vec3(-676.24,315.7,87.92), ["Heading"] = 355.0 },
	{ ["Coords"] = vec3(-680.9,320.23,87.92), ["Heading"] = 265.0 },
	{ ["Coords"] = vec3(-680.55,324.8,87.92), ["Heading"] = 265.0 },
	{ ["Coords"] = vec3(-684.31,350.09,82.98), ["Heading"] = 175.01 },
	{ ["Coords"] = vec3(-685.63,350.29,82.98), ["Heading"] = 175.01 },
	{ ["Coords"] = vec3(-694.84,347.52,82.98), ["Heading"] = 265.0 },
	{ ["Coords"] = vec3(-695.33,341.26,82.98), ["Heading"] = 265.0 },
	{ ["Coords"] = vec3(-649.22,318.53,88.03), ["Heading"] = 355.0 },
	{ ["Coords"] = vec3(-648.49,327.05,88.03), ["Heading"] = 175.01 },
	{ ["Coords"] = vec3(-661.3,336.23,87.83), ["Heading"] = 175.01 },
	{ ["Coords"] = vec3(-669.7,336.9,88.03), ["Heading"] = 355.0 },
	-- Medical Center Norte
	{ ["Coords"] = vec3(-252.15,6323.11,32.35), ["Heading"] = 133.23 },
	{ ["Coords"] = vec3(-250.5,6321.87,32.35), ["Heading"] = 133.23 },
	{ ["Coords"] = vec3(-246.98,6317.95,32.33), ["Heading"] = 133.23 },
	{ ["Coords"] = vec3(-245.27,6316.22,32.35), ["Heading"] = 133.23 },
	{ ["Coords"] = vec3(-251.03,6310.51,32.35), ["Heading"] = 317.49 },
	{ ["Coords"] = vec3(-252.63,6312.12,32.35), ["Heading"] = 317.49 },
	{ ["Coords"] = vec3(-254.39,6313.88,32.35), ["Heading"] = 317.49 },
	{ ["Coords"] = vec3(-256.1,6315.58,32.35), ["Heading"] = 317.49 },
	{ ["Coords"] = vec3(-258.03,6317.12,32.35), ["Heading"] = 317.49 },
	-- Boolingbroke
	{ ["Coords"] = vec3(1761.87, 2591.56, 45.66), ["Heading"] = 272.13 },
	{ ["Coords"] = vec3(1761.87, 2594.64, 45.66), ["Heading"] = 272.13 },
	{ ["Coords"] = vec3(1761.87, 2597.73, 45.66), ["Heading"] = 272.13 },
	{ ["Coords"] = vec3(1771.98, 2597.95, 45.66), ["Heading"] = 87.88 },
	{ ["Coords"] = vec3(1771.98, 2594.88, 45.66), ["Heading"] = 87.88 },
	{ ["Coords"] = vec3(1771.98, 2591.79, 45.66), ["Heading"] = 87.88 },
	-- Ocean
	{ ["Coords"] = vec3(-1862.59, -334.37, 50.18), ["Heading"] = 323.15 },
	{ ["Coords"] = vec3(-1865.68, -332.05, 50.2), ["Heading"] = 323.15 },
	{ ["Coords"] = vec3(-1868.51, -330.02, 50.18), ["Heading"] = 323.15 },
	{ ["Coords"] = vec3(-1872.07, -327.04, 50.18), ["Heading"] = 323.15 },
	{ ["Coords"] = vec3(-1875.12, -324.77, 50.18), ["Heading"] = 323.15 },
	{ ["Coords"] = vec3(-1878.38, -322.15, 50.18), ["Heading"] = 323.15 },
	{ ["Coords"] = vec3(-1875.45, -318.11, 50.18), ["Heading"] = 136.88 },
	{ ["Coords"] = vec3(-1872.09, -320.61, 50.18), ["Heading"] = 136.88 },
	{ ["Coords"] = vec3(-1868.91, -323.18, 50.18), ["Heading"] = 136.88 },
	-- Clandestine
	{ ["Coords"] = vec3(-471.87,6287.56,13.63), ["Heading"] = 53.86 },    -----937.02,-2059.34,10.33,138.9
	--- DP SUL
	{ ["Coords"] = vec3(-937.06,-2059.38,10.33), ["Heading"] = 1.0 },
	{ ["Coords"] = vec3(-935.32,-2060.84,10.33), ["Heading"] = 1.0}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	for Number,v in pairs(Beds) do
		AddBoxZone("Beds:"..Number,v["Coords"],1.0,1.5,{
			name = "Beds:"..Number,
			heading = v["Heading"],
			minZ = v["Coords"]["z"] - 0.01,
			maxZ = v["Coords"]["z"] + 0.01
		},{
			shop = Number,
			Distance = 1.75,
			options = {
				{
					event = "target:PutBed",
					label = "Deitar",
					tunnel = "client"
				},{
					event = "target:Treatment",
					label = "Tratamento",
					tunnel = "client"
				}
			}
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:PUTBED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:PutBed")
AddEventHandler("target:PutBed",function(Number)
	if not Previous then
		local Ped = PlayerPedId()
		Previous = GetEntityCoords(Ped)
		SetEntityCoords(Ped,Beds[Number]["Coords"]["x"],Beds[Number]["Coords"]["y"],Beds[Number]["Coords"]["z"] - 1,false,false,false,false)
		vRP.playAnim(false,{"anim@gangops@morgue@table@","body_search"},true)
		SetEntityHeading(Ped,Beds[Number]["Heading"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:UPBED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:UpBed")
AddEventHandler("target:UpBed",function()
	if Previous then
		local Ped = PlayerPedId()
		SetEntityCoords(Ped,Previous["x"],Previous["y"],Previous["z"] - 1,false,false,false,false)
		Previous = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:TREATMENT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:Treatment")
AddEventHandler("target:Treatment",function(Number)
	if not Previous then
		if vSERVER.CheckIn() then
			local Ped = PlayerPedId()
			Previous = GetEntityCoords(Ped)
			SetEntityCoords(Ped,Beds[Number]["Coords"]["x"],Beds[Number]["Coords"]["y"],Beds[Number]["Coords"]["z"] - 1,false,false,false,false)
			vRP.playAnim(false,{"anim@gangops@morgue@table@","body_search"},true)
			SetEntityHeading(Ped,Beds[Number]["Heading"])

			TriggerEvent("inventory:preventWeapon",true)
			LocalPlayer["state"]["Commands"] = true
			LocalPlayer["state"]["Cancel"] = true
			TriggerEvent("paramedic:Reset")

			if GetEntityHealth(Ped) <= 100 then
				exports["survival"]:Revive(101)
			end

			Treatment = true
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTTREATMENT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:StartTreatment")
AddEventHandler("target:StartTreatment",function()
	if not Treatment then
		LocalPlayer["state"]["Commands"] = true
		LocalPlayer["state"]["Cancel"] = true
		Treatment = true
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBEDS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local Ped = PlayerPedId()
		if Previous and not IsEntityPlayingAnim(Ped,"anim@gangops@morgue@table@","body_search",3) then
			SetEntityCoords(Ped,Previous["x"],Previous["y"],Previous["z"] - 1,false,false,false,false)
			Previous = nil
		end

		Citizen.Wait(10000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTREATMENT
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		if Treatment then
			if GetGameTimer() >= TreatmentTimer then
				local Ped = PlayerPedId()
				local Health = GetEntityHealth(Ped)
				TreatmentTimer = GetGameTimer() + 1000

				if Health < 200 then
					SetEntityHealth(Ped,Health + 1)
				else
					Treatment = false
					LocalPlayer["state"]["Cancel"] = false
					LocalPlayer["state"]["Commands"] = false
					TriggerEvent("Notify","amarelo","Tratamento concluido.",5000)
				end
			end
		end

		Wait(1000)
	end
end)