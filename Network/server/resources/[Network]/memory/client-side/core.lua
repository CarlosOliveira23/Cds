-----------------------------------------------------------------------------------------------------------------------------------------
-- kadu
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Kaduzera = {}
Tunnel.bindInterface("memory", Kaduzera)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Results = false
local Progress = false
local Timer = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- MEMORY
-----------------------------------------------------------------------------------------------------------------------------------------
function Memory()
	if Progress then
		return false
	end

	Progress = true
	SetNuiFocus(true, true)
	Timer = GetGameTimer() + 40000
	SendNUIMessage({ action = "Open" })

	while Progress do
		if GetGameTimer() >= Timer then
			SendNUIMessage({ action = "Close" })
		end

		Wait(0)
	end

	if Results and Timer > GetGameTimer() then
		return true
	end

	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- SUCESS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Success", function(Data, Callback)
	Results = true
	Progress = false
	SetNuiFocus(false, false)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Close", function(Data, Callback)
	Results = false
	Progress = false
	SetNuiFocus(false, false)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MEMORY
-----------------------------------------------------------------------------------------------------------------------------------------
function Kaduzera.Memory()
	return Memory()
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXPORTS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Memory", Memory)
