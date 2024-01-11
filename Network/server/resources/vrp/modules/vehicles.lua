-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("CleanVehicle")
AddEventHandler("CleanVehicle", function(entIndex)
    local entity = NetworkGetEntityFromNetworkId(entIndex)
    if DoesEntityExist(entity) and not IsPedAPlayer(entity) and GetEntityType(entity) == 2 then
        SetVehicleDirtLevel(entity, 0.0)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESOURCESTART
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onResourceStart",function(Resource)
    if "vrp" == Resource then
        Wait(3000)
    end
end)