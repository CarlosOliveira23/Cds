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
Tunnel.bindInterface("doors",Kaduzera)
vTASKBAR = Tunnel.getInterface("taskbar")
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOORS
-----------------------------------------------------------------------------------------------------------------------------------------
GlobalState["Doors"] = {
	-- Police-1
	[1] = { x = -952.54, y = -2049.71, z = 6.1, hash = -806761221, lock = true, text = true, distance = 1, press = 2, press = 2, perm = "Police" and "Core" },
	[2] = { x = -953.05, y = -2051.72, z = 9.4, hash = -1291439697, lock = true, text = true, distance = 1, press = 2, press = 2, perm = "Police" and "Core" },
	[3] = { x = -955.99, y = -2049.01, z = 9.4, hash = -1291439697, lock = true, text = true, distance = 1, press = 2, press = 2, perm = "Police" and "Core" },
	[4] = { x = -959.65, y = -2052.67, z = 9.4, hash = -1291439697, lock = true, text = true, distance = 1, press = 2, press = 2, perm = "Police" and "Core" },
	[5] = { x = -925.98, y = -2035.20, z = 9.6, hash = 1307986194, lock = true, text = true, distance = 1, press = 2, press = 2, perm = "Police" and "Core", other = 32 },
	[6] = { x = -926.82, y = -2034.42, z = 9.6, hash = 1307986194, lock = true, text = true, distance = 1, press = 2, press = 2, perm = "Police" and "Core", other = 31 },
	[7] = { x = -953.81, y = -2044.32, z = 9.7, hash = 1307986194, lock = true, text = true, distance = 1, press = 2, press = 2, perm = "Police" and "Core" },
	[8] = { x = -954.02, y = -2058.36, z = 9.6, hash = 1307986194, lock = true, text = true, distance = 1, press = 2, press = 2, perm = "Police" and "Core", other = 35 },
	[9] = { x = -954.78, y = -2057.61, z = 9.6, hash = 1307986194, lock = true, text = true, distance = 1, press = 2, press = 2, perm = "Police" and "Core", other = 34 },
	[10] = { x = -912.94, y = -2033.33, z = 9.6, hash = 1307986194, lock = true, text = true, distance = 1, press = 2, press = 2, perm = "Police" and "Core", other = 37 },
	[11] = { x = -913.69, y = -2032.55, z = 9.6, hash = 1307986194, lock = true, text = true, distance = 1, press = 2, press = 2, perm = "Police" and "Core", other = 36 },
	-- Police-2
	[12] = { x = 817.22, y = -1321.18, z = 26.08, hash = -2138350253, lock = true, text = true, distance = 1, press = 2, press = 2, perm = "Police" and "Core"  },
	[13] = { x = 858.11, y = -1320.39, z = 28.24, hash = 749848321, lock = true, text = true, distance = 1, press = 2, press = 2, perm = "Police" and "Core" },
	[14] = { x = 830.43, y = -1310.36, z = 28.26, hash = 749848321, lock = true, text = true, distance = 1, press = 2, press = 2, perm = "Police" and "Core" },
	[15] = { x = 846.99, y = -1314.19, z = 26.59, hash = 749848321, lock = true, text = true, distance = 1, press = 2, press = 2, perm = "Police" and "Core" },
	[16] = { x = 848.79, y = -1284.46, z = 28.19, hash = 749848321, lock = true, text = true, distance = 1, press = 2, press = 2, perm = "Police" and "Core" },
	-- Police-3
	[17] = { x = 855.49, y = -1287.33, z = 26.93, hash = -2086711439, lock = true, text = true, distance = 1, press = 2, press = 2, perm = "Police" and "Core" },
	[18] = { x = 848.73, y = -1295.45, z = 28.24, hash = 749848321, lock = true, text = true, distance = 1, press = 2, press = 2, perm = "Police" and "Core" },
	[19] = { x = 853.26, y = -1313.72, z = 26.93, hash = 749848321, lock = true, text = true, distance = 1, press = 2, press = 2, perm = "Police" and "Core" },
	[20] = { x = 855.96, y = -1315.17, z = 28.26, hash = 749848321, lock = true, text = true, distance = 1, press = 2, press = 2, perm = "Police" and "Core" },
	[21] = { x = 863.11, y = -1289.28, z = 21.99, hash = 631614199, lock = true, text = true, distance = 1, press = 2, press = 2, perm = "Police" and "Core" },
	[22] = { x = 864.97, y = -1287.41, z = 21.99, hash = 631614199, lock = true, text = true, distance = 1, press = 2, press = 2, perm = "Police" and "Core" },
	[23] = { x = 868.75, y = -1287.5, z = 21.99, hash = 631614199, lock = true, text = true, distance = 1, press = 2, press = 2, perm = "Police" and "Core" },
	[24] = { x = 872.44, y = -1287.41, z = 21.99, hash = 631614199, lock = true, text = true, distance = 5, press = 2, press = 2, perm = "Police" and "Core" },
	[25] = { x = 872.52, y = -1291.67, z = 21.99, hash = 631614199, lock = true, text = true, distance = 5, press = 2, press = 2, perm = "Police" and "Core" },
	[26] = { x = 868.73, y = -1291.62, z = 21.99, hash = 631614199, lock = true, text = true, distance = 5, press = 2, press = 2, perm = "Police" and "Core" },
	[27] = { x = 864.06, y = -1291.47, z = 21.99, hash = 631614199, lock = true, text = true, distance = 5, press = 2, press = 2, perm = "Police" and "Core" },
	[28] = { x = 1763.44, y = 2478.50, z = 46.00, hash = 913760512, lock = true, text = true, distance = 10, press = 2, press = 2, perm = "Police" and "Core" },
	[29] = { x = 1766.54, y = 2480.33, z = 46.00, hash = 913760512, lock = true, text = true, distance = 10, press = 2, press = 2, perm = "Police" and "Core" },
	[30] = { x = 1769.73, y = 2482.13, z = 46.00, hash = 913760512, lock = true, text = true, distance = 10, press = 2, press = 2, perm = "Police" and "Core" },
	[31] = { x = 1772.83, y = 2483.97, z = 46.00, hash = 913760512, lock = true, text = true, distance = 10, press = 2, press = 2, perm = "Police" and "Core" },
	[32] = { x = 1776.00, y = 2485.77, z = 46.00, hash = 913760512, lock = true, text = true, distance = 10, press = 2, press = 2, perm = "Police" and "Core" },
	-- Police-4
	[33] = { x = 1849.02, y = 3693.30, z = 34.37, hash = -1491332605, lock = true, text = true, distance = 10, press = 2, press = 2, perm = "Police" and "Core" },
	[34] = { x = 1851.94, y = 3694.98, z = 34.37, hash = -1491332605, lock = true, text = true, distance = 10, press = 2, press = 2, perm = "Police" and "Core" },
	[35] = { x = 1856.33, y = 3696.54, z = 34.37, hash = -1491332605, lock = true, text = true, distance = 10, press = 2, press = 2, perm = "Police" and "Core" },
	[36] = { x = 1853.76, y = 3699.85, z = 34.37, hash = -2002725619, lock = true, text = true, distance = 10, press = 2, press = 2, perm = "Police" and "Core" },
	[37] = { x = 1847.24, y = 3688.46, z = 34.37, hash = -2002725619, lock = true, text = true, distance = 10, press = 2, press = 2, perm = "Police" and "Core" },
	-- Police-5
	[38] = { x = -444.45, y = 6007.71, z = 27.75, hash = -594854737, lock = true, text = true, distance = 10, press = 2, press = 2, perm = "Police" and "Core" },
	[39] = { x = -442.98, y = 6011.80, z = 27.75, hash = -594854737, lock = true, text = true, distance = 10, press = 2, press = 2, perm = "Police" and "Core" },
	[40] = { x = -445.12, y = 6012.14, z = 27.75, hash = -594854737, lock = true, text = true, distance = 10, press = 2, press = 2, perm = "Police" and "Core" },
	[41] = { x = -448.08, y = 6015.12, z = 27.75, hash = -594854737, lock = true, text = true, distance = 10, press = 2, press = 2, perm = "Police" and "Core" },
	[42] = { x = -445.60, y = 6017.56, z = 27.75, hash = -594854737, lock = true, text = true, distance = 10, press = 2, press = 2, perm = "Police" and "Core" },
	[43] = { x = -442.63, y = 6014.60, z = 27.75, hash = -594854737, lock = true, text = true, distance = 10, press = 2, press = 2, perm = "Police" and "Core" },
	-- Ottos
	[44] = { x = 823.68, y = -828.17, z = 26.34, hash = -147325430, lock = true, text = true, distance = 10, press = 2, perm = "Ottos" },
	[45] = { x = 829.39, y = -824.63, z = 26.34, hash = -147325430, lock = true, text = true, distance = 10, press = 2, perm = "Ottos" },
	[46] = { x = 837.86, y = -822.1, z = 26.34, hash = -147325430, lock = true, text = true, distance = 10, press = 2, perm = "Ottos" },
	[47] = { x = 841.32, y = -820.4, z = 26.32, hash = 263193286, lock = true, text = true, distance = 10, press = 2, perm = "Ottos" },
	-- Tuners
	[48] = { x = 151.73, y = -3012.3, z = 7.04, hash = -1229046235, lock = true, text = true, distance = 10, press = 2, perm = "Mechanic" },
	-- Chiliad
	[49] = { x = 2196.82, y = 5570.79, z = 53.9, hash = 819505495, lock = true, text = true, distance = 10, press = 2, perm = "Chiliad" },
	-- Families
	[50] = { x = -151.55, y = -1622.2, z = 33.65, hash = 1381046002, lock = true, text = true, distance = 10, press = 2, perm = "Families" },
	-- Highways
	[51] = { x = 1431.64, y = 6338.15, z = 23.86, hash = 1471868433, lock = true, text = true, distance = 10, press = 2, perm = "Highways" },
	-- Vagos
	[52] = { x = 325.11, y = -1990.69, z = 24.2, hash = 2118614536, lock = true, text = true, distance = 10, press = 2, perm = "Vagos" },
	[53] = { x = 336.45, y = -1992.27, z = 24.2, hash = 2118614536, lock = true, text = true, distance = 10, press = 2, perm = "Vagos" },
	-- Madrazzo
	[54] = { x = 1390.46, y = 1162.32, z = 114.33, hash = -52575179, lock = true, text = true, distance = 10, press = 2, perm = "Madrazzo", other = 55 },
	[55] = { x = 1390.46, y = 1162.32, z = 114.33, hash = -1032171637, lock = true, text = true, distance = 10, press = 2, perm = "Madrazzo", other = 54 },
	[56] = { x = 1406.95, y = 1128.27, z = 114.33, hash = 262671971, lock = true, text = true, distance = 10, press = 2, perm = "Madrazzo" },
	-- Playboy
	[57] = { x = -1470.84, y = 68.46, z = 53.3, hash = -2125423493, lock = true, text = true, distance = 10, press = 2, perm = "Playboy" },
	-- TheSouth
	[58] = { x = 982.29, y = -125.23, z = 74.05, hash = -930593859, lock = true, text = true, distance = 10, press = 2, perm = "TheSouth" },
	[59] = { x = 959.98, y = -140.16, z = 74.49, hash = -197537718, lock = true, text = true, distance = 10, press = 2, perm = "TheSouth" },
	[60] = { x = 981.62, y = -102.6, z = 74.85, hash = 190770132, lock = true, text = true, distance = 10, press = 2, perm = "TheSouth" },
	-- Vineyard
	[61] = { x = -1864.15, y = 2060.52, z = 141.13, hash = -1141522158, lock = true, text = true, distance = 10, press = 2, perm = "Vineyard", other = 62 },
	[62] = { x = 1390.46, y = 1162.32, z = 114.33, hash = 988364535, lock = true, text = true, distance = 10, press = 2, perm = "Vineyard", other = 61 },
		-- desmanche
	[63] = { x = 484.42, y = -1315.54, z = 29.2, hash = -190780785, lock = true, text = true, distance = 10, press = 2, perm = "Bennys" },
	[64] = { x = 483.14, y = -1312.56, z = 29.2, hash = -664582244, lock = true, text = true, distance = 10, press = 2, perm = "Bennys" },    ---- -1927271438
	[65] = { x = 495.05, y = -1311.78, z = 29.28, hash = -1927271438, lock = true, text = true, distance = 10, press = 2, perm = "Bennys" },
	---- Petroleo
	[66] = { x = 1545.93, y = -2449.85, z = 80.32, hash = 781635019, lock = true, text = true, distance = 10, press = 2, perm = "Petroleo" },
	-- cassino
	[67] = { x = 947.41, y = 40.65, z = 75.32, hash = 21324050, lock = true, text = true, distance = 10, press = 2, perm = kadu },
	[68] = { x = 946.54, y = 41.31, z = 75.32, hash = 21324050, lock = true, text = true, distance = 10, press = 2, perm = kadu },
	--- Kart
	[69] = { x = -160.78, y = -2150.84, z = 16.7, hash = -1234764774, lock = true, text = true, distance = 10, press = 2, perm = "Admin" },
	[70] = { x = -159.23, y = -2154.27, z = 16.7, hash = 91564889, lock = true, text = true, distance = 10, press = 2, perm = "Admin" },
	--- Casas nao Mexer..
	[71] = { x = 29.07, y = -23.88, z = -24.01, hash = 520341586, lock = true, text = true, distance = 10, press = 2, perm = "Admin" },
	----- policia PRAÇA
	[72] = { x = 452.30, y = -1000.80, z = 28.68, hash = 2130672747, lock = true, distance = 7, press = 2, perm = "Police" and "Core" },
	[73] = { x = 488.89, y = -1016.89, z = 27.14, hash = -1603817716, lock = true, distance = 7, press = 2, perm = "Police" and "Core" },
	[74] = { x = 476.61, y = -1008.87, z = 26.48, hash = -53345114, lock = true, distance = 1.5, press = 2, perm = "Police" and "Core" },
	[75] = { x = 481.00, y = -1004.11, z = 26.48, hash = -53345114, lock = true, distance = 1.5, press = 2, perm = "Police" and "Core" },
	[76] = { x = 477.91, y = -1012.18, z = 26.48, hash = -53345114, lock = true, distance = 1.5, press = 2, perm = "Police" and "Core" },
	[77] = { x = 480.91, y = -1012.18, z = 26.48, hash = -53345114, lock = true, distance = 1.5, press = 2, perm = "Police" and "Core" },
	[78] = { x = 483.91, y = -1012.18, z = 26.48, hash = -53345114, lock = true, distance = 1.5, press = 2, perm = "Police" and "Core" },
	[79] = { x = 486.91, y = -1012.18, z = 26.48, hash = -53345114, lock = true, distance = 1.5, press = 2, perm = "Police" and "Core" },
	[80] = { x = 484.17, y = -1007.73, z = 26.48, hash = -53345114, lock = true, distance = 1.5, press = 2, perm = "Police" and "Core" },
	[81] = { x = 440.52, y = -977.60, z = 30.82, hash = 2888281650, lock = true, distance = 1.5, press = 2, perm = "Police" and "Core" },
	[82] = { x = 440.52, y = -986.23, z = 30.82, hash = 4198287975, lock = true, distance = 1.5, press = 2, perm = "Police" and "Core" },
	[83] = { x = 479.75, y = -999.62, z = 30.78, hash = -692649124, lock = true, distance = 1.5, press = 2, perm = "Police" and "Core" },
	[84] = { x = 487.43, y = -1000.18, z = 30.78, hash = -692649124, lock = true, distance = 1.5, press = 2, perm = "Police" and "Core" },
	[85] = { x = 467.36, y = -1014.40, z = 26.48, hash = -692649124, lock = true, distance = 1.5, press = 2, perm = "Police" and "Core", other = 16 },
	[86] = { x = 469.77, y = -1014.40, z = 26.48, hash = -692649124, lock = true, distance = 1.5, press = 2, perm = "Police" and "Core", other = 15 },
	[87] = { x = 440.73, y = -998.74, z = 30.81, hash = -1547307588, lock = true, distance = 1.5, press = 2, perm = "Police" and "Core", other = 18 },
	[88] = { x = 443.06, y = -998.74, z = 30.81, hash = -1547307588, lock = true, distance = 1.5, press = 2, perm = "Police" and "Core", other = 17 },
	[89] = { x = 458.20, y = -972.25, z = 30.81, hash = -1547307588, lock = true, distance = 1.5, press = 2, perm = "Police" and "Core", other = 20 },
	[90] = { x = 455.88, y = -972.25, z = 30.81, hash = -1547307588, lock = true, distance = 1.5, press = 2, perm = "Police" and "Core", other = 19 },
	----- MECHANIC
	[91] = { x = 826.63, y = -944.71, z = 26.49, hash = 1308911070, lock = true, text = true, distance = 1, press = 2, perm = "Mechanic" },
	[92] = { x = 825.01, y = -944.75, z = 26.49, hash = -403433025, lock = true, text = true, distance = 1, press = 2, perm = "Mechanic" },
	[93] = { x = 831.02, y = -940.97, z = 20.29, hash = -1252738454, lock = true, text = true, distance = 2, press = 2, perm = "Mechanic" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOORSSTATISTICS   29.07,-23.88,-24.01,325.99
-----------------------------------------------------------------------------------------------------------------------------------------
function Kaduzera.doorsStatistics(doorNumber,doorStatus)
	local Doors = GlobalState["Doors"]

	Doors[doorNumber]["lock"] = doorStatus

	if Doors[doorNumber]["other"] ~= nil then
		local doorSecond = Doors[doorNumber]["other"]
		Doors[doorSecond]["lock"] = doorStatus
	end

	GlobalState["Doors"] = Doors
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOORSPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function Kaduzera.doorsPermission(doorNumber)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if GlobalState["Doors"][doorNumber]["perm"] ~= nil then
			if vRP.HasService(Passport,GlobalState["Doors"][doorNumber]["perm"]) then
				return true
			end
		end
	end

	return false
end