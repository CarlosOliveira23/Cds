-----------------------------------------------------------------------------------------------------------------------------------------
-- kadu
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Kaduzera = {}
Tunnel.bindInterface("bus",Kaduzera)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUFFS
-----------------------------------------------------------------------------------------------------------------------------------------
Buffs = {
	["Dexterity"] = {}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function Kaduzera.Payment(Service)
    local source = source
    local Passport = vRP.Passport(source)
    if Passport then
        local Experience = vRP.GetExperience(Passport, "Driver")
        local Category = ClassCategory(Experience)
        local Valuation = 100
        local premiumBonus = 0 

        if Category == "B+" then
            Valuation = Valuation + 10
        elseif Category == "A" then
            Valuation = Valuation + 20
        elseif Category == "A+" then
            Valuation = Valuation + 30
        elseif Category == "S" then
            Valuation = Valuation + 40
        elseif Category == "S+" then
            Valuation = Valuation + 50
        end

        if Buffs["Dexterity"][Passport] then
            if Buffs["Dexterity"][Passport] > os.time() then
                Valuation = Valuation + (Valuation * 0.1)
            end
        end

        vRP.PutExperience(Passport, "Driver", 1)

        -- Verifica se o jogador é premium
        local isPremium = vRP.HasPermission(Passport,"Premium") or vRP.HasPermission(Passport,"PremiumPrata") or vRP.HasPermission(Passport,"PremiumOuro")

        -- Se for premium, conceda um bônus adicional de 50% do Valuation
        if isPremium then
            premiumBonus = Valuation * 0.5  -- 50% a mais do Valuation
            Valuation = Valuation + premiumBonus
        end

        vRP.GenerateItem(Passport, "dollars", Valuation, true)

        -- Envie notificações para Valuation e premiumBonus
        TriggerClientEvent("Notify", source, "salario2", "Você recebeu pagamento de: $" .. Valuation, 5000)
        if isPremium then
            TriggerClientEvent("Notify", source, "salario2","Você recebeu Bônus do seu Premium: $" .. premiumBonus, 5000)
            --vRP.GenerateItem(Passport, "dollars", premiumBonus, true)  -- Gere o item premiumBonus
        end
        
        TriggerEvent("inventory:BuffServer", source, Passport, "Dexterity", Valuation)
    end
end

