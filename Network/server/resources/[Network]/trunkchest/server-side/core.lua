-----------------------------------------------------------------------------------------------------------------------------------------
-- kadu
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Kaduzera = {}
Tunnel.bindInterface("trunkchest",Kaduzera)
vTASKBAR = Tunnel.getInterface("taskbar")
vCLIENT = Tunnel.getInterface("trunkchest")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Vehicle = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENCHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function Kaduzera.openChest()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Vehicle[Passport] then
		local myInfos = {}
		local Inventory = vRP.Inventory(Passport)
		for k,v in pairs(Inventory) do
			v["amount"] = parseInt(v["amount"])
			v["name"] = itemName(v["item"])
			v["peso"] = itemWeight(v["item"])
			v["index"] = itemIndex(v["item"])
			v["max"] = itemMaxAmount(v["item"])
			v["economy"] = parseFormat(itemEconomy(v["item"]))
			v["desc"] = itemDescription(v["item"])
			v["key"] = v["item"]
			v["slot"] = k

			local splitName = splitString(v["item"],"-")
			if splitName[2] ~= nil then
				if itemDurability(v["item"]) then
					v["durability"] = parseInt(os.time() - splitName[2])
					v["days"] = itemDurability(v["item"])
				else
					v["durability"] = 0
					v["days"] = 1
				end
			else
				v["durability"] = 0
				v["days"] = 1
			end

			myInfos[k] = v
		end

		local vehInfos = {}
		local Result = vRP.GetSrvData(Vehicle[Passport]["Data"])
		for k,v in pairs(Result) do
			v["amount"] = parseInt(v["amount"])
			v["name"] = itemName(v["item"])
			v["peso"] = itemWeight(v["item"])
			v["index"] = itemIndex(v["item"])
			v["max"] = itemMaxAmount(v["item"])
			v["economy"] = parseFormat(itemEconomy(v["item"]))
			v["desc"] = itemDescription(v["item"])
			v["key"] = v["item"]
			v["slot"] = k

			local splitName = splitString(v["item"],"-")
			if splitName[2] ~= nil then
				if itemDurability(v["item"]) then
					v["durability"] = parseInt(os.time() - splitName[2])
					v["days"] = itemDurability(v["item"])
				else
					v["durability"] = 0
					v["days"] = 1
				end
			else
				v["durability"] = 0
				v["days"] = 1
			end

			vehInfos[k] = v
		end

		return myInfos,vehInfos,vRP.InventoryWeight(Passport),vRP.GetWeight(Passport),vRP.ChestWeight(Result),Vehicle[Passport]["Weight"]
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREVEHS
-----------------------------------------------------------------------------------------------------------------------------------------
local storeVehs = {
	["ratloader"] = {
		["woodlog"] = true
	},
	["stockade"] = {
		["pouch"] = true
	},
	["trash"] = {
		["glassbottle"] = true,
		["plasticbottle"] = true,
		["elastic"] = true,
		["metalcan"] = true,
		["battery"] = true
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATECHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function Kaduzera.updateChest(Slot,Target,Amount)
	local source = source
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport and Vehicle[Passport] then
		if Amount <= 0 then Amount = 1 end

		if vRP.UpdateChest(Passport,Vehicle[Passport]["Data"],Slot,Target,Amount) then
			TriggerClientEvent("trunkchest:Update",source,"requestChest")
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function Kaduzera.storeItem(Item,Slot,Amount,Target)
	local source = source
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport and Vehicle[Passport] then
		if Amount <= 0 then Amount = 1 end
		local vehName = Vehicle[Passport]["Model"]

		if (storeVehs[vehName] and not storeVehs[vehName][Item]) or Item == "dollars" or itemBlock(Item) then
			TriggerClientEvent("trunkchest:Update",source,"requestChest")
			TriggerClientEvent("Notify",source,"amarelo","Armazenamento proibido.",5000)
			goto scapeInventory
		end

		if vRP.StoreChest(Passport,Vehicle[Passport]["Data"],Amount,Vehicle[Passport]["Weight"],Slot,Target) then
			TriggerClientEvent("trunkchest:Update",source,"requestChest")
		else
			if Vehicle[Passport] then
				local Result = vRP.GetSrvData(Vehicle[Passport]["Data"])
				TriggerClientEvent("trunkchest:UpdateWeight",source,vRP.InventoryWeight(Passport),vRP.GetWeight(Passport),vRP.ChestWeight(Result),Vehicle[Passport]["Weight"])
			end
		end
	end

	::scapeInventory::
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function Kaduzera.takeItem(Slot,Amount,Target)
	local source = source
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport and Vehicle[Passport] then
		if Amount <= 0 then Amount = 1 end

		if vRP.TakeChest(Passport,Vehicle[Passport]["Data"],Amount,Slot,Target) then
			TriggerClientEvent("trunkchest:Update",source,"requestChest")
		else
			if Vehicle[Passport] then
				local Result = vRP.GetSrvData(Vehicle[Passport]["Data"])
				TriggerClientEvent("trunkchest:UpdateWeight",source,vRP.InventoryWeight(Passport),vRP.GetWeight(Passport),vRP.ChestWeight(Result),Vehicle[Passport]["Weight"])
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
function Kaduzera.chestClose()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Vehicle[Passport] then
		TriggerClientEvent("player:syncDoorsOptions",source,Vehicle[Passport]["Net"],"close")
		Vehicle[Passport] = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRUNKCHEST:OPENTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trunkchest:openTrunk")
AddEventHandler("trunkchest:openTrunk",function(Entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and VehicleChest(Entity[2]) > 0 then
		local PassportPlate = vRP.PassportPlate(Entity[1])
		if PassportPlate and (vRP.HasService(Passport,"Police") or PassportPlate["Passport"] == Passport or vRP.InventoryFull(Passport,"vehkey-"..Entity[1])) then
			Vehicle[Passport] = {
				["Net"] = Entity[4],
				["Plate"] = Entity[1],
				["Model"] = Entity[2],
				["User"] = PassportPlate["Passport"],
				["Weight"] = VehicleChest(Entity[2]),
				["Data"] = "Trunkchest:"..PassportPlate["Passport"]..":"..Entity[2]
			}

			local Network = NetworkGetEntityFromNetworkId(Vehicle[Passport]["Net"])

			if GetVehicleDoorLockStatus(Network) <= 1 then
				TriggerClientEvent("trunkchest:Open",source)

				local Players = vRP.Players(source)
				for _,v in pairs(Players) do
					async(function()
						if Vehicle[Passport] and Vehicle[Passport]["Net"] then
							TriggerClientEvent("player:VehicleDoors",v,Vehicle[Passport]["Net"],"open")
						end
					end)
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","Veículo trancado.",5000)
				Vehicle[Passport] = nil
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Você precisa da chave do veículo.",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FORCETRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trunkchest:forceTrunk")
AddEventHandler("trunkchest:forceTrunk",function(Entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and VehicleChest(Entity[2]) > 0 then
		local PassportPlate = vRP.PassportPlate(Entity[1])
		if PassportPlate then
			local Service,Total = vRP.NumPermission("Police")
			if Total >= 0 then
				if vCLIENT.checkWeapon(source,"WEAPON_CROWBAR") then
					TriggerClientEvent("Notify",source,"amarelo","Você precisa colocar o <b>"..itemName("WEAPON_CROWBAR").."</b> em mãos.",5000)
					return
				end

				Vehicle[Passport] = {
					["Net"] = Entity[4],
					["Plate"] = Entity[1],
					["Model"] = Entity[2],
					["User"] = PassportPlate["Passport"],
					["Weight"] = VehicleChest(Entity[2]),
					["Data"] = "Trunkchest:"..PassportPlate["Passport"]..":"..Entity[2]
				}

				local Network = NetworkGetEntityFromNetworkId(Vehicle[Passport]["Net"])

				if GetVehicleDoorLockStatus(Network) == 2 then
					vRPC.playAnim(source,false,{ "amb@prop_human_bum_bin@base", "base" },true)
					
					if vTASKBAR.taskRobberys(source) then
						TriggerClientEvent("trunkchest:Open",source)

						local Coords = vRP.GetEntityCoords(source)
						for Passports,Sources in pairs(Service) do
							async(function()
								TriggerClientEvent("sounds:source",Sources,"crime",0.5)
								TriggerClientEvent("NotifyPush",Sources,{ code = 31, title = "Roubo a Porta-malas", x = Coords["x"], y = Coords["y"], z = Coords["z"], color = 22 })
							end)
						end

						local Players = vRPC.Players(source)
						for _,v in pairs(Players) do
							async(function()
								if Vehicle[Passport] and Vehicle[Passport]["Net"] then
									TriggerClientEvent("player:VehicleDoors",v,Vehicle[Passport]["Net"],"open")
								end
							end)
						end
					else
						vRPC.stopAnim(source,true)
					end
				else
					Vehicle[Passport] = nil
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","Contingente indisponível.",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport)
	if Vehicle[Passport] then
		Vehicle[Passport] = nil
	end
end)