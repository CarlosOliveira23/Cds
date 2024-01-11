-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("survival",Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Death = false
local DeathTimer = 200
local Cooldown = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        local TimeDistance = 999

        if LocalPlayer["state"]["Active"] then
            local Ped = PlayerPedId()
            if GetEntityHealth(Ped) <= 100 then
                if not Death then
                    Death = true

                    local Coords = GetEntityCoords(Ped)
                    NetworkResurrectLocalPlayer(Coords, 0.0)

                    NetworkSetFriendlyFireOption(false)
                    SetEntityInvincible(Ped, true)
                    SetEntityHealth(Ped, 100)

                    if LocalPlayer["state"]["Route"] < 900000 then
                        DeathTimer = 200

                        TriggerEvent("hud:RemoveHood")
                        TriggerEvent("hud:ScubaRemove")
                        TriggerEvent("radio:RadioClean")
                        TriggerEvent("inventory:Cancel")
                        TriggerEvent("inventory:CleanWeapons")
                        TriggerServerEvent("paramedic:bloodDeath")
                        TriggerServerEvent("pma-voice:toggleMute", true)
                    else
                        DeathTimer = 5
                    end

                    SendNUIMessage({ Action = "Display", Mode = "block" })
                    --TriggerEvent("inventory:preventWeapon", false)
                    vRP.playAnim(false, { "combat@damage@writheidle_c", "writhe_idle_g" }, true)
                    TriggerEvent("inventory:Close")
                else
                    TimeDistance = 1
                    SetEntityHealth(Ped, 100)

                    -- Adicione a linha abaixo para manter a arma na mão após a ressurreição
                    SetCurrentPedWeapon(Ped, GetHashKey("WEAPON_PISTOL_MK2"), true)
					SetCurrentPedWeapon(Ped, GetHashKey("WEAPON_COMBATPISTOL"), true)
					SetCurrentPedWeapon(Ped, GetHashKey("WEAPON_SPECIALCARBINE_MK2"), true)

                    DisableControlAction(1, 18, true)
                    -- (códigos de desativação de controle adicionais aqui)

                    if not IsEntityPlayingAnim(Ped, "combat@damage@writheidle_c", "writhe_idle_g", 3) and not IsPedInAnyVehicle(Ped) and not IsEntityPlayingAnim(Ped, "nm", "firemans_carry", 3) then
                        vRP.playAnim(false, { "combat@damage@writheidle_c", "writhe_idle_g" }, true)
                    end

                    if IsPedInAnyVehicle(Ped) then
                        local Vehicle = GetVehiclePedIsUsing(Ped)
                        if GetPedInVehicleSeat(Vehicle, -1) == Ped then
                            SetVehicleEngineOn(Vehicle, false, true, true)
                        end
                    end

                    if LocalPlayer["state"]["Route"] > 900000 and IsControlJustPressed(1, 38) then
                        TriggerEvent("arena:ResetStreek")
                        TriggerEvent("arena:Respawn")
                    end

                    if GetGameTimer() >= Cooldown then
                        Cooldown = GetGameTimer() + 1000

                        if DeathTimer > 0 then
                            DeathTimer = DeathTimer - 1
                            SendNUIMessage({ Action = "Message", Message = "Você está inconsciente, aguarde <color>" .. DeathTimer .. "</color> segundos" })

                            if DeathTimer <= 0 then
                                if LocalPlayer["state"]["Route"] < 900000 then
                                    SendNUIMessage({ Action = "Message", Message = "Digite <color>/GG</color> para voltar ao Hospital" })
                                else
                                    SendNUIMessage({ Action = "Message", Message = "Pressione <color>E</color> para renascer dentro da arena" })
                                end
                            end
                        end
                    end
                end
            end
        end

        Wait(TimeDistance)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKDEATH
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.CheckDeath()
	if Death and DeathTimer <= 0 then
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Respawn()
	Death = false
	DeathTimer = 200

	ClearPedTasks(PlayerPedId())
	NetworkSetFriendlyFireOption(true)
	ClearPedBloodDamage(PlayerPedId())
	SetEntityHealth(PlayerPedId(),200)
	SetEntityInvincible(PlayerPedId(),false)

	TriggerEvent("paramedic:Reset")
	TriggerEvent("inventory:CleanWeapons")
	LocalPlayer["state"]["Handcuff"] = false
	TriggerServerEvent("pma-voice:toggleMute",false)

	if LocalPlayer["state"]["Police"] then
		SetEntityCoords(PlayerPedId(),-939.82,-2003.06,9.5)
	elseif LocalPlayer["state"]["Core"] then
		SetEntityCoords(PlayerPedId(),824.62,-1371.69,26.13)
	elseif LocalPlayer["state"]["Paramedic"] then
		SetEntityCoords(PlayerPedId(),1142.95,-1578.46,35.38)
	elseif LocalPlayer["state"]["Barragem"] then
		SetEntityCoords(PlayerPedId(),1276.58,-196.53,102.16)
	elseif LocalPlayer["state"]["Farol"] then
		SetEntityCoords(PlayerPedId(),3057.8,5091.34,24.42)
	elseif LocalPlayer["state"]["Parque"] then
		SetEntityCoords(PlayerPedId(),395.15,790.83,187.79)
	elseif LocalPlayer["state"]["Sandy"] then
		SetEntityCoords(PlayerPedId(),2135.98,3884.22,33.21)
	elseif LocalPlayer["state"]["Petroleo"] then
		SetEntityCoords(PlayerPedId(),1477.01,-2435.8,66.24)
	elseif LocalPlayer["state"]["Praia-1"] then
		SetEntityCoords(PlayerPedId(),-3112.06,1364.43,22.6)
    elseif LocalPlayer["state"]["Praia-2"] then
		SetEntityCoords(PlayerPedId(),-3065.36,1773.87,36.08)
	elseif LocalPlayer["state"]["Zancudo"] then
		SetEntityCoords(PlayerPedId(),-606.96,2191.31,126.14)
	elseif LocalPlayer["state"]["Madrazzo"] then
		SetEntityCoords(PlayerPedId(),1459.59,1114.36,114.31)
	elseif LocalPlayer["state"]["TheSouth"] then
		SetEntityCoords(PlayerPedId(),979.55,-87.63,74.34)
	elseif LocalPlayer["state"]["Vineyard"] then
		SetEntityCoords(PlayerPedId(),-1922.3,2032.13,140.73)
	elseif LocalPlayer["state"]["Highways"] then
		SetEntityCoords(PlayerPedId(),1072.17,-2381.59,30.7)
	elseif LocalPlayer["state"]["Chiliad"] then
		SetEntityCoords(PlayerPedId(),1349.13,-2086.58,52.0)
	else
	SetEntityCoords(PlayerPedId(),342.99, -1398.35, 32.5)
    end
	SendNUIMessage({ Action = "Display", Mode = "none" })
    Wait(1000)
    DoScreenFadeIn(1000)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REVIVE
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Revive",function(Health,Arena)
	local Ped = PlayerPedId()

	SetEntityHealth(Ped,Health)
	SetEntityInvincible(Ped,false)

	if Arena then
		SetPedArmour(Ped,99)
	end

	if Death then
		Death = false
		DeathTimer = 200

		ClearPedTasks(Ped)
		NetworkSetFriendlyFireOption(true)

		SendNUIMessage({ Action = "Display", Mode = "none" })

		if LocalPlayer["state"]["Route"] < 900000 then
			TriggerEvent("paramedic:Reset")
			TriggerServerEvent("pma-voice:toggleMute",false)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REVIVE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Revive(Health,Arena)
	exports["survival"]:Revive(Health,Arena)
end