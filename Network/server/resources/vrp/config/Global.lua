-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
BaseMode = "license"
Whitelisted = true
SalarySeconds = 1800
BannedText = "Banido"
CleanDeathInventory = true
ServerName = "vanilla"
ReleaseText = "Envie esse 'ID RANDÔMICO' na sala liberação, lembre-se de que esse 'ID' não é o 'ID' do seu personagem."
SpawnCoords = vec3(-27.45,-145.84,56.99)
BackPrison = vec3(1841.62,2585.94,46.02)
BackpackWeightDefault = 25
WipeBackpackDeath = false
NewItemIdentity = true
UsableF7 = true
-----------------------------------------------------------------------------------------------------------------------------------------
-- Discord
-----------------------------------------------------------------------------------------------------------------------------------------
Discord = {
	["Connect"] = "https://discord.com/api/webhooks/1125818441685807104/Qdb6gHqWDJk6yia_2FUYMUkcYVy_sVQ-InzjJvqWfp4-7saTL7QgbdrRD8M3sf4rYkrJ",
	["Disconnect"] = "https://discord.com/api/webhooks/1125818441685807104/Qdb6gHqWDJk6yia_2FUYMUkcYVy_sVQ-InzjJvqWfp4-7saTL7QgbdrRD8M3sf4rYkrJ",
	["Airport"] = "https://discord.com/api/webhooks/1125818441685807104/Qdb6gHqWDJk6yia_2FUYMUkcYVy_sVQ-InzjJvqWfp4-7saTL7QgbdrRD8M3sf4rYkrJ",
	["Deaths"] = "https://discord.com/api/webhooks/1125818441685807104/Qdb6gHqWDJk6yia_2FUYMUkcYVy_sVQ-InzjJvqWfp4-7saTL7QgbdrRD8M3sf4rYkrJ",
	["Police"] = "https://discord.com/api/webhooks/1125818441685807104/Qdb6gHqWDJk6yia_2FUYMUkcYVy_sVQ-InzjJvqWfp4-7saTL7QgbdrRD8M3sf4rYkrJ",
	["Paramedic"] = "https://discord.com/api/webhooks/1125818441685807104/Qdb6gHqWDJk6yia_2FUYMUkcYVy_sVQ-InzjJvqWfp4-7saTL7QgbdrRD8M3sf4rYkrJ",
	["Gemstone"] = "https://discord.com/api/webhooks/1125818441685807104/Qdb6gHqWDJk6yia_2FUYMUkcYVy_sVQ-InzjJvqWfp4-7saTL7QgbdrRD8M3sf4rYkrJ",
	["Login"] = "https://discord.com/api/webhooks/1125818441685807104/Qdb6gHqWDJk6yia_2FUYMUkcYVy_sVQ-InzjJvqWfp4-7saTL7QgbdrRD8M3sf4rYkrJ",
	["Chest"] = "https://discord.com/api/webhooks/1125818441685807104/Qdb6gHqWDJk6yia_2FUYMUkcYVy_sVQ-InzjJvqWfp4-7saTL7QgbdrRD8M3sf4rYkrJ",
	-- Contraband
	["Chiliad"] = "https://discord.com/api/webhooks/1125818441685807104/Qdb6gHqWDJk6yia_2FUYMUkcYVy_sVQ-InzjJvqWfp4-7saTL7QgbdrRD8M3sf4rYkrJ",
	["Families"] = "https://discord.com/api/webhooks/1125818441685807104/Qdb6gHqWDJk6yia_2FUYMUkcYVy_sVQ-InzjJvqWfp4-7saTL7QgbdrRD8M3sf4rYkrJ",
	["Highways"] = "https://discord.com/api/webhooks/1125818441685807104/Qdb6gHqWDJk6yia_2FUYMUkcYVy_sVQ-InzjJvqWfp4-7saTL7QgbdrRD8M3sf4rYkrJ",
	["Vagos"] = "https://discord.com/api/webhooks/1125818441685807104/Qdb6gHqWDJk6yia_2FUYMUkcYVy_sVQ-InzjJvqWfp4-7saTL7QgbdrRD8M3sf4rYkrJ",
	-- Favelas
	["Barragem"] = "https://discord.com/api/webhooks/1125818441685807104/Qdb6gHqWDJk6yia_2FUYMUkcYVy_sVQ-InzjJvqWfp4-7saTL7QgbdrRD8M3sf4rYkrJ",
	["Farol"] = "https://discord.com/api/webhooks/1125818441685807104/Qdb6gHqWDJk6yia_2FUYMUkcYVy_sVQ-InzjJvqWfp4-7saTL7QgbdrRD8M3sf4rYkrJ",
	["Parque"] = "https://discord.com/api/webhooks/1125818441685807104/Qdb6gHqWDJk6yia_2FUYMUkcYVy_sVQ-InzjJvqWfp4-7saTL7QgbdrRD8M3sf4rYkrJ",
	["Sandy"] = "https://discord.com/api/webhooks/1125818441685807104/Qdb6gHqWDJk6yia_2FUYMUkcYVy_sVQ-InzjJvqWfp4-7saTL7QgbdrRD8M3sf4rYkrJ",
	["Petroleo"] = "https://discord.com/api/webhooks/1125818441685807104/Qdb6gHqWDJk6yia_2FUYMUkcYVy_sVQ-InzjJvqWfp4-7saTL7QgbdrRD8M3sf4rYkrJ",
	["Praia-1"] = "https://discord.com/api/webhooks/1125818441685807104/Qdb6gHqWDJk6yia_2FUYMUkcYVy_sVQ-InzjJvqWfp4-7saTL7QgbdrRD8M3sf4rYkrJ",
	["Praia-2"] = "https://discord.com/api/webhooks/1125818441685807104/Qdb6gHqWDJk6yia_2FUYMUkcYVy_sVQ-InzjJvqWfp4-7saTL7QgbdrRD8M3sf4rYkrJ",
	["Zancudo"] = "https://discord.com/api/webhooks/1125818441685807104/Qdb6gHqWDJk6yia_2FUYMUkcYVy_sVQ-InzjJvqWfp4-7saTL7QgbdrRD8M3sf4rYkrJ",
	-- Mafias
	["Madrazzo"] = "https://discord.com/api/webhooks/1125818441685807104/Qdb6gHqWDJk6yia_2FUYMUkcYVy_sVQ-InzjJvqWfp4-7saTL7QgbdrRD8M3sf4rYkrJ",
	["Playboy"] = "https://discord.com/api/webhooks/1125818441685807104/Qdb6gHqWDJk6yia_2FUYMUkcYVy_sVQ-InzjJvqWfp4-7saTL7QgbdrRD8M3sf4rYkrJ",
	["TheSouth"] = "https://discord.com/api/webhooks/1125818441685807104/Qdb6gHqWDJk6yia_2FUYMUkcYVy_sVQ-InzjJvqWfp4-7saTL7QgbdrRD8M3sf4rYkrJ",
	["Vineyard"] = "https://discord.com/api/webhooks/1125818441685807104/Qdb6gHqWDJk6yia_2FUYMUkcYVy_sVQ-InzjJvqWfp4-7saTL7QgbdrRD8M3sf4rYkrJ",
	-- Admin
	["Admin"] = "https://discord.com/api/webhooks/1130975504330150101/Sm6vQSkskK-5gw9C08WUBVW17Thff2gYmUGXds-U0TXy9hw7257sN2wwEslp6tK6e-4H",
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- REWARDS
-----------------------------------------------------------------------------------------------------------------------------------------
Rewards = {
	[1] = { ["item"] = "vehiclevip", ["amount"] = 1 },
	[2] = { ["item"] = "advtoolbox", ["amount"] = 2 },
	[3] = { ["item"] = "treasurebox", ["amount"] = 5 },
	[4] = { ["item"] = "nitro", ["amount"] = 3 },
	[5] = { ["item"] = "chips", ["amount"] = 2750 },
	[6] = { ["item"] = "repairkit01", ["amount"] = 2 },
	[7] = { ["item"] = "recyclable", ["amount"] = 2000 },
	[8] = { ["item"] = "dollars", ["amount"] = 7500 },
	[9] = { ["item"] = "medkit", ["amount"] = 3 },
	[10] = { ["item"] = "gemstone", ["amount"] = 10 },
	[11] = { ["item"] = "advtoolbox", ["amount"] = 2 },
	[12] = { ["item"] = "treasurebox", ["amount"] = 5 },
	[13] = { ["item"] = "diagram", ["amount"] = 1 },
	[14] = { ["item"] = "tyres", ["amount"] = 5 },
	[15] = { ["item"] = "dollars", ["amount"] = 7500 },
	[16] = { ["item"] = "backpack", ["amount"] = 1 },
	[17] = { ["item"] = "nitro", ["amount"] = 3 },
	[18] = { ["item"] = "advtoolbox", ["amount"] = 3 },
	[19] = { ["item"] = "gemstone", ["amount"] = 10 },
	[20] = { ["item"] = "chips", ["amount"] = 2750 },
	[21] = { ["item"] = "recyclable", ["amount"] = 2000 },
	[22] = { ["item"] = "rope", ["amount"] = 3 },
	[23] = { ["item"] = "vape", ["amount"] = 1 },
	[24] = { ["item"] = "medkit", ["amount"] = 3 },
	[25] = { ["item"] = "treasurebox", ["amount"] = 5 },
	[26] = { ["item"] = "repairkit02", ["amount"] = 1 },
	[27] = { ["item"] = "backpack", ["amount"] = 1 },
	[28] = { ["item"] = "tyres", ["amount"] = 5 },
	[29] = { ["item"] = "diagram", ["amount"] = 1 },
	[30] = { ["item"] = "races", ["amount"] = 3 },
	[31] = { ["item"] = "vehiclevip", ["amount"] = 1 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUNGER / THIRST
-----------------------------------------------------------------------------------------------------------------------------------------
ConsumeHunger = 1
ConsumeThirst = 1
CooldownHungerThrist = 90000
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAINTENANCE
-----------------------------------------------------------------------------------------------------------------------------------------
Maintenance = false
MaintenanceText = "O servidor está em modo manutenção, só pessoas autorizadas tem acesso ao servidor."
MaintenanceLicenses = {
	["110000136eb1606"] = true,
	["11000013ec74224"] = true,
	["11000015c09aae8"] = true,
	["110000133b0e1d3"] = true,
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARACTERITENS
-----------------------------------------------------------------------------------------------------------------------------------------
CharacterItens = {
	["water"] = 3,
	["sandwich"] = 5,
	["cellphone"] = 1,
	["dollars"] = 5000
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- GROUPBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
GroupBlips = {
	["Police"] = true,
	["Paramedic"] = true
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLIENTSTATE
-----------------------------------------------------------------------------------------------------------------------------------------
ClientState = {
	["Police"] = true,
	["Mechanic"] = true,
	["Paramedic"] = true
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTCLOTHES
-----------------------------------------------------------------------------------------------------------------------------------------
StartClothes = {
	["mp_m_freemode_01"] = {
		["pants"] = { item = 0, texture = 0 },
		["arms"] = { item = 0, texture = 0 },
		["tshirt"] = { item = 1, texture = 0 },
		["torso"] = { item = 0, texture = 0 },
		["vest"] = { item = 0, texture = 0 },
		["shoes"] = { item = 0, texture = 0 },
		["mask"] = { item = 0, texture = 0 },
		["backpack"] = { item = 0, texture = 0 },
		["hat"] = { item = -1, texture = 0 },
		["glass"] = { item = 0, texture = 0 },
		["ear"] = { item = -1, texture = 0 },
		["watch"] = { item = -1, texture = 0 },
		["bracelet"] = { item = -1, texture = 0 },
		["accessory"] = { item = 0, texture = 0 },
		["decals"] = { item = 0, texture = 0 }
	},
	["mp_f_freemode_01"] = {
		["pants"] = { item = 0, texture = 0 },
		["arms"] = { item = 0, texture = 0 },
		["tshirt"] = { item = 1, texture = 0 },
		["torso"] = { item = 0, texture = 0 },
		["vest"] = { item = 0, texture = 0 },
		["shoes"] = { item = 0, texture = 0 },
		["mask"] = { item = 0, texture = 0 },
		["backpack"] = { item = 0, texture = 0 },
		["hat"] = { item = -1, texture = 0 },
		["glass"] = { item = 0, texture = 0 },
		["ear"] = { item = -1, texture = 0 },
		["watch"] = { item = -1, texture = 0 },
		["bracelet"] = { item = -1, texture = 0 },
		["accessory"] = { item = 0, texture = 0 },
		["decals"] = { item = 0, texture = 0 }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- LANG
-----------------------------------------------------------------------------------------------------------------------------------------
Lang = {
	["Join"] = "Entrando em vanilla...",
	["Connecting"] = "Conectando em vanilla...",
	["Position"] = "Você é o %d/%d da fila, aguarde sua conexão com a vanilla",
	["Error"] = "Conexão perdida com o vanilla."
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- QUEUE
-----------------------------------------------------------------------------------------------------------------------------------------
Queue = {}
Queue["List"] = {}
Queue["Players"] = {}
Queue["Counts"] = 0
Queue["Connecting"] = {}
Queue["Threads"] = 0
Max = 1024