local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

Kaduzera = {}
Tunnel.bindInterface(GetCurrentResourceName(),Kaduzera)

local Delay = {}

function Kaduzera.CheckHouseDelay(Number)
    local source = source
    if not Delay[Number] or Delay[Number] <= os.time() then
        Delay[Number] = os.time() + (15 * 60) --15 minutos 
        return true
    else
        TriggerClientEvent("Notify", source, "amarelo", "Aguarde "..CompleteTimers(tonumber(Delay[Number]) - tonumber(os.time()))..".",5000)
        return false
    end
end

function Kaduzera.FinishHouseService(WorkingAtHome, ServicesDone)
    local source = source
    local Passport = vRP.Passport(source)
    
    if Passport then
        local Completed = true
        for k,v in pairs(ServicesDone) do
            if not v then
                Completed = false
                break
            end
        end

        local paymentAmount = #ServicesDone * math.random(90, 110)

        if vRP.HasGroup(Passport, "Premium") or vRP.HasGroup(Passport, "PremiumOuro") or vRP.HasGroup(Passport,"PremiumPrata") then
            paymentAmount = paymentAmount * 1.25
        end

        if Completed then
            vRP.GiveItem(Passport, "dollars", paymentAmount, true)
        end
    end
end
