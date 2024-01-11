-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Blip = nil
local Objects = {}
local Active = false
local Coolcar = GetGameTimer()
local Cooldown = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        local TimeDistance = 999
        if Active and Components[Active] then
            local Ped = PlayerPedId()
            local Crashed = Components[Active]
            local Coords = GetEntityCoords(Ped)
            local Distance = #(Coords - Crashed["1"][1])

            if Distance <= 300 then
                TimeDistance = 1
                DrawMarker(1, Crashed["1"][1]["x"], Crashed["1"][1]["y"], Crashed["1"][1]["z"] - 10.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 300.0, 300.0, 200.0, 255, 0, 0, 300, 0, 0, 0, 0)
            end            

            if Distance <= 151.5 then
                if IsPedInAnyVehicle(Ped) and GetGameTimer() > Cooldown then
                    Coolcar = GetGameTimer() + 15000

                    SetTimeout(10000, function()
                        if Active and Components[Active] then
                            local Ped = PlayerPedId()
                            local Coords = GetEntityCoords(Ped)
                            if #(Coords - Crashed["1"][1]) <= 151.5 then
                                TriggerEvent("garages:Delete")
                            end
                        end
                    end)
                end

                local Armour = GetPedArmour(Ped)
                local Healths = GetEntityHealth(Ped)
                if Healths > 100 and GetGameTimer() > Cooldown then
                    Cooldown = GetGameTimer() + 10000
                    SetEntityHealth(Ped, Healths + 5)
                    SetPedArmour(Ped, Armour + 5)
                end
            end

            for Number, v in pairs(Crashed) do
                if not Objects[Number] and LoadModel(v[3]) then
                    Objects[Number] = CreateObjectNoOffset(v[3], v[1], false, false, false)
                    SetEntityHeading(Objects[Number], v[2])
                    SetEntityLodDist(Objects[Number], 0xFFFF)
                    FreezeEntityPosition(Objects[Number], true)
                    PlaceObjectOnGroundProperly(Objects[Number])

                    if Number ~= "1" then
                        exports["target"]:AddBoxZone("Helicrash:" .. Number, v[1], 3.5, 5.0, {
                            name = "Helicrash:" .. Number,
                            heading = v[2],
                            minZ = v[1]["z"] - 1.00,
                            maxZ = v[1]["z"] + 0.25
                        }, {
                            shop = "Helicrash:" .. Number,
                            Distance = 1.75,
                            options = {
                                {
                                    event = "chest:Open",
                                    label = "Abrir",
                                    tunnel = "shop",
                                    service = "Custom"
                                }
                            }
                        })
                    end
                end
            end
        else
            if Objects["1"] then
                DeleteEntity(Objects["1"])  -- Exclua o helicóptero

                for Number, v in pairs(Objects) do
                    if Number ~= "1" then
                        -- Exclua outros objetos
                        DeleteEntity(v)
                    end
                end

                -- Limpe o registro dos objetos excluídos
                Objects = {}
            end
        end

        Wait(TimeDistance)
    end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDSTATEBAGCHANGEHANDLER
-----------------------------------------------------------------------------------------------------------------------------------------
AddStateBagChangeHandler("Helicrash", nil, function(Name, Key, Value)
    if DoesBlipExist(Blip) then
        RemoveBlip(Blip)
    end

    Active = Value

    if not Value then
        if Objects["1"] then
            TriggerEvent("Notify", "helicrash", "Todos os suprimentos foram saqueados e o Evento Foi Finalizado", 30000)
            local Ped = PlayerPedId()
            if GetEntityHealth(Ped) <= 100 then
                exports["survival"]:Revive(150)
            end

            if IsPedArmed(Ped, 6) then
                TriggerEvent("inventory:CleanWeapons", true)
            end

            -- Exclua o helicóptero (objeto "1")
            if DoesEntityExist(Objects["1"]) then
                DeleteEntity(Objects["1"])
            end

            -- Exclua outros objetos
            for Number, _ in pairs(Objects) do
                if Number ~= "1" then
                    exports["target"]:RemCircleZone("Helicrash:" .. Number)

                    if DoesEntityExist(Objects[Number]) then
                        DeleteEntity(Objects[Number])
                    end
                end
            end

            -- Limpe o registro dos objetos excluídos
            for Number, _ in pairs(Objects) do
                Objects[Number] = nil
            end
        end
    else
        HeliBlip(Active)

        if Objects["1"] then
            for Number, v in pairs(Objects) do
                exports["target"]:RemCircleZone("Helicrash:" .. Number)

                if DoesEntityExist(Objects[Number]) then
                    DeleteEntity(Objects[Number])
                end
            end

            -- Limpe o registro dos objetos excluídos
            for Number, _ in pairs(Objects) do
                Objects[Number] = nil
            end
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- GLOBALSTATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("onClientResourceStart")
AddEventHandler("onClientResourceStart",function(Resource)
    if (GetCurrentResourceName() ~= Resource) then
        return
    end

    if GlobalState["Helicrash"] then
        Active = GlobalState["Helicrash"]
        HeliBlip(Active)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HELIBLIP
-----------------------------------------------------------------------------------------------------------------------------------------
function HeliBlip(Number)
	if Components[Number] then
		Blip = AddBlipForCoord(Components[Number]["1"][1],Components[Number]["1"][2],Components[Number]["1"][3])
		SetBlipSprite(Blip,43)
		SetBlipDisplay(Blip,4)
		SetBlipAsShortRange(Blip,true)
		SetBlipColour(Blip,5)
		SetBlipScale(Blip,0.8)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Helicrash")
		EndTextCommandSetBlipName(Blip)
	end
end