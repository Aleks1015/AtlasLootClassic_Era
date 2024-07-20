if AtlasLoot.IS_SOD == false then return end
-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)
local select = _G.select
local string = _G.string
local format = string.format

-- WoW

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local addonname = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname, 1, AtlasLoot.CLASSIC_VERSION_NUM)

local AL = AtlasLoot.Locales
local ALIL = AtlasLoot.IngameLocales

local GetForVersion = AtlasLoot.ReturnForGameVersion

local NORMAL_DIFF = data:AddDifficulty("NORMAL", nil, nil, nil, true)
local MOLTEN_DIFF = data:AddDifficulty(AL["Molten"], nil, nil, nil,true)
local RAID10_DIFF = data:AddDifficulty("10RAID")
local RAID20_DIFF = data:AddDifficulty("20RAID")
local RAID40_DIFF = data:AddDifficulty("40RAID")

local ALLIANCE_DIFF, HORDE_DIFF, LOAD_DIFF
if UnitFactionGroup("player") == "Horde" then
	HORDE_DIFF = data:AddDifficulty(FACTION_HORDE, "horde", nil, 1)
	ALLIANCE_DIFF = data:AddDifficulty(FACTION_ALLIANCE, "alliance", nil, 1)
	LOAD_DIFF = HORDE_DIFF
else
	ALLIANCE_DIFF = data:AddDifficulty(FACTION_ALLIANCE, "alliance", nil, 1)
	HORDE_DIFF = data:AddDifficulty(FACTION_HORDE, "horde", nil, 1)
	LOAD_DIFF = ALLIANCE_DIFF
end

local NORMAL_ITTYPE = data:AddItemTableType("Item", "Item")
local SET_ITTYPE = data:AddItemTableType("Set", "Item")

local QUEST_EXTRA_ITTYPE = data:AddExtraItemTableType("Quest")
local PRICE_EXTRA_ITTYPE = data:AddExtraItemTableType("Price")

local DUNGEON_CONTENT = data:AddContentType(AL["Dungeons"], ATLASLOOT_DUNGEON_COLOR)
local RAID_CONTENT = data:AddContentType(AL["Leveling Raids"], ATLASLOOT_RAID20_COLOR)
local RAID10_CONTENT = data:AddContentType(AL["10 Raids"], ATLASLOOT_RAID20_COLOR)
local RAID30_CONTENT = data:AddContentType(AL["20-40 Raids"], ATLASLOOT_RAID40_COLOR)
local RAID20_CONTENT = data:AddContentType(AL["20 Raids"], ATLASLOOT_RAID20_COLOR)
local RAID40_CONTENT = data:AddContentType(AL["40 Raids"], ATLASLOOT_RAID40_COLOR)

local ATLAS_MODULE_NAME = "Atlas_ClassicWoW"

local BLUE = "|cff6666ff%s|r"
--local GREY = "|cff999999%s|r"
local GREEN = "|cff66cc33%s|r"
local _RED = "|cffcc6666%s|r"
local PURP = "|cff9900ff%s|r"
local WHIT = "|cffffffff%s|r"

local NAME_COLOR, NAME_COLOR_BOSS = "|cffC0C0C0", "|cffC0C0C0"
local NAME_BRD_RING_OF_LAW = NAME_COLOR_BOSS..AL["Ring of Law"]..":|r %s" -- Tempest Keep

local KEYS = {	-- Keys
	name = AL["Keys"],
	TableType = NORMAL_ITTYPE,
	ExtraList = true,
	IgnoreAsSource = true,
	[NORMAL_DIFF] = {
		{ 1, "INV_Box_01", nil, AL["Key"], nil },
		{ 2, 16309,},
		{ 3, 12344,},
		{ 4, 17191,},
		{ 5, 7146, },
		{ 6, 12382,},
		{ 7, 6893, },
		{ 8, 11000,},
		{ 9, 11140,},
		{ 10, 18249, },
		{ 11, 13704, },
		{ 12, 11197, },
		{ 13, 18266, },
		{ 14, 18268, },
		{ 15, 13873, },
		{ 16, "INV_Box_01", nil, AL["Misc"], nil },
		{ 17, 19931 },
		{ 18, 18250 },
		{ 19, 9240 },
		{ 20, 17333 },
		{ 21, 22754 },
		{ 22, 13523 },
		{ 23, 18746 },
		{ 24, 18663 },
		{ 25, 19974 },
		{ 26, 7733 },
		{ 27, 10818 },
		{ 29, 22057 },
		{ 30, 21986 },
	},
}

local T1_SET = {
	name = format(AL["Tier %s Sets"], "1"),
	ExtraList = true,
	LoadDifficulty = LOAD_DIFF,
	TableType = SET_ITTYPE,
	IgnoreAsSource = true,
	ContentPhase = 4,
	[ALLIANCE_DIFF] = {
		{ 1, 1717 }, -- Warlock
		{ 2, 1718 }, -- Warlock
		{ 4, 1704 }, -- Mage
		{ 5, 1705 }, -- Mage
		{ 7, 1698 }, -- Druid 
		{ 8, 1699 }, -- Druid 
		{ 9, 1700 }, -- Druid 
		{ 10, 1701 }, -- Druid 
		{ 12, 1709}, -- Priest
		{ 13, 1710}, -- Priest
		{ 16, 1719}, -- Warrior
		{ 17, 1720}, -- Warrior
		{ 19, 1711}, -- Rogue
		{ 20, 1712}, -- Rogue
		{ 22, 1702}, -- Hunter
		{ 23, 1703}, -- Hunter
		{ 25, 1706}, -- Paladin
		{ 26, 1707}, -- Paladin
		{ 27, 1708}, -- Paladin
	},

	[HORDE_DIFF] = {
		GetItemsFromDiff = ALLIANCE_DIFF,
		{ 25, 1713}, -- Shaman
		{ 26, 1714}, -- Shaman
		{ 27, 1715}, -- Shaman
		{ 28, 1716}, -- Shaman
	},
}

local T2_SET = {
	name = format(AL["Tier %s Sets"], "2"),
	ExtraList = true,
	LoadDifficulty = LOAD_DIFF,
	TableType = SET_ITTYPE,
	ContentPhase = 5,
	IgnoreAsSource = true,
	[ALLIANCE_DIFF] = {
		{ 1, 212 }, -- Warlock
		{ 3, 211 }, -- Priest
		{ 16, 210 }, -- Mage
		{ 5, 213 }, -- Rogue
		{ 20, 214 }, -- Druid
		{ 7, 215 }, -- Hunter
		{ 9, 218 }, -- Warrior
		{ 24, 217 }, -- Paladin
	},

	[HORDE_DIFF] = {
		GetItemsFromDiff = ALLIANCE_DIFF,
		{ 22, 216 }, -- Shaman
		{ 24 }, -- Paladin
	},
}

local T3_SET = {
	name = format(AL["Tier %s Sets"], "3"),
	ExtraList = true,
	LoadDifficulty = LOAD_DIFF,
	TableType = SET_ITTYPE,
	ContentPhase = 8,
	IgnoreAsSource = true,
	[ALLIANCE_DIFF] = {
		{ 1, 529 }, -- Warlock
		{ 3, 525 }, -- Priest
		{ 16, 526 }, -- Mage
		{ 5, 524 }, -- Rogue
		{ 20, 521 }, -- Druid
		{ 7, 530 }, -- Hunter
		{ 9, 523 }, -- Warrior
		{ 24, 528 }, -- Paladin
	},

	[HORDE_DIFF] = {
		GetItemsFromDiff = ALLIANCE_DIFF,
		{ 22, 527 }, -- Shaman
		{ 24 }, -- Paladin
	},
}

local AQ_SCARABS = { -- AQ40Trash2
	name = AL["Ahn'Qiraj scarabs"],
	ExtraList = true,
	ContentPhase = 7,
	[NORMAL_DIFF] = {
		{ 1,  20876 }, -- Idol of Death
		{ 2,  20879 }, -- Idol of Life
		{ 3,  20875 }, -- Idol of Night
		{ 4,  20878 }, -- Idol of Rebirth
		{ 5,  20881 }, -- Idol of Strife
		{ 6,  20877 }, -- Idol of the Sage
		{ 7,  20874 }, -- Idol of the Sun
		{ 8,  20882 }, -- Idol of War
		{ 10, 21762 }, -- Greater Scarab Coffer Key
		{ 12, 21156 }, -- Scarab Bag
		{ 14, 21230 }, -- Ancient Qiraji Artifact
		{ 16, 20864 }, -- Bone Scarab
		{ 17, 20861 }, -- Bronze Scarab
		{ 18, 20863 }, -- Clay Scarab
		{ 19, 20862 }, -- Crystal Scarab
		{ 20, 20859 }, -- Gold Scarab
		{ 21, 20865 }, -- Ivory Scarab
		{ 22, 20860 }, -- Silver Scarab
		{ 23, 20858 }, -- Stone Scarab
		{ 26, 22203 }, -- Large Obsidian Shard
		{ 27, 22202 }, -- Small Obsidian Shard
		{ 29, 21229 }, -- Qiraji Lord's Insignia
	},
}

local AQ_ENCHANTS = { -- AQEnchants
	name = AL["Ahn'Qiraj enchants"],
	ExtraList = true,
	ContentPhase = 7,
	[NORMAL_DIFF] = {
		{ 1,  20728 }, -- Formula: Enchant Gloves - Frost Power
		{ 2,  20731 }, -- Formula: Enchant Gloves - Superior Agility
		{ 3,  20734 }, -- Formula: Enchant Cloak - Stealth
		{ 4,  20729 }, -- Formula: Enchant Gloves - Fire Power
		{ 5,  20736 }, -- Formula: Enchant Cloak - Dodge
		{ 6,  20730 }, -- Formula: Enchant Gloves - Healing Power
		{ 7,  20727 }, -- Formula: Enchant Gloves - Shadow Power
	},
}

local AQ_OPENING = {	-- Keys
	name = AL["AQ opening"],
	TableType = NORMAL_ITTYPE,
	ExtraList = true,
	ContentPhase = 7,
	IgnoreAsSource = true,
	[NORMAL_DIFF] = {
		{ 1,  21138 }, -- Red Scepter Shard
		{ 2,  21529 }, -- Amulet of Shadow Shielding
		{ 3,  21530 }, -- Onyx Embedded Leggings
		{ 5,  21139 }, -- Green Scepter Shard
		{ 6,  21531 }, -- Drake Tooth Necklace
		{ 7,  21532 }, -- Drudge Boots
		{ 9,  21137 }, -- Blue Scepter Shard
		{ 10, 21517 }, -- Gnomish Turban of Psychic Might
		{ 11, 21527 }, -- Darkwater Robes
		{ 12, 21526 }, -- Band of Icy Depths
		{ 13, 21025 }, -- Recipe: Dirge's Kickin' Chimaerok Chops
		{ 16, 21175 }, -- The Scepter of the Shifting Sands
		{ 17, 21176 }, -- Black Qiraji Resonating Crystal
		{ 18, 21523 }, -- Fang of Korialstrasz
		{ 19, 21521 }, -- Runesword of the Red
		{ 20, 21522 }, -- Shadowsong's Sorrow
		{ 21, 21520 }, -- Ravencrest's Legacy
	},
}

local DM_BOOKS = { -- DMBooks
	name = AL["Books"],
	ExtraList = true,
	IgnoreAsSource = true,
	ContentPhase = 4,
	[NORMAL_DIFF] = {
		{ 1,  228680 }, -- Foror's Compendium of Dragon Slaying
		{ 3,  18362 }, -- Holy Bologna: What the Light Won't Tell You
		{ 4,  228693 }, -- The Arcanist's Cookbook
		{ 5,  18360 }, -- Harnessing Shadows
		{ 6,  228691 }, -- Garona: A Study on Stealth and Treachery
		{ 7,  18364 }, -- The Emerald Dream
		{ 8,  18361 }, -- The Greatest Race of Hunters
		{ 9,  18363 }, -- Frost Shock and You
		{ 10, 228690 }, -- The Light and How to Swing It
		{ 11, 228692 }, -- Codex of Defense
		{ 16, 228679 }, -- Quel'Serrar
		{ 18, 18333 }, -- Libram of Focus
		{ 19, 18334 }, -- Libram of Protection
		{ 20, 18332 }, -- Libram of Rapidity
		{ 22, 11733 }, -- Libram of Constitution
		{ 23, 11736 }, -- Libram of Resilience
		{ 24, 11732 }, -- Libram of Rumination
		{ 25, 11734 }, -- Libram of Tenacity
		{ 26, 11737 }, -- Libram of Voracity
	},
}

data["Ragefire"] = {
	MapID = 2437,
	InstanceID = 389,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "Ragefire",
	AtlasMapFile = "RagefireChasm",
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = GetForVersion({10, 13, 18}, {8, 13, 16}),
	ContentPhase = 1,
	items = {
		{ -- RFCTaragaman
			name = AL["Taragaman the Hungerer"],
			npcID = 11520,
			Level = 16,
			DisplayIDs = {{7970}},
			AtlasMapBossID = 2,
			[NORMAL_DIFF] = {
				{ 1,  14149 }, -- Subterranean Cape
				{ 2,  14148 }, -- Crystalline Cuffs
				{ 3,  14145 }, -- Cursed Felblade
			},
		},
		{ -- RFCJergosh
			name = AL["Jergosh the Invoker"],
			npcID = 11518,
			Level = 16,
			DisplayIDs = {{11429}},
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1,  14150 }, -- Robe of Evocation
				{ 2,  14147 }, -- Cavedweller Bracers
				{ 3,  14151 }, -- Chanting Blade
			},
		},
	},
}

data["WailingCaverns"] = {
	MapID = 718,
	InstanceID = 43,
	SubAreaIDs = { 15285, 15301, 15294, 15300, 15292, 17731 },
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "WailingCaverns",
	AtlasMapFile = {"CL_WailingCaverns", "CL_WailingCavernsEnt"},
	AtlasMapFile_AL = {"WailingCaverns", "WailingCavernsEnt"},
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = GetForVersion({10, 17, 24}, {10, 17, 21}),
	ContentPhase = 1,
	items = {
		{ -- WCLordCobrahn
			name = AL["Lord Cobrahn"],
			npcID = 3669,
			Level = 20,
			SubAreaID = 15300,
			DisplayIDs = {{4213}},
			AtlasMapBossID = 2,
			[NORMAL_DIFF] = {
				{ 1,  6460 }, -- Cobrahn's Grasp
				{ 2,  10410 }, -- Leggings of the Fang
				{ 4,  6465 }, -- Robe of the Moccasin
			},
		},
		{ -- WCLadyAnacondra
			name = AL["Lady Anacondra"],
			npcID = 3671,
			Level = 20,
			DisplayIDs = {{4313}},
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1,  10412 }, -- Belt of the Fang
				{ 3,  5404 }, -- Serpent's Shoulders
				{ 4,  6446 }, -- Snakeskin Bag
			},
		},
		{ -- WCKresh
			name = AL["Kresh"],
			npcID = 3653,
			Level = 20,
			DisplayIDs = {{5126}},
			AtlasMapBossID = 4,
			[NORMAL_DIFF] = {
				{ 1,  13245 }, -- Kresh's Back
				{ 3,  6447 }, -- Worn Turtle Shell Shield
			},
		},
		{ -- WCLordPythas
			name = AL["Lord Pythas"],
			npcID = 3670,
			Level = GetForVersion(21, 20),
			SubAreaID = 17731,
			DisplayIDs = {{4214}},
			AtlasMapBossID = 5,
			[NORMAL_DIFF] = {
				{ 1,  6472 }, -- Stinging Viper
				{ 3,  6473 }, -- Armor of the Fang
			},
		},
		{ -- WCSkum
			name = AL["Skum"],
			npcID = 3674,
			Level = GetForVersion(21, 20),
			DisplayIDs = {{4203}},
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1,  6449 }, -- Glowing Lizardscale Cloak
				{ 3,  6448 }, -- Tail Spike
			},
		},
		{ -- WCLordSerpentis
			name = AL["Lord Serpentis"],
			npcID = 3673,
			Level = GetForVersion(21, 20),
			DisplayIDs = {{4215}},
			AtlasMapBossID = 7,
			[NORMAL_DIFF] = {
				{ 1,  6469 }, -- Venomstrike
				{ 3,  5970 }, -- Serpent Gloves
				{ 4,  10411 }, -- Footpads of the Fang
				{ 5,  6459 }, -- Savage Trodders
			},
		},
		{ -- WCVerdan
			name = AL["Verdan the Everliving"],
			npcID = 5775,
			Level = GetForVersion(21, 20),
			DisplayIDs = {{4256}},
			AtlasMapBossID = 8,
			[NORMAL_DIFF] = {
				{ 1,  6630 }, -- Seedcloud Buckler
				{ 2,  6631 }, -- Living Root
				{ 4,  6629 }, -- Sporid Cape
			},
		},
		{ -- WCMutanus
			name = AL["Mutanus the Devourer"],
			npcID = 3654,
			Level = GetForVersion(22, 20),
			SubAreaID = 15294,
			DisplayIDs = {{4088}},
			AtlasMapBossID = 9,
			[NORMAL_DIFF] = {
				{ 1,  6461 }, -- Slime-encrusted Pads
				{ 2,  6627 }, -- Mutant Scale Breastplate
				{ 3,  6463 }, -- Deep Fathom Ring
				{ 16,  10441 }, -- Glowing Shard
			},
		},
		{ -- WCDeviateFaerieDragon
			name = AL["Deviate Faerie Dragon"],
			npcID = 5912,
			Level = GetForVersion(19, 20),
			DisplayIDs = {{1267}},
			AtlasMapBossID = 10,
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1,  5243 }, -- Firebelcher
				{ 3,  6632 }, -- Feyscale Cloak
			},
		},
		{ -- WCTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  10413 }, -- Gloves of the Fang
			},
		},
	},
}

data["TheDeadmines"] = {
	MapID = 1581,
	InstanceID = 36,
	SubAreaIDs = { 19444, 19529, 19502, 26104 },
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "TheDeadmines",
	AtlasMapFile_AL = {"TheDeadmines", "TheDeadminesEnt"},
	AtlasMapFile = {"CL_TheDeadmines", "CL_TheDeadminesEnt"},
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = GetForVersion({10, 17, 26}, {10, 18, 22}),
	ContentPhase = 1,
	items = {
		{	--DMRhahkZor
			name = AL["Rhahk'Zor"],
			npcID = 644,
			Level = 19,
			DisplayIDs = {{14403}},
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1, 872 },	-- Rockslicer
				{ 3, 5187 },	-- Rhahk'Zor's Hammer
			},
		},
		{	--DMMinerJohnson
			name = AL["Miner Johnson"],
			npcID = 3586,
			Level = 19,
			DisplayIDs = {{556}},
			specialType = "rare",
			AtlasMapBossID = 2,
			[NORMAL_DIFF] = {
				{ 1, 5443 },	-- Gold-plated Buckler
				{ 3, 5444 },	-- Miner's Cape
			},
		},
		{	--DMSneed
			name = AL["Sneed"],
			npcID = 643,
			Level = 20,
			SubAreaID = 19529,
			DisplayIDs = {{7125}},
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1, 5194 },	-- Taskmaster Axe
				{ 3, 5195 },	-- Gold-flecked Gloves
			},
		},
		{	--DMSneedsShredder
			name = AL["Sneed's Shredder"],
			npcID = 642,
			Level = 20,
			DisplayIDs = {{1269}},
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1, 1937 },	-- Buzz Saw
				{ 3, 2169 },	-- Buzzer Blade
			},
		},
		{	--DMGilnid
			name = AL["Gilnid"],
			npcID = 1763,
			Level = 20,
			SubAreaID = 19502,
			DisplayIDs = {{7124}},
			AtlasMapBossID = 4,
			[NORMAL_DIFF] = {
				{ 1, 1156 },	-- Lavishly Jeweled Ring
				{ 3, 5199 },	-- Smelting Pants
			},
		},
		{	--DMMrSmite
			name = AL["Mr. Smite"],
			npcID = 646,
			Level = 20,
			SubAreaID = 26104,
			DisplayIDs = {{2026}},
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1, 7230 },	-- Smite's Mighty Hammer
				{ 3, 5192 },	-- Thief's Blade
				{ 4, 5196 },	-- Smite's Reaver
			},
		},
		{	--DMCaptainGreenskin
			name = AL["Captain Greenskin"],
			npcID = 647,
			Level = 20,
			DisplayIDs = {{7113},{2349},{2347},{5207}},
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1, 5201 },	-- Emberstone Staff
				{ 3, 10403 },	-- Blackened Defias Belt
				{ 4, 5200 },	-- Impaling Harpoon
			},
		},
		{	--DMVanCleef
			name = AL["Edwin VanCleef"],
			npcID = 639,
			Level = GetForVersion(21,20),
			DisplayIDs = {{2029}},
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1, 5193 },	-- Cape of the Brotherhood
				{ 2, 5202 },	-- Corsair's Overshirt
				{ 3, 10399 },	-- Blackened Defias Armor
				{ 4, 5191 },	-- Cruel Barb
				{ 6, 2874 },	-- An Unsent Letter
			},
		},
		{	--DMCookie
			name = AL["Cookie"],
			npcID = 645,
			Level = 20,
			DisplayIDs = {{1305}},
			specialType = "elite",
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1, 5198 },	-- Cookie's Stirring Rod
				{ 3, 5197 },	-- Cookie's Tenderizer
				{ 5, 8490 },	-- Cat Carrier (Siamese)
			},
		},
		{	--DMDefiasGunpowder
			name = AL["Defias Gunpowder"],
			ExtraList = true,
			AtlasMapBossID = 5,
			[NORMAL_DIFF] = {
				{ 1, 5397 },	-- Defias Gunpowder
			},
		},
		{	--DMTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 8492 },	-- Parrot Cage (Green Wing Macaw)
			},
		},
		KEYS,
	}
}

data["ShadowfangKeep"] = {
	MapID = 209,
	InstanceID = 33,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "ShadowfangKeep",
	AtlasMapFile = "CL_ShadowfangKeep",
	AtlasMapFile_AL = "ShadowfangKeep",
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = GetForVersion({11, 22, 30}, {14, 18, 21}),
	ContentPhase = 1,
	items = {
		{ -- SFKRethilgore
			name = AL["Rethilgore"],
			npcID = 3914,
			Level = 20,
			DisplayIDs = {{524}},
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1,  5254 }, -- Rugged Spaulders
			},
		},
		{ -- SFKFelSteed
			name = AL["Fel Steed / Shadow Charger"],
			npcID = {3865, 3864},
			Level = GetForVersion({19, 20}, {18,19}),
			DisplayIDs = {{1952},{1951}},
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1,  6341 }, -- Eerie Stable Lantern
				{ 3,  932 }, -- Fel Steed Saddlebags
			},
		},
		{ -- SFKRazorclawtheButcher
			name = AL["Razorclaw the Butcher"],
			npcID = 3886,
			Level = GetForVersion(22,20),
			DisplayIDs = {{524}},
			AtlasMapBossID = 4,
			[NORMAL_DIFF] = {
				{ 1,  1292 }, -- Butcher's Cleaver
				{ 3,  6226 }, -- Bloody Apron
				{ 4,  6633 }, -- Butcher's Slicer
			},
		},
		{ -- SFKSilverlaine
			name = AL["Baron Silverlaine"],
			npcID = 3887,
			Level = GetForVersion(24,20),
			DisplayIDs = {{3222}},
			AtlasMapBossID = 5,
			[NORMAL_DIFF] = {
				{ 1,  6321 }, -- Silverlaine's Family Seal
				{ 3,  6323 }, -- Baron's Scepter
			},
		},
		{ -- SFKSpringvale
			name = AL["Commander Springvale"],
			npcID = 4278,
			Level = GetForVersion(24,20),
			DisplayIDs = {{3223}},
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1,  6320 }, -- Commander's Crest
				{ 3,  3191 }, -- Arced War Axe
			},
		},
		{ -- SFKOdotheBlindwatcher
			name = AL["Odo the Blindwatcher"],
			npcID = 4279,
			Level = GetForVersion(24,21),
			DisplayIDs = {{522}},
			AtlasMapBossID = 8,
			[NORMAL_DIFF] = {
				{ 1,  6318 }, -- Odo's Ley Staff
				{ 3,  6319 }, -- Girdle of the Blindwatcher
			},
		},
		{ -- SFKDeathswornCaptain
			name = AL["Deathsworn Captain"],
			npcID = 3872,
			Level = GetForVersion(25,21),
			DisplayIDs = {{3224}},
			specialType = "rare",
			AtlasMapBossID = 9,
			[NORMAL_DIFF] = {
				{ 1,  6642 }, -- Phantom Armor
				{ 3,  6641 }, -- Haunting Blade
			},
		},
		{ -- SFKArugalsVoidwalker
			name = AL["Arugal's Voidwalker"],
			npcID = 4627,
			Level = GetForVersion({24, 25}, 20),
			DisplayIDs = {{1131}},
			AtlasMapBossID = 10,
			[NORMAL_DIFF] = {
				{ 1,  5943 }, -- Rift Bracers
			},
		},
		{ -- SFKFenrustheDevourer
			name = AL["Fenrus the Devourer"],
			npcID = 4274,
			Level = GetForVersion(25,21),
			DisplayIDs = {{2352}},
			AtlasMapBossID = 10,
			[NORMAL_DIFF] = {
				{ 1,  6340 }, -- Fenrus' Hide
				{ 2,  3230 }, -- Black Wolf Bracers
			},
		},
		{ -- SFKWolfMasterNandos
			name = AL["Wolf Master Nandos"],
			npcID = 3927,
			Level = GetForVersion(25,21),
			DisplayIDs = {{11179}},
			AtlasMapBossID = 11,
			[NORMAL_DIFF] = {
				{ 1,  3748 }, -- Feline Mantle
				{ 3,  6314 }, -- Wolfmaster Cape
			},
		},
		{ -- SFKArchmageArugal
			name = AL["Archmage Arugal"],
			npcID = 4275,
			Level = GetForVersion(25,21),
			DisplayIDs = {{2353}},
			AtlasMapBossID = 12,
			[NORMAL_DIFF] = {
				{ 1,  6324 }, -- Robes of Arugal
				{ 2,  6392 }, -- Belt of Arugal
				{ 3,  6220 }, -- Meteor Shard
			},
		},
		{ -- SFKTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  2292 }, -- Necrology Robes
				{ 2,  1489 }, -- Gloomshroud Armor
				{ 3,  1974 }, -- Mindthrust Bracers
				{ 4,  2807 }, -- Guillotine Axe
				{ 5,  1482 }, -- Shadowfang
				{ 6,  1935 }, -- Assassin's Blade
				{ 7,  1483 }, -- Face Smasher
				{ 8,  1318 }, -- Night Reaver
				{ 9,  3194 }, -- Black Malice
				{ 10, 2205 }, -- Duskbringer
				{ 11, 1484 }, -- Witching Stave
			},
		},
		{ -- SFKSever
			name = AL["Sever"],
			npcID = 14682,
			DisplayIDs = {{1061}},
			AtlasMapBossID = 7,
			ContentPhase = 6,
			specialType = "scourgeInvasion",
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  23173 }, -- Abomination Skin Leggings
				{ 2,  23171 }, -- The Axe of Severing
			},
		},
		AtlasLoot:GameVersion_GE(AtlasLoot.WRATH_VERSION_NUM, { -- SFKApothecaryH
			name = AL["Apothecary Hummel <Crown Chemical Co.>"],
			npcID = 36296,
			Level = 83,
			DisplayIDs = {{31167}},
			AtlasMapBossID = 3,
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  51804 }, -- Winking Eye of Love
				{ 2,  51805 }, -- Heartbreak Charm
				{ 3,  51806 }, -- Shard of Pirouetting Happiness
				{ 4,  51807 }, -- Sweet Perfume Broach
				{ 5,  51808 }, -- Choker of the Pure Heart
				{ 7,  49641 }, -- Faded Lovely Greeting Card
				{ 8,  49715 }, -- Forever-Lovely Rose
				{ 9,  50250 }, -- X-45 Heartbreaker
				{ 10,  50446 }, -- Toxic Wasteling
				{ 11,  50471 }, -- The Heartbreaker
				{ 12,  50741 }, -- Vile Fumigator's Mask
			},
		}),
		{ -- SFKJordansHammer
			name = AL["Jordan's Smithing Hammer"],
			ExtraList = true,
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1,  6895 }, -- Jordan's Smithing Hammer
			},
		},
		{ -- SFKBookofUr
			name = AL["The Book of Ur"],
			ExtraList = true,
			AtlasMapBossID = 10,
			[NORMAL_DIFF] = {
				{ 1,  6283 }, -- The Book of Ur
			},
		},
	},
}

data["TheStockade"] = {
	MapID = 717,
	InstanceID = 34,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "TheStockade",
	AtlasMapFile = "CL_TheStockade",
	AtlasMapFile_AL = "TheStockade",
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = GetForVersion({15, 24, 32}, {15, 23, 29}),
	ContentPhase = 1,
	items = {
		{ -- SWStKamDeepfury
			name = AL["Kam Deepfury"],
			npcID = 1666,
			Level = GetForVersion(27, 25),
			DisplayIDs = {{825}},
			AtlasMapBossID = 2,
			[NORMAL_DIFF] = {
				{ 1,  2280 }, -- Kam's Walking Stick
			},
		},
		{ -- SWStBruegalIronknuckle
			name = AL["Bruegal Ironknuckle"],
			npcID = 1720,
			Level = GetForVersion(26, 25),
			DisplayIDs = {{2142}},
			AtlasMapBossID = 6,
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1,  3228 }, -- Jimmied Handcuffs
				{ 2,  2941 }, -- Prison Shank
				{ 3,  2942 }, -- Iron Knuckles
			},
		},
		{ -- SWStTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  1076 }, -- Defias Renegade Ring
			},
		},
	},
}

data["RazorfenKraul"] = {
	MapID = 491,
	InstanceID = 47,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "RazorfenKraul",
	AtlasMapFile = "CL_RazorfenKraul",
	AtlasMapFile_AL = "RazorfenKraul",
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = GetForVersion({25, 29, 38},{17, 24, 27}),
	ContentPhase = 1,
	items = {
		{ -- RFKAggem
			name = AL["Aggem Thorncurse"],
			npcID = 4424,
			Level = GetForVersion(30,26),
			DisplayIDs = {{6097}},
			AtlasMapBossID = 2,
			[NORMAL_DIFF] = {
				{ 1,  6681 }, -- Thornspike
			},
		},
		{ -- RFKDeathSpeakerJargba
			name = AL["Death Speaker Jargba"],
			npcID = 4428,
			Level = GetForVersion(30,27),
			DisplayIDs = {{4644}},
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1,  2816 }, -- Death Speaker Scepter
				{ 3,  6685 }, -- Death Speaker Mantle
				{ 4,  6682 }, -- Death Speaker Robes
			},
		},
		{ -- RFKOverlordRamtusk
			name = AL["Overlord Ramtusk"],
			npcID = 4420,
			Level = GetForVersion(32,27),
			DisplayIDs = {{4652}},
			AtlasMapBossID = 4,
			[NORMAL_DIFF] = {
				{ 1,  6687 }, -- Corpsemaker
				{ 3,  6686 }, -- Tusken Helm
			},
		},
		{ -- RFKRazorfenSpearhide
			name = AL["Razorfen Spearhide"],
			npcID = 4438,
			Level = GetForVersion({29, 30},27),
			DisplayIDs = {{6078}},
			AtlasMapBossID = 4,
			[NORMAL_DIFF] = {
				{ 1,  6679 }, -- Armor Piercer
			},
		},
		{ -- RFKAgathelos
			name = AL["Agathelos the Raging"],
			npcID = 4422,
			Level = GetForVersion(33,27),
			DisplayIDs = {{2450}},
			AtlasMapBossID = 5,
			[NORMAL_DIFF] = {
				{ 1,  6691 }, -- Swinetusk Shank
				{ 3,  6690 }, -- Ferine Leggings
			},
		},
		{ -- RFKBlindHunter
			name = AL["Blind Hunter"],
			npcID = 4425,
			Level = GetForVersion(32,27),
			DisplayIDs = {{4735}},
			AtlasMapBossID = 6,
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1,  6695 }, -- Stygian Bone Amulet
				{ 2,  6697 }, -- Batwing Mantle
				{ 3,  6696 }, -- Nightstalker Bow
			},
		},
		{ -- RFKCharlgaRazorflank
			name = AL["Charlga Razorflank"],
			npcID = 4421,
			Level = GetForVersion(33,27),
			DisplayIDs = {{4642}},
			AtlasMapBossID = 7,
			[NORMAL_DIFF] = {
				{ 1,  6693 }, -- Agamaggan's Clutch
				{ 2,  6694 }, -- Heart of Agamaggan
				{ 3,  6692 }, -- Pronged Reaver
				{ 16,  17008 }, -- Small Scroll
			},
		},
		{ -- RFKEarthcallerHalmgar
			name = AL["Earthcaller Halmgar"],
			npcID = 4842,
			Level = GetForVersion(32,27),
			DisplayIDs = {{6102}},
			AtlasMapBossID = 9,
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1,  6689 }, -- Wind Spirit Staff
				{ 3,  6688 }, -- Whisperwind Headdress
			},
		},
		{ -- RFKTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  2264 }, -- Mantle of Thieves
				{ 2,  1488 }, -- Avenger's Armor
				{ 3,  4438 }, -- Pugilist Bracers
				{ 4,  1978 }, -- Wolfclaw Gloves
				{ 5,  2039 }, -- Plains Ring
				{ 6,  1727 }, -- Sword of Decay
				{ 7,  776 }, -- Vendetta
				{ 8,  1976 }, -- Slaghammer
				{ 9,  1975 }, -- Pysan's Old Greatsword
				{ 10, 2549 }, -- Staff of the Shade
			},
		},
	},
}

data["ScarletMonasteryGraveyard"] = {
	MapID = 796,
	InstanceID = 189,
	SubAreaIDs = { 21379, 24000, 23805 },
	name = C_Map.GetAreaInfo(796) .." - ".. AL["Graveyard"],
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "ScarletMonastery",
	AtlasMapFile = {"CL_SMGraveyard", "CL_ScarletMonasteryEnt"},
	AtlasMapFile_AL = {"SMGraveyard", "SMEnt"},
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = GetForVersion({20, 26, 36},{20, 30, 32}),
	ContentPhase = 2,
	items = {
		-- Graveyard
		{ -- SMVishas
			name = AL["Interrogator Vishas"],
			npcID = 3983,
			Level = 32,
			DisplayIDs = {{2044}},
			SubAreaID = 21379,
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1,  7682 }, -- Torturing Poker
				{ 3,  7683 }, -- Bloody Brass Knuckles
			},
		},
		{ -- SMAzshir
			name = AL["Azshir the Sleepless"],
			npcID = 6490,
			Level = GetForVersion(33,32),
			DisplayIDs = {{5534}},
			SubAreaID = 24000,
			AtlasMapBossID = "1'",
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1,  7709 }, -- Blighted Leggings
				{ 2,  217295 }, -- Necrotic Wand
				{ 3,  217296 }, -- Ghostshard Talisman
			},
		},
		{ -- SMFallenChampion
			name = AL["Fallen Champion"],
			npcID = 6488,
			Level = GetForVersion(33,32),
			DisplayIDs = {{5230}},
			specialType = "rare",
			AtlasMapBossID = "1'",
			[NORMAL_DIFF] = {
				{ 1,  217294 }, -- Embalmed Shroud
				{ 2,  7690 }, -- Ebon Vise
				{ 3,  7689 }, -- Morbid Dawn
			},
		},
		{ -- SMIronspine
			name = AL["Ironspine"],
			npcID = 6489,
			Level = GetForVersion(33,32),
			DisplayIDs = {{5231}},
			AtlasMapBossID = "1'",
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1,  7688 }, -- Ironspine's Ribcage
				{ 2,  7687 }, -- Ironspine's Fist
				{ 3,  7686 }, -- Ironspine's Eye
			},
		},
		{ -- SMBloodmageThalnos
			name = AL["Bloodmage Thalnos"],
			npcID = 4543,
			Level = GetForVersion(33,32),
			SubAreaID = 23805,
			DisplayIDs = {{11396}},
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1,  7685 }, -- Orb of the Forgotten Seer
				{ 3,  7684 }, -- Bloodmage Mantle
			},
		},
		{ -- SMGTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  5819 }, -- Sunblaze Coif
				{ 2,  7727 }, -- Watchman Pauldrons
				{ 3,  7728 }, -- Beguiler Robes
				{ 4,  7754 }, -- Harbinger Boots
				{ 5,  10332 }, -- Scarlet Boots
				{ 6,  2262 }, -- Mark of Kern
				{ 7,  7787 }, -- Resplendent Guardian
				{ 8,  7729 }, -- Chesterfall Musket
				{ 9,  7761 }, -- Steelclaw Reaver
				{ 10, 7752 }, -- Dreamslayer
				{ 11, 8226 }, -- The Butcher
				{ 12, 7786 }, -- Headsplitter
				{ 13, 7753 }, -- Bloodspiller
				{ 14, 7730 }, -- Cobalt Crusher
			},
		},
		{ -- SMScorn
			name = AL["Scorn"],
			npcID = 14693,
			DisplayIDs = {{16197}},
			AtlasMapBossID = 1,
			ContentPhase = 6,
			specialType = "scourgeInvasion",
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 23169 }, -- Scorn's Icy Choker
				{ 2, 23170 }, -- The Frozen Clutch
				{ 3, 23168 }, -- Scorn's Focal Dagger
			},
		},
		AtlasLoot:GameVersion_GE(AtlasLoot.WRATH_VERSION_NUM, { -- SMHeadlessHorseman
			name = AL["Headless Horseman"],
			npcID = 23682,
			Level = 83,
			DisplayIDs = {{22351}},
			AtlasMapBossID = nil,
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 211817 }, -- Ring of Ghoulish Glee
				{ 2, 211844 }, -- The Horseman's Seal
				{ 3, 211847 }, -- Wicked Witch's Band
				{ 5, 211850 }, -- The Horseman's Horrific Helm
				{ 6, 211851 }, -- The Horseman's Baleful Blade
				{ 8, 33292 }, -- Hallowed Helm
				{ 10, 34068 }, -- Weighted Jack-o'-Lantern
				{ 12, 33277 }, -- Tome of Thomas Thomson
				{ 16, 37012 }, -- The Horseman's Reins
				{ 18, 33182 }, -- Swift Flying Broom        280% flying
				{ 19, 33176 }, -- Flying Broom              60% flying
				{ 21, 33184 }, -- Swift Magic Broom         100% ground
				{ 22, 37011 }, -- Magic Broom               60% ground
				{ 24, 33154 }, -- Sinister Squashling
			}
		}),
		KEYS,
	},
}

data["ScarletMonasteryLibrary"] = {
	MapID = 796,
	InstanceID = 189,
	SubAreaIDs = { 21426, 21444, 21420 },
	name = C_Map.GetAreaInfo(796) .." - ".. AL["Library"],
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "ScarletMonastery",
	AtlasMapFile = {"CL_SMLibrary", "CL_ScarletMonasteryEnt"},
	AtlasMapFile_AL = {"SMLibrary", "SMEnt"},
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = GetForVersion({20, 29, 39},{20, 33, 35}),
	ContentPhase = 2,
	items = {
		-- Library
		{ -- SMHoundmasterLoksey
			name = AL["Houndmaster Loksey"],
			npcID = 3974,
			Level = 34,
			SubAreaID = 21444,
			DisplayIDs = {{2040}},
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1,  7710 }, -- Loksey's Training Stick
				{ 3,  7756 }, -- Dog Training Gloves
				{ 4,  3456 }, -- Dog Whistle
			},
		},
		{ -- SMDoan
			name = AL["Arcanist Doan"],
			npcID = 6487,
			Level = GetForVersion(37,34),
			SubAreaID = 21420,
			DisplayIDs = {{5266}},
			AtlasMapBossID = 2,
			[NORMAL_DIFF] = {
				{ 1,  7714 }, -- Hypnotic Blade
				{ 2,  217299 }, -- Illusionary Rod
				{ 4,  217298 }, -- Mantle of Doan
				{ 5,  217297 }, -- Robe of Doan
			},
		},
		{ -- SMLTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  5819 }, -- Sunblaze Coif
				{ 2,  7755 }, -- Flintrock Shoulders
				{ 3,  7727 }, -- Watchman Pauldrons
				{ 4,  7728 }, -- Beguiler Robes
				{ 5,  7759 }, -- Archon Chestpiece
				{ 6,  7760 }, -- Warchief Kilt
				{ 7,  7754 }, -- Harbinger Boots
				{ 8,  10332 }, -- Scarlet Boots
				{ 9,  1992 }, -- Swampchill Fetish
				{ 10, 2262 }, -- Mark of Kern
				{ 11, 7787 }, -- Resplendent Guardian
				{ 12, 7729 }, -- Chesterfall Musket
				{ 13, 7761 }, -- Steelclaw Reaver
				{ 14, 7752 }, -- Dreamslayer
				{ 15, 8226 }, -- The Butcher
				{ 16, 7786 }, -- Headsplitter
				{ 17, 5756 }, -- Sliverblade
				{ 18, 7736 }, -- Fight Club
				{ 19, 8225 }, -- Tainted Pierce
				{ 20, 7753 }, -- Bloodspiller
				{ 21, 7730 }, -- Cobalt Crusher
				{ 22, 7758 }, -- Ruthless Shiv
				{ 23, 7757 }, -- Windweaver Staff
			},
		},
		{
			name = AL["Doan's Strongbox"],
			ExtraList = true,
			AtlasMapBossID = "1'",
			[NORMAL_DIFF] = {
				{ 1,  7146 }, -- The Scarlet Key
			},
		},
		KEYS,
	},
}

data["ScarletMonasteryArmory"] = {
	MapID = 796,
	InstanceID = 189,
	SubAreaIDs = { 21460, 21455, 21448, 21457 },
	name = C_Map.GetAreaInfo(796) .." - ".. AL["Armory"],
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "ScarletMonastery",
	AtlasMapFile = {"CL_SMArmory", "CL_ScarletMonasteryEnt"},
	AtlasMapFile_AL = {"SMArmory", "SMEnt"},
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = GetForVersion({20, 32, 42},{20, 35, 37}),
	ContentPhase = 2,
	items = {
		-- Armory
		{ -- SMHerod
			name = AL["Herod"],
			npcID = 3975,
			Level = GetForVersion(40,37),
			SubAreaID = 21448,
			DisplayIDs = {{2041}},
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1,  7719 }, -- Raging Berserker's Helm
				{ 2,  7718 }, -- Herod's Shoulder
				{ 3,  10330 }, -- Scarlet Leggings
				{ 4,  7717 }, -- Ravager
			},
		},
		{ -- SMATrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  5819 }, -- Sunblaze Coif
				{ 2,  7755 }, -- Flintrock Shoulders
				{ 3,  7727 }, -- Watchman Pauldrons
				{ 4,  7728 }, -- Beguiler Robes
				{ 5,  7759 }, -- Archon Chestpiece
				{ 6,  7754 }, -- Harbinger Boots
				{ 7,  10332 }, -- Scarlet Boots
				{ 8,  1992 }, -- Swampchill Fetish
				{ 9,  2262 }, -- Mark of Kern
				{ 10, 7787 }, -- Resplendent Guardian
				{ 11, 7729 }, -- Chesterfall Musket
				{ 12, 7761 }, -- Steelclaw Reaver
				{ 13, 7752 }, -- Dreamslayer
				{ 14, 8226 }, -- The Butcher
				{ 15, 7786 }, -- Headsplitter
				{ 16, 5756 }, -- Sliverblade
				{ 17, 7736 }, -- Fight Club
				{ 18, 8225 }, -- Tainted Pierce
				{ 19, 7753 }, -- Bloodspiller
				{ 20, 7730 }, -- Cobalt Crusher
				{ 21, 7757 }, -- Windweaver Staff
				{ 23, 10333 }, -- Scarlet Wristguards
				{ 24, 10329 }, -- Scarlet Belt
				{ 26, 23192 }, -- Tabard of the Scarlet Crusade
			},
		},
		KEYS,
	},
}

data["ScarletMonasteryCathedral"] = {
	MapID = 796,
	InstanceID = 189,
	SubAreaIDs = { 21401, 21410 },
	name = C_Map.GetAreaInfo(796) .." - ".. AL["Cathedral"],
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "ScarletMonastery",
	AtlasMapFile = {"CL_SMCathedral", "CL_ScarletMonasteryEnt"},
	AtlasMapFile_AL = {"SMCathedral", "SMEnt"},
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = GetForVersion({20, 35, 45},{20, 36, 40}),
	ContentPhase = 2,
	items = {
		-- Cathedral
		{ -- SMFairbanks
			name = AL["High Inquisitor Fairbanks"],
			npcID = 4542,
			Level = 40,
			DisplayIDs = {{2605}},
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1,  19507 }, -- Inquisitor's Shawl
				{ 2,  19508 }, -- Branded Leather Bracers
				{ 3,  19509 }, -- Dusty Mail Boots
			},
		},
		{ -- SMMograine
			name = AL["Scarlet Commander Mograine"],
			npcID = 3976,
			Level = GetForVersion(42,40),
			DisplayIDs = {{2042}},
			AtlasMapBossID = 2,
			[NORMAL_DIFF] = {
				{ 1,  7724 }, -- Gauntlets of Divinity
				{ 2,  10330 }, -- Scarlet Leggings
				{ 3,  7726 }, -- Aegis of the Scarlet Commander
				{ 4,  217302 }, -- Mograine's Might
			},
		},
		{ -- SMWhitemane
			name = AL["High Inquisitor Whitemane"],
			npcID = 3977,
			Level = GetForVersion(42,40),
			DisplayIDs = {{2043}},
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1,  217300 }, -- Whitemane's Chapeau
				{ 2,  217301 }, -- Triune Amulet
				{ 3,  7721 }, -- Hand of Righteousness
			},
		},
		{ -- SMCTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  5819 }, -- Sunblaze Coif
				{ 2,  7755 }, -- Flintrock Shoulders
				{ 3,  7727 }, -- Watchman Pauldrons
				{ 4,  7728 }, -- Beguiler Robes
				{ 5,  7759 }, -- Archon Chestpiece
				{ 6,  7760 }, -- Warchief Kilt
				{ 7,  7754 }, -- Harbinger Boots
				{ 8,  10332 }, -- Scarlet Boots
				{ 9,  1992 }, -- Swampchill Fetish
				{ 10, 2262 }, -- Mark of Kern
				{ 11, 7787 }, -- Resplendent Guardian
				{ 12, 7729 }, -- Chesterfall Musket
				{ 13, 7761 }, -- Steelclaw Reaver
				{ 14, 7752 }, -- Dreamslayer
				{ 15, 8226 }, -- The Butcher
				{ 16, 7786 }, -- Headsplitter
				{ 17, 5756 }, -- Sliverblade
				{ 18, 7736 }, -- Fight Club
				{ 19, 8225 }, -- Tainted Pierce
				{ 20, 7753 }, -- Bloodspiller
				{ 21, 7730 }, -- Cobalt Crusher
				{ 22, 7758 }, -- Ruthless Shiv
				{ 23, 7757 }, -- Windweaver Staff
				{ 25, 10328 }, -- Scarlet Chestpiece
				{ 26, 10331 }, -- Scarlet Gauntlets
				{ 27, 10329 }, -- Scarlet Belt
			},
		},
		KEYS,
	},
}

data["RazorfenDowns"] = {
	MapID = 722,
	InstanceID = 129,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "RazorfenDowns",
	AtlasMapFile = "CL_RazorfenDowns",
	AtlasMapFile_AL = "RazorfenDowns",
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = GetForVersion({35, 37, 46},{25, 34, 37}),
	ContentPhase = 2,
	items = {
		{ -- RFDTutenkash
			name = AL["Tuten'kash"],
			npcID = 7355,
			Level = GetForVersion(40,37),
			DisplayIDs = {{7845}},
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1,  217293 }, -- Silky Spider Cape
				{ 2,  10775 }, -- Carapace of Tuten'kash
				{ 3,  10777 }, -- Arachnid Gloves
			},
		},
		{ -- RFDMordreshFireEye
			name = AL["Mordresh Fire Eye"],
			npcID = 7357,
			Level = GetForVersion(39,37),
			DisplayIDs = {{8055}},
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1,  217290 }, -- Glowing Eye of Mordresh
				{ 2,  217292 }, -- Deathmage Sash
				{ 3,  217291 }, -- Mordresh's Lifeless Skull
			},
		},
		{ -- RFDGlutton
			name = AL["Glutton"],
			npcID = 8567,
			Level = GetForVersion(40,37),
			DisplayIDs = {{7864}},
			AtlasMapBossID = 4,
			[NORMAL_DIFF] = {
				{ 1,  10774 }, -- Fleshhide Shoulders
				{ 3,  10772 }, -- Glutton's Cleaver
			},
		},
		{ -- RFDRagglesnout
			name = AL["Ragglesnout"],
			npcID = 7354,
			Level = GetForVersion(40,37),
			DisplayIDs = {{11382}},
			AtlasMapBossID = 5,
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1,  10768 }, -- Boar Champion's Belt
				{ 2,  10767 }, -- Savage Boar's Guard
				{ 3,  10758 }, -- X'caliboar
			},
		},
		{ -- RFDAmnennar
			name = AL["Amnennar the Coldbringer"],
			npcID = 7358,
			Level = GetForVersion(41,37),
			DisplayIDs = {{7971}},
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1,  10763 }, -- Icemetal Barbute
				{ 2,  217288 }, -- Robes of the Lich
				{ 3,  217289 }, -- Deathchill Armor
				{ 4,  10761 }, -- Coldrage Dagger
				{ 6,  10765 }, -- Bonefingers
			},
		},
		{ -- RFDPlaguemaw
			name = AL["Plaguemaw the Rotting"],
			npcID = 7356,
			Level = GetForVersion(40,37),
			DisplayIDs = {{6124}},
			AtlasMapBossID = 7,
			[NORMAL_DIFF] = {
				{ 1,  10766 }, -- Plaguerot Sprig
				{ 3,  10760 }, -- Swine Fists
			},
		},

		{ -- RFDTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  10574 }, -- Corpseshroud
				{ 2,  10581 }, -- Death's Head Vestment
				{ 3,  10583 }, -- Quillward Harness
				{ 4,  10584 }, -- Stormgale Fists
				{ 5,  10578 }, -- Thoughtcast Boots
				{ 6,  10582 }, -- Briar Tredders
				{ 7,  10572 }, -- Freezing Shard
				{ 8,  10567 }, -- Quillshooter
				{ 9,  10571 }, -- Ebony Boneclub
				{ 10, 10570 }, -- Manslayer
				{ 11, 10573 }, -- Boneslasher
			},
		},
		{ -- RFDLadyF
			name = AL["Lady Falther'ess"],
			npcID = 14686,
			DisplayIDs = {{10698}},
			AtlasMapBossID = 2,
			ContentPhase = 6,
			specialType = "scourgeInvasion",
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  23178 }, -- Mantle of Lady Falther'ess
				{ 2,  23177 }, -- Lady Falther'ess' Finger
			},
		},
		{ -- RFDHenryStern
			name = AL["Henry Stern"],
			npcID = 8696,
			DisplayIDs = {{8029}},
			AtlasMapBossID = 2,
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  3826 }, -- Mighty Troll's Blood Potion
				{ 2,  10841 }, -- Goldthorn Tea
			},
		},
	},
}

data["Uldaman"] = {
	MapID = 1337, -- just no...
	InstanceID = 70,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "Uldaman",
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	AtlasMapFile = {"CL_Uldaman", "CL_UldamanEnt"},
	AtlasMapFile_AL = {"Uldaman", "UldamanEnt"},
	LevelRange = GetForVersion({30, 41, 51},{30, 36, 40}),
	ContentPhase = 2,
	items = {
		{ -- UldEric
			name = AL["Eric \"The Swift\""],
			npcID = 6907,
			Level = GetForVersion(40,39),
			DisplayIDs = {{5708}},
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1,  9394 }, -- Horned Viking Helmet
				{ 3,  9398 }, -- Worn Running Boots
				{ 5,  2459 }, -- Swiftness Potion
			},
		},
		{ -- UldBaelog
			name = AL["Baelog"],
			npcID = 6906,
			Level = GetForVersion(41,39),
			DisplayIDs = {{5710}},
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1,  9401 }, -- Nordic Longshank
				{ 3,  9399 }, -- Precision Arrow
				{ 5,  9400 }, -- Baelog's Shortbow
			},
		},
		{ -- UldOlaf
			name = AL["Olaf"],
			npcID = 6908,
			Level = GetForVersion(40,39),
			DisplayIDs = {{5709}},
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1,  9404 }, -- Olaf's All Purpose Shield
				{ 3,  9403 }, -- Battered Viking Shield
				{ 4,  1177 }, -- Oil of Olaf
			},
		},
		{ -- UldRevelosh
			name = AL["Revelosh"],
			npcID = 6910,
			Level = GetForVersion(40,39),
			DisplayIDs = {{5945}},
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1,  217307 }, -- Revelosh's Spaulders
				{ 2,  217305 }, -- Revelosh's Armguards
				{ 3,  217304 }, -- Revelosh's Gloves
				{ 4,  217306 }, -- Revelosh's Boots
				{ 6,  7741 }, -- The Shaft of Tsol
			},
		},
		{ -- UldIronaya
			name = AL["Ironaya"],
			npcID = 7228,
			Level = GetForVersion(40,39),
			DisplayIDs = {{6089}},
			AtlasMapBossID = 4,
			[NORMAL_DIFF] = {
				{ 1,  9409 }, -- Ironaya's Bracers
				{ 2,  217303 }, -- Stoneweaver Leggings
				{ 3,  217704 }, -- Ironshod Bludgeon
			},
		},
		{ -- UldObsidianSentinel
			name = AL["Obsidian Sentinel"],
			npcID = 7023,
			Level = GetForVersion(42,40),
			DisplayIDs = {{5285}},
			AtlasMapBossID = 5,
			[NORMAL_DIFF] = {
				{ 1,  8053 }, -- Obsidian Power Source
			},
		},
		{ -- UldAncientStoneKeeper
			name = AL["Ancient Stone Keeper"],
			npcID = 7206,
			Level = GetForVersion(44,40),
			DisplayIDs = {{10798}},
			AtlasMapBossID = 7,
			[NORMAL_DIFF] = {
				{ 1,  9410 }, -- Cragfists
				{ 3,  9411 }, -- Rockshard Pauldrons
			},
		},
		{ -- UldGalgannFirehammer
			name = AL["Galgann Firehammer"],
			npcID = 7291,
			Level = GetForVersion(45,40),
			DisplayIDs = {{6059}},
			AtlasMapBossID = 8,
			[NORMAL_DIFF] = {
				{ 1,  11310 }, -- Flameseer Mantle
				{ 2,  9412 }, -- Galgann's Fireblaster
				{ 4,  11311 }, -- Emberscale Cape
				{ 5,  9419 }, -- Galgann's Firehammer
			},
		},
		{ -- UldGrimlok
			name = AL["Grimlok"],
			npcID = 4854,
			Level = GetForVersion(45,40),
			DisplayIDs = {{11165}},
			AtlasMapBossID = 9,
			[NORMAL_DIFF] = {
				{ 1,  223535 }, -- Grimlok's Tribal Vestments
				{ 2,  223536 }, -- Grimlok's Charge
				{ 3,  9414 }, -- Oilskin Leggings
				{ 5, 7670 }, -- Shattered Necklace Sapphire
			},
		},
		{ -- UldArchaedas
			name = AL["Archaedas"],
			npcID = 2748,
			Level = GetForVersion(47,40),
			DisplayIDs = {{5988}},
			AtlasMapBossID = 10,
			[NORMAL_DIFF] = {
				{ 1,  11118 }, -- Archaedic Stone
				{ 2,  9413 }, -- The Rockpounder
				{ 3,  9418 }, -- Stoneslayer
			},
		},
		{ -- UldTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  9431 }, -- Papal Fez
				{ 2,  9429 }, -- Miner's Hat of the Deep
				{ 3,  9420 }, -- Adventurer's Pith Helmet
				{ 4,  9430 }, -- Spaulders of a Lost Age
				{ 5,  9397 }, -- Energy Cloak
				{ 6,  9406 }, -- Spirewind Fetter
				{ 7,  9428 }, -- Unearthed Bands
				{ 8,  223537 }, -- Skullplate Bracers
				{ 9,  9396 }, -- Legguards of the Vault
				{ 10, 9393 }, -- Beacon of Hope
				{ 12, 7666 }, -- Shattered Necklace
				{ 16, 9381 }, -- Earthen Rod
				{ 17, 9426 }, -- Monolithic Bow
				{ 18, 9422 }, -- Shadowforge Bushmaster
				{ 19, 9465 }, -- Digmaster 5000
				{ 20, 9384 }, -- Stonevault Shiv
				{ 21, 9386 }, -- Excavator's Brand
				{ 22, 9427 }, -- Stonevault Bonebreaker
				{ 23, 9392 }, -- Annealed Blade
				{ 24, 9424 }, -- Ginn-su Sword
				{ 25, 9383 }, -- Obsidian Cleaver
				{ 26, 9425 }, -- Pendulum of Doom
				{ 27, 9423 }, -- The Jackhammer
				{ 28, 9391 }, -- The Shoveler
			},
		},
		{ -- UldBaelogsChest
			name = AL["Baelog's Chest"],
			ExtraList = true,
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1,  7740 }, -- Gni'kiv Medallion
			},
		},
		{ -- UldConspicuousUrn
			name = AL["Conspicuous Urn"],
			ExtraList = true,
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1,  7671 }, -- Shattered Necklace Topaz
			},
		},
		{ -- UldShadowforgeCache
			name = AL["Shadowforge Cache"],
			ExtraList = true,
			AtlasMapBossID = 8,
			[NORMAL_DIFF] = {
				{ 1,  7669 }, -- Shattered Necklace Ruby
			},
		},
		{ -- UldTabletofWill
			name = AL["Tablet of Will"],
			ExtraList = true,
			AtlasMapBossID = 8,
			[NORMAL_DIFF] = {
				{ 1,  5824 }, -- Tablet of Will
			},
		},
	},
}

data["Zul'Farrak"] = {
	MapID = 1176,
	InstanceID = 209,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "Zul'Farrak",
	AtlasMapFile = "CL_ZulFarrak",
	AtlasMapFile_AL = "ZulFarrak",
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = GetForVersion({39, 44, 54},{35, 42, 46}),
	ContentPhase = 3,
	items = {
		{ -- ZFAntusul
			name = AL["Antu'sul"],
			npcID = 8127,
			Level = GetForVersion(48,46),
			DisplayIDs = {{7353}},
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1,  9640 }, -- Vice Grips
				{ 2,  223532 }, -- Lifeblood Amulet
				{ 3,  9639 }, -- The Hand of Antu'sul
				{ 5,  9379 }, -- Sang'thraze the Deflector
			},
		},
		{ -- ZFThekatheMartyr
			name = AL["Theka the Martyr"],
			npcID = 7272,
			Level = GetForVersion({45, 46},46),
			DisplayIDs = {{6696}},
			AtlasMapBossID = 2,
			specialType = "quest",
			[NORMAL_DIFF] = {
				{ 1,  10660 }, -- First Mosh'aru Tablet
			},
		},
		{ -- ZFSandarrDunereaver
			name = AL["Sandarr Dunereaver"],
			npcID = 10080,
			Level = 45,
			DisplayIDs = {{9291}},
			IgnoreAsSource = true,
			--AtlasMapBossID = 2,
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1,  9523, [ATLASLOOT_IT_AMOUNT1] = "2-4" }, -- First Mosh'aru Tablet
			},
		},
		{ -- ZFWitchDoctorZumrah
			name = AL["Witch Doctor Zum'rah"],
			npcID = 7271,
			Level = 46,
			DisplayIDs = {{6434}},
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1,  223534 }, -- Jumanza Grips
				{ 2,  18082 }, -- Zum'rah's Vexing Cane
			},
		},
		{ -- ZFNekrumGutchewer
			name = AL["Nekrum Gutchewer"],
			npcID = 7796,
			Level = GetForVersion({45, 46},45),
			DisplayIDs = {{6690}},
			AtlasMapBossID = 4,
			specialType = "quest",
			[NORMAL_DIFF] = {
				{ 1,  9471 }, -- Nekrum's Medallion
			},
		},
		{ -- ZFSezzziz
			name = AL["Shadowpriest Sezz'ziz"],
			npcID = 7275,
			Level = GetForVersion(47,46),
			DisplayIDs = {{6441}},
			AtlasMapBossID = 4,
			[NORMAL_DIFF] = {
				{ 1,  9470 }, -- Bad Mojo Mask
				{ 2,  223529 }, -- Jinxed Hoodoo Skin
				{ 3,  223530 }, -- Jinxed Hoodoo Kilt
				{ 4,  9475 }, -- Diabolic Skiver
			},
		},
		{ -- ZFDustwraith
			name = AL["Dustwraith"],
			npcID = 10081,
			Level = GetForVersion(47,46),
			DisplayIDs = {{9292}},
			AtlasMapBossID = 4,
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1,  223533 }, -- Desertwalker Cane
			},
		},
		{ -- ZFSandfury
			name = AL["Sandfury Executioner"],
			npcID = 7274,
			Level = 46,
			DisplayIDs = {{6440}},
			AtlasMapBossID = 5,
			[NORMAL_DIFF] = {
				{ 1,  8444 }, -- Executioner's Key
			},
		},
		{ -- ZFSergeantBly
			name = AL["Sergeant Bly"],
			npcID = 7604,
			Level = 45,
			DisplayIDs = {{6433}},
			AtlasMapBossID = 5,
			specialType = "quest",
			[NORMAL_DIFF] = {
				{ 1,  8548 }, -- Divino-matic Rod
			},
		},
		{ -- ZFHydromancerVelratha
			name = AL["Hydromancer Velratha"],
			npcID = 7795,
			Level = 46,
			DisplayIDs = {{6685}},
			AtlasMapBossID = 6,
			specialType = "quest",
			[NORMAL_DIFF] = {
				{ 1,  9234 }, -- Tiara of the Deep
				{ 2,  10661 }, -- Second Mosh'aru Tablet
			},
		},
		{ -- ZFGahzrilla
			name = AL["Gahz'rilla"],
			npcID = 7273,
			Level = 46,
			DisplayIDs = {{7271}},
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1,  223528 }, -- Gahz'rilla Scale Armor
				{ 3,  223527 }, -- Gahz'rilla Fang
			},
		},
		{ -- ZFChiefUkorzSandscalp
			name = AL["Chief Ukorz Sandscalp"],
			npcID = 7267,
			Level = GetForVersion(48,46),
			DisplayIDs = {{6439}},
			AtlasMapBossID = 7,
			[NORMAL_DIFF] = {
				{ 1,  223963 }, -- Embrace of the Lycan
				{ 2,  223531 }, -- Big Bad Pauldrons
				{ 3,  9478 }, -- Ripsaw
				{ 4,  9477 }, -- The Chief's Enforcer
				{ 6,  11086 }, -- Jang'thraze the Protector
			},
		},
		{ -- ZFZerillis
			name = AL["Zerillis"],
			npcID = 10082,
			Level = 45,
			DisplayIDs = {{9293}},
			AtlasMapBossID = 8,
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1,  223962 }, -- Sandstalker Ankleguards
			},
		},
		{ -- ZFTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  9512 }, -- Blackmetal Cape
				{ 2,  9484 }, -- Spellshock Leggings
				{ 3,  862 }, -- Runed Ring
				{ 4,  6440 }, -- Brainlash
				{ 5,  9483 }, -- Flaming Incinerator
				{ 6,  2040 }, -- Troll Protector
				{ 7,  5616 }, -- Gutwrencher
				{ 8,  9511 }, -- Bloodletter Scalpel
				{ 9,  9481 }, -- The Minotaur
				{ 10, 9480 }, -- Eyegouger
				{ 11, 9482 }, -- Witch Doctor's Cane
				{ 13, 9243 }, -- Shriveled Heart
			},
		},
	},
}

data["Maraudon"] = {
	MapID = 2100,
	InstanceID = 349,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "Maraudon",
	AtlasMapFile = {"CL_Maraudon", "CL_MaraudonEnt"},
	AtlasMapFile_AL = {"Maraudon", "MaraudonEnt"},
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = GetForVersion({25, 46, 55},{30, 43, 48}),
	ContentPhase = 3,
	items = {
		{ -- MaraKhanVeng
			name = AL["Veng"],
			npcID = 13738,
			DisplayIDs = {{9418}},
			AtlasMapBossID = 1,
			specialType = "quest",
			[NORMAL_DIFF] = {
				{ 1,  17765 }, -- Gem of the Fifth Khan
			},
		},
		{ -- MaraNoxxion
			name = AL["Noxxion"],
			npcID = 13282,
			Level = GetForVersion(48,46),
			DisplayIDs = {{11172}},
			AtlasMapBossID = 2,
			[NORMAL_DIFF] = {
				{ 1,  17746 }, -- Noxxion's Shackles
				{ 2,  17744 }, -- Heart of Noxxion
				{ 3,  17745 }, -- Noxious Shooter
			},
		},
		{ -- MaraRazorlash
			name = AL["Razorlash"],
			npcID = 12258,
			Level = GetForVersion(48,46),
			DisplayIDs = {{12389}},
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1,  17749 }, -- Phytoskin Spaulders
				{ 2,  223543 }, -- Vinerot Sandals
				{ 4,  17750 }, -- Chloromesh Girdle
				{ 5,  17751 }, -- Brusslehide Leggings
			},
		},
		{ -- MaraKhanMaraudos
			name = AL["Maraudos"],
			npcID = 13739,
			DisplayIDs = {{9441}},
			AtlasMapBossID = 4,
			specialType = "quest",
			[NORMAL_DIFF] = {
				{ 1,  17764 }, -- Gem of the Fourth Khan
			},
		},
		{ -- MaraLordVyletongue
			name = AL["Lord Vyletongue"],
			npcID = 12236,
			Level = GetForVersion(47,44),
			DisplayIDs = {{12334}},
			AtlasMapBossID = 5,
			[NORMAL_DIFF] = {
				{ 1,  17755 }, -- Satyrmane Sash
				{ 2,  17754 }, -- Infernal Trickster Leggings
				{ 3,  17752 }, -- Satyr's Lash
			},
		},
		{ -- MaraMeshlok
			name = AL["Meshlok the Harvester"],
			npcID = 12237,
			Level = 48,
			DisplayIDs = {{9014}},
			AtlasMapBossID = 6,
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1,  17767 }, -- Bloomsprout Headpiece
				{ 2,  17741 }, -- Nature's Embrace
				{ 3,  17742 }, -- Fungus Shroud Armor
			},
		},
		{ -- MaraCelebras
			name = AL["Celebras the Cursed"],
			npcID = 12225,
			Level = GetForVersion(49,46),
			DisplayIDs = {{12350}},
			AtlasMapBossID = 7,
			[NORMAL_DIFF] = {
				{ 1,  223525 }, -- Soothsayer's Headdress
				{ 2,  17739 }, -- Grovekeeper's Drape
				{ 3,  17738 }, -- Claw of Celebras
			},
		},
		{ -- MaraLandslide
			name = AL["Landslide"],
			npcID = 12203,
			Level = GetForVersion(50,48),
			DisplayIDs = {{12293}},
			AtlasMapBossID = 8,
			[NORMAL_DIFF] = {
				{ 1,  223522 }, -- Helm of the Mountain
				{ 2,  17736 }, -- Rockgrip Gauntlets
				{ 3,  223523 }, -- Cloud Stone
				{ 4,  223524 }, -- Fist of Stone
			},
		},
		{ -- MaraTinkererGizlock
			name = AL["Tinkerer Gizlock"],
			npcID = 13601,
			Level = GetForVersion(50,48),
			DisplayIDs = {{7125}},
			AtlasMapBossID = 9,
			[NORMAL_DIFF] = {
				{ 1,  223545 }, -- Gizlock's Hypertech Buckler
				{ 2,  223542 }, -- Megashot Rifle
				{ 3,  223520 }, -- Inventor's Focal Sword
			},
		},
		{ -- MaraRotgrip
			name = AL["Rotgrip"],
			npcID = 13596,
			Level = GetForVersion(50,48),
			DisplayIDs = {{13589}},
			AtlasMapBossID = 10,
			[NORMAL_DIFF] = {
				{ 1,  223521 }, -- Rotgrip Mantle
				{ 2,  17728 }, -- Albino Crocscale Boots
				{ 3,  17730 }, -- Gatorbite Axe
			},
		},
		{ -- MaraPrincessTheradras
			name = AL["Princess Theradras"],
			npcID = 12201,
			Level = GetForVersion(51,48),
			DisplayIDs = {{12292}},
			AtlasMapBossID = 11,
			[NORMAL_DIFF] = {
				{ 1,  223964 }, -- Blade of Eternal Darkness
				{ 3,  223519 }, -- Eye of Theradras
				{ 4,  223541 }, -- Gemshard Heart
				{ 5,  17714 }, -- Bracers of the Stone Princess
				{ 6,  17711 }, -- Elemental Rockridge Leggings
				{ 7,  17713 }, -- Blackstone Ring
				{ 8,  223518 }, -- Charstone Dirk
				{ 9,  221780 }, -- Princess Theradras' Scepter
			},
		},
		{ -- MaraNamelesProphet
			name = AL["The Nameless Prophet"],
			npcID = 13718,
			DisplayIDs = {{9426}},
			AtlasMapFile = "CL_MaraudonEnt",
			AtlasMapFile_AL = "MaraudonEnt",
			AtlasMapBossID = "*A",
			ExtraList = true,
			specialType = "quest",
			[NORMAL_DIFF] = {
				{ 1,  17757 }, -- Amulet of Spirits
			},
		},
		{ -- MaraKhanKolk
			name = AL["Kolk"],
			npcID = 13742,
			DisplayIDs = {{4860}},
			AtlasMapFile = "CL_MaraudonEnt",
			AtlasMapFile_AL = "MaraudonEnt",
			AtlasMapBossID = "*1",
			ExtraList = true,
			specialType = "quest",
			[NORMAL_DIFF] = {
				{ 1,  17761 }, -- Gem of the First Khan
			},
		},
		{ -- MaraKhanGelk
			name = AL["Gelk"],
			npcID = 13741,
			DisplayIDs = {{9427}},
			AtlasMapFile = "CL_MaraudonEnt",
			AtlasMapFile_AL = "MaraudonEnt",
			AtlasMapBossID = "*2",
			ExtraList = true,
			specialType = "quest",
			[NORMAL_DIFF] = {
				{ 1,  17762 }, -- Gem of the Second Khan
			},
		},
		{ -- MaraKhanMagra
			name = AL["Magra"],
			npcID = 13740,
			DisplayIDs = {{9433}},
			AtlasMapFile = "CL_MaraudonEnt",
			AtlasMapFile_AL = "MaraudonEnt",
			AtlasMapBossID = "*3",
			ExtraList = true,
			specialType = "quest",
			[NORMAL_DIFF] = {
				{ 1,  17763 }, -- Gem of the Third Khan
			},
		},
	},
}

data["BlackrockDepths"] = {
	MapID = 1584,
	InstanceID = 230,
	SubAreaIDs = { 26758, 26761, 26747, 26733, 26755, 26740, 26751, 26759, 26735, 26769, 26768, 26766, 26781, 26765, 26764, 26742, 26750, 26745, 26784, 26749 },
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "BlackrockDepths",
	AtlasMapFile = {"CL_BlackrockDepths", "CL_BlackrockMountainEnt"},
	AtlasMapFile_AL = {"BlackrockDepths", "BlackrockMountainEnt"},
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = GetForVersion({42, 52, 60},{40, 48, 56}),
	ContentPhase = 3,
	items = {
		{ -- BRDLordRoccor
			name = AL["Lord Roccor"],
			npcID = 9025,
			Level = 51,
			SubAreaID = 26735,
			DisplayIDs = {{5781}},
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1,  22234 }, -- Mantle of Lost Hope
				{ 2,  11632 }, -- Earthslag Shoulders
				{ 3,  11631 }, -- Stoneshell Guard
				{ 4,  22397 }, -- Idol of Ferocity
				{ 5,  11630 }, -- Rockshard Pellets
				{ 7,  11813 }, -- Formula: Smoking Heart of the Mountain
				--{ 8,  11811 }, -- Smoking Heart of the Mountain
			},
		},
		{ -- BRDHighInterrogatorGerstahn
			name = AL["High Interrogator Gerstahn "],
			npcID = 9018,
			Level = 52,
			SubAreaID = 26733,
			DisplayIDs = {{8761}},
			AtlasMapBossID = 5,
			[NORMAL_DIFF] = {
				{ 1,  11626 }, -- Blackveil Cape
				{ 2,  11624 }, -- Kentic Amice
				{ 3,  22240 }, -- Greaves of Withering Despair
				{ 4,  223539 }, -- Enthralled Sphere
				{ 5,  11623 }, -- Spritecaster Cape
				{ 7,  11140 }, -- Prison Cell Key
			},
		},
		{ -- BRDHoundmaster
			name = AL["Houndmaster Grebmar"],
			npcID = 9319,
			Level = 52,
			SubAreaID = 26735,
			DisplayIDs = {{9212}},
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1,  11623 }, -- Spritecaster Cape
				{ 2,  11627 }, -- Fleetfoot Greaves
				{ 3,  223540 }, -- Houndmaster's Bow
				{ 4,  223982 }, -- Houndmaster's Rifle
				{ 5,  11626 }, -- Blackveil Cape
			},
		},
		-- ## RING START
		{ -- BRDGorosh
			name = AL["Gorosh the Dervish"],
			nameFormat = NAME_BRD_RING_OF_LAW,
			npcID = 9027,
			Level = GetForVersion(56,52),
			SubAreaID = 26742,
			DisplayIDs = {{8760}},
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1,  227952 }, -- Savage Gladiator Chain
				{ 2,  22271 }, -- Leggings of Frenzied Magic
				{ 3,  22257 }, -- Bloodclot Band
				{ 4,  227962 }, -- Flarethorn
			},
		},
		{ -- BRDGrizzle
			name = AL["Grizzle"],
			nameFormat = NAME_BRD_RING_OF_LAW,
			npcID = 9028,
			Level = GetForVersion(54,52),
			DisplayIDs = {{7873}},
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1,  223544 }, -- Dregmetal Spaulders
				{ 2,  11703 }, -- Stonewall Girdle
				{ 3,  22270 }, -- Entrenching Boots
				{ 4,  11702 }, -- Grizzle's Skinner
				{ 6,  11610 }, -- Plans: Dark Iron Pulverizer
				--{ 2,  11608 }, -- Dark Iron Pulverizer
			},
		},
		{ -- BRDEviscerator
			name = AL["Eviscerator"],
			nameFormat = NAME_BRD_RING_OF_LAW,
			npcID = 9029,
			Level = GetForVersion(54,52),
			DisplayIDs = {{523}},
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1,  223987 }, -- Splinthide Shoulders
				{ 2,  11679 }, -- Rubicund Armguards
				{ 4,  11686 }, -- Girdle of Beastial Fury
				{ 5,  227961 }, -- Savage Gladiator Grips
			},
		},
		{ -- BRDOkthor
			name = AL["Ok'thor the Breaker"],
			nameFormat = NAME_BRD_RING_OF_LAW,
			npcID = 9030,
			Level = GetForVersion(54,53),
			DisplayIDs = {{11538}},
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1,  11665 }, -- Ogreseer Fists
				{ 2,  11662 }, -- Ban'thok Sash
				{ 3,  11728 }, -- Savage Gladiator Leggings
				{ 4,  223985 }, -- Cyclopean Band
			},
		},
		{ -- BRDAnubshiah
			name = AL["Anub'shiah"],
			nameFormat = NAME_BRD_RING_OF_LAW,
			npcID = 9031,
			Level = GetForVersion(54,52),
			DisplayIDs = {{3004}},
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1,  11678 }, -- Carapace of Anub'shiah
				{ 2,  223986 }, -- Graverot Cape
				{ 3,  11675 }, -- Shadefiend Boots
				{ 4,  227957 }, -- Savage Gladiator Greaves
			},
		},
		{ -- BRDHedrum
			name = AL["Hedrum the Creeper"],
			nameFormat = NAME_BRD_RING_OF_LAW,
			npcID = 9032,
			Level = GetForVersion(53,52),
			DisplayIDs = {{8271}},
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1,  11633 }, -- Spiderfang Carapace
				{ 2,  223984 }, -- Silkweb Gloves
				{ 3,  11635 }, -- Hookfang Shanker
				{ 4,  227955 }, -- Savage Gladiator Helm
			},
		},
		-- ## RING END
		{ -- BRDPyromancerLoregrain
			name = AL["Pyromancer Loregrain"],
			npcID = 9024,
			Level = 52,
			SubAreaID = 26745,
			DisplayIDs = {{8762}},
			AtlasMapBossID = 7,
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1,  223981 }, -- Flamestrider Robes
				{ 2,  223980 }, -- Searingscale Leggings
				{ 3,  11748 }, -- Pyric Caduceus
				{ 4,  223538 }, -- Kindling Stave
				{ 6,  11207 }, -- Formula: Enchant Weapon - Fiery Weapon
			},
		},
		{ -- BRDTheVault
			name = AL["Dark Coffer"],
			SubAreaID = 26758,
			npcID = {9438, 9442, 9443, 9439, 9437, 9441},
			DisplayIDs = {{8592},{8595},{8596},{8593},{8591},{8594}},
			AtlasMapBossID = 8,
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["Dark Keeper"], nil },
				{ 2,  11197 }, -- Dark Keeper Key
				{ 5, "INV_Box_01", nil, AL["Secret Safe"], nil },
				{ 6,  22256 }, -- Mana Shaping Handwraps
				{ 7,  22205 }, -- Black Steel Bindings
				{ 8,  22255 }, -- Magma Forged Band
				{ 9,  22254 }, -- Wand of Eternal Light
				{ 10,  11923 }, -- The Hammer of Grace
				{ 16, "INV_Box_01", nil, AL["Relic Coffer"], nil },
				{ 17, 11945 }, -- Dark Iron Ring
				{ 18, 11946 }, -- Fire Opal Necklace
				{ 20, "INV_Box_01", nil, AL["Dark Coffer"], nil },
				{ 21, 11752 }, -- Black Blood of the Tormented
				{ 22, 11751 }, -- Burning Essence
				{ 23, 11753 }, -- Eye of Kajal
			},
		},
		{ -- BRDWarderStilgiss
			name = AL["Warder Stilgiss"],
			npcID = 9041,
			Level = GetForVersion(56,54),
			SubAreaID = 26758,
			DisplayIDs = {{9089}},
			AtlasMapBossID = 8,
			[NORMAL_DIFF] = {
				{ 1,  11782 }, -- Boreal Mantle
				{ 2,  22241 }, -- Dark Warder's Pauldrons
				{ 3,  11783 }, -- Chillsteel Girdle
				{ 4,  223983 }, -- Arbiter's Blade		
			},
		},
		{ -- BRDVerek
			name = AL["Verek"],
			npcID = 9042,
			Level = GetForVersion(55,53),
			SubAreaID = 26758,
			DisplayIDs = {{9019}},
			AtlasMapBossID = 8,
			[NORMAL_DIFF] = {
				{ 1,  11755 }, -- Verek's Collar
				{ 2,  22242 }, -- Verek's Leash
				{ 16, 226404 }, -- Tarnished Undermine Real
			},
		},
		{ -- BRDWatchmanDoomgrip
			name = AL["Watchman Doomgrip"],
			npcID = 9476,
			Level = GetForVersion(55,54),
			SubAreaID = 26758,
			DisplayIDs = {{8655}},
			AtlasMapBossID = 8,
			[NORMAL_DIFF] = {
				{ 1,  22205 }, -- Black Steel Bindings
				{ 2,  22255 }, -- Magma Forged Band
				{ 3,  22256 }, -- Mana Shaping Handwraps
				{ 4,  22254 }, -- Wand of Eternal Light
			},
		},
		{ -- BRDFineousDarkvire
			name = AL["Fineous Darkvire"],
			npcID = 9056,
			Level = GetForVersion(54,53),
			SubAreaID = 26759,
			DisplayIDs = {{8704}},
			AtlasMapBossID = 9,
			[NORMAL_DIFF] = {
				{ 1,  11839 }, -- Chief Architect's Monocle
				{ 2,  22223 }, -- Foreman's Head Protector
				{ 3,  11842 }, -- Lead Surveyor's Mantle
				{ 4,  11841 }, -- Senior Designer's Pantaloons
				{ 6,  11840 }, -- Master Builder's Shirt
				{ 16, 226404 }, -- Tarnished Undermine Real
			},
		},
		{ -- BRDLordIncendius
			name = AL["Lord Incendius"],
			npcID = 9017,
			Level = GetForVersion(55,53),
			SubAreaID = 26750,
			DisplayIDs = {{1204}},
			AtlasMapBossID = 10,
			ContentPhase = 3,
			[NORMAL_DIFF] = {
				{ 1,  11766 }, -- Flameweave Cuffs
				{ 2,  11764 }, -- Cinderhide Armsplints
				{ 3,  11765 }, -- Pyremail Wristguards
				{ 4,  11767 }, -- Emberplate Armguards
				{ 6,  19268 }, -- Ace of Elementals
				{ 8,  11768 }, -- Incendic Bracers
				{ 16, 226404 }, -- Tarnished Undermine Real
			},
		},
		{ -- BRDGuzzler_Ribbly Screwspigot
		name = AL["Ribbly Screwspigot"],
		SubAreaID = 26751,
		npcID = {9543},
		Level = 55,
		DisplayIDs = {{8667}},
		AtlasMapBossID = 15,
		ContentPhase = 3,
		[NORMAL_DIFF] = {
				{ 1, 2662 }, -- Ribbly's Quiver
				{ 2, 2663 }, -- Ribbly's Bandolier
				{ 3, 11612 }, -- Plans: Dark Iron Plate
				{ 4, 11742 }, -- Wayfarer's Knapsack
			},
		},
		{ -- BRDGuzzler_Plugger Spazzring
		name = AL["Plugger Spazzring"],
		SubAreaID = 26751,
		npcID = {9499},
		Level = 55,
		DisplayIDs = {{8652}},
		AtlasMapBossID = 15,
		ContentPhase = 3,
		[NORMAL_DIFF] = {
			{ 1, 12793 }, -- Mixologist's Tunic
			{ 2, 12791 }, -- Barman Shanker
			{ 3, 11325 }, -- Dark Iron Ale Mug
			{ 4, 18653 }, -- Schematic: Goblin Jumper Cables XL
			{ 5, 13483 }, -- Recipe: Transmute Fire to Earth
			{ 6, 15759 }, -- Pattern: Black Dragonsale Breastplate
			{ 7, 11602 }, -- Grim Guzzler Key
			},
		},
		{ -- BRDBaelGar
			name = AL["Bael'Gar"],
			npcID = 9016,
			Level = GetForVersion(54,52),
			SubAreaID = 26747,
			DisplayIDs = {{12162}},
			AtlasMapBossID = 11,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  11807 }, -- Sash of the Burning Heart
				{ 2,  11802 }, -- Lavacrest Leggings
				{ 3,  11805 }, -- Rubidium Hammer
				{ 4,  11803 }, -- Force of Magma
				{ 16, 226404 }, -- Tarnished Undermine Real
			},
		},
		{ -- BRDGeneralAngerforge
			name = AL["General Angerforge"],
			npcID = 9033,
			Level = GetForVersion(57,55),
			SubAreaID = 26749,
			DisplayIDs = {{8756}},
			AtlasMapBossID = 13,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  11820 }, -- Royal Decorated Armor
				{ 2,  11821 }, -- Warstrife Leggings
				{ 3,  11810 }, -- Force of Will
				{ 4,  227940 }, -- Lord General's Sword
				{ 5,  227948 }, -- Angerforge's Battle Axe
				{ 6,  11841 }, -- Senior Designer's Pantaloons
				{ 16, 226404 }, -- Tarnished Undermine Real
			},
		},
		{ -- BRDGolemLordArgelmach
			name = AL["Golem Lord Argelmach"],
			npcID = 8983,
			Level = GetForVersion(57,55),
			SubAreaID = 26781,
			DisplayIDs = {{8759}},
			AtlasMapBossID = 14,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  227964 }, -- Luminary Kilt
				{ 2,  227965 }, -- Omnicast Boots
				{ 3,  11669 }, -- Naglering
				{ 4,  227967 }, -- Second Wind
				{ 16, 226404 }, -- Tarnished Undermine Real
			},
		},
		{ -- BRDGuzzler_
		name = AL["Hurley Blackbreath"],
		SubAreaID = 26751,
		npcID = {9537},
		Level = 55,	
		DisplayIDs = {{8658}},
		AtlasMapBossID = 15,
		ContentPhase = 4,
		[NORMAL_DIFF] = {
			{ 1,  11735 }, -- Ragefury Eyepatch
			{ 2,  18043 }, -- Coal Miner Boots
			{ 3,  22275 }, -- Firemoss Boots
			{ 4,  18044 }, -- Hurley's Tankard
			{ 16, 226404 }, -- Tarnished Undermine Real
			},
		},
		{ -- BRDGuzzler_
		name = AL["Lokhtos Darkbargainer"],
		SubAreaID = 26751,
		npcID = {12944},
		Level = 55,	
		DisplayIDs = {{14666}},
		AtlasMapBossID = 15,
		ContentPhase = 4,
		[NORMAL_DIFF] = {
			{ 1, 227727 }, -- Plans: Sulfuron Hammer
			},
		},
		{ -- Phalanx
			name = AL["Phalanx"],
			npcID = 9502,
			Level = 55,
			SubAreaID = 26751,
			DisplayIDs = {{8177}},
			AtlasMapBossID = 15,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  227947 }, -- Golem Fitted Pauldrons
				{ 2,  11745 }, -- Fists of Phalanx
				{ 3, 11744 }, -- Bloodfist
				{ 4, 11743 }, -- Rockfist
				{ 16, 226404 }, -- Tarnished Undermine Real
			},
		},
		{ -- BRDFlamelash
			name = AL["Ambassador Flamelash"],
			npcID = 9156,
			Level = GetForVersion(57,55),
			SubAreaID = 26761,
			DisplayIDs = {{8329}},
			AtlasMapBossID = 16,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  227973 }, -- Circle of Flame
				{ 3,  227970 }, -- Cape of the Fire Salamander
				{ 4,  227971 }, -- Molten Fists
				{ 5,  227972 }, -- Burst of Knowledge
				{ 6,  227934 }, -- Flame Wrath
				{ 8,  23320 }, -- Tablet of Flame Shock VI
				{ 16, 226404 }, -- Tarnished Undermine Real
			},
		},
		{ -- BRDPanzor
			name = AL["Panzor the Invincible"],
			npcID = 8923,
			Level = GetForVersion(57,56),
			SubAreaID = 26764,
			DisplayIDs = {{8270}},
			AtlasMapBossID = 17,
			specialType = "rare",
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  22245 }, -- Soot Encrusted Footwear
				{ 2,  11787 }, -- Shalehusk Boots
				{ 3,  11785 }, -- Rock Golem Bulwark
				{ 4,  11786 }, -- Stone of the Earth
			},
		},
		{ -- BRDTomb
			name = AL["Chest of The Seven"],
			SubAreaID = 26784,
			npcID = {9034, 9035, 9036, 9037, 9038, 9039, 9040},
			ObjectID = 169243,
			Level = GetForVersion({55, 57},{55, 56}),
			DisplayIDs = {{8690},{8686},{8692},{8689},{8691},{8687},{8688}},
			AtlasMapBossID = 18,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  227958 }, -- Ghostshroud
				{ 2,  227956 }, -- Deathdealer Breastplate
				{ 3,  11929 }, -- Haunting Specter Leggings
				{ 4,  227959 }, -- Legplates of the Eternal Guardian
				{ 5,  227941 }, -- Wraith Scythe
				{ 6,  11923 }, -- The Hammer of Grace
				{ 7,  227963 }, -- Blood-etched Blade
				{ 8,  227960 }, -- Impervious Giant
			},
		},
		{ -- BRDMagmus
			name = AL["Magmus"],
			npcID = 9938,
			Level = GetForVersion(57,56),
			SubAreaID = 26768,
			DisplayIDs = {{12162}},
			AtlasMapBossID = 20,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  11746 }, -- Golem Skull Helm
				{ 2,  227978 }, -- Magmus Stone
				{ 3,  22395 }, -- Totem of Rage
				{ 4,  22400 }, -- Libram of Truth
				{ 5,  227974 }, -- Lavastone Hammer
				{ 16, 226404 }, -- Tarnished Undermine Real
			},
		},
		{ -- BRDPrincess
			name = AL["Princess Moira Bronzebeard "],
			npcID = 8929,
			Level = GetForVersion(58,55),
			SubAreaID = 26769,
			DisplayIDs = {{8705}},
			AtlasMapBossID = 21,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  12557 }, -- Ebonsteel Spaulders
				{ 2,  12554 }, -- Hands of the Exalted Herald
				{ 3,  12556 }, -- High Priestess Boots
				{ 4,  12553 }, -- Swiftwalker Boots
			},
		},
		{ -- BRDEmperorDagranThaurissan
			name = AL["Emperor Dagran Thaurissan"],
			npcID = 9019,
			Level = GetForVersion(59,56),
			SubAreaID = 26769,
			DisplayIDs = {{8807}},
			AtlasMapBossID = 21,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  227991 }, -- Ironfoe
				{ 3,  227988 }, -- Imperial Jewel
				{ 4,  227985 }, -- The Emperor's New Cape
				{ 5,  227980 }, -- Robes of the Royal Crown
				{ 6,  227986 }, -- Wristguards of Renown
				{ 7,  227987 }, -- Sash of the Grand Hunt
				{ 8,  11934 }, -- Emperor's Seal
				{ 9,  228722 }, -- Hand of Justice
				{ 10, 227984 }, -- Thaurissan's Royal Scepter
				{ 11, 227981 }, -- Dreadforge Retaliator
				{ 12, 227982 }, -- Guiding Stave of Wisdom
				{ 16, 226404 }, -- Tarnished Undermine Real
				{ 18, 12033 }, -- Thaurissan Family Jewels
			},
		},
		{ -- BRDTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  12549 }, -- Braincage
				{ 2,  12552 }, -- Blisterbane Wrap
				{ 3,  12551 }, -- Stoneshield Cloak
				{ 4,  12542 }, -- Funeral Pyre Vestment
				{ 5,  12546 }, -- Aristocratic Cuffs
				{ 6,  12550 }, -- Runed Golem Shackles
				{ 7,  12547 }, -- Mar Alom's Grip
				{ 8,  12555 }, -- Battlechaser's Greaves
				{ 9,  12527 }, -- Ribsplitter
				{ 10, 12531 }, -- Searing Needle
				{ 11, 12535 }, -- Doomforged Straightedge
				{ 12, 12528 }, -- The Judge's Gavel
				{ 13, 12532 }, -- Spire of the Stoneshaper
				{ 16, 15781 }, -- Pattern: Black Dragonscale Leggings
				{ 17, 15770 }, -- Pattern: Black Dragonscale Shoulders
				{ 19, 11611 }, -- Plans: Dark Iron Sunderer
				{ 20, 11614 }, -- Plans: Dark Iron Mail
				{ 21, 11615 }, -- Plans: Dark Iron Shoulders
				{ 23, 16048 }, -- Schematic: Dark Iron Rifle
				{ 24, 16053 }, -- Schematic: Master Engineer's Goggles
				{ 25, 16049 }, -- Schematic: Dark Iron Bomb
				{ 26, 18654 }, -- Schematic: Gnomish Alarm-O-Bot
				{ 27, 18661 }, -- Schematic: World Enlarger
			},
		},
		{ -- BRDBSPlans
			name = AL["Plans"],
			ExtraList = true,
			IgnoreAsSource = true,
			[NORMAL_DIFF] = {
				{ 1,  11614 }, -- Plans: Dark Iron Mail
				{ 2,  11615 }, -- Plans: Dark Iron Shoulders
			},
		},
		{ -- BRDTheldren
			name = AL["Theldren"].." - "..format(AL["Tier %s Sets"], "0.5"),
			npcID = 16059,
			DisplayIDs = {{15981}},
			AtlasMapBossID = 6,
			Level = 60,
			ExtraList = true,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  228700 }, -- Ironweave Mantle
				{ 2,  22330 }, -- Shroud of Arcane Mastery
				{ 3,  22318 }, -- Malgen's Long Bow
				{ 4,  22317 }, -- Lefty's Brass Knuckle
			},
		},
	},
}

data["LowerBlackrockSpire"] = {
	name = AL["Lower Blackrock Spire"],
	MapID = 1583,
	InstanceID = 229,
	SubAreaIDs = { 26683, 26718, 26711, 26713, 26686, 32528, 26688 },
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "LowerBlackrockSpire",
	AtlasMapFile = {"CL_BlackrockSpireLower", "CL_BlackrockMountainEnt"},
	AtlasMapFile_AL = {"BlackrockSpireLower", "BlackrockMountainEnt"},
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = GetForVersion({48, 55, 60}, {45, 54, 60}),
	ContentPhase = 4,
	items = {
		{ -- LBRSFelguard
			name = AL["Burning Felguard"],
			npcID = 10263,
			Level = {56, 57},
			DisplayIDs = {{5047}},
			AtlasMapBossID = 1,
			specialType = "rare",
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  228554 }, -- Demonskin Gloves
				{ 2,  228555 }, -- Phase Blade
			},
		},
		{ -- LBRSSpirestoneButcher
			name = AL["Spirestone Butcher"],
			npcID = 9219,
			Level = 57,
			DisplayIDs = {{11574}},
			AtlasMapBossID = 4,
			specialType = "rare",
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  228556 }, -- Butcher's Apron
				{ 2,  13286 }, -- Rivenspike
			},
		},
		{ -- LBRSOmokk
			name = AL["Highlord Omokk"],
			npcID = 9196,
			Level = GetForVersion(59,57),
			SubAreaID = 26713,
			DisplayIDs = {{11565}},
			AtlasMapBossID = 5,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  226752 }, -- Boots of Elements
				{ 3,  13166 }, -- Slamshot Shoulders
				{ 4,  228571 }, -- Plate of the Shaman King
				{ 5,  13170 }, -- Skyshroud Leggings
				{ 6,  13169 }, -- Tressermane Leggings
				{ 7,  228570 }, -- Fist of Omokk
				{ 8,  12336 }, -- Gemstone of Spirestone
				{ 18, 12534 }, -- Omokk's Head
				{ 16, 226404 }, -- Tarnished Undermine Real
			},
		},
		{ -- LBRSSpirestoneBattleLord
			name = AL["Spirestone Battle Lord"],
			npcID = 9218,
			Level = 58,
			DisplayIDs = {{11576}},
			AtlasMapBossID = 6,
			specialType = "rare",
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  228557 }, -- Swiftdart Battleboots
				{ 2,  13285 }, -- The Nicker
			},
		},
		{ -- LBRSSpirestoneLordMagus
			name = AL["Spirestone Lord Magus"],
			npcID = 9217,
			Level = {57, 58},
			DisplayIDs = {{11578}},
			AtlasMapBossID = 6,
			specialType = "rare",
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  228564 }, -- Ogreseer Tower Boots
				{ 2,  228565 }, -- Magus Ring
				{ 3,  228563 }, -- Globe of D'sak
			},
		},
		{ -- LBRSVosh
			name = AL["Shadow Hunter Vosh'gajin"],
			npcID = 9236,
			Level = 58,
			SubAreaID = 26688,
			DisplayIDs = {{9732}},
			AtlasMapBossID = 7,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  226702 }, -- Shadowcraft Gloves
				{ 3,  228562 }, -- Demonic Runed Spaulders
				{ 4,  228558 }, -- Funeral Cuffs
				{ 5,  228561 }, -- Trueaim Gauntlets
				{ 6,  12653 }, -- Riphook
				{ 7,  228559 }, -- Blackcrow
				{ 8,  12654 }, -- Doomshot
				{ 16, 226404 }, -- Tarnished Undermine Real
			},
		},
		{ -- LBRSVoone
			name = AL["War Master Voone"],
			npcID = 9237,
			Level = GetForVersion(59,58),
			SubAreaID = 26688,
			DisplayIDs = {{9733}},
			AtlasMapBossID = 9,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  226721 }, -- Beaststalker's Gloves
				{ 3,  228574 }, -- Talisman of Evasion
				{ 4,  228572 }, -- Brazecore Armguards
				{ 5,  228594 }, -- Kayser's Boots of Precision
				{ 6,  13173 }, -- Flightblade Throwing Axe
				{ 7,  12582 }, -- Keris of Zul'Serak
				{ 9,  12335 }, -- Gemstone of Smolderthorn
				{ 16, 226404 }, -- Tarnished Undermine Real
			},
		},
		{ -- LBRSGrimaxe
			name = AL["Bannok Grimaxe"],
			npcID = 9596,
			Level = 59,
			DisplayIDs = {{9668}},
			AtlasMapBossID = 12,
			specialType = "rare",
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  228568 }, -- Backusarian Gauntlets
				{ 2,  228567 }, -- Chiselbrand Girdle
				{ 3,  12621 }, -- Demonfork
				{ 5,  12838 }, -- Plans: Arcanite Reaper
				--{ 6,  12784 }, -- Arcanite Reaper
			},
		},
		{ -- LBRSSmolderweb
			name = AL["Mother Smolderweb"],
			npcID = 10596,
			Level = 59,
			SubAreaID = 26686,
			DisplayIDs = {{9929}},
			AtlasMapBossID = 13,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  226713 }, -- Wildheart Boots
				{ 3,  228577 }, -- Gilded Gauntlets
				{ 4,  228576 }, -- Smolderweb's Eye
				{ 5,  228573 }, -- Venomspitter
				{ 16, 226404 }, -- Tarnished Undermine Real
			},
		},
		{ -- LBRSCrystalFang
			name = AL["Crystal Fang"],
			npcID = 10376,
			Level = 60,
			SubAreaID = 26686,
			DisplayIDs = {{9755}},
			AtlasMapBossID = 14,
			specialType = "rare",
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  228590 }, -- Sunderseer Mantle
				{ 2,  13184 }, -- Fallbrush Handgrips
				{ 3,  228592 }, -- Fang of the Crystal Spider
			},
		},
		{ -- LBRSDoomhowl
			name = AL["Urok Doomhowl"],
			npcID = 10584,
			Level = 60,
			DisplayIDs = {{11583}},
			AtlasMapBossID = 15,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  13258 }, -- Slaghide Gauntlets
				{ 2,  228595 }, -- Marksman's Girdle
				{ 3,  13259 }, -- Ribsteel Footguards
				{ 4,  13178 }, -- Rosewine Circle
				{ 18,  18784 }, -- Top Half of Advanced Armorsmithing: Volume III
				{ 16, 226404 }, -- Tarnished Undermine Real
			},
		},
		{ -- LBRSZigris
			name = AL["Quartermaster Zigris"],
			npcID = 9736,
			Level = 59,
			SubAreaID = 32528,
			DisplayIDs = {{9738}},
			AtlasMapBossID = 16,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  13247 }, -- Quartermaster Zigris' Footlocker
				{ 3,  13253 }, -- Hands of Power
				{ 4,  13252 }, -- Cloudrunner Girdle
				{ 6,  12835 }, -- Plans: Annihilator
				--{ 5,  12798 }, -- Annihilator
			},
		},
		{ -- LBRSHalycon
			name = AL["Halycon"],
			npcID = 10220,
			Level = 59,
			SubAreaID = 26711,
			DisplayIDs = {{9567}},
			AtlasMapBossID = 17,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  13212 }, -- Halycon's Spiked Collar
				{ 2,  228598 }, -- Ironweave Bracers
				{ 3,  228575 }, -- Slashclaw Bracers
				{ 4,  13210 }, -- Pads of the Dread Wolf
				{ 16, 226404 }, -- Tarnished Undermine Real
			},
		},
		{ -- LBRSSlavener
			name = AL["Gizrul the Slavener"],
			npcID = 10268,
			Level = 60,
			SubAreaID = 26711,
			DisplayIDs = {{9564}},
			AtlasMapBossID = 17,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  226710 }, -- Wildheart Spaulders
				{ 3,  13208 }, -- Bleak Howler Armguards
				{ 4,  13206 }, -- Wolfshear Leggings
				{ 5,  228591 }, -- Rhombeard Protector
				{ 16, 226404 }, -- Tarnished Undermine Real
			},
		},
		{ -- LBRSBashguud
			name = AL["Ghok Bashguud"],
			npcID = 9718,
			Level = 59,
			DisplayIDs = {{11809}},
			AtlasMapBossID = 18,
			specialType = "rare",
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  13203 }, -- Armswake Cloak
				{ 2,  13198 }, -- Hurd Smasher
				{ 3,  13204 }, -- Bashguuder
			},
		},
		{ -- LBRSWyrmthalak
			name = AL["Overlord Wyrmthalak"],
			npcID = 9568,
			Level = 60,
			SubAreaID = 26718,
			DisplayIDs = {{8711}},
			AtlasMapBossID = 19,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  228585 }, -- Mark of the Dragon Lord
				{ 3,  226716 }, -- Beaststalker's Mantle
				{ 5,  228588 }, -- Reiver Claws
				{ 6,  228589 }, -- Heart of the Scale
				{ 7,  228599 }, -- Heart of Wyrmthalak
				{ 8,  228601 }, -- Relentless Scythe
				{ 9,  228586 }, -- Chillpike
				{ 10, 228587 }, -- Trindlehaven Staff
				{ 12, 12337 }, -- Gemstone of Bloodaxe
				{ 18, 12780 }, -- General Drakkisath's Command
				{ 16, 226404 }, -- Tarnished Undermine Real
			},
		},

		{ -- LBRSTrash
			name = AL["Trash"],
			ExtraList = true,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  14513 }, -- Pattern: Robe of the Archmage
				--{ 2,  14152 }, -- Robe of the Archmage
				{ 3,  226744 }, -- Devout Belt
				{ 4,  226724 }, -- Magister's Belt
				{ 5,  226725 }, -- Magister's Bindings
				{ 6,  226759 }, -- Dreadmist Bracers
				{ 7,  226701 }, -- Shadowcraft Belt
				{ 8,  226712 }, -- Wildheart Belt
				{ 9, 226718 }, -- Beaststalker's Belt
				{ 10, 226754 }, -- Cord of Elements
				{ 11, 226765 }, -- Belt of Valor
				{ 12, 226766 }, -- Bracers of Valor
				{ 16, 15749 }, -- Pattern: Volcanic Breastplate
				{ 17, 15775 }, -- Pattern: Volcanic Shoulders
				{ 18, 13494 }, -- Recipe: Greater Fire Protection Potion
				{ 19, 16250 }, -- Formula: Enchant Weapon - Superior Striking
				{ 20, 16244 }, -- Formula: Enchant Gloves - Greater Strength
				{ 21, 9214 }, -- Grimoire of Inferno
				{ 23, 12219 }, -- Unadorned Seal of Ascension
				{ 24, 12586 }, -- Immature Venom Sac
			},
		},
		{ -- LBRSGrayhoof
			name = AL["Mor Grayhoof"].." - "..format(AL["Tier %s Sets"], "0.5"),
			npcID = 16080,
			DisplayIDs = {{15997}},
			ExtraList = true,
			ContentPhase = 4,
			AtlasMapBossID = 9,
			[NORMAL_DIFF] = {
				{ 1,  228596 }, -- Ironweave Belt
				{ 2,  22325 }, -- Belt of the Trickster
				{ 3,  22319 }, -- Tome of Divine Right
				{ 4,  22398 }, -- Idol of Rejuvenation
				{ 5,  228600 }, -- The Jaw Breaker
			},
		},
	},
}

data["UpperBlackrockSpire"] = {
	name = AL["Upper Blackrock Spire"],
	MapID = 1583,
	InstanceID = 229,
	SubAreaIDs = { 26670, 26668, 26684, 26662, 26642, 26683, 15492, 26666, 26715 },
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "UpperBlackrockSpire",
	AtlasMapFile = {"CL_BlackrockSpireUpper", "CL_BlackrockMountainEnt"},
	AtlasMapFile_AL = {"BlackrockSpireUpper", "BlackrockMountainEnt"},
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = GetForVersion({48, 55, 60}, {45, 58, 60}),
	ContentPhase = 4,
	items = {
		{ -- UBRSEmberseer
			name = AL["Pyroguard Emberseer"],
			npcID = 9816,
			Level = 60,
			SubAreaID = 26662,
			DisplayIDs = {{2172}},
			AtlasMapBossID = 1,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  226748 }, -- Gauntlets of Elements
				{ 3,  228584 }, -- Emberfury Talisman
				{ 4,  228583 }, -- TruestrikeShoulders
				{ 5,  12905 }, -- Wildfire Cape
				{ 6,  12926 }, -- Flaming Band
				{ 8,  23320 }, -- Tablet of Flame Shock VI
				{ 16, 226404 }, -- Tarnished Undermine Real
			},
		},
		{ -- UBRSSolakar
			name = AL["Solakar Flamewreath"],
			npcID = 10264,
			Level = 60,
			SubAreaID = 26666,
			DisplayIDs = {{9581}},
			AtlasMapBossID = 2,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  226741 }, -- Devout Mantle
				{ 3,  12609 }, -- Polychromatic Visionwrap
				{ 4,  12603 }, -- Nightbrace Tunic
				{ 5,  228578 }, -- Dustfeather Sash
				{ 6,  228579 }, -- Crystallized Girdle
				{ 8,  18657 }, -- Schematic: Hyper-Radiant Flame Reflector
			},
		},
		{ -- UBRSRunewatcher
			name = AL["Jed Runewatcher"],
			npcID = 10509,
			Level = 59,
			SubAreaID = 26642,
			DisplayIDs = {{9686}},
			AtlasMapBossID = 4,
			ContentPhase = 4,
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1,  228566 }, -- Starfire Tiara
				{ 2,  12930 }, -- Briarwood Reed
				{ 3,  227942 }, -- Serpentine Skuller
			},
		},
		{ -- UBRSAnvilcrack
			name = AL["Goraluk Anvilcrack "],
			npcID = 10899,
			Level = 61,
			SubAreaID = 26642,
			DisplayIDs = {{10222}},
			AtlasMapBossID = 5,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  228672 }, -- Handcrafted Mastersmith Girdle
				{ 2,  13498 }, -- Handcrafted Mastersmith Leggings
				{ 3,  228602 }, -- Flame Walkers
				{ 4,  18048 }, -- Mastersmith's Hammer
				{ 6,  12834 }, -- Plans: Arcanite Champion
				{ 7,  12837 }, -- Plans: Masterwork Stormhammer
				{ 9, 18779 }, -- Bottom Half of Advanced Armorsmithing: Volume I
				{ 16, "INV_Box_01", nil, AL["Unforged Rune Covered Breastplate"], nil },
				{ 17, 12806 }, -- Unforged Rune Covered Breastplate
				{ 18, 12696 }, -- Plans: Demon Forged Breastplate
			},
		},
		{ -- UBRSGyth
			name = AL["Gyth"],
			npcID = 10339,
			Level = 62,
			SubAreaID = 26670,
			DisplayIDs = {{9806}},
			AtlasMapBossID = 6,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  12871 }, -- Chromatic Carapace
				{ 3,  226753 }, -- Pauldrons of Elements
				{ 5,  22225 }, -- Dragonskin Cowl
				{ 6,  12960 }, -- Tribal War Feathers
				{ 7,  12953 }, -- Dragoneye Coif
				{ 8,  12952 }, -- Gyth's Skull
				{ 10, 13522 }, -- Recipe: Flask of Chromatic Resistance
			},
		},
		{ -- UBRSRend
			name = AL["Warchief Rend Blackhand"],
			npcID = 10429,
			Level = 62,
			SubAreaID = 26670,
			DisplayIDs = {{9778}},
			AtlasMapBossID = 6,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  12590 }, -- Felstriker
				{ 3,  226768 }, -- Spaulders of Valor
				{ 5,  228604 }, -- Eye of Rend
				{ 6,  228605 }, -- Bonespike Shoulder
				{ 7,  228651 }, -- Battleborn Armbraces
				{ 8,  228676 }, -- Feralsurge Girdle
				{ 9,  228650 }, -- Warmaster Legguards
				{ 10, 18102 }, -- Dragonrider Boots
				{ 11, 22247 }, -- Faith Healer's Boots
				{ 12, 228675 }, -- Band of Rumination
				{ 13, 228653 }, -- Dal'Rend's Sacred Charge
				{ 14, 228652 }, -- Dal'Rend's Tribal Guardian
				{ 15, 228603 }, -- Blackhand Doomsaw
				{ 16, 226404 }, -- Tarnished Undermine Real
			},
		},
		{ -- UBRSBeast
			name = AL["The Beast"],
			npcID = 10430,
			Level = 62,
			SubAreaID = 26684,
			DisplayIDs = {{10193}},
			AtlasMapBossID = 8,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  12731 }, -- Pristine Hide of the Beast
				{ 3,  226735 }, -- Lightforge Spaulders
				{ 5,  228663 }, -- Bloodmoon Cloak
				{ 6,  228664 }, -- Frostweaver Cape
				{ 7,  228662 }, -- Blackmist Armguards
				{ 8,  12965 }, -- Spiritshroud Leggings
				{ 9,  228660 }, -- Blademaster Leggings
				{ 10, 228661 }, -- Tristam Legguards
				{ 11, 228597 }, -- Ironweave Boots
				{ 12, 12709 }, -- Finkle's Skinner
				{ 13, 228666 }, -- Seeping Willow
				{ 15, 24101 }, -- Book of Ferocious Bite V
				{ 18, 19227 }, -- Ace of Beasts
				{ 16, 226404 }, -- Tarnished Undermine Real
			},
		},
		{ -- UBRSDrakkisath
			name = AL["General Drakkisath"],
			npcID = 10363,
			Level = 62,
			SubAreaID = 26715,
			DisplayIDs = {{10115}},
			AtlasMapBossID = 9,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  228606 }, -- Blackblade of Shahram
				{ 3,  228677 }, -- Spellweaver's Turban
				{ 4,  228669 }, -- Tooth of Gnarr
				{ 5,  22269 }, -- Shadow Prowler's Cloak
				{ 6,  228670 }, -- Brigam Girdle
				{ 7,  228667 }, -- Painweaver Band
				{ 8,  228678 }, -- Draconic Infused Emblem
				{ 9,  22253 }, -- Tome of the Lost
				{ 10, 12602 }, -- Draconian Deflector
				{ 12, 15730 }, -- Pattern: Red Dragonscale Breastplate
				{ 14, 13519 }, -- Recipe: Flask of the Titans
				{ 16, 226404 }, -- Tarnished Undermine Real
				{ 18, 226745 }, -- Devout Robe
				{ 19, 226729 }, -- Magister's Robes
				{ 20, 226757 }, -- Dreadmist Robe
				{ 21, 226700 }, -- Shadowcraft Tunic
				{ 22, 226715 }, -- Wildheart Vest
				{ 23, 226723 }, -- Beaststalker's Tunic
				{ 24, 226749 }, -- Vest of Elements
				{ 25, 226734 }, -- Lightforge Breastplate
				{ 26, 226770 }, -- Breastplate of Valor
			},
		},
		{ -- UBRSTrash
			name = AL["Trash"],
			ExtraList = true,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  24102 }, -- Manual of Eviscerate IX
				{ 2,  228593 }, -- Wind Dancer Boots
				{ 4,  226744 }, -- Devout Belt
				{ 5,  226725 }, -- Magister's Bindings
				{ 6,  226759 }, -- Dreadmist Bracers
				{ 7,  226701 }, -- Shadowcraft Belt
				{ 8,  226717 }, -- Beaststalker's Bindings
				{ 9,  226718 }, -- Beaststalker's Belt
				{ 10, 226754 }, -- Cord of Elements
				{ 11, 226766 }, -- Bracers of Valor
				{ 16, 16247 }, -- Formula: Enchant 2H Weapon - Superior Impact
			},
		},
		{
			name = AL["Darkstone Tablet"],
			ExtraList = true,
			AtlasMapBossID = 3,
			specialType = "quest",
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  12358 }, -- Darkstone Tablet
			},
		},
		{ -- UBRSValthalak
			name = AL["Lord Valthalak"].." - "..format(AL["Tier %s Sets"], "0.5"),
			npcID = 16042,
			DisplayIDs = {{14308}},
			ExtraList = true,
			ContentPhase = 4,
			AtlasMapBossID = 8,
			[NORMAL_DIFF] = {
				{ 1,  228681 }, -- Ironweave Cowl
				{ 2,  228684 }, -- Pendant of Celerity
				{ 3,  22337 }, -- Shroud of Domination
				{ 4,  22343 }, -- Handguards of Savagery
				{ 5,  22342 }, -- Leggings of Torment
				{ 6,  228683 }, -- Rune Band of Wizardry
				{ 7,  22336 }, -- Draconian Aegis of the Legion
				{ 8,  228682 }, -- Lord Valthalak's Staff of Command
			},
		},
	},
}

data["DemonFallCanyon"] = {
	name = AL["Demon Fall Canyon"],
	MapID = 15475,
	InstanceID = 15540,
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	ContentPhase = 4,
	LevelRange = {55, 57, 60},
	items = {
		{ -- Grimroot
			name = AL["Grimroot"],
			npcID = 226923,
			Level = 58,
			--SubAreaID = 0,
			DisplayIDs = {{121733}},
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  228083 }, -- Gloaming Treeheart
				{ 2,  228081 }, -- Germinating Poisonseed
				{ 3,  228080 }, -- Resin Loop
				{ 4,  228082 }, -- Warsong Axe
				{ 5,  228079 }, -- Cloak of Leaves
				{ 16,  226404 }, -- Tarnished Undermine Real
			},
		},
		{ --Diathorus the Seeker
			name = AL["Diathorus the Seeker"],
			npcID = 227019,
			Level = 58,
			--SubAreaID = 0,
			DisplayIDs = {{10691}},
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  228104 }, -- Robes of Elune
				{ 2,  228094 }, -- Dreadlord's Blade
				{ 3,  228107 }, -- Fallen Huntress' Longbow
				{ 4,  228106 }, -- Shield of Life and Death
				{ 5,  228103 }, -- Nathrezim's Greaves
				{ 16,  226404 }, -- Tarnished Undermine Real
				{ 18, 18665 }, -- The Eye of Shadow
			},
		},
		{ --The Destructor's Wraith
			name = AL["The Destructor's Wraith"],
			npcID = 228022,
			Level = 58,
			--SubAreaID = 0,
			DisplayIDs = {{121410}},
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  228074 }, -- Hands of Temptation
				{ 2,  228075 }, -- Spear of Destiny
				{ 3,  228076 }, -- Burning Ring of Fire
				{ 4,  228077 }, -- Dreambough
				{ 5,  228078 }, -- Accursed Chalice
				{ 16,  226404 }, -- Tarnished Undermine Real
				{ 18, 18665 }, -- The Eye of Shadow
			},
		},
		{ --Zilbagob
			name = AL["Zilbagob"],
			npcID = 226922,
			Level = 58,
			--SubAreaID = 0,
			DisplayIDs = {{121881}},
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  228085 }, -- Phaseshifted Legion Band
				{ 2,  228086 }, -- Repurposed Shredderblade
				{ 3,  228088 }, -- Shredder Operator's Dogtags
				{ 4,  228087 }, -- Supercharged Silver Moebius
				{ 5,  228084 }, -- Miniaturized Fire Extinguisher
				{ 16,  226404 }, -- Tarnished Undermine Real
			},
		},
		{ --Pyranis
			name = AL["Pyranis"],
			npcID = 227140,
			Level = 58,
			--SubAreaID = 0,
			DisplayIDs = {{227140}},
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  228093 }, -- Dark Heart of Darkness
				{ 2,  228090 }, -- Cenarion Ritual Dagger
				{ 3,  228092 }, -- Druidic Mantle
				{ 4,  228091 }, -- Thorned Boots
				{ 5,  228089 }, -- Woodcarved Moonstalker
				{ 16,  226404 }, -- Tarnished Undermine Real
			},
		},
		{ --Hellscream's Phantom
			name = AL["Hellscream's Phantom"],
			npcID = 227028,
			Level = 58,
			--SubAreaID = 0,
			DisplayIDs = {{121966}},
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  228410 }, -- Dreadblade of the Destructor
				{ 3,  228111 }, -- Mask of the Godslayer
				{ 4,  228112 }, -- Nightmare Gown
				{ 5,  228109 }, -- Legguards of Sacrifice
				{ 6,  228113 }, -- Cold Embraces
				{ 7,  228108 }, -- Shadow of Gorehowl
				{ 9,  228126 }, -- Aperitive Epiphany
				{ 16,  226404 }, -- Tarnished Undermine Real
			},
		},
	}
}

data["DireMaulEast"] = {
	name = AL["Dire Maul East"],
	MapID = 2557,
	--InstanceID = 429,
	SubAreaIDs = { 34776, 33730 },
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "DireMaul",
	AtlasMapFile = {"DireMaulEast", "DireMaulEnt"},
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = {31, 55, 60},
	ContentPhase = 4,
	items = {
		{ -- DMEPusillin
			name = AL["Pusillin"],
			npcID = 14354,
			Level = 57,
			DisplayIDs = {{7552}},
			AtlasMapBossID = "1-2",
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  18267 }, -- Recipe: Runn Tum Tuber Surprise
				{ 3,  18249 }, -- Crescent Key
				{ 16, 226404 }, -- Tarnished Undermine Real
			},
		},
		{ -- DMEZevrimThornhoof
			name = AL["Zevrim Thornhoof"],
			npcID = 11490,
			Level = 57,
			DisplayIDs = {{11335}},
			AtlasMapBossID = 3,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  228053 }, -- Fervent Helm
				{ 2,  18313 }, -- Helm of Awareness
				{ 3,  228050 }, -- Satyr's Bow
				{ 5,  18308 }, -- Clever Hat
				{ 6,  18306 }, -- Gloves of Shadowy Mist
				{ 16, 226404 }, -- Tarnished Undermine Real
			},
		},
		{ -- DMEHydro
			name = AL["Hydrospawn"],
			npcID = 13280,
			Level = 57,
			DisplayIDs = {{5489}},
			AtlasMapBossID = 3,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  228054 }, -- Tempest Talisman
				{ 2,  18322 }, -- Waterspout Boots
				{ 3,  228052 }, -- Waveslicer
				{ 5,  19268 }, -- Ace of Elementals
				{ 7,  18305 }, -- Breakwater Legguards
				{ 8,  18307 }, -- Riptide Shoes
				{ 16, 226404 }, -- Tarnished Undermine Real
			},
		},
		{ -- DMELethtendris
			name = AL["Lethtendris"],
			npcID = 14327,
			Level = 57,
			DisplayIDs = {{14378}},
			AtlasMapBossID = 3,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  18325 }, -- Felhide Cap
				{ 2,  228051 }, -- Quel'dorai Channeling Rod
				{ 4,  18301 }, -- Lethtendris's Wand
				{ 5,  18302 }, -- Band of Vigor
				{ 16, 226404 }, -- Tarnished Undermine Real
			},
		},
		{ -- DMEAlzzin
			name = AL["Alzzin the Wildshaper"],
			npcID = 11492,
			Level = 58,
			DisplayIDs = {{14416}},
			AtlasMapBossID = 5,
			SubAreaID = 33730,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  18328 }, -- Shadewood Cloak
				{ 2,  228055 }, -- Energized Chestplate
				{ 3,  18309 }, -- Gloves of Restoration
				{ 4,  18326 }, -- Razor Gauntlets
				{ 5,  18327 }, -- Whipvine Cord
				{ 6,  18318 }, -- Merciful Greaves
				{ 7,  18321 }, -- Energetic Rod
				{ 8,  228056 }, -- Fiendish Machete
				{ 9,  228699 }, -- Ring of Demonic Guile
				{ 10, 228057 }, -- Ring of Demonic Potency
				{ 16, 226404 }, -- Tarnished Undermine Real
			},
		},
		{ -- DMETrash
			name = AL["Trash"],
			ExtraList = true,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  18289 }, -- Barbed Thorn Necklace
				{ 2,  18296 }, -- Marksman Bands
				{ 3,  18298 }, -- Unbridled Leggings
				{ 4,  18295 }, -- Phasing Boots
				{ 6,  18333 }, -- Libram of Focus
				{ 7,  18334 }, -- Libram of Protection
				{ 8,  18332 }, -- Libram of Rapidity
				{ 10, 18255 }, -- Runn Tum Tuber
				{ 11, 18297 }, -- Thornling Seed
			},
		},
		{ -- DMEIsalien
			name = AL["Isalien"].." - "..format(AL["Tier %s Sets"], "0.5"),
			npcID = 16097,
			DisplayIDs = {{16000}},
			ExtraList = true,
			AtlasMapBossID = 5,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  228066 }, -- Ironweave Gloves
				{ 2,  22472 }, -- Boots of Ferocity
				{ 3,  22401 }, -- Libram of Hope
				{ 4,  22345 }, -- Totem of Rebirth
				{ 5,  22315 }, -- Hammer of Revitalization
				{ 6,  22314 }, -- Huntsman's Harpoon
			},
		},
		DM_BOOKS,
		KEYS,
	},
}

data["DireMaulWest"] = {
	name = AL["Dire Maul West"],
	MapID = 2557,
	--InstanceID = 429,
	SubAreaIDs = { 33748, 33749, 33750, 33710 },
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "DireMaul",
	AtlasMapFile = {"DireMaulWest", "DireMaulEnt"},
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = {31, 58, 60},
	ContentPhase = 4,
	items = {
		{ -- DMWTendrisWarpwood
			name = AL["Tendris Warpwood"],
			npcID = 11489,
			Level = 60,
			DisplayIDs = {{14383}},
			AtlasMapBossID = 2,
			SubAreaID = 33748,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  228063 }, -- Warpwood Binding
				{ 2,  228468 }, -- Tanglemoss Leggings
				{ 4,  18352 }, -- Petrified Bark Shield
				{ 5,  18353 }, -- Stoneflower Staff
				{ 16, 226404 }, -- Tarnished Undermine Real
			},
		},
		{ -- DMWIllyannaRavenoak
			name = AL["Illyanna Ravenoak"],
			npcID = 11488,
			Level = 60,
			DisplayIDs = {{11270}},
			SubAreaID = 33749,
			AtlasMapBossID = 3,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  18383 }, -- Force Imbued Gauntlets
				{ 2,  18386 }, -- Padre's Trousers
				{ 4,  18349 }, -- Gauntlets of Accuracy
				{ 5,  18347 }, -- Well Balanced Axe
				{ 16, 226404 }, -- Tarnished Undermine Real
			},
		},
		{ -- DMWMagisterKalendris
			name = AL["Magister Kalendris"],
			npcID = 11487,
			Level = 60,
			DisplayIDs = {{14384}},
			AtlasMapBossID = 4,
			SubAreaID = 33749,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  18374 }, -- Flamescarred Shoulders
				{ 2,  228067 }, -- Elder Magus Pendant
				{ 3,  18371 }, -- Mindtap Talisman
				{ 5,  18350 }, -- Amplifying Cloak
				{ 6,  18351 }, -- Magically Sealed Bracers
				{ 8,  22309 }, -- Pattern: Big Bag of Enchantment
				{ 16, 226404 }, -- Tarnished Undermine Real
				--{ 9,  22249 }, -- Big Bag of Enchantment
			},
		},
		{ -- DMWTsuzee
			name = AL["Tsu'zee"],
			npcID = 11467,
			Level = 60,
			DisplayIDs = {{11250}},
			specialType = "rare",
			AtlasMapBossID = 5,
			SubAreaID = 33749,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  228061 }, -- Brightspark Gloves
				{ 3,  18346 }, -- Threadbare Trousers
				{ 4,  18345 }, -- Murmuring Ring
			},
		},
		{ -- DMWImmolthar
			name = AL["Immol'thar"],
			npcID = 11496,
			Level = 61,
			DisplayIDs = {{14173}},
			AtlasMapBossID = 6,
			SubAreaID = 33750,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  18381 }, -- Evil Eye Pendant
				{ 2,  18384 }, -- Bile-etched Spaulders
				{ 3,  18389 }, -- Cloak of the Cosmos
				{ 4,  18385 }, -- Robe of Everlasting Night
				{ 5,  18394 }, -- Demon Howl Wristguards
				{ 6,  18377 }, -- Quickdraw Gloves
				{ 7,  18391 }, -- Eyestalk Cord
				{ 8,  18379 }, -- Odious Greaves
				{ 9,  18370 }, -- Vigilance Charm
				{ 10, 18372 }, -- Blade of the New Moon
				{ 16, 226404 }, -- Tarnished Undermine Real
			},
		},
		{ -- DMWPrinceTortheldrin
			name = AL["Prince Tortheldrin"],
			npcID = 11486,
			Level = 61,
			DisplayIDs = {{11256}},
			AtlasMapBossID = 7,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  18382 }, -- Fluctuating Cloak
				{ 2,  18373 }, -- Chestplate of Tranquility
				{ 3,  18375 }, -- Bracers of the Eclipse
				{ 4,  228470 }, -- Silvermoon Leggings
				{ 5,  228069 }, -- Eldritch Reinforced Legplates
				{ 6,  18395 }, -- Emerald Flame Ring
				{ 7,  228471 }, -- Stoneshatter
				{ 8,  18396 }, -- Mind Carver
				{ 9,  18376 }, -- Timeworn Mace
				{ 10, 228472 }, -- Distracting Dagger
				{ 16, 226404 }, -- Tarnished Undermine Real
			},
		},
		{ -- DMWTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  18340 }, -- Eidolon Talisman
				{ 2,  18344 }, -- Stonebark Gauntlets
				{ 3,  18338 }, -- Wand of Arcane Potency
				{ 5,  18333 }, -- Libram of Focus
				{ 6,  18334 }, -- Libram of Protection
				{ 7,  18332 }, -- Libram of Rapidity
			},
		},
		{ -- DMWRevanchion
			name = AL["Revanchion"],
			npcID = 14690,
			DisplayIDs = {{14695}},
			AtlasMapBossID = 2,
			specialType = "scourgeInvasion",
			ExtraList = true,
			ContentPhase = 8,
			[NORMAL_DIFF] = {
				{ 1, 23127 }, -- Cloak of Revanchion
				{ 2, 23129 }, -- Bracers of Mending
				{ 3, 23128 }, -- The Shadow's Grasp
			},
		},
		{ -- DMWShendralarProvisioner
			name = AL["Shen'dralar Provisioner"],
			npcID = 14371,
			DisplayIDs = {{14412}},
			ExtraList = true,
			AtlasMapBossID = "1'",
			IgnoreAsSource = true,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  18487, [PRICE_EXTRA_ITTYPE] = "money:40000" }, -- Pattern: Mooncloth Robe
				--{ 2,  18486 }, -- Mooncloth Robe
			},
		},
		{ -- DMWHelnurath
			name = AL["Lord Hel'nurath"],
			npcID = 14506,
			DisplayIDs = {{14556}},
			ExtraList = true,
			AtlasMapBossID = 6,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  228475 }, -- Diabolic Mantle
				{ 2,  18754 }, -- Fel Hardened Bracers
				{ 3,  18755 }, -- Xorothian Firestick
				{ 4,  18756 }, -- Dreadguard's Protector
			},
		},
		DM_BOOKS,
		KEYS,
	},
}

data["DireMaulNorth"] = {
	name = AL["Dire Maul North"],
	MapID = 2557,
	--InstanceID = 429,
	SubAreaIDs = { 33774, 33775 },
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "DireMaulNorth",
	AtlasMapFile = {"DireMaulNorth", "DireMaulEnt"},
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = {31, 58, 60},
	ContentPhase = 4,
	items = {
		{ -- DMNGuardMoldar
			name = AL["Guard Mol'dar"],
			npcID = 14326,
			Level = 59,
			DisplayIDs = {{11561}},
			AtlasMapBossID = 1,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  228059 }, -- Denwatcher's Shoulders
				{ 2,  228058 }, -- Bulky Iron Spaulders
				{ 3,  228060 }, -- Heliotrope Cloak
				{ 4,  18497 }, -- Sublime Wristguards
				{ 5,  18498 }, -- Hedgecutter
				{ 7,  18450 }, -- Robe of Combustion
				{ 8,  18458 }, -- Modest Armguards
				{ 9,  18459 }, -- Gallant's Wristguards
				{ 10, 18451 }, -- Hyena Hide Belt
				{ 11, 18462 }, -- Jagged Bone Fist
				{ 12, 18463 }, -- Ogre Pocket Knife
				{ 13, 18464 }, -- Gordok Nose Ring
				{ 14, 18460 }, -- Unsophisticated Hand Cannon
				{ 16, 18250 }, -- Gordok Shackle Key
				{ 17, 18268 }, -- Gordok Inner Door Key
			},
		},
		{ -- DMNStomperKreeg
			name = AL["Stomper Kreeg"],
			npcID = 14322,
			Level = 59,
			DisplayIDs = {{11545}},
			AtlasMapBossID = 2,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  18425 }, -- Kreeg's Mug
				{ 16, "INV_Box_01", nil, AL["Sells:"], nil },
				{ 17, 18269, [PRICE_EXTRA_ITTYPE] = "money:1500" }, -- Gordok Green Grog
				{ 18, 18284, [PRICE_EXTRA_ITTYPE] = "money:1500" }, -- Kreeg's Stout Beatdown
				{ 19, 18287, [PRICE_EXTRA_ITTYPE] = "money:200" }, -- Evermurky
				{ 20, 18288, [PRICE_EXTRA_ITTYPE] = "money:1500" }, -- Molasses Firewater
				{ 21, 9260, [PRICE_EXTRA_ITTYPE] = "money:1600" }, -- Volatile Rum
			},
		},
		{ -- DMNGuardFengus
			name = AL["Guard Fengus"],
			npcID = 14321,
			Level = 59,
			DisplayIDs = {{11561}},
			AtlasMapBossID = 3,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  18450 }, -- Robe of Combustion
				{ 2,  18458 }, -- Modest Armguards
				{ 3,  18459 }, -- Gallant's Wristguards
				{ 4,  18451 }, -- Hyena Hide Belt
				{ 5,  18462 }, -- Jagged Bone Fist
				{ 6,  18463 }, -- Ogre Pocket Knife
				{ 7,  18464 }, -- Gordok Nose Ring
				{ 8,  18460 }, -- Unsophisticated Hand Cannon
				{ 10, 18250 }, -- Gordok Shackle Key
				{ 16, "INV_Box_01", nil, AL["Fengus's Chest"], nil },
				{ 17, 18266 }, -- Gordok Courtyard Key
			},
		},
		{ -- DMNGuardSlipkik
			name = AL["Guard Slip'kik"],
			npcID = 14323,
			Level = 59,
			DisplayIDs = {{11561}},
			AtlasMapBossID = 4,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  228059 }, -- Denwatcher's Shoulders
				{ 2,  228058 }, -- Bulky Iron Spaulders
				{ 3,  228060 }, -- Heliotrope Cloak
				{ 4,  18497 }, -- Sublime Wristguards
				{ 5,  18498 }, -- Hedgecutter
				{ 7,  18450 }, -- Robe of Combustion
				{ 8,  18458 }, -- Modest Armguards
				{ 9,  18459 }, -- Gallant's Wristguards
				{ 10, 18451 }, -- Hyena Hide Belt
				{ 11, 18462 }, -- Jagged Bone Fist
				{ 12, 18463 }, -- Ogre Pocket Knife
				{ 13, 18464 }, -- Gordok Nose Ring
				{ 14, 18460 }, -- Unsophisticated Hand Cannon
				{ 16, 18250 }, -- Gordok Shackle Key
			},
		},
		{ -- DMNThimblejack
			name = AL["Knot Thimblejack's Cache"],
			AtlasMapBossID = 4,
			npcID = 14338,
			ObjectID = 179501,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  18414 }, -- Pattern: Belt of the Archmage
				{ 16,  18517 }, -- Pattern: Chromatic Cloak
				{ 17,  18518 }, -- Pattern: Hide of the Wild
				{ 18,  18519 }, -- Pattern: Shifting Cloak
				{ 5,  18415 }, -- Pattern: Felcloth Gloves
				{ 6,  18416 }, -- Pattern: Inferno Gloves
				{ 7,  18417 }, -- Pattern: Mooncloth Gloves
				{ 8,  18418 }, -- Pattern: Cloak of Warding
				{ 20, 18514 }, -- Pattern: Girdle of Insight
				{ 21, 18515 }, -- Pattern: Mongoose Boots
				{ 22, 18516 }, -- Pattern: Swift Flight Bracers
				{ 10, 18258 }, -- Gordok Ogre Suit
				{ 11, 18240 }, -- Ogre Tannin
			},
		},
		{ -- DMNCaptainKromcrush
			name = AL["Captain Kromcrush"],
			npcID = 14325,
			Level = 61,
			DisplayIDs = {{11564}},
			AtlasMapBossID = 5,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  18503 }, -- Kromcrush's Chestplate
				{ 2,  228068 }, -- Mugger's Belt
				{ 3,  18507 }, -- Boots of the Full Moon
				{ 4,  18502 }, -- Monstrous Glaive
			},
		},
		{ -- DMNChoRush
			name = AL["Cho'Rush the Observer"],
			npcID = 14324,
			Level = 60,
			DisplayIDs = {{11537}},
			AtlasMapBossID = 6,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  228062 }, -- Insightful Hood
				{ 2,  18483 }, -- Mana Channeling Wand
				{ 3,  228064 }, -- Observer's Shield
				{ 4,  18484 }, -- Cho'Rush's Blade
			},
		},
		{ -- DMNKingGordok
			name = AL["King Gordok"],
			npcID = 11501,
			Level = 62,
			DisplayIDs = {{11583}},
			AtlasMapBossID = 6,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  228480 }, -- Crown of the Ogre King
				{ 2,  18525 }, -- Bracers of Prosperity
				{ 3,  18527 }, -- Harmonious Gauntlets
				{ 4,  228479 }, -- Leggings of Destruction
				{ 5,  18521 }, -- Grimy Metal Boots
				{ 6,  18522 }, -- Band of the Ogre King
				{ 7,  18523 }, -- Brightly Glowing Stone
				{ 8,  228478 }, -- Barbarous Blade
				{ 16, 226404 }, -- Tarnished Undermine Real
				{ 18, 19258 }, -- Ace of Warlords
				{ 20, 18780 }, -- Top Half of Advanced Armorsmithing: Volume I
			},
		},
		{ -- DMNTRIBUTERUN
			name = AL["Tribute"],
			ExtraList = true,
			npcID = 14324,
			ObjectID = 179564,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  228486 }, -- Treant's Bane
				{ 3,  228065 }, -- Cyclone Spaulders
				{ 4,  18495 }, -- Redoubt Cloak
				{ 5,  228474 }, -- Mindsurge Robe
				{ 6,  228070 }, -- Ogre Forged Hauberk
				{ 7,  18533 }, -- Gordok Bracers of Power
				{ 8,  18529 }, -- Elemental Plate Girdle
				{ 9,  228469 }, -- Tarnished Elven Ring
				{ 10, 18537 }, -- Counterattack Lodestone
				{ 11, 18499 }, -- Barrier Shield
				{ 12, 228473 }, -- Unyielding Maul
				{ 13, 228484 }, -- Rod of the Ogre Magi
				{ 16, 18479 }, -- Carrion Scorpid Helm
				{ 17, 18480 }, -- Scarab Plate Helm
				{ 18, 18478 }, -- Hyena Hide Jerkin
				{ 19, 18475 }, -- Oddly Magical Belt
				{ 20, 18477 }, -- Shaggy Leggings
				{ 21, 18476 }, -- Mud Stained Boots
				{ 22, 18482 }, -- Ogre Toothpick Shooter
				{ 23, 18481 }, -- Skullcracking Mace
				{ 25, 18655 }, -- Schematic: Major Recombobulator
			},
		},
		{ -- DMNTrash
			name = AL["Trash"],
			ExtraList = true,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  18250 }, -- Gordok Shackle Key
				{ 3,  18333 }, -- Libram of Focus
				{ 4,  18334 }, -- Libram of Protection
				{ 5,  18332 }, -- Libram of Rapidity
				{ 7,  18640 }, -- Happy Fun Rock
			},
		},
		DM_BOOKS,
		KEYS,
	},
}

data["Scholomance"] = {
	MapID = 2057,
	InstanceID = 289,
	SubAreaIDs = { 32549, 32574, 32567, 32577, 32566, 32565, 32581, 32579, 32573, 32568, 32576, 32569 },
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "Scholomance",
	AtlasMapFile = "CL_Scholomance",
	AtlasMapFile_AL = "Scholomance",
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = {45, 58, 60},
	ContentPhase = 4,
	items = {
		{ -- SCHOLOBlood
			name = AL["Blood Steward of Kirtonos"],
			npcID = 14861,
			Level = 61,
			SubAreaID = 32573,
			DisplayIDs = {{10925}},
			AtlasMapBossID = 1,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  13523 }, -- Blood of Innocents
			},
		},
		{ -- SCHOLOKirtonostheHerald
			name = AL["Kirtonos the Herald"],
			npcID = 10506,
			Level = 60,
			SubAreaID = 32574,
			DisplayIDs = {{7534}},
			AtlasMapBossID = 2,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  226764 }, -- Boots of Valor
				{ 3,  228019 }, -- Heart of the Fiend
				{ 4,  228001 }, -- Stoneform Shoulders
				{ 5,  13969 }, -- Loomguard Armbraces
				{ 6,  228007 }, -- Gargoyle Slashers
				{ 7,  228005 }, -- Clutch of Andros
				{ 8,  228004 }, -- Windreaver Greaves
				{ 9,  228015 }, -- Frightalon
				{ 10, 228029 }, -- Gravestone War Axe
				{ 16, 226404 }, -- Tarnished Undermine Real
			},
		},
		{ -- SCHOLOJandiceBarov
			name = AL["Jandice Barov"],
			npcID = 10503,
			Level = 61,
			DisplayIDs = {{11073}},
			AtlasMapBossID = 3,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  226756 }, -- Dreadmist Mantle
				{ 3,  14548 }, -- Royal Cap Spaulders
				{ 4,  18689 }, -- Phantasmal Cloak
				{ 5,  228031 }, -- Darkshade Gloves
				{ 6,  228040 }, -- Ghostloom Leggings
				{ 7,  228041 }, -- Wraithplate Leggings
				{ 8,  227997 }, -- Barovian Family Sword
				{ 9,  22394 }, -- Staff of Metanoia
				{ 12, 13523 }, -- Blood of Innocents
				{ 16, 226404 }, -- Tarnished Undermine Real
			},
		},
		{ -- SCHOLORattlegore
			name = AL["Rattlegore"],
			npcID = 11622,
			Level = 61,
			SubAreaID = 32577,
			DisplayIDs = {{12073}},
			AtlasMapBossID = 5,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  226703 }, -- Shadowcraft Boots
				{ 3,  228032 }, -- Bone Ring Helm
				{ 4,  14538 }, -- Deadwalker Mantle
				{ 5,  18686 }, -- Bone Golem Shoulders
				{ 6,  14537 }, -- Corpselight Greaves
				{ 7,  228037 }, -- Rattlecage Buckler
				{ 8,  227994 }, -- Frightskull Shaft
				{ 10, 18782 }, -- Top Half of Advanced Armorsmithing: Volume II
				{ 12, 13873 }, -- Viewing Room Key
				{ 16, 226404 }, -- Tarnished Undermine Real
			},
		},
		{ -- SCHOLODeathKnight
			name = AL["Death Knight Darkreaver"],
			npcID = 14516,
			Level = 61,
			SubAreaID = 32577,
			DisplayIDs = {{14591}},
			AtlasMapBossID = 5,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  228045 }, -- Necromantic Band
				{ 2,  18761 }, -- Oblivion's Touch
				{ 3,  18758 }, -- Specter's Blade
				{ 4,  228030 }, -- Malicious Axe
			},
		},
		{ -- SCHOLOMarduk
			name = AL["Marduk Blackpool"],
			npcID = 10433,
			Level = 58,
			SubAreaID = 32576,
			DisplayIDs = {{10248}},
			AtlasMapBossID = 6,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  227992 }, -- Death Knight Sabatons
				{ 2,  227993 }, -- Ebon Hilt of Marduk
			},
		},
		{ -- SCHOLOVectus
			name = AL["Vectus"],
			npcID = 10432,
			Level = 60,
			SubAreaID = 32576,
			DisplayIDs = {{2606}},
			AtlasMapBossID = 6,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  18691 }, -- Dark Advisor's Pendant
				{ 2,  228017 }, -- Skullsmoke Pants
				{ 16,  226404 }, -- Tarnished Undermine Real
			},
		},
		{ -- SCHOLORasFrostwhisper
			name = AL["Ras Frostwhisper"],
			npcID = 10508,
			Level = 62,
			SubAreaID = 32579,
			DisplayIDs = {{7919}},
			AtlasMapBossID = 7,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  228023 }, -- Alanna's Embrace
				{ 3,  226726 }, -- Magister's Mantle
				{ 5,  228036 }, -- Death's Clutch
				{ 6,  14340 }, -- Freezing Lich Robes
				{ 7,  228034 }, -- Shivery Handwraps
				{ 8,  14525 }, -- Boneclenched Gauntlets
				{ 9,  14502 }, -- Frostbite Girdle
				{ 10, 228044 }, -- Maelstrom Leggings
				{ 11, 18694 }, -- Shadowy Mail Greaves
				{ 12, 228039 }, -- Spellbound Tome
				{ 13, 18696 }, -- Intricately Runed Shield
				{ 14, 228027 }, -- Iceblade Hacker
				{ 15, 14487 }, -- Bonechill Hammer
				{ 16, 226404 }, -- Tarnished Undermine Real
				{ 18, 13521 }, -- Recipe: Flask of Supreme Power
			},
		},
		{ -- SCHOLOInstructorMalicia
			name = AL["Instructor Malicia"],
			npcID = 10505,
			Level = 60,
			SubAreaID = 32567,
			DisplayIDs = {{11069}},
			AtlasMapBossID = 8,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  226704 }, -- Shadowcraft Bracers
				{ 2,  18681 }, -- Burial Shawl
				{ 3,  228010 }, -- Necropile Mantle
				{ 4,  228013 }, -- Necropile Robe
				{ 5,  14637 }, -- Cadaverous Armor
				{ 6,  228012 }, -- Bloodmail Hauberk
				{ 7,  228000 }, -- Deathbone Chestplate
				{ 8, 228011 }, -- Necropile Cuffs
				{ 9, 14640 }, -- Cadaverous Gloves
				{ 10, 228020 }, -- Bloodmail Gauntlets
				{ 11, 228006 }, -- Deathbone Gauntlets
				{ 12, 14636 }, -- Cadaverous Belt
				{ 13, 228014 }, -- Bloodmail Belt
				{ 14, 228002 }, -- Deathbone Girdle
				{ 15, 228018 }, -- Necropile Leggings
				{ 16, 226404 }, -- Tarnished Undermine Real
				{ 18, 14638 }, -- Cadaverous Leggings
				{ 19, 18682 }, -- Ghoul Skin Leggings
				{ 20, 228003 }, -- Bloodmail Legguards
				{ 21, 228008 }, -- Deathbone Legguards
				{ 22, 228009 }, -- Necropile Boots
				{ 23, 14641 }, -- Cadaverous Walkers
				{ 24, 227998 }, -- Bloodmail Boots
				{ 25, 227999 }, -- Deathbone Sabatons
				{ 26, 228016 }, -- Dimly Opalescent Ring
				{ 27, 23201 }, -- Libram of Divinity
				{ 28, 23200 }, -- Totem of Sustaining
				{ 29, 227996 }, -- Ancient Bone Bow
				{ 30, 18683 }, -- Hammer of the Vesper
			},
		},
		{ -- SCHOLODoctorTheolenKrastinov
			name = AL["Doctor Theolen Krastinov"],
			npcID = 11261,
			Level = 60,
			SubAreaID = 32565,
			DisplayIDs = {{10901}},
			AtlasMapBossID = 9,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  226731 }, -- Magister's Gloves
				{ 2,  14617 }, -- Sawbones Shirt
				{ 3,  18681 }, -- Burial Shawl
				{ 4,  228010 }, -- Necropile Mantle
				{ 5,  228013 }, -- Necropile Robe
				{ 6,  14637 }, -- Cadaverous Armor
				{ 7,  228012 }, -- Bloodmail Hauberk
				{ 8,  228000 }, -- Deathbone Chestplate
				{ 9, 228011 }, -- Necropile Cuffs
				{ 10, 14640 }, -- Cadaverous Gloves
				{ 11, 228020 }, -- Bloodmail Gauntlets
				{ 12, 228006 }, -- Deathbone Gauntlets
				{ 13, 14636 }, -- Cadaverous Belt
				{ 14, 228014 }, -- Bloodmail Belt
				{ 15, 228002 }, -- Deathbone Girdle
				{ 16, 226404 }, -- Tarnished Undermine Real
				{ 17, 228018 }, -- Necropile Leggings
				{ 18, 14638 }, -- Cadaverous Leggings
				{ 19, 18682 }, -- Ghoul Skin Leggings
				{ 20, 228003 }, -- Bloodmail Legguards
				{ 21, 228008 }, -- Deathbone Legguards
				{ 22, 228009 }, -- Necropile Boots
				{ 23, 14641 }, -- Cadaverous Walkers
				{ 24, 227998 }, -- Bloodmail Boots
				{ 25, 227999 }, -- Deathbone Sabatons
				{ 26, 228016 }, -- Dimly Opalescent Ring
				{ 27, 23201 }, -- Libram of Divinity
				{ 28, 23200 }, -- Totem of Sustaining
				{ 29, 227996 }, -- Ancient Bone Bow
				{ 30, 18683 }, -- Hammer of the Vesper
			},
		},
		{ -- SCHOLOLorekeeperPolkelt
			name = AL["Lorekeeper Polkelt"],
			npcID = 10901,
			Level = 60,
			SubAreaID = 32566,
			DisplayIDs = {{11492}},
			AtlasMapBossID = 10,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  226758 }, -- Dreadmist Wraps
				{ 2,  18681 }, -- Burial Shawl
				{ 3,  228010 }, -- Necropile Mantle
				{ 4,  228013 }, -- Necropile Robe
				{ 5,  14637 }, -- Cadaverous Armor
				{ 6,  228012 }, -- Bloodmail Hauberk
				{ 7,  228000 }, -- Deathbone Chestplate
				{ 8, 228011 }, -- Necropile Cuffs
				{ 9, 14640 }, -- Cadaverous Gloves
				{ 10, 228020 }, -- Bloodmail Gauntlets
				{ 11, 228006 }, -- Deathbone Gauntlets
				{ 12, 14636 }, -- Cadaverous Belt
				{ 13, 228014 }, -- Bloodmail Belt
				{ 14, 228002 }, -- Deathbone Girdle
				{ 15, 228018 }, -- Necropile Leggings
				{ 16, 226404 }, -- Tarnished Undermine Real
				{ 18, 14638 }, -- Cadaverous Leggings
				{ 19, 18682 }, -- Ghoul Skin Leggings
				{ 20, 228003 }, -- Bloodmail Legguards
				{ 21, 228008 }, -- Deathbone Legguards
				{ 22, 228009 }, -- Necropile Boots
				{ 23, 14641 }, -- Cadaverous Walkers
				{ 24, 227998 }, -- Bloodmail Boots
				{ 25, 227999 }, -- Deathbone Sabatons
				{ 26, 228016 }, -- Dimly Opalescent Ring
				{ 27, 23201 }, -- Libram of Divinity
				{ 28, 23200 }, -- Totem of Sustaining
				{ 29, 227996 }, -- Ancient Bone Bow
				{ 30, 18683 }, -- Hammer of the Vesper
			},
		},
		{ -- SCHOLOTheRavenian
			name = AL["The Ravenian"],
			npcID = 10507,
			Level = 60,
			SubAreaID = 32569,
			DisplayIDs = {{10433}},
			AtlasMapBossID = 11,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  226712 }, -- Wildheart Belt
				{ 2,  18681 }, -- Burial Shawl
				{ 3,  228010 }, -- Necropile Mantle
				{ 4,  228013 }, -- Necropile Robe
				{ 5,  14637 }, -- Cadaverous Armor
				{ 6,  228012 }, -- Bloodmail Hauberk
				{ 7,  228000 }, -- Deathbone Chestplate
				{ 8, 228011 }, -- Necropile Cuffs
				{ 9, 14640 }, -- Cadaverous Gloves
				{ 10, 228020 }, -- Bloodmail Gauntlets
				{ 11, 228006 }, -- Deathbone Gauntlets
				{ 12, 14636 }, -- Cadaverous Belt
				{ 13, 228014 }, -- Bloodmail Belt
				{ 14, 228002 }, -- Deathbone Girdle
				{ 15, 228018 }, -- Necropile Leggings
				{ 16, 226404 }, -- Tarnished Undermine Real
				{ 18, 14638 }, -- Cadaverous Leggings
				{ 19, 18682 }, -- Ghoul Skin Leggings
				{ 20, 228003 }, -- Bloodmail Legguards
				{ 21, 228008 }, -- Deathbone Legguards
				{ 22, 228009 }, -- Necropile Boots
				{ 23, 14641 }, -- Cadaverous Walkers
				{ 24, 227998 }, -- Bloodmail Boots
				{ 25, 227999 }, -- Deathbone Sabatons
				{ 26, 228016 }, -- Dimly Opalescent Ring
				{ 27, 23201 }, -- Libram of Divinity
				{ 28, 23200 }, -- Totem of Sustaining
				{ 29, 227996 }, -- Ancient Bone Bow
				{ 30, 18683 }, -- Hammer of the Vesper
			},
		},
		{ -- SCHOLOLordAlexeiBarov
			name = AL["Lord Alexei Barov"],
			npcID = 10504,
			Level = 60,
			SubAreaID = 32549,
			DisplayIDs = {{11072}},
			AtlasMapBossID = 12,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  226739 }, -- Lightforge Bracers
				{ 2,  18681 }, -- Burial Shawl
				{ 3,  228010 }, -- Necropile Mantle
				{ 4,  228013 }, -- Necropile Robe
				{ 5,  14637 }, -- Cadaverous Armor
				{ 6,  228012 }, -- Bloodmail Hauberk
				{ 7,  228000 }, -- Deathbone Chestplate
				{ 8, 228011 }, -- Necropile Cuffs
				{ 9, 14640 }, -- Cadaverous Gloves
				{ 10, 228020 }, -- Bloodmail Gauntlets
				{ 11, 228006 }, -- Deathbone Gauntlets
				{ 12, 14636 }, -- Cadaverous Belt
				{ 13, 228014 }, -- Bloodmail Belt
				{ 14, 228002 }, -- Deathbone Girdle
				{ 15, 228018 }, -- Necropile Leggings
				{ 16, 226404 }, -- Tarnished Undermine Real
				{ 18, 14638 }, -- Cadaverous Leggings
				{ 19, 18682 }, -- Ghoul Skin Leggings
				{ 20, 228003 }, -- Bloodmail Legguards
				{ 21, 228008 }, -- Deathbone Legguards
				{ 22, 228009 }, -- Necropile Boots
				{ 23, 14641 }, -- Cadaverous Walkers
				{ 24, 227998 }, -- Bloodmail Boots
				{ 25, 227999 }, -- Deathbone Sabatons
				{ 26, 228016 }, -- Dimly Opalescent Ring
				{ 27, 23201 }, -- Libram of Divinity
				{ 28, 23200 }, -- Totem of Sustaining
				{ 29, 227996 }, -- Ancient Bone Bow
				{ 30, 18683 }, -- Hammer of the Vesper
			},
		},
		{ -- SCHOLOLadyIlluciaBarov
			name = AL["Lady Illucia Barov"],
			npcID = 10502,
			Level = 60,
			SubAreaID = 32568,
			DisplayIDs = {{11835}},
			AtlasMapBossID = 13,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  18681 }, -- Burial Shawl
				{ 2,  228010 }, -- Necropile Mantle
				{ 3,  228013 }, -- Necropile Robe
				{ 4,  14637 }, -- Cadaverous Armor
				{ 5,  228012 }, -- Bloodmail Hauberk
				{ 6,  228000 }, -- Deathbone Chestplate
				{ 7, 228011 }, -- Necropile Cuffs
				{ 8, 14640 }, -- Cadaverous Gloves
				{ 9, 228020 }, -- Bloodmail Gauntlets
				{ 10, 228006 }, -- Deathbone Gauntlets
				{ 11, 14636 }, -- Cadaverous Belt
				{ 12, 228014 }, -- Bloodmail Belt
				{ 13, 228002 }, -- Deathbone Girdle
				{ 14, 228018 }, -- Necropile Leggings
				{ 16, 226404 }, -- Tarnished Undermine Real
				{ 18, 14638 }, -- Cadaverous Leggings
				{ 19, 18682 }, -- Ghoul Skin Leggings
				{ 20, 228003 }, -- Bloodmail Legguards
				{ 21, 228008 }, -- Deathbone Legguards
				{ 22, 228009 }, -- Necropile Boots
				{ 23, 14641 }, -- Cadaverous Walkers
				{ 24, 227998 }, -- Bloodmail Boots
				{ 25, 227999 }, -- Deathbone Sabatons
				{ 26, 228016 }, -- Dimly Opalescent Ring
				{ 27, 23201 }, -- Libram of Divinity
				{ 28, 23200 }, -- Totem of Sustaining
				{ 29, 227996 }, -- Ancient Bone Bow
				{ 30, 18683 }, -- Hammer of the Vesper
			},
		},
		{ -- SCHOLODarkmasterGandling
			name = AL["Darkmaster Gandling"],
			npcID = 1853,
			Level = 61,
			SubAreaID = 32581,
			DisplayIDs = {{11070}},
			AtlasMapBossID = 14,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  228022 }, -- Headmaster's Charge
				{ 2,  14514 }, -- Pattern: Robe of the Void
				{ 4,  226746 }, -- Devout Crown
				{ 5,  226728 }, -- Magister's Crown
				{ 6,  226762 }, -- Dreadmist Mask
				{ 7,  226707 }, -- Shadowcraft Cap
				{ 8,  226708 }, -- Wildheart Cowl
				{ 9, 226720 }, -- Beaststalker's Cap
				{ 10, 226755 }, -- Coif of Elements
				{ 11, 226733 }, -- Lightforge Helm
				{ 12, 226769 }, -- Helm of Valor
				{ 13, 228025 }, -- Tombstone Breastplate
				{ 14, 13951 }, -- Vigorsteel Vambraces
				{ 15, 228042 }, -- Detention Strap
				{ 16, 226404 }, -- Tarnished Undermine Real
				{ 18, 13398 }, -- Boots of the Shrieker
				{ 19, 228046 }, -- Don Mauricio's Band of Domination
				{ 20, 13938 }, -- Bonecreeper Stylus
				{ 21, 228024 }, -- Silent Fang
				{ 22, 228021 }, -- Witchblade
				{ 23, 19276 }, -- Ace of Portals
				{ 25, 13501 }, -- Recipe: Major Mana Potion
			},
		},
		{ -- SCHOLOTrash
			name = AL["Trash"],
			ExtraList = true,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  226724 }, -- Magister's Belt
				{ 2,  226761 }, -- Dreadmist Belt
				{ 3,  226704 }, -- Shadowcraft Bracers
				{ 4,  226714 }, -- Wildheart Bracers
				{ 5,  226712 }, -- Wildheart Belt
				{ 6,  226751 }, -- Bindings of Elements
				{ 7,  226739 }, -- Lightforge Bracers
				{ 9,  12843 }, -- Corruptor's Scourgestone
				{ 10, 12841 }, -- Invader's Scourgestone
				{ 11, 12840 }, -- Minion's Scourgestone
				{ 13, 20520 }, -- Dark Rune
				{ 14, 12753 }, -- Skin of Shadow
				{ 16, 228704 }, -- Tattered Leather Hood
				{ 17, 18699 }, -- Icy Tomb Spaulders
				{ 18, 14536 }, -- Bonebrace Hauberk
				{ 19, 18700 }, -- Malefic Bracers
				{ 20, 18702 }, -- Belt of the Ordained
				{ 21, 228703 }, -- Coldstone Slippers
				{ 22, 18701 }, -- Innervating Band
				{ 24, 16254 }, -- Formula: Enchant Weapon - Lifestealing
				{ 25, 16255 }, -- Formula: Enchant 2H Weapon - Major Spirit
				{ 26, 15773 }, -- Pattern: Wicked Leather Armor
				{ 27, 15776 }, -- Pattern: Runic Leather Armor
				{ 29, 13920 }, -- Healthy Dragon Scale
			},
		},
		{ -- SCHOLOLordB
			name = AL["Lord Blackwood"],
			npcID = 14695,
			DisplayIDs = {{14699}},
			AtlasMapBossID = 2,
			ContentPhase = 8,
			specialType = "scourgeInvasion",
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  23132 }, -- Lord Blackwood's Blade
				{ 2,  23156 }, -- Blackwood's Thigh
				{ 3,  23139 }, -- Lord Blackwood's Buckler
			},
		},
		{ -- SCHOLOKormok
			name = AL["Kormok"].." - "..format(AL["Tier %s Sets"], "0.5"),
			npcID = 16118,
			DisplayIDs = {{16020}},
			ExtraList = true,
			ContentPhase = 4,
			AtlasMapBossID = 7,
			[NORMAL_DIFF] = {
				{ 1,  228038 }, -- Ironweave Pants
				{ 2,  228047 }, -- Amalgam's Band
				{ 3,  22331 }, -- Band of the Steadfast Hero
				{ 4,  228028 }, -- Blade of Necromancy
				{ 5,  228033 }, -- Hammer of Divine Might
			},
		},
		KEYS,
	},
}

data["Stratholme"] = {
	MapID = 2017,
	InstanceID = 329,
	SubAreaIDs = {
		-- Living
		32319, 32320, 32367, 32331, 32357, 32281, 32285, 32277,
		-- Undead
		32342, 32322, 32303, 32301, 32352,
		-- Ziggurats
		32344, 32345, 32349,
	},
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "Stratholme",
	AtlasMapFile = "CL_Stratholme",
	AtlasMapFile_AL = "Stratholme",
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	ContentPhase = 4,
	LevelRange = GetForVersion({37, 58, 60}, {45, 58, 60}),
	items = {
		{ -- STRATSkull
			name = AL["Skul"],
			NameColor = GREEN,
			npcID = 10393,
			Level = 58,
			DisplayIDs = {{2606}},
			AtlasMapBossID = 1,
			specialType = "rare",
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  13395 }, -- Skul's Fingerbone Claws
				{ 2,  13394 }, -- Skul's Cold Embrace
				{ 3,  13396 }, -- Skul's Ghastly Touch
			},
		},
		{ -- STRATEzraGrimm
			name = AL["Ezra Grimm"],
			NameColor = GREEN,
			npcID = 11058,
			Level = 61,
			DisplayIDs = {{10475}},
			AtlasMapBossID = 1,
			specialType = "rare",
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1, 226404 }, -- Tarnished Undermine Real
			},
		},
		{ -- STRATStratholmeCourier
			name = AL["Stratholme Courier"],
			NameColor = GREEN,
			npcID = 11082,
			Level = 57,
			DisplayIDs = {{10547}},
			AtlasMapBossID = 1,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  13303 }, -- Crusaders' Square Postbox Key
				{ 2,  13305 }, -- Elders' Square Postbox Key
				{ 3,  13304 }, -- Festival Lane Postbox Key
				{ 4,  13307 }, -- Fras Siabi's Postbox Key
				{ 5,  13306 }, -- King's Square Postbox Key
				{ 6,  13302 }, -- Market Row Postbox Key
			},
		},
		{ -- STRATHearthsingerForresten
			name = AL["Hearthsinger Forresten"],
			NameColor = GREEN,
			npcID = 10558,
			Level = 57,
			SubAreaID = 32277,
			DisplayIDs = {{10482}},
			AtlasMapBossID = 3,
			specialType = "rare",
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  226730 }, -- Magister's Boots
				{ 3,  228501 }, -- Songbird Blouse
				{ 4,  228504 }, -- Rainbow Girdle
				{ 5,  228503 }, -- Woollies of the Prancing Minstrel
				{ 6,  228502 }, -- Piccolo of the Flaming Fire
			},
		},
		{ -- STRATTheUnforgiven
			name = AL["The Unforgiven"],
			NameColor = GREEN,
			npcID = 10516,
			Level = 57,
			SubAreaID = 32281,
			DisplayIDs = {{10771}},
			AtlasMapBossID = 4,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  226711 }, -- Wildheart Gloves
				{ 3,  228500 }, -- Mask of the Unforgiven
				{ 4,  13405 }, -- Wailing Nightbane Pauldrons
				{ 5,  13409 }, -- Tearfall Bracers
				{ 6,  13408 }, -- Soul Breaker
				{ 16, 226404 }, -- Tarnished Undermine Real
			},
		},
		{ -- STRATPostmaster
			name = AL["Postmaster Malown"],
			NameColor = GREEN,
			npcID = 11143,
			Level = 60,
			DisplayIDs = {{10669}},
			AtlasMapBossID = "6'",
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  228528 }, -- The Postmaster's Band
				{ 2,  228525 }, -- The Postmaster's Tunic
				{ 3,  228527 }, -- The Postmaster's Trousers
				{ 4,  228529 }, -- The Postmaster's Treads
				{ 5,  228524 }, -- The Postmaster's Seal
				{ 6,  13393 }, -- Malown's Slam
				{ 16, 226404 }, -- Tarnished Undermine Real
			},
		},
		{ -- STRATTimmytheCruel
			name = AL["Timmy the Cruel"],
			NameColor = GREEN,
			npcID = 10808,
			Level = 58,
			SubAreaID = 32319,
			DisplayIDs = {{571}},
			AtlasMapBossID = 6,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  226737 }, -- Lightforge Gauntlets
				{ 3,  228513 }, -- Vambraces of the Sadist
				{ 4,  228515 }, -- Grimgore Noose
				{ 5,  228514 }, -- Timmy's Galoshes
				{ 6,  13401 }, -- The Cruel Hand of Timmy
				{ 16, 226404 }, -- Tarnished Undermine Real
			},
		},
		{ -- STRATMalorsStrongbox
			name = AL["Malor the Zealous"],
			NameColor = GREEN,
			npcID = 11032,
			ObjectID = 176112,
			Level = 60,
			SubAreaID = 32319,
			DisplayIDs = {{10458}},
			AtlasMapBossID = 7,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["Malors Strongbox"], nil },
				{ 2,  12845 }, -- Medallion of Faith
				{ 16,  226404 }, -- Tarnished Undermine Real
			},
		},
		{ -- STRATCrimsonHammersmith
			name = AL["Crimson Hammersmith"],
			NameColor = GREEN,
			npcID = 11120,
			Level = 60,
			SubAreaID = 32357,
			DisplayIDs = {{10637}},
			AtlasMapBossID = 8,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  18781 }, -- Bottom Half of Advanced Armorsmithing: Volume II
				--{ 3,  12824 }, -- Plans: Enchanted Battlehammer
			},
		},
		{ -- STRATCannonMasterWilley
			name = AL["Cannon Master Willey"],
			NameColor = GREEN,
			npcID = 10997,
			Level = 60,
			SubAreaID = 32357,
			DisplayIDs = {{10674}},
			AtlasMapBossID = 9,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  226706 }, -- Shadowcraft Spaulders
				{ 3,  22407 }, -- Helm of the New Moon
				{ 4,  228533 }, -- Diana's Pearl Necklace
				{ 5,  22405 }, -- Mantle of the Scarlet Crusade
				{ 6,  18721 }, -- Barrage Girdle
				{ 7,  13381 }, -- Master Cannoneer Boots
				{ 8,  228523 }, -- Cannonball Runner
				{ 9,  228522 }, -- Willey's Portable Howitzer
				{ 10, 13377 }, -- Miniature Cannon Balls
				{ 11, 22404 }, -- Willey's Back Scratcher
				{ 12, 22406 }, -- Redemption
				{ 16, 226404 }, -- Tarnished Undermine Real
				{ 18, 12839 }, -- Plans: Heartseeker
			},
		},
		{ -- STRATArchivistGalford
			name = AL["Archivist Galford"],
			NameColor = GREEN,
			npcID = 10811,
			Level = 60,
			SubAreaID = 32331,
			DisplayIDs = {{10544}},
			AtlasMapBossID = 10,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  226740 }, -- Devout Gloves
				{ 3,  13386 }, -- Archivist Cape
				{ 4,  13387 }, -- Foresight Girdle
				{ 5,  18716 }, -- Ash Covered Boots
				{ 6,  13385 }, -- Tome of Knowledge
				{ 8,  12811 }, -- Righteous Orb
				{ 10, 22897 }, -- Tome of Conjure Food VII
				{ 16, 226404 }, -- Tarnished Undermine Real
			},
		},
		{ -- STRATBalnazzar
			name = AL["Balnazzar"],
			NameColor = GREEN,
			npcID = {10812, 10813},
			Level = 999,
			SubAreaID = 32367,
			DisplayIDs = {{10545}, {10691}},
			AtlasMapBossID = 11,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  228539 }, -- Book of the Dead
				{ 2,  14512 }, -- Pattern: Truefaith Vestments
				{ 4,  226738 }, -- Lightforge Boots
				{ 6,  228540 }, -- Crown of Tyranny
				{ 7,  228545 }, -- Grand Crusader's Helm
				{ 8,  228536 }, -- Star of Mystaria
				{ 9, 228546 }, -- Shroud of the Nathrezim
				{ 10, 13358 }, -- Wyrmtongue Shoulders
				{ 11, 13369 }, -- Fire Striders
				{ 12, 228541 }, -- Gift of the Elven Magi
				{ 13, 228544 }, -- Hammer of the Grand Crusader
				{ 14,  22334 }, -- Band of Mending
				{ 15, 13348 }, -- Demonshear
				{ 16, 226404 }, -- Tarnished Undermine Real
				{ 18, 13520 }, -- Recipe: Flask of Distilled Wisdom
				{ 20, 13250 }, -- Head of Balnazzar
			},
		},
		{ -- STRATMagistrateBarthilas
			name = AL["Magistrate Barthilas"],
			NameColor = PURP,
			npcID = 10435,
			Level = 58,
			SubAreaID = 32342,
			DisplayIDs = {{10433}},
			AtlasMapBossID = 12,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  18727 }, -- Crimson Felt Hat
				{ 2,  228505 }, -- Royal Tribunal Cloak
				{ 3,  228518 }, -- Magistrate's Cuffs
				{ 4,  18722 }, -- Death Grips
				{ 5,  23198 }, -- Idol of Brutality
				{ 6,  228516 }, -- Peacemaker
				{ 8,  228166 }, -- Key to the City
				{ 16, 226404 }, -- Tarnished Undermine Real
			},
		},
		{ -- STRATStonespine
			name = AL["Stonespine"],
			NameColor = PURP,
			npcID = 10809,
			Level = 60,
			SubAreaID = 32303,
			DisplayIDs = {{7856}},
			AtlasMapBossID = 14,
			specialType = "rare",
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  13397 }, -- Stoneskin Gargoyle Cape
				{ 2,  13954 }, -- Verdant Footpads
				{ 3,  13399 }, -- Gargoyle Shredder Talons
			},
		},
		{ -- STRATBaronessAnastari
			name = AL["Baroness Anastari"],
			NameColor = PURP,
			npcID = 10436,
			Level = 59,
			SubAreaID = 32344,
			DisplayIDs = {{10698}},
			AtlasMapBossID = 15,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  226763 }, -- Dreadmist Sandals
				{ 3,  18728 }, -- Anastari Heirloom
				{ 4,  228521 }, -- Shadowy Laced Handwraps
				{ 5,  18729 }, -- Screeching Bow
				{ 6,  13534 }, -- Banshee Finger
				{ 8,  13538 }, -- Windshrieker Pauldrons
				{ 9,  13535 }, -- Coldtouch Phantom Wraps
				{ 10, 13537 }, -- Chillhide Bracers
				{ 11, 13539 }, -- Banshee's Touch
				{ 12, 13514 }, -- Wail of the Banshee
				{ 16, 226404 }, -- Tarnished Undermine Real
			},
		},
		{ -- STRATBlackGuardSwordsmith
			name = AL["Black Guard Swordsmith"],
			NameColor = PURP,
			npcID = 11121,
			Level = {61, 62},
			SubAreaID = 32345,
			DisplayIDs = {{775}},
			AtlasMapBossID = 15,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  18783 }, -- Bottom Half of Advanced Armorsmithing: Volume III
				--{ 2,  12725 }, -- Plans: Enchanted Thorium Helm
				--{ 3,  12620 }, -- Enchanted Thorium Helm
				--{ 3,  12825 }, -- Plans: Blazing Rapier
				--{ 6,  12777 }, -- Blazing Rapier
			},
		},
		{ -- STRATNerubenkan
			name = AL["Nerub'enkan"],
			NameColor = PURP,
			npcID = 10437,
			Level = 60,
			SubAreaID = 32345,
			DisplayIDs = {{9793}},
			AtlasMapBossID = 16,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  226722 }, -- Beaststalker's Boots
				{ 3,  228531 }, -- Thuzadin Sash
				{ 4,  228530 }, -- Chitinous Plate Legguards
				{ 5,  18738 }, -- Carapace Spine Crossbow
				{ 6,  13529 }, -- Husk of Nerub'enkan
				{ 8,  13533 }, -- Acid-etched Pauldrons
				{ 9,  13532 }, -- Darkspinner Claws
				{ 10, 13531 }, -- Crypt Stalker Leggings
				{ 11, 13530 }, -- Fangdrip Runners
				{ 12, 13508 }, -- Eye of Arachnida
				{ 16, 226404 }, -- Tarnished Undermine Real
			},
		},
		{ -- STRATMalekithePallid
			name = AL["Maleki the Pallid"],
			NameColor = PURP,
			npcID = 10438,
			Level = 61,
			SubAreaID = 32349,
			DisplayIDs = {{10546}},
			AtlasMapBossID = 17,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  226743 }, -- Devout Sandals
				{ 3,  18734 }, -- Pale Moon Cloak
				{ 4,  18735 }, -- Maleki's Footwraps
				{ 5,  13524 }, -- Skull of Burning Shadows
				{ 6,  228535 }, -- Bone Slicing Hatchet
				{ 8,  13528 }, -- Twilight Void Bracers
				{ 9,  13525 }, -- Darkbind Fingers
				{ 10, 13526 }, -- Flamescarred Girdle
				{ 11, 13527 }, -- Lavawalker Greaves
				{ 12, 13509 }, -- Clutch of Foresight
				{ 18, 12833 }, -- Plans: Hammer of the Titans
				{ 16, 226404 }, -- Tarnished Undermine Real
			},
		},
		{ -- STRATRamsteintheGorger
			name = AL["Ramstein the Gorger"],
			NameColor = PURP,
			npcID = 10439,
			Level = 61,
			SubAreaID = 32301,
			DisplayIDs = {{12818}},
			AtlasMapBossID = 18,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  226771 }, -- Gauntlets of Valor
				{ 3,  18723 }, -- Animated Chain Necklace
				{ 4,  228520 }, -- Soulstealer Mantle
				{ 5,  13373 }, -- Band of Flesh
				{ 6,  13515 }, -- Ramstein's Lightning Bolts
				{ 7,  13375 }, -- Crest of Retribution
				{ 8,  13372 }, -- Slavedriver's Cane
				{ 16, 226404 }, -- Tarnished Undermine Real
			},
		},
		{ -- STRATBaronRivendare
			name = AL["Baron Rivendare"],
			NameColor = PURP,
			npcID = 10440,
			Level = 62,
			SubAreaID = 32352,
			DisplayIDs = {{10729}},
			AtlasMapBossID = 19,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  13335 }, -- Deathcharger's Reins
				{ 2,  228543 }, -- Runeblade of Baron Rivendare
				{ 4,  228553 }, -- Helm of the Executioner
				{ 5,  22412 }, -- Thuzadin Mantle
				{ 6,  13340 }, -- Cape of the Black Baron
				{ 7,  13346 }, -- Robes of the Exalted
				{ 8,  228551 }, -- Tunic of the Crescent Moon
				{ 9,  228537 }, -- Dracorian Gauntlets
				{ 10, 228552 }, -- Gauntlets of Deftness
				{ 11, 228538 }, -- Seal of Rivendare
				{ 12, 22408 }, -- Ritssyn's Wand of Bad Mojo
				{ 13, 13349 }, -- Scepter of the Unholy
				{ 14, 13368 }, -- Bonescraper
				{ 15, 228542 }, -- Skullforge Reaver
				{ 16, 226404 }, -- Tarnished Undermine Real
				{ 18, 226747 }, -- Devout Skirt
				{ 19, 226727 }, -- Magister's Leggings
				{ 20, 226760 }, -- Dreadmist Leggings
				{ 21, 226705 }, -- Shadowcraft Pants
				{ 22, 226709 }, -- Wildheart Kilt
				{ 23, 226719 }, -- Beaststalker's Pants
				{ 24, 226750 }, -- Kilt of Elements
				{ 25, 226736 }, -- Lightforge Legplates
				{ 26, 226767 }, -- Legplates of Valor
			},
		},
		{ -- STRATTrash
			name = AL["Trash"],
			ExtraList = true,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  226742 }, -- Devout Bracers
				{ 2,  226724 }, -- Magister's Belt
				{ 3,  226761 }, -- Dreadmist Belt
				{ 4,  226704 }, -- Shadowcraft Bracers
				{ 5,  226714 }, -- Wildheart Bracers
				{ 6,  226717 }, -- Beaststalker's Bindings
				{ 7,  226751 }, -- Bindings of Elements
				{ 8,  226732 }, -- Lightforge Belt
				{ 9,  226765 }, -- Belt of Valor
				{ 11, 12811 }, -- Righteous Orb
				{ 12, 12735 }, -- Frayed Abomination Stitching
				{ 13, 12843 }, -- Corruptor's Scourgestone
				{ 14, 12841 }, -- Invader's Scourgestone
				{ 15, 12840 }, -- Minion's Scourgestone
				{ 16, 18742 }, -- Stratholme Militia Shoulderguard
				{ 17, 18743 }, -- Gracious Cape
				{ 18, 17061 }, -- Juno's Shadow
				{ 19, 228532 }, -- Morlune's Bracer
				{ 20, 18744 }, -- Plaguebat Fur Gloves
				{ 21, 18745 }, -- Sacred Cloth Leggings
				{ 22, 228534 }, -- Plaguehound Leggings
				{ 24, 16249 }, -- Formula: Enchant 2H Weapon - Major Intellect
				{ 25, 16248 }, -- Formula: Enchant Weapon - Unholy
				{ 26, 14495 }, -- Pattern: Ghostweave Pants
				{ 27, 15777 }, -- Pattern: Runic Leather Shoulders
				{ 28, 15768 }, -- Pattern: Wicked Leather Belt
				{ 29, 18658 }, -- Schematic: Ultra-Flash Shadow Reflector
				{ 30, 16052 }, -- Schematic: Voice Amplification Modulator
			},
		},
		{ -- STRATBSPlansSerenity / STRATBSPlansCorruption
			name = AL["Plans"],
			ContentPhase = 4,
			ExtraList = true,
			IgnoreAsSource = true,
			[NORMAL_DIFF] = {
				{ 1,  12827 }, -- Plans: Serenity
				{ 16,  12830 }, -- Plans: Corruption
			},
		},
		{ -- STRATAtiesh
			name = AL["Atiesh"],
			NameColor = GREEN,
			ExtraList = true,
			AtlasMapBossID = 2,
			ContentPhase = 8,
			[NORMAL_DIFF] = {
				{ 1,  22736 }, -- Andonisus, Reaper of Souls
			},
		},
		{ -- STRATBalzaphon
			name = AL["Balzaphon"],
			NameColor = GREEN,
			ExtraList = true,
			specialType = "scourgeInvasion",
			npcID = 14684,
			DisplayIDs = {{7919}},
			AtlasMapBossID = 2,
			ContentPhase = 8,
			[NORMAL_DIFF] = {
				{ 1,  23126 }, -- Waistband of Balzaphon
				{ 2,  23125 }, -- Chains of the Lich
				{ 3,  23124 }, -- Staff of Balzaphon
			},
		},
		{ -- STRATSothosJarien
			name = AL["Sothos and Jarien's Heirlooms"].." - "..format(AL["Tier %s Sets"], "0.5"),
			NameColor = GREEN,
			ExtraList = true,
			ContentPhase = 4,
			AtlasMapBossID = 11,
			[NORMAL_DIFF] = {
				{ 1,  22327 }, -- Amulet of the Redeemed
				{ 2,  228547 }, -- Ironweave Robe
				{ 3,  22328 }, -- Legplates of Vigilance
				{ 4,  22334 }, -- Band of Mending
				{ 5,  228548 }, -- Scepter of Interminable Focus
			},
		},
		KEYS,
	},
}

-- ########################
-- Raids
-- ########################
data["WorldBosses"] = {
	name = AL["World Bosses"],
	AtlasMapFile = "Azuregos",
	ContentType = RAID30_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	ContentPhase = 4,
	items = {
		{ -- AAzuregos
			name = AL["Azuregos"],
			AtlasMapFile = "Azuregos",
			npcID = 6109,
			Level = 999,
			ContentPhase = 4,
			DisplayIDs = {{11460}},
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1,  228385 }, -- Crystal Adorned Crown
				{ 2,  228389 }, -- Drape of Benediction
				{ 3,  228383 }, -- Puissant Cape
				{ 4,  228340 }, -- Unmelting Ice Girdle
				{ 5,  228345 }, -- Leggings of Arcane Supremacy
				{ 6,  228384 }, -- Snowblind Shoes
				{ 7,  228381 }, -- Cold Snap
				{ 8,  228382 }, -- Fang of the Mystics
				{ 9,  228349 }, -- Eskhandar's Left Claw
				{ 10, 228347 }, -- Typhoon
				{ 16, 18704 }, -- Mature Blue Dragon Sinew
				{ 18, 11938 }, -- Sack of Gems
				-- Hidden items
				{ 0, 17962 }, -- Blue Sack of Gems
				{ 0, 17963 }, -- Green Sack of Gems
				{ 0, 17964 }, -- Gray Sack of Gems
				{ 0, 17965 }, -- Yellow Sack of Gems
				{ 0, 17969 }, -- Red Sack of Gems
			},
		},
		{ -- KKazzak
			name = AL["Lord Kazzak"],
			AtlasMapFile = "LordKazzak",
			npcID = 12397,
			Level = 999,
			ContentPhase = 4,
			DisplayIDs = {{12449}},
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1,  228353 }, -- Infernal Headcage
				{ 2,  228354 }, -- Blazefury Medallion
				{ 3,  228360 }, -- Eskhandar's Pelt
				{ 4,  228357 }, -- Blacklight Bracer
				{ 5,  228351 }, -- Doomhide Gauntlets
				{ 6,  228355 }, -- Flayed Doomguard Belt
				{ 7,  228352 }, -- Fel Infused Leggings
				{ 8,  228359 }, -- Ring of Entropy
				{ 9,  228397 }, -- Empyrean Demolisher
				{ 10, 228356 }, -- Amberseal Keeper
				{ 16, 18665 }, -- The Eye of Shadow
				{ 18, 11938 }, -- Sack of Gems
				-- Hidden items
				{ 0, 17962 }, -- Blue Sack of Gems
				{ 0, 17963 }, -- Green Sack of Gems
				{ 0, 17964 }, -- Gray Sack of Gems
				{ 0, 17965 }, -- Yellow Sack of Gems
				{ 0, 17969 }, -- Red Sack of Gems
			},
		},
		{ -- DLethon
			name = AL["Lethon"],
			AtlasMapFile = "FourDragons",
			npcID = 14888,
			Level = 999,
			ContentPhase = 6,
			DisplayIDs = {{15365}},
			[NORMAL_DIFF] = {
				{ 1,  20628 }, -- Deviate Growth Cap
				{ 2,  20626 }, -- Black Bark Wristbands
				{ 3,  20630 }, -- Gauntlets of the Shining Light
				{ 4,  20625 }, -- Belt of the Dark Bog
				{ 5,  20627 }, -- Dark Heart Pants
				{ 6,  20629 }, -- Malignant Footguards
				{ 9,  20579 }, -- Green Dragonskin Cloak
				{ 10, 20615 }, -- Dragonspur Wraps
				{ 11, 20616 }, -- Dragonbone Wristguards
				{ 12, 20618 }, -- Gloves of Delusional Power
				{ 13, 20617 }, -- Ancient Corroded Leggings
				{ 14, 20619 }, -- Acid Inscribed Greaves
				{ 15, 20582 }, -- Trance Stone
				{ 16, 20644 }, -- Nightmare Engulfed Object
				{ 17, 20600 }, -- Malfurion's Signet Ring
				{ 24, 20580 }, -- Hammer of Bestial Fury
				{ 25, 20581 }, -- Staff of Rampant Growth
				{ 29, 20381 }, -- Dreamscale
				{ 30, 11938 }, -- Sack of Gems
				-- Hidden items
				{ 0, 17962 }, -- Blue Sack of Gems
				{ 0, 17963 }, -- Green Sack of Gems
				{ 0, 17964 }, -- Gray Sack of Gems
				{ 0, 17965 }, -- Yellow Sack of Gems
				{ 0, 17969 }, -- Red Sack of Gems
			},
		},
		{ -- DEmeriss
			name = AL["Emeriss"],
			AtlasMapFile = "FourDragons",
			npcID = 14889,
			Level = 999,
			ContentPhase = 6,
			DisplayIDs = {{15366}},
			[NORMAL_DIFF] = {
				{ 1,  20623 }, -- Circlet of Restless Dreams
				{ 2,  20622 }, -- Dragonheart Necklace
				{ 3,  20624 }, -- Ring of the Unliving
				{ 4,  20621 }, -- Boots of the Endless Moor
				{ 5,  20599 }, -- Polished Ironwood Crossbow
				{ 9,  20579 }, -- Green Dragonskin Cloak
				{ 10, 20615 }, -- Dragonspur Wraps
				{ 11, 20616 }, -- Dragonbone Wristguards
				{ 12, 20618 }, -- Gloves of Delusional Power
				{ 13, 20617 }, -- Ancient Corroded Leggings
				{ 14, 20619 }, -- Acid Inscribed Greaves
				{ 15, 20582 }, -- Trance Stone
				{ 16, 20644 }, -- Nightmare Engulfed Object
				{ 17, 20600 }, -- Malfurion's Signet Ring
				{ 24, 20580 }, -- Hammer of Bestial Fury
				{ 25, 20581 }, -- Staff of Rampant Growth
				{ 30, 11938 }, -- Sack of Gems
				-- Hidden items
				{ 0, 17962 }, -- Blue Sack of Gems
				{ 0, 17963 }, -- Green Sack of Gems
				{ 0, 17964 }, -- Gray Sack of Gems
				{ 0, 17965 }, -- Yellow Sack of Gems
				{ 0, 17969 }, -- Red Sack of Gems
			},
		},
		{ -- DTaerar
			name = AL["Taerar"],
			AtlasMapFile = "FourDragons",
			npcID = 14890,
			Level = 999,
			ContentPhase = 6,
			DisplayIDs = {{15363}, {15367}},
			[NORMAL_DIFF] = {
				{ 1,  20633 }, -- Unnatural Leather Spaulders
				{ 2,  20631 }, -- Mendicant's Slippers
				{ 3,  20634 }, -- Boots of Fright
				{ 4,  20632 }, -- Mindtear Band
				{ 5,  20577 }, -- Nightmare Blade
				{ 9,  20579 }, -- Green Dragonskin Cloak
				{ 10, 20615 }, -- Dragonspur Wraps
				{ 11, 20616 }, -- Dragonbone Wristguards
				{ 12, 20618 }, -- Gloves of Delusional Power
				{ 13, 20617 }, -- Ancient Corroded Leggings
				{ 14, 20619 }, -- Acid Inscribed Greaves
				{ 15, 20582 }, -- Trance Stone
				{ 16, 20644 }, -- Nightmare Engulfed Object
				{ 17, 20600 }, -- Malfurion's Signet Ring
				{ 24, 20580 }, -- Hammer of Bestial Fury
				{ 25, 20581 }, -- Staff of Rampant Growth
				{ 30, 11938 }, -- Sack of Gems
				-- Hidden items
				{ 0, 17962 }, -- Blue Sack of Gems
				{ 0, 17963 }, -- Green Sack of Gems
				{ 0, 17964 }, -- Gray Sack of Gems
				{ 0, 17965 }, -- Yellow Sack of Gems
				{ 0, 17969 }, -- Red Sack of Gems
			},
		},
		{ -- DYsondre
			name = AL["Ysondre"],
			AtlasMapFile = "FourDragons",
			npcID = 14887,
			Level = 999,
			ContentPhase = 6,
			DisplayIDs = {{15364}},
			[NORMAL_DIFF] = {
				{ 1,  20637 }, -- Acid Inscribed Pauldrons
				{ 2,  20635 }, -- Jade Inlaid Vestments
				{ 3,  20638 }, -- Leggings of the Demented Mind
				{ 4,  20639 }, -- Strangely Glyphed Legplates
				{ 5,  20636 }, -- Hibernation Crystal
				{ 6,  20578 }, -- Emerald Dragonfang
				{ 9,  20579 }, -- Green Dragonskin Cloak
				{ 10, 20615 }, -- Dragonspur Wraps
				{ 11, 20616 }, -- Dragonbone Wristguards
				{ 12, 20618 }, -- Gloves of Delusional Power
				{ 13, 20617 }, -- Ancient Corroded Leggings
				{ 14, 20619 }, -- Acid Inscribed Greaves
				{ 15, 20582 }, -- Trance Stone
				{ 16, 20644 }, -- Nightmare Engulfed Object
				{ 17, 20600 }, -- Malfurion's Signet Ring
				{ 24, 20580 }, -- Hammer of Bestial Fury
				{ 25, 20581 }, -- Staff of Rampant Growth
				{ 30, 11938 }, -- Sack of Gems
				-- Hidden items
				{ 0, 17962 }, -- Blue Sack of Gems
				{ 0, 17963 }, -- Green Sack of Gems
				{ 0, 17964 }, -- Gray Sack of Gems
				{ 0, 17965 }, -- Yellow Sack of Gems
				{ 0, 17969 }, -- Red Sack of Gems
			},
		},
	}
}

data["MoltenCore"] = {
	MapID = 2717,
	InstanceID = 409,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "MoltenCore",
	AtlasMapFile = "CL_MoltenCore",
	AtlasMapFile_AL = "MoltenCore",
	ContentType = RAID30_CONTENT,
	LoadDifficulty = RAID40_DIFF,
	ContentPhase = 4,
	items = {
		{	--MCLucifron
			name = AL["Lucifron"],
			npcID = 12118,
			Level = 999,
			DisplayIDs = {{13031},{12030}},
			AtlasMapBossID = 1,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1, 228285 },	-- Helm of the Lifegiver
				{ 2, 228247 },	-- Choker of Enlightenment
				{ 3, 228239 },	-- Robe of Volatile Power
				{ 4, 228246 },	-- Wristguards of Stability
				{ 5, 228244 },	-- Manastorm Leggings
				{ 6, 228245 },	-- Salamander Scale Pants
				{ 7, 228240 },	-- Flamewaker Legplates
				{ 8, 228242 },	-- Heavy Dark Iron Ring
				{ 9, 228243 },	-- Ring of Spell Power
				{ 10, 228262 },	-- Crimson Shocker
				{ 11, 228263 },	-- Sorcerous Dagger
				{ 12, 16665 },	-- Tome of Tranquilizing Shot
			},
		},
		{	--MCMagmadar
			name = AL["Magmadar"],
			npcID = 11982,
			Level = 999,
			DisplayIDs = {{10193}},
			AtlasMapBossID = 2,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1, 228350 },	-- Eskhandar's Right Claw
				{ 2, 228249 },	-- Medallion of Steadfast Might
				{ 3, 228258 },	-- Deep Earth Spaulders
				{ 4, 228257 },	-- Aged Core Leather Gloves
				{ 5, 228260 },	-- Flameguard Gauntlets
				{ 6, 228256 },	-- Mana Igniting Cord
				{ 7, 228240 },	-- Flamewaker Legplates
				{ 8, 228253 },	-- Sabatons of the Flamewalker
				{ 9, 228254 },	-- Magma Tempered Boots
				{ 10, 228261 },	-- Quick Strike Ring
				{ 11, 228255 },	-- Talisman of Ephemeral Power
				{ 12, 228259 },	-- Fire Runed Grimoire
				{ 13, 228252 },	-- Striker's Mark
				{ 14, 228248 },	-- Earthshaker
				{ 15, 228229 },	-- Obsidian Edged Blade
				{ 16, "INV_Box_02", nil, AL["Molten"], nil },
				{ 17, 228519 },	-- Striker's Mark (Molten)
				{ 18, 228463 },	-- Earthshaker (Molten)
				{ 19, 228459 },	-- Obsidian Edged Blade (Molten)
			},
		},
		{	--MCGehennas
			name = AL["Gehennas"],
			npcID = 12259,
			Level = 999,
			DisplayIDs = {{13030},{12002}},
			AtlasMapBossID = 3,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1, 228285 },	-- Helm of the Lifegiver
				{ 2, 228239 },	-- Robe of Volatile Power
				{ 3, 228246 },	-- Wristguards of Stability
				{ 4, 228244 },	-- Manastorm Leggings
				{ 5, 228245 },	-- Salamander Scale Pants
				{ 6, 228240 },	-- Flamewaker Legplates
				{ 7, 228242 },	-- Heavy Dark Iron Ring
				{ 8, 228243 },	-- Ring of Spell Power
				{ 9, 228262 },	-- Crimson Shocker
				{ 10, 228263 },	-- Sorcerous Dagger
			},
		},
		{	--MCGarr
			name = AL["Garr"],
			npcID = 12057,
			Level = 999,
			DisplayIDs = {{12110}, {5781}},
			AtlasMapBossID = 4,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1, 18564 },	-- Bindings of the Windseeker
				{ 3, 228258 },	-- Deep Earth Spaulders
				{ 4, 228257 },	-- Aged Core Leather Gloves
				{ 5, 228260 },	-- Flameguard Gauntlets
				{ 6, 228256 },	-- Mana Igniting Cord
				{ 7, 228240 },	-- Flamewaker Legplates
				{ 8, 228253 },	-- Sabatons of the Flamewalker
				{ 9, 228254 },	-- Magma Tempered Boots
				{ 10, 228261 },	-- Quick Strike Ring
				{ 11, 228255 },	-- Talisman of Ephemeral Power
				{ 12, 228259 },	-- Fire Runed Grimoire
				{ 13, 228266 },	-- Drillborer Disk
				{ 14, 228267 },	-- Gutgore Ripper
				{ 15, 228264 },	-- Aurastone Hammer
				{ 16, 228265 },	-- Brutality Blade
				{ 17, 228229 },	-- Obsidian Edged Blade
				{ 19, "INV_Box_02", nil, AL["Molten"], nil },
				{ 20, 228702 },	-- Drillborer Disk (Molten)
				{ 21, 228462 },	-- Aurastone Hammer (Molten)
				{ 22, 228506 },	-- Brutality Blade (Molten)
				{ 23, 228459 },	-- Obsidian Edged Blade (Molten)
			},
		},
		{	--MCShazzrah
			name = AL["Shazzrah"],
			npcID = 12264,
			Level = 999,
			DisplayIDs = {{13032}},
			AtlasMapBossID = 5,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1, 228285 },	-- Helm of the Lifegiver
				{ 2, 228239 },	-- Robe of Volatile Power
				{ 3, 228246 },	-- Wristguards of Stability
				{ 4, 228244 },	-- Manastorm Leggings
				{ 5, 228245 },	-- Salamander Scale Pants
				{ 6, 228240 },	-- Flamewaker Legplates
				{ 7, 228242 },	-- Heavy Dark Iron Ring
				{ 8, 228243 },	-- Ring of Spell Power
				{ 9, 228262 },	-- Crimson Shocker
				{ 10, 228263 },	-- Sorcerous Dagger
			},
		},
		{	--MCGeddon
			name = AL["Baron Geddon"],
			npcID = 12056,
			Level = 999,
			DisplayIDs = {{12129}},
			AtlasMapBossID = 6,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  18563 },	-- Bindings of the Windseeker
				{ 3, 228258 },	-- Deep Earth Spaulders
				{ 4, 228257 },	-- Aged Core Leather Gloves
				{ 5, 228260 },	-- Flameguard Gauntlets
				{ 6, 228256 },	-- Mana Igniting Cord
				{ 7, 228240 },	-- Flamewaker Legplates
				{ 8, 228253 },	-- Sabatons of the Flamewalker
				{ 9, 228254 },	-- Magma Tempered Boots
				{ 10, 228261 },	-- Quick Strike Ring
				{ 11, 228268 },	-- Seal of the Archmagus
				{ 12, 228255 },	-- Talisman of Ephemeral Power
				{ 13, 228259 },	-- Fire Runed Grimoire
				{ 14, 228229 },	-- Obsidian Edged Blade
				{ 16, "INV_Box_02", nil, AL["Molten"], nil },
				{ 17, 228459 },	-- Obsidian Edged Blade (Molten)
			},
		},
		{	--MCGolemagg
			name = AL["Golemagg the Incinerator"],
			npcID = 11988,
			Level = 999,
			DisplayIDs = {{11986}},
			AtlasMapBossID = 7,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1, 17203 },	-- Sulfuron Ingot
				{ 2, 228258 },	-- Deep Earth Spaulders
				{ 3, 228257 },	-- Aged Core Leather Gloves
				{ 4, 228260 },	-- Flameguard Gauntlets
				{ 5, 228256 },	-- Mana Igniting Cord
				{ 6, 228240 },	-- Flamewaker Legplates
				{ 7, 228253 },	-- Sabatons of the Flamewalker
				{ 8, 228254 },	-- Magma Tempered Boots
				{ 9, 228261 },	-- Quick Strike Ring
				{ 10, 228255 },	-- Talisman of Ephemeral Power
				{ 11, 228259 },	-- Fire Runed Grimoire
				{ 12, 228270 },	-- Blastershot Launcher
				{ 13, 228269 },	-- Azuresong Mageblade
				{ 14, 228229 },	-- Obsidian Edged Blade
				{ 15, 228271 },	-- Staff of Dominance
				{ 16, "INV_Box_02", nil, AL["Molten"], nil },
				{ 17, 228517 },	-- Azuresong Mageblade
				{ 18, 228459 },	-- Obsidian Edged Blade
				
			},
		},
		{ -- MCSulfuron
			name = AL["Sulfuron Harbinger"],
			npcID = 12098,
			Level = 999,
			DisplayIDs = {{13030},{12030}},
			AtlasMapBossID = 8,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1, 228285 }, -- Helm of the Lifegiver
				{ 2, 228239 }, -- Robe of Volatile Power
				{ 3, 228246 }, -- Wristguards of Stability
				{ 4, 228244 }, -- Manastorm Leggings
				{ 5, 228245 }, -- Salamander Scale Pants
				{ 6, 228240 }, -- Flamewaker Legplates
				{ 7, 228242 }, -- Heavy Dark Iron Ring
				{ 8, 228243 }, -- Ring of Spell Power
				{ 9, 228262 }, -- Crimson Shocker
				{ 10, 228263 }, -- Sorcerous Dagger
				{ 11, 228272 }, -- Shadowstrike
			},
		},
		{ -- MCMajordomo
			name = AL["Majordomo Executus"],
			npcID = 12018,
			Level = 999,
			ObjectID = 179703,
			DisplayIDs = {{12029},{13029},{12002}},
			AtlasMapBossID = 9,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  228279 }, -- Fireguard Shoulders
				{ 2,  228283 }, -- Wild Growth Spaulders
				{ 3,  228280 }, -- Fireproof Cloak
				{ 4,  228281 }, -- Gloves of the Hypnotic Flame
				{ 5,  228282 }, -- Sash of Whispered Secrets
				{ 6,  228284 }, -- Wristguards of True Flight
				{ 7,  228275 }, -- Core Forged Greaves
				{ 8,  228274 }, -- Cauterizing Band
				{ 9,  228277 }, -- Core Hound Tooth
				{ 10, 228278 }, -- Finkle's Lava Dredger
				{ 16, 18703 }, -- Ancient Petrified Leaf
				{ 18, 18646 }, -- The Eye of Divinity
				{ 20, "INV_Box_02", nil, AL["Molten"], nil },
				{ 21,  228701 }, -- Core Hound Tooth (Molten)

			},
		},
		{ -- MCRagnaros
			name = AL["Ragnaros"],
			npcID = 11503,
			Level = 999,
			DisplayIDs = {{11121}},
			AtlasMapBossID = 10,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1, 227728 }, -- Eye of Sulfuras
				{ 2, 19017 }, -- Essence of the Firelord
				{ 4, 228297 }, -- Shard of the Flame
				{ 5, 228291 }, -- Crown of Destruction
				{ 6, 228289 }, -- Choker of the Fire Lord
				{ 7, 228290 }, -- Cloak of the Shrouded Mists
				{ 8, 228292 }, -- Dragon's Blood Cape
				{ 9, 228295 }, -- Onslaught Girdle
				{ 10, 228286 }, -- Band of Accuria
				{ 11, 228287 }, -- Band of Sulfuras
				{ 12, 228293 }, -- Essence of the Pure Flame
				{ 13, 228294 }, -- Malistar's Defender
				{ 14, 228296 }, -- Perdition's Blade
				{ 15, 228299 }, -- Spinal Reaper
				{ 16, 228288 }, -- Bonereaver's Edge
				{ 18, "INV_Box_02", nil, AL["Molten"], nil },
				{ 19, 228511 }, -- Perdition's Blade (Molten)
				{ 20, 228460 }, -- Spinal Reaper (Molten)
				{ 21, 228461 }, -- Bonereaver's Edge (Molten)
			},
		},
		{ -- MCRANDOMBOSSDROPS
			name = AL["All bosses"],
			ExtraList = true,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1,  18264 }, -- Plans: Elemental Sharpening Stone
				{ 3,  18292 }, -- Schematic: Core Marksman Rifle
				{ 4,  18291 }, -- Schematic: Force Reactive Disk
				{ 5, 18290 }, -- Schematic: Biznicks 247x128 Accurascope
				{ 7, 18259 }, -- Formula: Enchant Weapon - Spell Power
				{ 8, 18260 }, -- Formula: Enchant Weapon - Healing Power
				{ 16, 18252 }, -- Pattern: Core Armor Kit
				{ 18, 18265 }, -- Pattern: Flarecore Wraps
				{ 19, 21371 }, -- Pattern: Core Felcloth Bag
				{ 21, 18257 }, -- Recipe: Major Rejuvenation Potion
			},
		},
		{ -- MCTrashMobs
			name = AL["Trash"],
			ExtraList = true,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1, 17011 }, -- Lava Core
				{ 2, 17010 }, -- Fiery Core
				{ 3, 11382 }, -- Blood of the Mountain
				{ 4, 17012 }, -- Core Leather
			},
		},
		{ -- MC Phase 4 New Items - Unknown drop
			name = AL["New"],
			ExtraList = true,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1, 228128 }, -- Hammer of The Black Anvil
				{ 16, "INV_Box_02", nil, AL["Molten"], nil },
				{ 17, 228508 }, -- Hammer of The Black Anvil
			},
		},
		{ -- MC Phase 4 Tier Tokens
			name = AL["Tier Tokens"],
			ExtraList = true,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1, 227530 }, --Incandescent Belt (Priest, Mage, Warlock)
				{ 2, 227531 }, --Incandescent Bindings (Priest, Mage, Warlock)
				{ 3, 227532 }, --Incandescent Hood (Priest, Mage, Warlock)
				{ 4, 227533 }, --Incandescent Gloves (Priest, Mage, Warlock)
				{ 5, 227534 }, --Incandescent Leggings (Priest, Mage, Warlock)
				{ 6, 227535 }, --Incandescent Robe (Priest, Mage, Warlock)
				{ 7, 227536 }, --Incandescent Boots (Priest, Mage, Warlock)
				{ 8, 227537 }, --Incandescent Shoulderpads (Priest, Mage, Warlock)
				{ 10, 227750 }, --Molten Scaled Bindings (Paladin, Hunter, Shaman)
				{ 11, 227751 }, --Molten Scaled Belt (Paladin, Hunter, Shaman)
				{ 12, 227752 }, --Molten Scaled Shoulderpads (Paladin, Hunter, Shaman)
				{ 13, 227754 }, --Molten Scaled Leggings (Paladin, Hunter, Shaman)
				{ 14, 227755 }, --Molten Scaled Helm (Paladin, Hunter, Shaman)
				{ 15, 227756 }, --Molten Scaled Gloves (Paladin, Hunter, Shaman)
				{ 16, 227757 }, --Molten Scaled Boots (Paladin, Hunter, Shaman)
				{ 17, 227758 }, --Molten Scaled Chest (Paladin, Hunter, Shaman)
				{ 19, 227759 }, --Scorched Core Gloves (Warrior, Rogue, Druid)
				{ 20, 227760 }, --Scorched Core Bindings (Warrior, Rogue, Druid)
				{ 21, 227761 }, --Scorched Core Belt (Warrior, Rogue, Druid)
				{ 22, 227762 }, --Scorched Core Shoulderpads (Warrior, Rogue, Druid)
				{ 23, 227763 }, --Scorched Core Leggings (Warrior, Rogue, Druid)
				{ 24, 227764 }, --Scorched Core  Helm (Warrior, Rogue, Druid)
				{ 25, 227765 }, --Scorched Core Boots (Warrior, Rogue, Druid)
				{ 26, 227766 }, --Scorched Core Chest (Warrior, Rogue, Druid)				
			},
		},
		T1_SET
	}
}

data["Onyxia"] = {
	MapID = 2159,
	InstanceID = 249,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "Onyxia",
	AtlasMapFile = "CL_OnyxiasLair",
	AtlasMapFile_AL = "OnyxiasLair",
	ContentType = RAID30_CONTENT,
	LoadDifficulty = RAID40_DIFF,
	ContentPhase = 4,
	items = {
		{ -- Onyxia
			name = AL["Onyxia"],
			npcID = 10184,
			Level = 999,
			DisplayIDs = {{8570}},
			AtlasMapBossID = 3,
			ContentPhase = 4,
			[NORMAL_DIFF] = {
				{ 1, 228688 }, -- Head of Onyxia (Alliance)
				--{ 2, 228689 }, -- Head of Onyxia (Horde)
				{ 3, 15410 }, -- Scale of Onyxia
				{ 5, 18705 }, -- Mature Black Dragon Sinew
				{ 6, 228759 }, -- Eskhandar's Collar
				{ 7, 17078 }, -- Sapphiron Drape
				{ 8, 18813 }, -- Ring of Binding
				{ 9, 228298 }, -- Shard of the Scale
				{ 10, 228955 }, -- Ancient Cornerstone Grimoire
				{ 11, 17068 }, -- Deathbringer
				{ 12, 17075 }, -- Vis'kag the Bloodletter
				{ 24, 228992 }, -- Onyxia Hide Backpack
				{ 25, 11938 }, -- Sack of Gems
				-- Hidden items
				{ 0, 17962 }, -- Blue Sack of Gems
				{ 0, 17963 }, -- Green Sack of Gems
				{ 0, 17964 }, -- Gray Sack of Gems
				{ 0, 17965 }, -- Yellow Sack of Gems
				{ 0, 17969 }, -- Red Sack of Gems
			},
		},
	},
}

data["Zul'Gurub"] = {
	MapID = 1977,
	InstanceID = 309,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "Zul'Gurub", -- ??
	AtlasMapFile = "CL_ZulGurub",
	AtlasMapFile_AL = "ZulGurub",
	ContentType = RAID20_CONTENT,
	LoadDifficulty = RAID20_DIFF,
	ContentPhase = 6,
	items = {
		{ -- ZGJeklik
			name = AL["High Priestess Jeklik"],
			npcID = 14517,
			Level = 999,
			DisplayIDs = {{15219}},
			AtlasMapBossID = 1,
			ContentPhase = 6,
			[NORMAL_DIFF] = {
				{ 1,  19721 }, -- Primal Hakkari Shawl
				{ 2,  19724 }, -- Primal Hakkari Aegis
				{ 3,  19723 }, -- Primal Hakkari Kossack
				{ 4,  19722 }, -- Primal Hakkari Tabard
				{ 5,  19717 }, -- Primal Hakkari Armsplint
				{ 6,  19716 }, -- Primal Hakkari Bindings
				{ 7,  19718 }, -- Primal Hakkari Stanchion
				{ 8,  19719 }, -- Primal Hakkari Girdle
				{ 9,  19720 }, -- Primal Hakkari Sash
				{ 16, 19918 }, -- Jeklik's Crusher
				{ 18, 19923 }, -- Jeklik's Opaline Talisman
				{ 19, 19928 }, -- Animist's Spaulders
				{ 20, 20262 }, -- Seafury Boots
				{ 21, 20265 }, -- Peacekeeper Boots
				{ 22, 19920 }, -- Primalist's Band
				{ 23, 19915 }, -- Zulian Defender
			},
		},
		{ -- ZGVenoxis
			name = AL["High Priest Venoxis"],
			npcID = 14507,
			Level = 999,
			DisplayIDs = {{15217}},
			AtlasMapBossID = 2,
			ContentPhase = 6,
			[NORMAL_DIFF] = {
				{ 1,  19721 }, -- Primal Hakkari Shawl
				{ 2,  19724 }, -- Primal Hakkari Aegis
				{ 3,  19723 }, -- Primal Hakkari Kossack
				{ 4,  19722 }, -- Primal Hakkari Tabard
				{ 5,  19717 }, -- Primal Hakkari Armsplint
				{ 6,  19716 }, -- Primal Hakkari Bindings
				{ 7,  19718 }, -- Primal Hakkari Stanchion
				{ 8,  19719 }, -- Primal Hakkari Girdle
				{ 9,  19720 }, -- Primal Hakkari Sash
				{ 16, 19904 }, -- Runed Bloodstained Hauberk
				{ 17, 19903 }, -- Fang of Venoxis
				{ 19, 19907 }, -- Zulian Tigerhide Cloak
				{ 20, 19906 }, -- Blooddrenched Footpads
				{ 21, 19905 }, -- Zanzil's Band
				{ 22, 19900 }, -- Zulian Stone Axe
			},
		},
		{ -- ZGMarli
			name = AL["High Priestess Mar'li"],
			npcID = 14510,
			Level = 999,
			DisplayIDs = {{15220}},
			AtlasMapBossID = 4,
			ContentPhase = 6,
			[NORMAL_DIFF] = {
				{ 1,  19721 }, -- Primal Hakkari Shawl
				{ 2,  19724 }, -- Primal Hakkari Aegis
				{ 3,  19723 }, -- Primal Hakkari Kossack
				{ 4,  19722 }, -- Primal Hakkari Tabard
				{ 5,  19717 }, -- Primal Hakkari Armsplint
				{ 6,  19716 }, -- Primal Hakkari Bindings
				{ 7,  19718 }, -- Primal Hakkari Stanchion
				{ 8,  19719 }, -- Primal Hakkari Girdle
				{ 9,  19720 }, -- Primal Hakkari Sash
				{ 16, 20032 }, -- Flowing Ritual Robes
				{ 17, 19927 }, -- Mar'li's Touch
				{ 19, 19871 }, -- Talisman of Protection
				{ 20, 19919 }, -- Bloodstained Greaves
				{ 21, 19925 }, -- Band of Jin
				{ 22, 19930 }, -- Mar'li's Eye
			},
		},
		{ -- ZGMandokir
			name = AL["Bloodlord Mandokir"],
			npcID = 11382,
			Level = 999,
			DisplayIDs = {{11288}},
			AtlasMapBossID = 5,
			ContentPhase = 6,
			[NORMAL_DIFF] = {
				{ 1,  19721 }, -- Primal Hakkari Shawl
				{ 2,  19724 }, -- Primal Hakkari Aegis
				{ 3,  19723 }, -- Primal Hakkari Kossack
				{ 4,  19722 }, -- Primal Hakkari Tabard
				{ 5,  19717 }, -- Primal Hakkari Armsplint
				{ 6,  19716 }, -- Primal Hakkari Bindings
				{ 7,  19718 }, -- Primal Hakkari Stanchion
				{ 8,  19719 }, -- Primal Hakkari Girdle
				{ 9,  19720 }, -- Primal Hakkari Sash
				{ 11, 22637 }, -- Primal Hakkari Idol
				{ 16, 19872 }, -- Swift Razzashi Raptor
				{ 17, 20038 }, -- Mandokir's Sting
				{ 18, 19867 }, -- Bloodlord's Defender
				{ 19, 19866 }, -- Warblade of the Hakkari
				{ 20, 19874 }, -- Halberd of Smiting
				{ 22, 19878 }, -- Bloodsoaked Pauldrons
				{ 23, 19870 }, -- Hakkari Loa Cloak
				{ 24, 19869 }, -- Blooddrenched Grips
				{ 25, 19895 }, -- Bloodtinged Kilt
				{ 26, 19877 }, -- Animist's Leggings
				{ 27, 19873 }, -- Overlord's Crimson Band
				{ 28, 19863 }, -- Primalist's Seal
				{ 29, 19893 }, -- Zanzil's Seal
			},
		},
		{ -- ZGGrilek
			name = AL["Gri'lek"],
			npcID = 15082,
			Level = 999,
			DisplayIDs = {{8390}},
			AtlasMapBossID = 6,
			ContentPhase = 6,
			[NORMAL_DIFF] = {
				{ 1,  19961 }, -- Gri'lek's Grinder
				{ 2,  19962 }, -- Gri'lek's Carver
				{ 4,  19939 }, -- Gri'lek's Blood
			},
		},
		{ -- ZGHazzarah
			name = AL["Hazza'rah"],
			npcID = 15083,
			Level = 999,
			DisplayIDs = {{15267}},
			AtlasMapBossID = 6,
			ContentPhase = 6,
			[NORMAL_DIFF] = {
				{ 1,  19967 }, -- Thoughtblighter
				{ 2,  19968 }, -- Fiery Retributer
				{ 4,  19942 }, -- Hazza'rah's Dream Thread
			},
		},
		{ -- ZGRenataki
			name = AL["Renataki"],
			npcID = 15084,
			Level = 999,
			DisplayIDs = {{15268}},
			AtlasMapBossID = 6,
			ContentPhase = 6,
			[NORMAL_DIFF] = {
				{ 1,  19964 }, -- Renataki's Soul Conduit
				{ 2,  19963 }, -- Pitchfork of Madness
				{ 4,  19940 }, -- Renataki's Tooth
			},
		},
		{ -- ZGWushoolay
			name = AL["Wushoolay"],
			npcID = 15085,
			Level = 999,
			DisplayIDs = {{15269}},
			AtlasMapBossID = 6,
			ContentPhase = 6,
			[NORMAL_DIFF] = {
				{ 1,  19993 }, -- Hoodoo Hunting Bow
				{ 2,  19965 }, -- Wushoolay's Poker
				{ 4,  19941 }, -- Wushoolay's Mane
			},
		},
		{ -- ZGGahzranka
			name = AL["Gahz'ranka"],
			npcID = 15114,
			Level = 999,
			DisplayIDs = {{15288}},
			AtlasMapBossID = 7,
			ContentPhase = 6,
			[NORMAL_DIFF] = {
				{ 1,  19945 }, -- Foror's Eyepatch
				{ 2,  19944 }, -- Nat Pagle's Fish Terminator
				{ 4,  19947 }, -- Nat Pagle's Broken Reel
				{ 5,  19946 }, -- Tigule's Harpoon
				{ 7,  22739 }, -- Tome of Polymorph: Turtle
			},
		},
		{ -- ZGThekal
			name = AL["High Priest Thekal"],
			npcID = 14509,
			Level = 999,
			DisplayIDs = {{15216}},
			AtlasMapBossID = 8,
			ContentPhase = 6,
			[NORMAL_DIFF] = {
				{ 1,  19721 }, -- Primal Hakkari Shawl
				{ 2,  19724 }, -- Primal Hakkari Aegis
				{ 3,  19723 }, -- Primal Hakkari Kossack
				{ 4,  19722 }, -- Primal Hakkari Tabard
				{ 5,  19717 }, -- Primal Hakkari Armsplint
				{ 6,  19716 }, -- Primal Hakkari Bindings
				{ 7,  19718 }, -- Primal Hakkari Stanchion
				{ 8,  19719 }, -- Primal Hakkari Girdle
				{ 9,  19720 }, -- Primal Hakkari Sash
				{ 16, 19902 }, -- Swift Zulian Tiger
				{ 17, 19897 }, -- Betrayer's Boots
				{ 18, 19896 }, -- Thekal's Grasp
				{ 20, 19899 }, -- Ritualistic Legguards
				{ 21, 20260 }, -- Seafury Leggings
				{ 22, 20266 }, -- Peacekeeper Leggings
				{ 23, 19898 }, -- Seal of Jin
				{ 24, 19901 }, -- Zulian Slicer
			},
		},
		{ -- ZGArlokk
			name = AL["High Priestess Arlokk"],
			npcID = 14515,
			Level = 999,
			DisplayIDs = {{15218}},
			AtlasMapBossID = 9,
			ContentPhase = 6,
			[NORMAL_DIFF] = {
				{ 1,  19721 }, -- Primal Hakkari Shawl
				{ 2,  19724 }, -- Primal Hakkari Aegis
				{ 3,  19723 }, -- Primal Hakkari Kossack
				{ 4,  19722 }, -- Primal Hakkari Tabard
				{ 5,  19717 }, -- Primal Hakkari Armsplint
				{ 6,  19716 }, -- Primal Hakkari Bindings
				{ 7,  19718 }, -- Primal Hakkari Stanchion
				{ 8,  19719 }, -- Primal Hakkari Girdle
				{ 9,  19720 }, -- Primal Hakkari Sash
				{ 16, 19910 }, -- Arlokk's Grasp
				{ 17, 19909 }, -- Will of Arlokk
				{ 19, 19913 }, -- Bloodsoaked Greaves
				{ 20, 19912 }, -- Overlord's Onyx Band
				{ 21, 19922 }, -- Arlokk's Hoodoo Stick
				{ 23, 19914 }, -- Panther Hide Sack
			},
		},
		{ -- ZGJindo
			name = AL["Jin'do the Hexxer"],
			npcID = 11380,
			Level = 999,
			DisplayIDs = {{11311}},
			AtlasMapBossID = 10,
			ContentPhase = 6,
			[NORMAL_DIFF] = {
				{ 1,  19721 }, -- Primal Hakkari Shawl
				{ 2,  19724 }, -- Primal Hakkari Aegis
				{ 3,  19723 }, -- Primal Hakkari Kossack
				{ 4,  19722 }, -- Primal Hakkari Tabard
				{ 5,  19717 }, -- Primal Hakkari Armsplint
				{ 6,  19716 }, -- Primal Hakkari Bindings
				{ 7,  19718 }, -- Primal Hakkari Stanchion
				{ 8,  19719 }, -- Primal Hakkari Girdle
				{ 9,  19720 }, -- Primal Hakkari Sash
				{ 11, 22637 }, -- Primal Hakkari Idol
				{ 16, 19885 }, -- Jin'do's Evil Eye
				{ 17, 19891 }, -- Jin'do's Bag of Whammies
				{ 18, 19890 }, -- Jin'do's Hexxer
				{ 19, 19884 }, -- Jin'do's Judgement
				{ 21, 19886 }, -- The Hexxer's Cover
				{ 22, 19875 }, -- Bloodstained Coif
				{ 23, 19888 }, -- Overlord's Embrace
				{ 24, 19929 }, -- Bloodtinged Gloves
				{ 25, 19894 }, -- Bloodsoaked Gauntlets
				{ 26, 19889 }, -- Blooddrenched Leggings
				{ 27, 19887 }, -- Bloodstained Legplates
				{ 28, 19892 }, -- Animist's Boots
			},
		},
		{ -- ZGHakkar
			name = AL["Hakkar"],
			npcID = 14834,
			Level = 999,
			DisplayIDs = {{15295}},
			AtlasMapBossID = 11,
			ContentPhase = 6,
			[NORMAL_DIFF] = {
				{ 1,  19857 }, -- Cloak of Consumption
				{ 2,  20257, [ATLASLOOT_IT_ALLIANCE] = 20264 }, -- Seafury Gauntlets
				--{ 3,  20264, [ATLASLOOT_IT_HORDE] = 20257 }, -- Peacekeeper Gauntlets
				{ 3,  19855 }, -- Bloodsoaked Legplates
				{ 4,  19876 }, -- Soul Corrupter's Necklace
				{ 5,  19856 }, -- The Eye of Hakkar
				{ 7, 19802 }, -- Heart of Hakkar
				{ 16,  19861 }, -- Touch of Chaos
				{ 17,  19853 }, -- Gurubashi Dwarf Destroyer
				{ 18, 19862 }, -- Aegis of the Blood God
				{ 19, 19864 }, -- Bloodcaller
				{ 20, 19865 }, -- Warblade of the Hakkari
				{ 21, 19866 }, -- Warblade of the Hakkari
				{ 22, 19852 }, -- Ancient Hakkari Manslayer
				{ 23, 19859 }, -- Fang of the Faceless
				{ 24, 19854 }, -- Zin'rokh, Destroyer of Worlds
			},
		},
		{ -- ZGShared
			name = AL["High Priest Shared loot"],
			ExtraList = true,
			ContentPhase = 6,
			[NORMAL_DIFF] = {
				{ 1,  22721 }, -- Band of Servitude
				{ 2,  22722 }, -- Seal of the Gurubashi Berserker
				{ 4,  22720 }, -- Zulian Headdress
				{ 5,  22718 }, -- Blooddrenched Mask
				{ 6,  22711 }, -- Cloak of the Hakkari Worshipers
				{ 7,  22712 }, -- Might of the Tribe
				{ 8,  22715 }, -- Gloves of the Tormented
				{ 9,  22714 }, -- Sacrificial Gauntlets
				{ 10, 22716 }, -- Belt of Untapped Power
				{ 11, 22713 }, -- Zulian Scepter of Rites
			},
		},
		{ -- ZGTrash1
			name = AL["Trash"],
			ContentPhase = 6,
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  20263 }, -- Gurubashi Helm
				{ 2,  20259 }, -- Shadow Panther Hide Gloves
				{ 3,  20261 }, -- Shadow Panther Hide Belt
				{ 4,  19921 }, -- Zulian Hacker
				{ 5,  19908 }, -- Sceptre of Smiting
				{ 16,  20258 }, -- Zulian Ceremonial Staff
				{ 17, 19726 }, -- Bloodvine
				{ 18, 19774 }, -- Souldarite
				{ 19, 19767 }, -- Primal Bat Leather
				{ 20, 19768 }, -- Primal Tiger Leather
				{ 7, 19706 }, -- Bloodscalp Coin
				{ 8, 19701 }, -- Gurubashi Coin
				{ 9, 19700 }, -- Hakkari Coin
				{ 10, 19699 }, -- Razzashi Coin
				{ 11, 19704 }, -- Sandfury Coin
				{ 12, 19705 }, -- Skullsplitter Coin
				{ 13, 19702 }, -- Vilebranch Coin
				{ 14, 19703 }, -- Witherbark Coin
				{ 15, 19698 }, -- Zulian Coin
				{ 22, 19708 }, -- Blue Hakkari Bijou
				{ 23, 19713 }, -- Bronze Hakkari Bijou
				{ 24, 19715 }, -- Gold Hakkari Bijou
				{ 25, 19711 }, -- Green Hakkari Bijou
				{ 26, 19710 }, -- Orange Hakkari Bijou
				{ 27, 19712 }, -- Purple Hakkari Bijou
				{ 28, 19707 }, -- Red Hakkari Bijou
				{ 29, 19714 }, -- Silver Hakkari Bijou
				{ 30, 19709 }, -- Yellow Hakkari Bijou
			},
		},
		{ -- ZGEnchants
			name = AL["Enchants"],
			ContentPhase = 6,
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  19789 }, -- Prophetic Aura
				{ 2,  19787 }, -- Presence of Sight
				{ 3,  19788 }, -- Hoodoo Hex
				{ 4,  19784 }, -- Death's Embrace
				{ 5,  19790 }, -- Animist's Caress
				{ 6,  19785 }, -- Falcon's Call
				{ 7,  19786 }, -- Vodouisant's Vigilant Embrace
				{ 8,  19783 }, -- Syncretist's Sigil
				{ 9,  19782 }, -- Presence of Might
				{ 16, 20077 }, -- Zandalar Signet of Might
				{ 17, 20076 }, -- Zandalar Signet of Mojo
				{ 18, 20078 }, -- Zandalar Signet of Serenity
				{ 20, 22635 }, -- Savage Guard
			},
		},
		{ -- ZGMuddyChurningWaters
			name = AL["Muddy Churning Waters"],
			ExtraList = true,
			AtlasMapBossID = "1'",
			ContentPhase = 6,
			[NORMAL_DIFF] = {
				{ 1,  19975 }, -- Zulian Mudskunk
			},
		},
		{ -- ZGJinxedHoodooPile
			name = AL["Jinxed Hoodoo Pile"],
			ExtraList = true,
			AtlasMapBossID = "2'",
			ContentPhase = 6,
			[NORMAL_DIFF] = {
				{ 1,  19727 }, -- Blood Scythe
				{ 3,  19820 }, -- Punctured Voodoo Doll
				{ 4,  19818 }, -- Punctured Voodoo Doll
				{ 5,  19819 }, -- Punctured Voodoo Doll
				{ 6,  19814 }, -- Punctured Voodoo Doll
				{ 7,  19821 }, -- Punctured Voodoo Doll
				{ 8,  19816 }, -- Punctured Voodoo Doll
				{ 9,  19817 }, -- Punctured Voodoo Doll
				{ 10, 19815 }, -- Punctured Voodoo Doll
				{ 11, 19813 }, -- Punctured Voodoo Doll
			},
		},
	},
}

data["BlackwingLair"] = {
	MapID = 2677,
	InstanceID = 469,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "BlackwingLair",
	AtlasMapFile = "CL_BlackwingLair",
	AtlasMapFile_AL = "BlackwingLair",
	ContentType = RAID40_CONTENT,
	LoadDifficulty = RAID40_DIFF,
	ContentPhase = 5,
	items = {
		{ -- BWLRazorgore
			name = AL["Razorgore the Untamed"],
			npcID = 12435,
			Level = 999,
			DisplayIDs = {{10115}},
			AtlasMapBossID = 1,
			ContentPhase = 5,
			[NORMAL_DIFF] = {
				{ 1,  16926 }, -- Bindings of Transcendence
				{ 2,  16918 }, -- Netherwind Bindings
				{ 3,  16934 }, -- Nemesis Bracers
				{ 4,  16911 }, -- Bloodfang Bracers
				{ 5,  16904 }, -- Stormrage Bracers
				{ 6,  16935 }, -- Dragonstalker's Bracers
				{ 7,  16943 }, -- Bracers of Ten Storms
				{ 8,  16951 }, -- Judgement Bindings
				{ 9,  16959 }, -- Bracelets of Wrath
				{ 16, 19336 }, -- Arcane Infused Gem
				{ 17, 19337 }, -- The Black Book
				{ 19, 19370 }, -- Mantle of the Blackwing Cabal
				{ 20, 19369 }, -- Gloves of Rapid Evolution
				{ 21, 19335 }, -- Spineshatter
				{ 22, 19334 }, -- The Untamed Blade
			},
		},
		{ -- BWLVaelastrasz
			name = AL["Vaelastrasz the Corrupt"],
			npcID = 13020,
			Level = 999,
			DisplayIDs = {{13992}},
			AtlasMapBossID = 2,
			ContentPhase = 5,
			[NORMAL_DIFF] = {
				{ 1,  16925 }, -- Belt of Transcendence
				{ 2,  16818 }, -- Netherwind Belt
				{ 3,  16933 }, -- Nemesis Belt
				{ 4,  16910 }, -- Bloodfang Belt
				{ 5,  16903 }, -- Stormrage Belt
				{ 6,  16936 }, -- Dragonstalker's Belt
				{ 7,  16944 }, -- Belt of Ten Storms
				{ 8,  16952 }, -- Judgement Belt
				{ 9,  16960 }, -- Waistband of Wrath
				{ 16, 19339 }, -- Mind Quickening Gem
				{ 17, 210980 }, -- Rune of Metamorphosis
				{ 19, 19372 }, -- Helm of Endless Rage
				{ 20, 19371 }, -- Pendant of the Fallen Dragon
				{ 21, 19348 }, -- Red Dragonscale Protector
				{ 22, 19346 }, -- Dragonfang Blade
			},
		},
		{ -- BWLLashlayer
			name = AL["Broodlord Lashlayer"],
			npcID = 12017,
			Level = 999,
			DisplayIDs = {{14308}},
			AtlasMapBossID = 3,
			ContentPhase = 5,
			[NORMAL_DIFF] = {
				{ 1,  16919 }, -- Boots of Transcendence
				{ 2,  16912 }, -- Netherwind Boots
				{ 3,  16927 }, -- Nemesis Boots
				{ 4,  16906 }, -- Bloodfang Boots
				{ 5,  16898 }, -- Stormrage Boots
				{ 6,  16941 }, -- Dragonstalker's Greaves
				{ 7,  16949 }, -- Greaves of Ten Storms
				{ 8,  16957 }, -- Judgement Sabatons
				{ 9,  16965 }, -- Sabatons of Wrath
				{ 16, 19341 }, -- Lifegiving Gem
				{ 17, 19342 }, -- Venomous Totem
				{ 19, 19373 }, -- Black Brood Pauldrons
				{ 20, 19374 }, -- Bracers of Arcane Accuracy
				{ 21, 19350 }, -- Heartstriker
				{ 22, 19351 }, -- Maladath, Runed Blade of the Black Flight
				{ 24, 20383 }, -- Head of the Broodlord Lashlayer
			},
		},
		{ -- BWLFiremaw
			name = AL["Firemaw"],
			npcID = 11983,
			Level = 999,
			DisplayIDs = {{6377}},
			AtlasMapBossID = 4,
			ContentPhase = 5,
			[NORMAL_DIFF] = {
				{ 1,  16920 }, -- Handguards of Transcendence
				{ 2,  16913 }, -- Netherwind Gloves
				{ 3,  16928 }, -- Nemesis Gloves
				{ 4,  16907 }, -- Bloodfang Gloves
				{ 5,  16899 }, -- Stormrage Handguards
				{ 6,  16940 }, -- Dragonstalker's Gauntlets
				{ 7,  16948 }, -- Gauntlets of Ten Storms
				{ 8,  16956 }, -- Judgement Gauntlets
				{ 9,  16964 }, -- Gauntlets of Wrath
				{ 13, 19344 }, -- Natural Alignment Crystal
				{ 14, 19343 }, -- Scrolls of Blinding Light
				{ 16, 19394 }, -- Drake Talon Pauldrons
				{ 17, 19398 }, -- Cloak of Firemaw
				{ 18, 19399 }, -- Black Ash Robe
				{ 19, 19400 }, -- Firemaw's Clutch
				{ 20, 19396 }, -- Taut Dragonhide Belt
				{ 21, 19401 }, -- Primalist's Linked Legguards
				{ 22, 19402 }, -- Legguards of the Fallen Crusader
				{ 24, 19365 }, -- Claw of the Black Drake
				{ 25, 19353 }, -- Drake Talon Cleaver
				{ 26, 19355 }, -- Shadow Wing Focus Staff
				{ 28, 19397 }, -- Ring of Blackrock
				{ 29, 19395 }, -- Rejuvenating Gem
			},
		},
		{ -- BWLEbonroc
			name = AL["Ebonroc"],
			npcID = 14601,
			Level = 999,
			DisplayIDs = {{6377}},
			AtlasMapBossID = 5,
			ContentPhase = 5,
			[NORMAL_DIFF] = {
				{ 1,  16920 }, -- Handguards of Transcendence
				{ 2,  16913 }, -- Netherwind Gloves
				{ 3,  16928 }, -- Nemesis Gloves
				{ 4,  16907 }, -- Bloodfang Gloves
				{ 5,  16899 }, -- Stormrage Handguards
				{ 6,  16940 }, -- Dragonstalker's Gauntlets
				{ 7,  16948 }, -- Gauntlets of Ten Storms
				{ 8,  16956 }, -- Judgement Gauntlets
				{ 9,  16964 }, -- Gauntlets of Wrath
				{ 11, 19345 }, -- Aegis of Preservation
				{ 12, 19406 }, -- Drake Fang Talisman
				{ 13, 19395 }, -- Rejuvenating Gem
				{ 16, 19394 }, -- Drake Talon Pauldrons
				{ 17, 19407 }, -- Ebony Flame Gloves
				{ 18, 19396 }, -- Taut Dragonhide Belt
				{ 19, 19405 }, -- Malfurion's Blessed Bulwark
				{ 21, 19368 }, -- Dragonbreath Hand Cannon
				{ 22, 19353 }, -- Drake Talon Cleaver
				{ 23, 19355 }, -- Shadow Wing Focus Staff
				{ 26, 19403 }, -- Band of Forced Concentration
				{ 27, 19397 }, -- Ring of Blackrock

			},
		},
		{ -- BWLFlamegor
			name = AL["Flamegor"],
			npcID = 11981,
			Level = 999,
			DisplayIDs = {{6377}},
			AtlasMapBossID = 6,
			ContentPhase = 5,
			[NORMAL_DIFF] = {
				{ 1,  16920 }, -- Handguards of Transcendence
				{ 2,  16913 }, -- Netherwind Gloves
				{ 3,  16928 }, -- Nemesis Gloves
				{ 4,  16907 }, -- Bloodfang Gloves
				{ 5,  16899 }, -- Stormrage Handguards
				{ 6,  16940 }, -- Dragonstalker's Gauntlets
				{ 7,  16948 }, -- Gauntlets of Ten Storms
				{ 8,  16956 }, -- Judgement Gauntlets
				{ 9,  16964 }, -- Gauntlets of Wrath
				{ 11, 19395 }, -- Rejuvenating Gem
				{ 12, 19431 }, -- Styleen's Impeding Scarab
				{ 16, 19394 }, -- Drake Talon Pauldrons
				{ 17, 19430 }, -- Shroud of Pure Thought
				{ 18, 19396 }, -- Taut Dragonhide Belt
				{ 19, 19433 }, -- Emberweave Leggings
				{ 21, 19367 }, -- Dragon's Touch
				{ 22, 19353 }, -- Drake Talon Cleaver
				{ 23, 19357 }, -- Herald of Woe
				{ 24, 19355 }, -- Shadow Wing Focus Staff
				{ 26, 19432 }, -- Circle of Applied Force
				{ 27, 19397 }, -- Ring of Blackrock
			},
		},
		{ -- BWLChromaggus
			name = AL["Chromaggus"],
			npcID = 14020,
			Level = 999,
			DisplayIDs = {{14367}},
			AtlasMapBossID = 7,
			ContentPhase = 5,
			[NORMAL_DIFF] = {
				{ 1,  16924 }, -- Pauldrons of Transcendence
				{ 2,  16917 }, -- Netherwind Mantle
				{ 3,  16932 }, -- Nemesis Spaulders
				{ 4,  16832 }, -- Bloodfang Spaulders
				{ 5,  16902 }, -- Stormrage Pauldrons
				{ 6,  16937 }, -- Dragonstalker's Spaulders
				{ 7,  16945 }, -- Epaulets of Ten Storms
				{ 8,  16953 }, -- Judgement Spaulders
				{ 9,  16961 }, -- Pauldrons of Wrath
				{ 16, 19389 }, -- Taut Dragonhide Shoulderpads
				{ 17, 19386 }, -- Elementium Threaded Cloak
				{ 18, 19390 }, -- Taut Dragonhide Gloves
				{ 19, 19388 }, -- Angelista's Grasp
				{ 20, 19393 }, -- Primalist's Linked Waistguard
				{ 21, 19392 }, -- Girdle of the Fallen Crusader
				{ 22, 19385 }, -- Empowered Leggings
				{ 23, 19391 }, -- Shimmering Geta
				{ 24, 19387 }, -- Chromatic Boots
				{ 26, 19361 }, -- Ashjre'thul, Crossbow of Smiting
				{ 27, 19349 }, -- Elementium Reinforced Bulwark
				{ 28, 19347 }, -- Claw of Chromaggus
				{ 29, 19352 }, -- Chromatically Tempered Sword
			},
		},
		{ -- BWLNefarian
			name = AL["Nefarian"],
			npcID = 11583,
			Level = 999,
			DisplayIDs = {{11380}},
			AtlasMapBossID = 8,
			ContentPhase = 5,
			[NORMAL_DIFF] = {
				{ 1,  16923 }, -- Robes of Transcendence
				{ 2,  16916 }, -- Netherwind Robes
				{ 3,  16931 }, -- Nemesis Robes
				{ 4,  16905 }, -- Bloodfang Chestpiece
				{ 5,  16897 }, -- Stormrage Chestguard
				{ 6,  16942 }, -- Dragonstalker's Breastplate
				{ 7,  16950 }, -- Breastplate of Ten Storms
				{ 8,  16958 }, -- Judgement Breastplate
				{ 9,  16966 }, -- Breastplate of Wrath
				{ 11, 19003 }, -- Head of Nefarian
				{ 16, 19360 }, -- Lok'amir il Romathis
				{ 17, 19363 }, -- Crul'shorukh, Edge of Chaos
				{ 18, 19364 }, -- Ashkandi, Greatsword of the Brotherhood
				{ 19, 19356 }, -- Staff of the Shadow Flame
				{ 21, 19375 }, -- Mish'undare, Circlet of the Mind Flayer
				{ 22, 19377 }, -- Prestor's Talisman of Connivery
				{ 23, 19378 }, -- Cloak of the Brood Lord
				{ 24, 19380 }, -- Therazane's Link
				{ 25, 19381 }, -- Boots of the Shadow Flame
				{ 26, 19376 }, -- Archimtiros' Ring of Reckoning
				{ 27, 19382 }, -- Pure Elementium Band
				{ 28, 19379 }, -- Neltharion's Tear
				{ 30, 11938 }, -- Sack of Gems
				-- Hidden items
				{ 0, 17962 }, -- Blue Sack of Gems
				{ 0, 17963 }, -- Green Sack of Gems
				{ 0, 17964 }, -- Gray Sack of Gems
				{ 0, 17965 }, -- Yellow Sack of Gems
				{ 0, 17969 }, -- Red Sack of Gems
			},
		},
		{ -- BWLTrashMobs
			name = AL["Trash"],
			ExtraList = true,
			ContentPhase = 5,
			[NORMAL_DIFF] = {
				{ 1,  19436 }, -- Cloak of Draconic Might
				{ 2,  19439 }, -- Interlaced Shadow Jerkin
				{ 3,  19437 }, -- Boots of Pure Thought
				{ 4,  19438 }, -- Ringo's Blizzard Boots
				{ 5,  19434 }, -- Band of Dark Dominion
				{ 6,  19435 }, -- Essence Gatherer
				{ 7,  19362 }, -- Doom's Edge
				{ 8,  19354 }, -- Draconic Avenger
				{ 9,  19358 }, -- Draconic Maul
				{ 11, 18562 }, -- Elementium Ore
			},
		},
		T2_SET,
	},
}

data["TheRuinsofAhnQiraj"] = { -- AQ20
	MapID = 3429,
	InstanceID = 509,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "TheRuinsofAhnQiraj",
	AtlasMapFile = "CL_TheRuinsofAhnQiraj",
	AtlasMapFile_AL = "TheRuinsofAhnQiraj",
	ContentType = RAID20_CONTENT,
	LoadDifficulty = RAID20_DIFF,
	ContentPhase = 7,
	items = {
		{ -- AQ20Kurinnaxx
			name = AL["Kurinnaxx"],
			npcID = 15348,
			Level = 999,
			DisplayIDs = {{15742}},
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1,  21499 }, -- Vestments of the Shifting Sands
				{ 2,  21498 }, -- Qiraji Sacrificial Dagger
				{ 4,  21502 }, -- Sand Reaver Wristguards
				{ 5,  21501 }, -- Toughened Silithid Hide Gloves
				{ 6,  21500 }, -- Belt of the Inquisition
				{ 7,  21503 }, -- Belt of the Sand Reaver
				{ 19, 20885 }, -- Qiraji Martial Drape
				{ 20, 20889 }, -- Qiraji Regal Drape
				{ 21, 20888 }, -- Qiraji Ceremonial Ring
				{ 22, 20884 }, -- Qiraji Magisterial Ring
			},
		},
		{ -- AQ20Rajaxx
			name = AL["General Rajaxx"],
			npcID = 15341,
			Level = 999,
			DisplayIDs = {{15376}},
			AtlasMapBossID = 2,
			[NORMAL_DIFF] = {
				{ 1,  21493 }, -- Boots of the Vanguard
				{ 2,  21492 }, -- Manslayer of the Qiraji
				{ 4,  21496 }, -- Bracers of Qiraji Command
				{ 5,  21494 }, -- Southwind's Grasp
				{ 6,  21495 }, -- Legplates of the Qiraji Command
				{ 7,  21497 }, -- Boots of the Qiraji General
				{ 9,  "INV_Box_01", nil, AL["Trash"] },
				{ 10,  21810 }, -- Treads of the Wandering Nomad
				{ 11,  21809 }, -- Fury of the Forgotten Swarm
				{ 12,  21806 }, -- Gavel of Qiraji Authority
				{ 19, 20885 }, -- Qiraji Martial Drape
				{ 20, 20889 }, -- Qiraji Regal Drape
				{ 21, 20888 }, -- Qiraji Ceremonial Ring
				{ 22, 20884 }, -- Qiraji Magisterial Ring
			},
		},
		{ -- AQ20Moam
			name = AL["Moam"],
			npcID = 15340,
			Level = 999,
			DisplayIDs = {{15392}},
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1,  21472 }, -- Dustwind Turban
				{ 2,  21467 }, -- Thick Silithid Chestguard
				{ 3,  21479 }, -- Gauntlets of the Immovable
				{ 4,  21471 }, -- Talon of Furious Concentration
				{ 6,  21455 }, -- Southwind Helm
				{ 7,  21468 }, -- Mantle of Maz'Nadir
				{ 8,  21474 }, -- Chitinous Shoulderguards
				{ 9,  21470 }, -- Cloak of the Savior
				{ 10, 21469 }, -- Gauntlets of Southwind
				{ 11, 21476 }, -- Obsidian Scaled Leggings
				{ 12, 21475 }, -- Legplates of the Destroyer
				{ 13, 21477 }, -- Ring of Fury
				{ 14, 21473 }, -- Eye of Moam
				{ 16, 20890 }, -- Qiraji Ornate Hilt
				{ 17, 20886 }, -- Qiraji Spiked Hilt
				{ 21, 20888 }, -- Qiraji Ceremonial Ring
				{ 22, 20884 }, -- Qiraji Magisterial Ring
				{ 24, 22220 }, -- Plans: Black Grasp of the Destroyer
				--{ 24, 22194 }, -- Black Grasp of the Destroyer
			},
		},
		{ -- AQ20Buru
			name = AL["Buru the Gorger"],
			npcID = 15370,
			Level = 999,
			DisplayIDs = {{15654}},
			AtlasMapBossID = 4,
			[NORMAL_DIFF] = {
				{ 1,  21487, [ATLASLOOT_IT_ALLIANCE] = 21486 }, -- Slimy Scaled Gauntlets
				--{ 2,  21486 }, -- Gloves of the Swarm
				{ 2,  21485 }, -- Buru's Skull Fragment
				{ 5,  21491 }, -- Scaled Bracers of the Gorger
				{ 6,  21489 }, -- Quicksand Waders
				{ 7,  21490 }, -- Slime Kickers
				{ 8,  21488 }, -- Fetish of Chitinous Spikes
				{ 16, 20890 }, -- Qiraji Ornate Hilt
				{ 17, 20886 }, -- Qiraji Spiked Hilt
				{ 20, 20885 }, -- Qiraji Martial Drape
				{ 21, 20889 }, -- Qiraji Regal Drape
				{ 22, 20888 }, -- Qiraji Ceremonial Ring
				{ 23, 20884 }, -- Qiraji Magisterial Ring
			},
		},
		{ -- AQ20Ayamiss
			name = AL["Ayamiss the Hunter"],
			npcID = 15369,
			Level = 999,
			DisplayIDs = {{15431}},
			AtlasMapBossID = 5,
			[NORMAL_DIFF] = {
				{ 1,  21479 }, -- Gauntlets of the Immovable
				{ 2,  21478 }, -- Bow of Taut Sinew
				{ 3,  21466 }, -- Stinger of Ayamiss
				{ 5,  21484 }, -- Helm of Regrowth
				{ 6,  21480 }, -- Scaled Silithid Gauntlets
				{ 7,  21482 }, -- Boots of the Fiery Sands
				{ 8,  21481 }, -- Boots of the Desert Protector
				{ 9,  21483 }, -- Ring of the Desert Winds
				{ 16, 20890 }, -- Qiraji Ornate Hilt
				{ 17, 20886 }, -- Qiraji Spiked Hilt
				{ 20, 20885 }, -- Qiraji Martial Drape
				{ 21, 20889 }, -- Qiraji Regal Drape
				{ 22, 20888 }, -- Qiraji Ceremonial Ring
				{ 23, 20884 }, -- Qiraji Magisterial Ring
			},
		},
		{ -- AQ20Ossirian
			name = AL["Ossirian the Unscarred"],
			npcID = 15339,
			Level = 999,
			DisplayIDs = {{15432}},
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1,  21460 }, -- Helm of Domination
				{ 2,  21454, [ATLASLOOT_IT_ALLIANCE] = 21453 }, -- Runic Stone Shoulders
				--{ 3,  21453 }, -- Mantle of the Horusath
				{ 3,  21456 }, -- Sandstorm Cloak
				{ 4,  21464 }, -- Shackles of the Unscarred
				{ 5,  21457 }, -- Bracers of Brutality
				{ 6,  21462 }, -- Gloves of Dark Wisdom
				{ 7,  21458 }, -- Gauntlets of New Life
				{ 8,  21463 }, -- Ossirian's Binding
				{ 9, 21461 }, -- Leggings of the Black Blizzard
				{ 10, 21459 }, -- Crossbow of Imminent Doom
				{ 11, 21715 }, -- Sand Polished Hammer
				{ 12, 21452 }, -- Staff of the Ruins
				{ 16, 20890 }, -- Qiraji Ornate Hilt
				{ 17, 20886 }, -- Qiraji Spiked Hilt
				{ 20, 20888 }, -- Qiraji Ceremonial Ring
				{ 21, 20884 }, -- Qiraji Magisterial Ring
				{ 23, 21220 }, -- Head of Ossirian the Unscarred
			},
		},
		{ -- AQ20Trash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  21804, [ATLASLOOT_IT_ALLIANCE] = 21803 }, -- Coif of Elemental Fury
				--{ 2,  21803 }, -- Helm of the Holy Avenger
				{ 2,  21805 }, -- Polished Obsidian Pauldrons
				{ 5,  20873 }, -- Alabaster Idol
				{ 6,  20869 }, -- Amber Idol
				{ 7,  20866 }, -- Azure Idol
				{ 8,  20870 }, -- Jasper Idol
				{ 9,  20868 }, -- Lambent Idol
				{ 10, 20871 }, -- Obsidian Idol
				{ 11, 20867 }, -- Onyx Idol
				{ 12, 20872 }, -- Vermillion Idol
				{ 14, 21761 }, -- Scarab Coffer Key
				{ 15, 21156 }, -- Scarab Bag
				{ 16, 21801 }, -- Antenna of Invigoration
				{ 17, 21800 }, -- Silithid Husked Launcher
				{ 18, 21802 }, -- The Lost Kris of Zedd
				{ 20, 20864 }, -- Bone Scarab
				{ 21, 20861 }, -- Bronze Scarab
				{ 22, 20863 }, -- Clay Scarab
				{ 23, 20862 }, -- Crystal Scarab
				{ 24, 20859 }, -- Gold Scarab
				{ 25, 20865 }, -- Ivory Scarab
				{ 26, 20860 }, -- Silver Scarab
				{ 27, 20858 }, -- Stone Scarab
				{ 29, 22203 }, -- Large Obsidian Shard
				{ 30, 22202 }, -- Small Obsidian Shard
			},
		},
		{ -- AQ20ClassBooks
			name = AL["Class books"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  21284 }, -- Codex of Greater Heal V
				{ 2,  21287 }, -- Codex of Prayer of Healing V
				{ 3,  21285 }, -- Codex of Renew X
				{ 4,  21279 }, -- Tome of Fireball XII
				{ 5,  21214 }, -- Tome of Frostbolt XI
				{ 6,  21280 }, -- Tome of Arcane Missiles VIII
				{ 7,  21281 }, -- Grimoire of Shadow Bolt X
				{ 8,  21283 }, -- Grimoire of Corruption VII
				{ 9,  21282 }, -- Grimoire of Immolate VIII
				{ 10, 21300 }, -- Handbook of Backstab IX
				{ 11, 21303 }, -- Handbook of Feint V
				{ 12, 21302 }, -- Handbook of Deadly Poison V
				{ 13, 21294 }, -- Book of Healing Touch XI
				{ 14, 21296 }, -- Book of Rejuvenation XI
				{ 15, 21295 }, -- Book of Starfire VII
				{ 16, 21306 }, -- Guide: Serpent Sting IX
				{ 17, 21304 }, -- Guide: Multi-Shot V
				{ 18, 21307 }, -- Guide: Aspect of the Hawk VII
				{ 19, 21291 }, -- Tablet of Healing Wave X
				{ 20, 21292 }, -- Tablet of Strength of Earth Totem V
				{ 21, 21293 }, -- Tablet of Grace of Air Totem III
				{ 22, 21288 }, -- Libram: Blessing of Wisdom VI
				{ 23, 21289 }, -- Libram: Blessing of Might VII
				{ 24, 21290 }, -- Libram: Holy Light IX
				{ 25, 21298 }, -- Manual of Battle Shout VII
				{ 26, 21299 }, -- Manual of Revenge VI
				{ 27, 21297 }, -- Manual of Heroic Strike IX
			},
		},
		AQ_SCARABS,
		AQ_ENCHANTS,
		AQ_OPENING,
	},
}

data["TheTempleofAhnQiraj"] = { -- AQ40
	MapID = 3428,
	InstanceID = 531,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "TheTempleofAhnQiraj",
	AtlasMapFile = "CL_TheTempleofAhnQiraj",
	AtlasMapFile_AL = "TheTempleofAhnQiraj",
	ContentType = RAID40_CONTENT,
	LoadDifficulty = RAID40_DIFF,
	ContentPhase = 7,
	items = {
		{ -- AQ40Skeram
			name = AL["The Prophet Skeram"],
			npcID = 15263,
			Level = 999,
			DisplayIDs = {{15345}},
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1,  21699 }, -- Barrage Shoulders
				{ 2,  21814 }, -- Breastplate of Annihilation
				{ 3,  21708 }, -- Beetle Scaled Wristguards
				{ 4,  21698 }, -- Leggings of Immersion
				{ 5,  21705 }, -- Boots of the Fallen Prophet
				{ 6,  21704 }, -- Boots of the Redeemed Prophecy
				{ 7,  21706 }, -- Boots of the Unwavering Will
				{ 9,  21702 }, -- Amulet of Foul Warding
				{ 10, 21700 }, -- Pendant of the Qiraji Guardian
				{ 11, 21701 }, -- Cloak of Concentrated Hatred
				{ 12, 21707 }, -- Ring of Swarming Thought
				{ 13, 21703 }, -- Hammer of Ji'zhi
				{ 14, 21128 }, -- Staff of the Qiraji Prophets
				{ 16, 21237 }, -- Imperial Qiraji Regalia
				{ 17, 21232 }, -- Imperial Qiraji Armaments
				{ 19, 22222 }, -- Plans: Thick Obsidian Breastplate
				--{ 20, 22196 }, -- Thick Obsidian Breastplate
			},
		},
		{ -- AQ40Trio
			name = AL["Bug Trio"],
			npcID = {15543, 15544, 15511},
			Level = 999,
			DisplayIDs = {{15657},{15658},{15656}},
			AtlasMapBossID = 2,
			[NORMAL_DIFF] = {
				{ 1,  21693 }, -- Guise of the Devourer
				{ 2,  21694 }, -- Ternary Mantle
				{ 3,  21697 }, -- Cape of the Trinity
				{ 4,  21696 }, -- Robes of the Triumvirate
				{ 5,  21692 }, -- Triad Girdle
				{ 6,  21695 }, -- Angelista's Touch
				{ 8,  21237 }, -- Imperial Qiraji Regalia
				{ 9,  21232 }, -- Imperial Qiraji Armaments
				{ 11, "INV_BOX_02", nil, format(AL["%s killed last"], AL["Lord Kri"]) },
				{ 12, 21680 }, -- Vest of Swift Execution
				{ 13, 21681 }, -- Ring of the Devoured
				{ 14, 21685 }, -- Petrified Scarab
				{ 15, 21603 }, -- Wand of Qiraji Nobility
				{ 16, "INV_BOX_02", nil, format(AL["%s killed last"], AL["Vem"]) },
				{ 17, 21690 }, -- Angelista's Charm
				{ 18, 21689 }, -- Gloves of Ebru
				{ 19, 21691 }, -- Ooze-ridden Gauntlets
				{ 20, 21688 }, -- Boots of the Fallen Hero
				{ 22, "INV_BOX_02", nil, format(AL["%s killed last"], AL["Princess Yauj"]) },
				{ 23, 21686 }, -- Mantle of Phrenic Power
				{ 24, 21684 }, -- Mantle of the Desert's Fury
				{ 25, 21683 }, -- Mantle of the Desert Crusade
				{ 26, 21682 }, -- Bile-Covered Gauntlets
				{ 27, 21687 }, -- Ukko's Ring of Darkness
			},
		},
		{ -- AQ40Sartura
			name = AL["Battleguard Sartura"],
			npcID = 15516,
			Level = 999,
			DisplayIDs = {{15583}},
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1,  21669 }, -- Creeping Vine Helm
				{ 2,  21678 }, -- Necklace of Purity
				{ 3,  21671 }, -- Robes of the Battleguard
				{ 4,  21672 }, -- Gloves of Enforcement
				{ 5,  21674 }, -- Gauntlets of Steadfast Determination
				{ 6,  21675 }, -- Thick Qirajihide Belt
				{ 7,  21676 }, -- Leggings of the Festering Swarm
				{ 8,  21668 }, -- Scaled Leggings of Qiraji Fury
				{ 9,  21667 }, -- Legplates of Blazing Light
				{ 10, 21648 }, -- Recomposed Boots
				{ 11, 21670 }, -- Badge of the Swarmguard
				{ 12, 21666 }, -- Sartura's Might
				{ 13, 21673 }, -- Silithid Claw
				{ 16, 21237 }, -- Imperial Qiraji Regalia
				{ 17, 21232 }, -- Imperial Qiraji Armaments
			},
		},
		{ -- AQ40Fankriss
			name = AL["Fankriss the Unyielding"],
			npcID = 15510,
			Level = 999,
			DisplayIDs = {{15743}},
			AtlasMapBossID = 4,
			[NORMAL_DIFF] = {
				{ 1,  21665 }, -- Mantle of Wicked Revenge
				{ 2,  21639 }, -- Pauldrons of the Unrelenting
				{ 3,  21627 }, -- Cloak of Untold Secrets
				{ 4,  21663 }, -- Robes of the Guardian Saint
				{ 5,  21652 }, -- Silithid Carapace Chestguard
				{ 6,  21651 }, -- Scaled Sand Reaver Leggings
				{ 7,  21645 }, -- Hive Tunneler's Boots
				{ 8,  21650 }, -- Ancient Qiraji Ripper
				{ 9,  21635 }, -- Barb of the Sand Reaver
				{ 11, 21664 }, -- Barbed Choker
				{ 12, 21647 }, -- Fetish of the Sand Reaver
				{ 13, 22402 }, -- Libram of Grace
				{ 14, 22396 }, -- Totem of Life
				{ 16, 21237 }, -- Imperial Qiraji Regalia
				{ 17, 21232 }, -- Imperial Qiraji Armaments
			},
		},
		{ -- AQ40Viscidus
			name = AL["Viscidus"],
			npcID = 15299,
			Level = 999,
			DisplayIDs = {{15686}},
			AtlasMapBossID = 5,
			[NORMAL_DIFF] = {
				{ 1,  21624 }, -- Gauntlets of Kalimdor
				{ 2,  21623 }, -- Gauntlets of the Righteous Champion
				{ 3,  21626 }, -- Slime-coated Leggings
				{ 4,  21622 }, -- Sharpened Silithid Femur
				{ 6,  21677 }, -- Ring of the Qiraji Fury
				{ 7,  21625 }, -- Scarab Brooch
				{ 8,  22399 }, -- Idol of Health
				{ 16, 21237 }, -- Imperial Qiraji Regalia
				{ 17, 21232 }, -- Imperial Qiraji Armaments
				{ 19, 20928 }, -- Qiraji Bindings of Command
				{ 20, 20932 }, -- Qiraji Bindings of Dominance
			},
		},
		{ -- AQ40Huhuran
			name = AL["Princess Huhuran"],
			npcID = 15509,
			Level = 999,
			DisplayIDs = {{15739}},
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1,  21621 }, -- Cloak of the Golden Hive
				{ 2,  21618 }, -- Hive Defiler Wristguards
				{ 3,  21619 }, -- Gloves of the Messiah
				{ 4,  21617 }, -- Wasphide Gauntlets
				{ 5,  21620 }, -- Ring of the Martyr
				{ 6,  21616 }, -- Huhuran's Stinger
				{ 16, 21237 }, -- Imperial Qiraji Regalia
				{ 17, 21232 }, -- Imperial Qiraji Armaments
				{ 19, 20928 }, -- Qiraji Bindings of Command
				{ 20, 20932 }, -- Qiraji Bindings of Dominance
			},
		},
		{ -- AQ40Emperors
			name = AL["Twin Emperors"],
			npcID = {15275, 15276},
			Level = 999,
			DisplayIDs = {{15761},{15778}},
			AtlasMapBossID = 7,
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["Emperor Vek'lor"], nil },
				{ 2,  20930 }, -- Vek'lor's Diadem
				{ 3,  21602 }, -- Qiraji Execution Bracers
				{ 4,  21599 }, -- Vek'lor's Gloves of Devastation
				{ 5,  21598 }, -- Royal Qiraji Belt
				{ 6,  21600 }, -- Boots of Epiphany
				{ 7,  21601 }, -- Ring of Emperor Vek'lor
				{ 8,  21597 }, -- Royal Scepter of Vek'lor
				{ 9,  20735 }, -- Formula: Enchant Cloak - Subtlety
				{ 12, 21232 }, -- Imperial Qiraji Armaments
				{ 16, "INV_Box_01", nil, AL["Emperor Vek'nilash"], nil },
				{ 17, 20926 }, -- Vek'nilash's Circlet
				{ 18, 21608 }, -- Amulet of Vek'nilash
				{ 19, 21604 }, -- Bracelets of Royal Redemption
				{ 20, 21605 }, -- Gloves of the Hidden Temple
				{ 21, 21609 }, -- Regenerating Belt of Vek'nilash
				{ 22, 21607 }, -- Grasp of the Fallen Emperor
				{ 23, 21606 }, -- Belt of the Fallen Emperor
				{ 24, 21679 }, -- Kalimdor's Revenge
				{ 25, 20726 }, -- Formula: Enchant Gloves - Threat
				{ 27, 21237 }, -- Imperial Qiraji Regalia
			},
		},
		{ -- AQ40Ouro
			name = AL["Ouro"],
			npcID = 15517,
			Level = 999,
			DisplayIDs = {{15509}},
			AtlasMapBossID = 8,
			[NORMAL_DIFF] = {
				{ 1,  21615 }, -- Don Rigoberto's Lost Hat
				{ 2,  21611 }, -- Burrower Bracers
				{ 3,  23558 }, -- The Burrower's Shell
				{ 4,  23570 }, -- Jom Gabbar
				{ 5,  21610 }, -- Wormscale Blocker
				{ 6,  23557 }, -- Larvae of the Great Worm
				{ 16, 21237 }, -- Imperial Qiraji Regalia
				{ 17, 21232 }, -- Imperial Qiraji Armaments
				{ 19,  20927 }, -- Ouro's Intact Hide
				{ 20,  20931 }, -- Skin of the Great Sandworm
			},
		},
		{ -- AQ40CThun
			name = AL["C'Thun"],
			npcID = 15727,
			Level = 999,
			DisplayIDs = {{15787}},
			AtlasMapBossID = 9,
			[NORMAL_DIFF] = {
				{ 1,  22732 }, -- Mark of C'Thun
				{ 2,  21583 }, -- Cloak of Clarity
				{ 3,  22731 }, -- Cloak of the Devoured
				{ 4,  22730 }, -- Eyestalk Waist Cord
				{ 5,  21582 }, -- Grasp of the Old God
				{ 6,  21586 }, -- Belt of Never-ending Agony
				{ 7,  21585 }, -- Dark Storm Gauntlets
				{ 8,  21581 }, -- Gauntlets of Annihilation
				{ 9,  21596 }, -- Ring of the Godslayer
				{ 10, 21579 }, -- Vanquished Tentacle of C'Thun
				{ 11, 21839 }, -- Scepter of the False Prophet
				{ 12, 21126 }, -- Death's Sting
				{ 13, 21134 }, -- Dark Edge of Insanity
				{ 16, 20929 }, -- Carapace of the Old God
				{ 17, 20933 }, -- Husk of the Old God
				{ 19, 21221 }, -- Eye of C'Thun
				{ 21, 22734 }, -- Base of Atiesh
			},
		},
		{ -- AQ40Trash1
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  21838 }, -- Garb of Royal Ascension
				{ 2,  21888 }, -- Gloves of the Immortal
				{ 3,  21889 }, -- Gloves of the Redeemed Prophecy
				{ 4,  21856 }, -- Neretzek, The Blood Drinker
				{ 5,  21837 }, -- Anubisath Warhammer
				{ 6,  21836 }, -- Ritssyn's Ring of Chaos
				{ 7,  21891 }, -- Shard of the Fallen Star
				{ 16, 21218 }, -- Blue Qiraji Resonating Crystal
				{ 17, 21324 }, -- Yellow Qiraji Resonating Crystal
				{ 18, 21323 }, -- Green Qiraji Resonating Crystal
				{ 19, 21321 }, -- Red Qiraji Resonating Crystal
			},
		},
		AQ_SCARABS,
		AQ_ENCHANTS,
		AQ_OPENING,
	},
}

data["Naxxramas"] = {
	MapID = 3456,
	InstanceID = AtlasLoot:GameVersion_LT(AtlasLoot.WRATH_VERSION_NUM,533,nil),
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "Naxxramas",
	AtlasMapFile = "CL_Naxxramas",
	AtlasMapFile_AL = "Naxxramas",
	ContentType = RAID40_CONTENT,
	LoadDifficulty = RAID40_DIFF,
	ContentPhase = 8,
	items = {
		-- The Arachnid Quarter
		{ -- NAXAnubRekhan
			name = AL["Anub'Rekhan"],
			npcID = 15956,
			Level = 999,
			DisplayIDs = {{15931}},
			AtlasMapBossID = "1",
			NameColor = BLUE,
			[NORMAL_DIFF] = {
				{ 1,  22726 }, -- Splinter of Atiesh
				{ 2,  22727 }, -- Frame of Atiesh
				{ 4,  22369 }, -- Desecrated Bindings
				{ 5,  22362 }, -- Desecrated Wristguards
				{ 6,  22355 }, -- Desecrated Bracers
				{ 8,  22935 }, -- Touch of Frost
				{ 9,  22938 }, -- Cryptfiend Silk Cloak
				{ 10, 22936 }, -- Wristguards of Vengeance
				{ 11, 22939 }, -- Band of Unanswered Prayers
				{ 12, 22937 }, -- Gem of Nerubis
			},
		},
		{ -- NAXGrandWidowFaerlina
			name = AL["Grand Widow Faerlina"],
			npcID = 15953,
			Level = 999,
			DisplayIDs = {{15940}},
			AtlasMapBossID = "2",
			NameColor = BLUE,
			[NORMAL_DIFF] = {
				{ 1,  22726 }, -- Splinter of Atiesh
				{ 2,  22727 }, -- Frame of Atiesh
				{ 4,  22369 }, -- Desecrated Bindings
				{ 5,  22362 }, -- Desecrated Wristguards
				{ 6,  22355 }, -- Desecrated Bracers
				{ 8,  22943 }, -- Malice Stone Pendant
				{ 9,  22941 }, -- Polar Shoulder Pads
				{ 10, 22940 }, -- Icebane Pauldrons
				{ 11, 22942 }, -- The Widow's Embrace
				{ 12, 22806 }, -- Widow's Remorse
			},
		},
		{ -- NAXMaexxna
			name = AL["Maexxna"],
			npcID = 15952,
			Level = 999,
			DisplayIDs = {{15928}},
			AtlasMapBossID = "3",
			NameColor = BLUE,
			[NORMAL_DIFF] = {
				{ 1,  22726 }, -- Splinter of Atiesh
				{ 2,  22727 }, -- Frame of Atiesh
				{ 4,  22371 }, -- Desecrated Gloves
				{ 5,  22364 }, -- Desecrated Handguards
				{ 6,  22357 }, -- Desecrated Gauntlets
				{ 8,  22947 }, -- Pendant of Forgotten Names
				{ 9,  23220 }, -- Crystal Webbed Robe
				{ 10, 22954 }, -- Kiss of the Spider
				{ 11, 22807 }, -- Wraith Blade
				{ 12, 22804 }, -- Maexxna's Fang
			},
		},
		-- The Plague Quarter
		{ -- NAXNoththePlaguebringer
			name = AL["Noth the Plaguebringer"],
			npcID = 15954,
			Level = 999,
			DisplayIDs = {{16590}},
			AtlasMapBossID = "1",
			NameColor = PURP,
			[NORMAL_DIFF] = {
				{ 1,  22726 }, -- Splinter of Atiesh
				{ 2,  22727 }, -- Frame of Atiesh
				{ 4,  22370 }, -- Desecrated Belt
				{ 5,  22363 }, -- Desecrated Girdle
				{ 6,  22356 }, -- Desecrated Waistguard
				{ 8,  23030 }, -- Cloak of the Scourge
				{ 9,  23031 }, -- Band of the Inevitable
				{ 10, 23028 }, -- Hailstone Band
				{ 11, 23029 }, -- Noth's Frigid Heart
				{ 12, 23006 }, -- Libram of Light
				{ 13, 23005 }, -- Totem of Flowing Water
				{ 14, 22816 }, -- Hatchet of Sundered Bone
			},
		},
		{ -- NAXHeigantheUnclean
			name = AL["Heigan the Unclean"],
			npcID = 15936,
			Level = 999,
			DisplayIDs = {{16309}},
			AtlasMapBossID = "2",
			NameColor = PURP,
			[NORMAL_DIFF] = {
				{ 1,  22726 }, -- Splinter of Atiesh
				{ 2,  22727 }, -- Frame of Atiesh
				{ 4,  22370 }, -- Desecrated Belt
				{ 5,  22363 }, -- Desecrated Girdle
				{ 6,  22356 }, -- Desecrated Waistguard
				{ 8,  23035 }, -- Preceptor's Hat
				{ 9,  23033 }, -- Icy Scale Coif
				{ 10, 23019 }, -- Icebane Helmet
				{ 11, 23036 }, -- Necklace of Necropsy
				{ 12, 23068 }, -- Legplates of Carnage
			},
		},
		{ -- NAXLoatheb
			name = AL["Loatheb"],
			npcID = 16011,
			Level = 999,
			DisplayIDs = {{16110}},
			AtlasMapBossID = "3",
			NameColor = PURP,
			[NORMAL_DIFF] = {
				{ 1,  22726 }, -- Splinter of Atiesh
				{ 2,  22727 }, -- Frame of Atiesh
				{ 4,  22366 }, -- Desecrated Leggings
				{ 5,  22359 }, -- Desecrated Legguards
				{ 6,  22352 }, -- Desecrated Legplates
				{ 8,  23038 }, -- Band of Unnatural Forces
				{ 9,  23037 }, -- Ring of Spiritual Fervor
				{ 10, 23042 }, -- Loatheb's Reflection
				{ 11, 23039 }, -- The Eye of Nerub
				{ 12, 22800 }, -- Brimstone Staff
			},
		},
		-- The Military Quarter
		{ -- NAXInstructorRazuvious
			name = AL["Instructor Razuvious"],
			npcID = 16061,
			Level = 999,
			DisplayIDs = {{16582}},
			AtlasMapBossID = "1",
			NameColor = _RED,
			[NORMAL_DIFF] = {
				{ 1,  22726 }, -- Splinter of Atiesh
				{ 2,  22727 }, -- Frame of Atiesh
				{ 4,  22372 }, -- Desecrated Sandals
				{ 5,  22365 }, -- Desecrated Boots
				{ 6,  22358 }, -- Desecrated Sabatons
				{ 8,  23017 }, -- Veil of Eclipse
				{ 9,  23219 }, -- Girdle of the Mentor
				{ 10, 23018 }, -- Signet of the Fallen Defender
				{ 11, 23004 }, -- Idol of Longevity
				{ 12, 23009 }, -- Wand of the Whispering Dead
				{ 13, 23014 }, -- Iblis, Blade of the Fallen Seraph
			},
		},
		{ -- NAXGothiktheHarvester
			name = AL["Gothik the Harvester"],
			npcID = 16060,
			Level = 999,
			DisplayIDs = {{16279}},
			AtlasMapBossID = "2",
			NameColor = _RED,
			[NORMAL_DIFF] = {
				{ 1,  22726 }, -- Splinter of Atiesh
				{ 2,  22727 }, -- Frame of Atiesh
				{ 4,  22372 }, -- Desecrated Sandals
				{ 5,  22365 }, -- Desecrated Boots
				{ 6,  22358 }, -- Desecrated Sabatons
				{ 8,  23032 }, -- Glacial Headdress
				{ 9,  23020 }, -- Polar Helmet
				{ 10, 23023 }, -- Sadist's Collar
				{ 11, 23021 }, -- The Soul Harvester's Bindings
				{ 12, 23073 }, -- Boots of Displacement
			},
		},
		{ -- NAXTheFourHorsemen
			name = AL["The Four Horsemen"],
			npcID = {16064, 16065, 16062, 16063},
			Level = 999,
			DisplayIDs = {{16155},{16153},{16139},{16154}},
			AtlasMapBossID = "3",
			NameColor = _RED,
			[NORMAL_DIFF] = {
				{ 1,  22726 }, -- Splinter of Atiesh
				{ 2,  22727 }, -- Frame of Atiesh
				{ 4,  22351 }, -- Desecrated Robe
				{ 5,  22350 }, -- Desecrated Tunic
				{ 6,  22349 }, -- Desecrated Breastplate
				{ 8,  23071 }, -- Leggings of Apocalypse
				{ 9,  23025 }, -- Seal of the Damned
				{ 10, 23027 }, -- Warmth of Forgiveness
				{ 11, 22811 }, -- Soulstring
				{ 12, 22809 }, -- Maul of the Redeemed Crusader
				{ 13, 22691 }, -- Corrupted Ashbringer
			},
		},
		-- The Construct Quarter
		{ -- NAXPatchwerk
			name = AL["Patchwerk"],
			npcID = 16028,
			Level = 999,
			DisplayIDs = {{16174}},
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1,  22726 }, -- Splinter of Atiesh
				{ 2,  22727 }, -- Frame of Atiesh
				{ 4,  22368 }, -- Desecrated Shoulderpads
				{ 5,  22361 }, -- Desecrated Spaulders
				{ 6,  22354 }, -- Desecrated Pauldrons
				{ 8,  22960 }, -- Cloak of Suturing
				{ 9,  22961 }, -- Band of Reanimation
				{ 10, 22820 }, -- Wand of Fates
				{ 11, 22818 }, -- The Plague Bearer
				{ 12, 22815 }, -- Severance
			},
		},
		{ -- NAXGrobbulus
			name = AL["Grobbulus"],
			npcID = 15931,
			Level = 999,
			DisplayIDs = {{16035}},
			AtlasMapBossID = 2,
			[NORMAL_DIFF] = {
				{ 1,  22726 }, -- Splinter of Atiesh
				{ 2,  22727 }, -- Frame of Atiesh
				{ 4,  22368 }, -- Desecrated Shoulderpads
				{ 5,  22361 }, -- Desecrated Spaulders
				{ 6,  22354 }, -- Desecrated Pauldrons
				{ 8,  22968 }, -- Glacial Mantle
				{ 9,  22967 }, -- Icy Scale Spaulders
				{ 10, 22810 }, -- Toxin Injector
				{ 11, 22803 }, -- Midnight Haze
				{ 12, 22988 }, -- The End of Dreams
			},
		},
		{ -- NAXGluth
			name = AL["Gluth"],
			npcID = 15932,
			Level = 999,
			DisplayIDs = {{16064}},
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1,  22726 }, -- Splinter of Atiesh
				{ 2,  22727 }, -- Frame of Atiesh
				{ 4,  22983 }, -- Rime Covered Mantle
				{ 5,  22981 }, -- Gluth's Missing Collar
				{ 6,  22994 }, -- Digested Hand of Power
				{ 7,  23075 }, -- Death's Bargain
				{ 8,  22813 }, -- Claymore of Unholy Might
				{ 16, 22368 }, -- Desecrated Shoulderpads
				{ 17, 22369 }, -- Desecrated Bindings
				{ 18, 22370 }, -- Desecrated Belt
				{ 19, 22372 }, -- Desecrated Sandals
				{ 20, 22361 }, -- Desecrated Spaulders
				{ 21, 22362 }, -- Desecrated Wristguards
				{ 22, 22363 }, -- Desecrated Girdle
				{ 23, 22365 }, -- Desecrated Boots
				{ 24, 22354 }, -- Desecrated Pauldrons
				{ 25, 22355 }, -- Desecrated Bracers
				{ 26, 22356 }, -- Desecrated Waistguard
				{ 27, 22358 }, -- Desecrated Sabatons
			},
		},
		{ -- NAXThaddius
			name = AL["Thaddius"],
			npcID = 15928,
			Level = 999,
			DisplayIDs = {{16137}},
			AtlasMapBossID = 4,
			[NORMAL_DIFF] = {
				{ 1,  22726 }, -- Splinter of Atiesh
				{ 2,  22727 }, -- Frame of Atiesh
				{ 4,  22367 }, -- Desecrated Circlet
				{ 5,  22360 }, -- Desecrated Headpiece
				{ 6,  22353 }, -- Desecrated Helmet
				{ 8,  23000 }, -- Plated Abomination Ribcage
				{ 9,  23070 }, -- Leggings of Polarity
				{ 10, 23001 }, -- Eye of Diminution
				{ 11, 22808 }, -- The Castigator
				{ 12, 22801 }, -- Spire of Twilight
			},
		},
		-- Frostwyrm Lair
		{ -- NAXSapphiron
			name = AL["Sapphiron"],
			npcID = 15989,
			Level = 999,
			DisplayIDs = {{16033}},
			AtlasMapBossID = "1",
			NameColor = GREEN,
			[NORMAL_DIFF] = {
				{ 1,  23050 }, -- Cloak of the Necropolis
				{ 2,  23045 }, -- Shroud of Dominion
				{ 3,  23040 }, -- Glyph of Deflection
				{ 4,  23047 }, -- Eye of the Dead
				{ 5,  23041 }, -- Slayer's Crest
				{ 6,  23046 }, -- The Restrained Essence of Sapphiron
				{ 7,  23049 }, -- Sapphiron's Left Eye
				{ 8,  23048 }, -- Sapphiron's Right Eye
				{ 9,  23043 }, -- The Face of Death
				{ 10, 23242 }, -- Claw of the Frost Wyrm
				{ 16, 23549 }, -- Fortitude of the Scourge
				{ 17, 23548 }, -- Might of the Scourge
				{ 18, 23545 }, -- Power of the Scourge
				{ 19, 23547 }, -- Resilience of the Scourge
			},
		},
		{ -- NAXKelThuzard
			name = AL["Kel'Thuzad"],
			npcID = 15990,
			Level = 999,
			DisplayIDs = {{15945}},
			AtlasMapBossID = "2",
			NameColor = GREEN,
			[NORMAL_DIFF] = {
				{ 1,  23057 }, -- Gem of Trapped Innocents
				{ 2,  23053 }, -- Stormrage's Talisman of Seething
				{ 3,  22812 }, -- Nerubian Slavemaker
				{ 4,  22821 }, -- Doomfinger
				{ 5,  22819 }, -- Shield of Condemnation
				{ 6,  22802 }, -- Kingsfall
				{ 7,  23056 }, -- Hammer of the Twisting Nether
				{ 8,  23054 }, -- Gressil, Dawn of Ruin
				{ 9,  23577 }, -- The Hungering Cold
				{ 10, 22798 }, -- Might of Menethil
				{ 11, 22799 }, -- Soulseeker
				{ 13, 22520 }, -- The Phylactery of Kel'Thuzad
				{ 16, 23061 }, -- Ring of Faith
				{ 17, 23062 }, -- Frostfire Ring
				{ 18, 23063 }, -- Plagueheart Ring
				{ 19, 23060 }, -- Bonescythe Ring
				{ 20, 23064 }, -- Ring of the Dreamwalker
				{ 21, 23067 }, -- Ring of the Cryptstalker
				{ 22, 23065 }, -- Ring of the Earthshatterer
				{ 23, 23066 }, -- Ring of Redemption
				{ 24, 23059 }, -- Ring of the Dreadnaught
				{ 26, 22733 }, -- Staff Head of Atiesh
			},
		},
		{ -- NAXTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  23664 }, -- Pauldrons of Elemental Fury
				{ 2,  23667 }, -- Spaulders of the Grand Crusader
				{ 3,  23069 }, -- Necro-Knight's Garb
				{ 4,  23226 }, -- Ghoul Skin Tunic
				{ 5,  23663 }, -- Girdle of Elemental Fury
				{ 6,  23666 }, -- Belt of the Grand Crusader
				{ 7,  23665 }, -- Leggings of Elemental Fury
				{ 8,  23668 }, -- Leggings of the Grand Crusader
				{ 9,  23237 }, -- Ring of the Eternal Flame
				{ 10, 23238 }, -- Stygian Buckler
				{ 11, 23044 }, -- Harbinger of Doom
				{ 12, 23221 }, -- Misplaced Servo Arm
				{ 16, 22376 }, -- Wartorn Cloth Scrap
				{ 17, 22373 }, -- Wartorn Leather Scrap
				{ 18, 22374 }, -- Wartorn Chain Scrap
				{ 19, 22375 }, -- Wartorn Plate Scrap
				{ 21, 23055 }, -- Word of Thawing
				{ 22, 22682 }, -- Frozen Rune
			},
		},
		T3_SET,
	},
}

data["BlackfathomDeeps2"] = {
	MapID = 719,
	InstanceID = 48,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "BlackfathomDeeps",
	AtlasMapFile = {"CL_BlackfathomDeepsA", "CL_BlackfathomDeepsEnt"},
	AtlasMapFile_AL = {"BlackfathomDeeps", "BlackfathomDeepsEnt"},
	ContentType = RAID_CONTENT,
	LevelRange = {25, 25, 39},
	ContentPhase = 1,
	items = {
		{ -- BFDBaronAquanis
			name = AL["Baron Aquanis"],
			npcID = 202699,
			Level = GetForVersion(28,24),
			DisplayIDs = {{110}},
			[NORMAL_DIFF] = {
				{ 1,  211454 }, -- Strange Water Globe
				{ 2,  211852 }, -- Handwraps of Befouled Water
				{ 3,  209423 }, -- Flowing Scarf
				{ 4,  209421 }, -- Cord of Aquanis
				{ 5,  209828 }, -- Sub-Zero Pauldrons
				{ 6,  209422 }, -- High Tide Choker
				{ 7,  209825 }, -- Droplet Choker
				{ 8,  204807 }, -- Fathomblade
				{ 9,  204804 }, -- Hydraxian Bangles
				{ 10,  209676 }, -- Shoulderguards of Crushing Depths
				{ 11,  209590 }, -- Cracked Water Globe
				{ 12,  209677 }, -- Loop of Swift Currents
			},
		},
		{ -- BFDGhamoora
			name = AL["Ghamoo-ra"],
			npcID = 201722,
			Level = GetForVersion(25,23),
			DisplayIDs = {{5027}},
			[NORMAL_DIFF] = {
				{ 1,  209436 }, -- Chipped Bite of Serra'kis
				{ 2,  209830 }, -- Ironhide Arbalest
				{ 3,  209418 }, -- Adamantine Tortoise Armor
				{ 4,  209824 }, -- Shimmering Shoulderpads
				{ 5,  209523 }, -- Shimmering Thresher Cape
				{ 6,  209432 }, -- Ghamoo-ra's Cinch
				{ 7,  209678 }, -- Mantle of the Thresher Slayer
				{ 8,  209424 }, -- Shell Plate Barrier
				{ 9,  209675 }, -- Clamweave Tunic
				{ 10,  209524 }, -- Bindings of Serra'kis
			},
		},
		{ -- BFDLadySarevess
			name = AL["Lady Sarevess"],
			npcID = 204068,
			Level = GetForVersion(25,23),
			DisplayIDs = {{4979}},
			[NORMAL_DIFF] = {
				{ 1,  209566 }, -- Leggings of the Faithful
				{ 2,  211789 }, -- Artemis Cowl
				{ 3,  211842 }, -- Rakkamar's Tattered Thinking Cap
				{ 4,  209680 }, -- Waterproof Scarf
				{ 5,  209525 }, -- Honed Darkwater Talwar
				{ 6,  209565 }, -- Band of Deep Places
				{ 7,  211843 }, -- Mask of Scorn
				{ 8,  209563 }, -- Naga Heartrender
				{ 9,  209564 }, -- Guardian's Trident
				{ 10,  209527 }, -- Naga Battle Gauntlets
				{ 11,  209822 }, -- Strength of Purpose
				{ 12,  209679 }, -- Azshari Novice's Shoulderpads
				{ 13,  209823 }, -- Signet of Beasts
			},
		},
		{ -- BFDGelihast
			name = AL["Gelihast"],
			npcID = 204921,
			Level = GetForVersion(26,24),
			DisplayIDs = {{1773}},
			[NORMAL_DIFF] = {
				{ 1,  209569 }, -- Murloc Hide Kneeboots
				{ 2,  209559 }, -- Twilight Sage's Walking Stick
				{ 3,  209568 }, -- Algae Gauntlets
				{ 4,  209820 }, -- Black Shroud Choker
				{ 5,  209573 }, -- Wrathful Spire
				{ 6,  209567 }, -- Coral Reef Axe
				{ 7,  209571 }, -- Deadlight
				{ 8,  209670 }, -- Skinwalkers
				{ 9,  209570 }, -- Tome of Cavern Lore
				{ 10,  209821 }, -- Ring of Shadowsight
				{ 11,  209572 }, -- Black Boiled Leathers
				{ 12,  209681 }, -- Black Murloc Egg
				{ 13,  211491 }, -- Bottomless Murloc Skin Bag
				{ 16,  211505 }, -- Twilight Avenger's Helm
				{ 17,  211504 }, -- Twilight Avenger's Chain
				{ 18,  211506 }, -- Twilight Avenger's Boots
				{ 20,  211507 }, -- Twilight Elementalist's Cowl
				{ 21,  211509 }, -- Twilight Elementalist's Robe
				{ 22,  211508 }, -- Twilight Elementalist's Footpads
				{ 24,  211510 }, -- Twilight Slayer's Cowl
				{ 25,  211512 }, -- Twilight Slayer's Tunic 
				{ 26,  211511 }, -- Twilight Slayer's Footpads
				{ 28,  209683 }, -- Twilight Invoker's Shawl
				{ 29,  209671 }, -- Twilight Invoker's Robes
				{ 30,  209669 }, -- Twilight Invoker's Shoes
			},
		},
		{ -- BFDOldSerrakis
			name = AL["Lorgus Jett"],
			npcID = 207356,
			Level = GetForVersion(26,24),
			DisplayIDs = {{1816}},
			[NORMAL_DIFF] = {
				{ 1,  209560 }, -- Hammer of Righteous Judgement
				{ 2,  209576 }, -- Mind-Expanding Mushroom
				{ 3,  209818 }, -- Sun-Touched Crescent
				{ 4,  209581 }, -- Silver Hand Sabatons
				{ 5,  209578 }, -- Glowing Leather Bands
				{ 6,  209682 }, -- Sturdy Hood
				{ 7,  209574 }, -- Discarded Tenets of the Silver Hand
				{ 8,  209577 }, -- Fist of the Wild
				{ 9,  209575 }, -- Carved Driftwood Icon
				{ 10,  209579 }, -- Crashing Thunder
				{ 16,  211505 }, -- Twilight Avenger's Helm
				{ 17,  211504 }, -- Twilight Avenger's Chain
				{ 18,  211506 }, -- Twilight Avenger's Boots
				{ 20,  211507 }, -- Twilight Elementalist's Cowl
				{ 21,  211509 }, -- Twilight Elementalist's Robe
				{ 22,  211508 }, -- Twilight Elementalist's Footpads
				{ 24,  211510 }, -- Twilight Slayer's Cowl
				{ 25,  211512 }, -- Twilight Slayer's Tunic 
				{ 26,  211511 }, -- Twilight Slayer's Footpads
				{ 28,  209683 }, -- Twilight Invoker's Shawl
				{ 29,  209671 }, -- Twilight Invoker's Robes
				{ 30,  209669 }, -- Twilight Invoker's Shoes

			},
		},
		{ -- BFDTwilightLordKelris
			name = AL["Twilight Lord Kelris"],
			npcID = 209678,
			Level = GetForVersion(27,24),
			DisplayIDs = {{4939}},
			AtlasMapFile = {"CL_BlackfathomDeepsB", "CL_BlackfathomDeepsEnt"},
			[NORMAL_DIFF] = {
				{ 1,  209694 }, -- Blackfathom Ritual Dagger
				{ 2,  209672 }, -- Black Fingerless Gloves
				{ 3,  209686 }, -- Jagged Bone Necklace
				{ 4,  209667 }, -- Gaze Dreamer Leggings
				{ 5,  209668 }, -- Signet of the Twilight Lord
				{ 6,  211455 }, -- Slick Fingerless Gloves
				{ 7,  209817 }, -- Voidwalker Brooch
				{ 8,  209674 }, -- Phoenix Ignition
				{ 9,  211458 }, -- Tome of Shadow Warding
				{ 10,  211457 }, -- Twilight Defender's Girdle
				{ 11,  209673 }, -- Glowing Fetish Amulet
				{ 12,  209816 }, -- Fetish of Mischief
				{ 13,  209561 }, -- Rod of the Ancient Sleepwalker
				{ 14,  211492 }, -- Kelris's Satchel
				{ 16,  211505 }, -- Twilight Avenger's Helm
				{ 17,  211504 }, -- Twilight Avenger's Chain
				{ 18,  211506 }, -- Twilight Avenger's Boots
				{ 20,  211507 }, -- Twilight Elementalist's Cowl
				{ 21,  211509 }, -- Twilight Elementalist's Robe
				{ 22,  211508 }, -- Twilight Elementalist's Footpads
				{ 24,  211510 }, -- Twilight Slayer's Cowl
				{ 25,  211512 }, -- Twilight Slayer's Tunic 
				{ 26,  211511 }, -- Twilight Slayer's Footpads
				{ 28,  209683 }, -- Twilight Invoker's Shawl
				{ 29,  209671 }, -- Twilight Invoker's Robes
				{ 30,  209669 }, -- Twilight Invoker's Shoes
				
			},
		},
		
		{ -- BFDAkumai
			name = AL["Aku'mai"],
			npcID = 213334,
			Level = GetForVersion(28,24),
			DisplayIDs = {{2837}},
			AtlasMapFile = {"CL_BlackfathomDeepsB", "CL_BlackfathomDeepsEnt"},
			[NORMAL_DIFF] = {
				{ 1,  209693 }, -- Perfect Blackfathom Pearl
				{ 2,  211452 }, -- Perfect Blackfathom Pearl
				{ 4,  209692 }, -- Sentinel Pauldrons
				{ 5,  211456 }, -- Dagger of Willing Sacrifice
				{ 6,  209685 }, -- Ancient Moss Cinch
				{ 7,  209688 }, -- Bael Modan Blunderbuss
				{ 8,  209687 }, -- Hydra Hide Cuirass
				{ 9,  209690 }, -- Shadowscale Coif
				{ 10,  209691 }, -- Vampiric Boot Knife
				{ 11,  209580 }, -- Gusting Wind
				{ 12,  209684 }, -- Soul Leech Pants
				{ 13,  209689 }, -- Crabshell Waders
				{ 14,  209534 }, -- Azshari Arbalest
				{ 15,  209562 }, -- Deadly Strike of the Hydra
				{ 16,  211505 }, -- Twilight Avenger's Helm
				{ 17,  211504 }, -- Twilight Avenger's Chain
				{ 18,  211506 }, -- Twilight Avenger's Boots
				{ 20,  211507 }, -- Twilight Elementalist's Cowl
				{ 21,  211509 }, -- Twilight Elementalist's Robe
				{ 22,  211508 }, -- Twilight Elementalist's Footpads
				{ 24,  211510 }, -- Twilight Slayer's Cowl
				{ 25,  211512 }, -- Twilight Slayer's Tunic 
				{ 26,  211511 }, -- Twilight Slayer's Footpads
				{ 28,  209683 }, -- Twilight Invoker's Shawl
				{ 29,  209671 }, -- Twilight Invoker's Robes
				{ 30,  209669 }, -- Twilight Invoker's Shoes
			},
		},
		{ -- BFDTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  1486 }, -- Tree Bark Jacket
				{ 2,  3416 }, -- Martyr's Chain
				{ 3,  1491 }, -- Ring of Precision
				{ 4,  3414 }, -- Crested Scepter
				{ 5,  1454 }, -- Axe of the Enforcer
				{ 6,  1481 }, -- Grimclaw
				{ 7,  2567 }, -- Evocator's Blade
				{ 8,  3413 }, -- Doomspike
				{ 9,  3417 }, -- Onyx Claymore
				{ 10, 3415 }, -- Staff of the Friar
				{ 11, 2271 }, -- Staff of the Blessed Seer
			},
		},
	},
}

data["Gnomeregan2"] = {
	MapID = 721,
	InstanceID = 90,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "Gnomeregan",
	AtlasMapFile = {"CL_Gnomeregan", "CL_GnomereganEnt"},
	AtlasMapFile_AL = {"Gnomeregan", "GnomereganEnt"},
	ContentType = RAID_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = {40, 40, 49},
	ContentPhase = 2,
	items = {
		{ -- Grubbis
			name = AL["Grubbis"],
			npcID = 217280,
			Level = 40,
			DisplayIDs = {{117047}},
			[NORMAL_DIFF] = {
				{ 1,  213288 }, -- Grubbis Grubby Gauntlets
				{ 2,  213304 }, -- Troggslayer Pauldrons
				{ 3,  213321 }, -- Volatile Concoction Belt
				{ 4,  213294 }, -- Caverndeep Sabatons
				{ 5,  213327 }, -- Belt of the Trogg Berserker
				{ 6,  213322 }, -- Skullduggery Waistband
				{ 7,  213351 }, -- Irradiated Tower Shield
				{ 8,  213542 }, -- The Necro-Gnomicon
				{ 9,  213323 }, -- Cord of Deep Earth
				{ 10,  215435 }, -- Libram of Benediction
				{ 11,  213324 }, -- Electromagnetic Waistcord
				{ 12,  213326 }, -- Girdle of Reclamation
				{ 13,  215436 }, -- Totem of Invigorating Flame
				{ 14,  215437 }, -- Trogg Transfigurator 3000
				{ 15,  216490 }, -- Idol of Wrath
			},
		},
		{ -- GnViscousFallout
			name = AL["Viscous Fallout"],
			npcID = 220007,
			Level = GetForVersion(32,28),
			DisplayIDs = {{5497}},
			[NORMAL_DIFF] = {
				{ 1,  213307 }, -- Drape of Dismantling
				{ 2,  213355 }, -- Falco's Sting
				{ 3,  213352 }, -- Gear-Mender's Grace
				{ 4,  213289 }, -- Hydrostaff
				{ 5,  213285 }, -- Lev's Oil-Stained Bindings
				{ 6,  213301 }, -- Synthetic Mantle
				{ 7,  213302 }, -- Mantle of the Cunning Negotiator
				{ 8,  213299 }, -- Petrolspill Pants
				{ 9,  213413 }, -- Generously Padded Shoulderpads
				{ 10,  213290 }, -- Acidic Waders
				{ 11,  213291 }, -- Toxic Revenger II
				{ 12,  213353 }, -- Defibrillating Staff
			},
		},
		{ -- GnElectrocutioner6000
			name = AL["Electrocutioner 6000"],
			npcID = 220072,
			Level = GetForVersion(30,28),
			DisplayIDs = {{118007}},
			[NORMAL_DIFF] = {
				{ 1,  213319 }, -- Machinist's Gloves
				{ 2,  213300 }, -- Fighter Ace Gloves
				{ 3,  213309 }, -- Cloak of Invention
				{ 4,  213287 }, -- Electrocutioner Hexnut
				{ 5,  213560 }, -- Mechanostrider Muffler
				{ 6,  213298 }, -- Mechbuilder's Overalls
				{ 7,  213293}, -- Hi-tech Supergun Mk.VII
				{ 8,  213559 }, -- Mechanostrider Gear Shifter
				{ 9,  216494}, -- Aragriar's Whimsical World Warper
				{ 10,  213354 }, -- Staff of the Evil Genius
				{ 11,  213414 }, -- Mech-Mender's Sash
				{ 12,  213418 }, -- Welded Truesilver Ringlets
				{ 13,  213279 }, -- Reflective Skullcap
				{ 16,  215377 }, -- Irradiated Robe
				{ 17,  215379 }, -- Irradiated Trousers
				{ 18,  215378 }, -- Irradiated Boots
				{ 20,  213286 }, -- Electrocutioner's Needle
				{ 22,  217008 }, -- Power Depleted Chest
				{ 23,  217009 }, -- Power Depleted Legs
				{ 24,  217007 }, -- Power Depleted Boots

			},
		},
		{ -- GnCrowdPummeler960
			name = AL["Crowd Pummeler 9-60"],
			npcID = 215728,
			Level = GetForVersion(32,28),
			DisplayIDs = {{6774}},
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1,  213295 }, -- Ultrasonic Vibroblade
				{ 2,  213419 }, -- 9-60 Repair Manual
				{ 3,  213408 }, -- Gyromatic Macro-Adjustor
				{ 4,  213278 }, -- Bonk-Maestro's Handguards
				{ 5,  213442 }, -- Cogmaster's Claw
				{ 6,  213317 }, -- Experimental Aim Stabilizers
				{ 7,  213292 }, -- Gizmotron Gigachopper
				{ 8,  213340 }, -- Gnomebot Operators Boots
				{ 9,  213415 }, -- Tinker's Wrist Wraps
				{ 10,  213305 }, -- Machined Alloy Shoulderplates
				{ 11,  210741 }, -- Automatic Crowd Pummeler
				{ 13,  215449 }, -- World Shrinker
				{ 14,  213412 }, -- Dielectric Safety Shield
			},
		},
		{ -- GnMechanicalMenagerie
			name = AL["The Mechanical Menagerie"],
			npcID = 218242,
			Level = GetForVersion(33,28),
			DisplayIDs = {{117365}},
			[NORMAL_DIFF] = {
				{ 1,  213296 }, -- Supercharged Headchopper
				{ 2,  213297 }, -- Oscillating Blasthammer
				{ 3,  213306 }, -- Ingenuity's Cover
				{ 4,  213325 }, -- Darkvision Girdle
				{ 5,  213411 }, -- Izzleflick's Inextinguishable Igniter
				{ 6,  213280 }, -- Marksman's Scopevisor
				{ 7,  213318 }, -- Ornate Dark Iron Bangles
				{ 8,  213320 }, -- Fingers of Arcane Accuracy
				{ 9,  213308 }, -- Prototype Parachute Cloak
				{ 10,  213417 }, -- Truesilver Filament Coif
				{ 11,  213303 }, -- Lightning Rod Spaulders
				{ 13,  215378 }, -- Irradiated Boots
				{ 14,  215379 }, -- Irradiated Trousers
				{ 15,  215377 }, -- Irradiated Robe
				{ 16,  215380 }, -- Power-Assisted Lifting Belt
				{ 17,  213410 }, -- Glimmering Gizmoblade
				{ 19,  217008 }, -- Power Depleted Chest
				{ 20,  217009 }, -- Power Depleted Legs	
				{ 21,  217007 }, -- Power Depleted Boots		
			},
		},
		{ -- GnMekgineerThermaplugg
			name = AL["Mekgineer Thermaplugg"],
			npcID = 218537,
			Level = GetForVersion(34,28),
			DisplayIDs = {{117499}},
			[NORMAL_DIFF] = {
				{ 1,  217350 }, -- Thermaplugg's Engineering Notes
				{ 2,  217351 }, -- Thermaplugg's Engineering Notes
				{ 4,  213281 }, -- Electromagnetic Hyperflux Reactivator
				{ 5,  213348 }, -- Gyromatic Experiment 420b
				{ 6,  213349 }, -- Gniodine Pill Bottle
				{ 7,  213350 }, -- Wirdal's Hardened Core
				{ 8,  213347 }, -- Miniaturized Combustion Chamber
				{ 9,  215461 }, -- Domesticated Attack Chicken
				{ 11,  215379 }, -- Irradiated Trousers
				{ 12,  215377 }, -- Irradiated Robe
				{ 13,  215378 }, -- Irradiated Boots
				{ 16,  213283 }, -- Hypercharged Gear of Conflagration
				{ 17,  213284 }, -- Hypercharged Gear of Devastation
				{ 18,  213282 }, -- Hypercharged Gear of Innovation
				{ 20,  213356 }, -- Thermaplugg's Custom Blaster
				{ 21,  213409 }, -- Mekgatorque's Arcano-Shredder
				{ 22,  213416 }, -- Thermaplugg's Rocket Cleaver
				{ 24,  216608 }, -- Radiant Ray Reflectors
				{ 25,  13325 }, -- Fluorescent Green Mechanostrider
				{ 27,  217008 }, -- Power Depleted Chest
				{ 28,  217009 }, -- Power Depleted Legs
				{ 29,  217007 }, -- Power Depleted Boots
			},
		},
		{ -- GnTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  213298 }, -- Mechbuilder's Overalls
				{ 2,  9491 }, -- Hotshot Pilot's Gloves
				{ 3,  9509 }, -- Petrolspill Leggings
				{ 4,  9510 }, -- Caverndeep Trudgers
				{ 5,  9487 }, -- Hi-tech Supergun
				{ 6,  9485 }, -- Vibroblade
				{ 7,  9488 }, -- Oscillating Power Hammer
				{ 8,  9486 }, -- Supercharger Battle Axe
				{ 9,  9490 }, -- Gizmotron Megachopper
				{ 11, 9489 }, -- Gyromatic Icemaker
				{ 12, 11827 }, -- Schematic: Lil' Smoky
				--{ 15, 11826 }, -- Lil' Smoky
				{ 16, 9327 }, -- Security DELTA Data Access Card
				{ 18, 7191 }, -- Fused Wiring
				{ 19, 9308 }, -- Grime-Encrusted Object
				{ 20, 216661 }, -- Grime-Encrusted Ring
				{ 22, 9279 }, -- White Punch Card
				{ 23, 9280 }, -- Yellow Punch Card
				{ 24, 9282 }, -- Blue Punch Card
				{ 25, 9281 }, -- Red Punch Card
				{ 26, 9316 }, -- Prismatic Punch Card
				{ 28, "INV_Box_01", nil, AL["SoD Only:"], nil },
				{ 29, 213427 }, -- Grime-Encrusted Salvage
			},
		},
	},
}

data["TheTempleOfAtal'Hakkar2"] = {
	MapID = 1477,
	InstanceID = 109,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "TheTempleOfAtal'Hakkar",
	AtlasMapFile = { "CL_TheSunkenTemple", "CL_TheSunkenTempleEnt" },
	AtlasMapFile_AL = { "TheSunkenTemple", "TheSunkenTempleEnt" },
	ContentType = RAID_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = GetForVersion({50, 50, 59},{50, 50, 59}),
	ContentPhase = 3,
	items = {
		{ -- STAtalalarion
			name = AL["Atal'alarion"],
			npcID = 218624,
			Level = GetForVersion(50,50),
			DisplayIDs = {{7873}},
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1,  220539 }, -- Warbands of Sacrifice
				{ 2,  220529 }, -- Spaulders of Fanaticism
				{ 3,  220527 }, -- Atal'ai Berserker's Mantle
				{ 4,  220602 }, -- Sewer Turtle Half-Shell
				{ 5,  220568 }, -- Temple Explorer's Gun Axe
				{ 6,  220567 }, -- Bloodied Headspike
				{ 7,  220615 }, -- Panther Fur Cloak
				{ 8,  220554 }, -- Atal'alarion's Tusk Band
				{ 9,  220511 }, -- Greathelm of the Nightmare
				{ 10,  220561 }, -- Tenacious Troll Kickers
				{ 11,  220537 }, -- Dreamer's Darkwater Bracers
				{ 12,  220580 }, -- Madness of the Avatar
				{ 13,  220635 }, -- Atal'alarion's Enchanted Boulder
				{ 16,  220636 }, -- Atal'ai Blood Icon
				{ 17,  220637 }, -- Atal'ai Ritual Token
			},
		},
		{ -- STFesteringRotslime
			name = AL["Festering Rotslime"],
			npcID = 218819,
			Level = GetForVersion(50,50),
			DisplayIDs = {{119351}},
			[NORMAL_DIFF] = {
				{ 1, 220542 }, -- Polluted Murkwater Gauntlets
				{ 2, 220552 }, -- Waistguard of Pain
				{ 3, 220538 }, -- Cursed Slimescale Bracers
				{ 4, 220545 }, -- Foul Smelling Fighter's Gloves
				{ 5, 220546 }, -- Hands of the Tormented
				{ 6, 220540 }, -- Corruption Laden Handguards
				{ 7, 220569 }, -- Blistering Ragehammer
				{ 8, 220550 }, -- Temple Looter's Waistband
				{ 9, 220518 }, -- Ba'ham's Dusty Hat
				{ 10, 220541 }, -- Disease-Ridden Plate Fists
				{ 11, 220571 }, -- Stinging Longbow
				{ 12, 220565 }, -- Ethereal Mistwalker Boots
				{ 13, 221484 }, -- Witch Doctor's Hex Stick
				{ 16,  220636 }, -- Atal'ai Blood Icon
				{ 17,  220637 }, -- Atal'ai Ritual Token
			},
		},
		{ -- STAtalaiDefenders
			name = AL["Atal'ai Defenders"],
			npcID = 221637,
			Level = GetForVersion(50,50),
			DisplayIDs = {{118789}},
			[NORMAL_DIFF] = {
				{ 1,  220555 }, -- Atal'ai Serpentscale Girdle
				{ 2,  220532 }, -- Reinforced Atal'ai Spaulders
				{ 3,  220516 }, -- Gasher's Forgotten Visor
				{ 4,  220591 }, -- Mijan's Restorative Rod
				{ 5,  220558 }, -- Atal'ai Assassin's Leggings
				{ 6,  220572 }, -- Rinzo's Rapid Repeater
				{ 7,  220528 }, -- Atal'ai Huntsman's Shoulders
				{ 8,  220611 }, -- Hukku's Hex Cape
				{ 9,  220533 }, -- Reforged Atal'ai Breastplate
				{ 10,  220522 }, -- Soulcatcher Crown
				{ 11,  220674 }, -- Debased Stealthblade
				{ 12,  220548 }, -- Atal'ai Hexxer's Gloves
				{ 13,  220560 }, -- Silvershell Legplates
				{ 14,  220638 }, -- Unorthodox Hex Stick
				{ 16,  220636 }, -- Atal'ai Blood Icon
				{ 17,  220637 }, -- Atal'ai Ritual Token
			},
		},
		{ -- STDreamscytheandWeaver
			name = AL["Dreamscythe and Weaver"],
			npcID = 220833,
			Level = GetForVersion(50,50),
			DisplayIDs = {{6379}},
			[NORMAL_DIFF] = {
				{ 1, 220549 }, -- Dawnspire Strap
				{ 2, 220521 }, -- Hakkari Ritualist's Headdress
				{ 3, 220587 }, -- Sacrificial Dream Dagger
				{ 4, 220536 }, -- Atal'ai Medicine Man's Wrists
				{ 5, 220581 }, -- Snake Clobberer
				{ 6, 220566 }, -- Smolder Claw
				{ 7, 220551 }, -- Devotee's Sash of the Emerald Dream
				{ 8, 220584 }, -- Flamebreath Blade
				{ 9, 220519 }, -- Voodoo Feathered Headdress
				{ 10, 220544 }, -- Bloodflare Talons
				{ 11, 220594 }, -- Scythe of the Dream
				{ 12, 220609 }, -- Drape of Nightfall
				{ 16,  220636 }, -- Atal'ai Blood Icon
				{ 17,  220637 }, -- Atal'ai Ritual Token
			},
		},
		{ -- STJammalanandOgom
			name = AL["Jammal'an and Ogom"],
			npcID = 218721,
			Level = GetForVersion(50,50),
			DisplayIDs = {{6708}},
			[NORMAL_DIFF] = {
				{ 1, 220578 }, -- Fist of the Forsaken
				{ 2, 220556 }, -- Kilt of the Fallen Atal'ai Prophet
				{ 3, 220601 }, -- Hakkari Witch Doctor's Guard
				{ 4, 220575 }, -- Eater of the Damned
				{ 5, 220547 }, -- Gloves of the Fallen Atal'ai Prophet
				{ 6, 220583 }, -- Vile Blade of the Wretched
				{ 7, 220576 }, -- Axe of the Atal'ai Executioner
				{ 8, 220625 }, -- Resilience of the Exiled
				{ 9, 220624 }, -- Bloodstained Charm of Valor
				{ 10, 220535 }, -- Garments of the Atal'ai Prophet
				{ 11, 220623 }, -- Jin'do's Lost Locket
				{ 12, 220605 }, -- Libram of Sacrilege
				{ 13, 220515 }, -- Enchanted Emerald Helmet
				{ 14, 220586 }, -- Hubris, the Bandit Brander
				{ 16,  220636 }, -- Atal'ai Blood Icon
				{ 17,  220637 }, -- Atal'ai Ritual Token
			},
		},
		{ -- STMorphazandHazzas
			name = AL["Morphaz and Hazzas"],
			npcID = 221943,
			Level = GetForVersion(50,50),
			DisplayIDs = {{9584}},
			AtlasMapBossID = 7,
			[NORMAL_DIFF] = {
				{ 1, 220965 }, -- Scalebane Greataxe
				{ 2, 220514 }, -- Visor of Verdant Feathers
				{ 3, 220553 }, -- Belt of the Forsaken Worshipper
				{ 4, 220543 }, -- Emerald Scalemail Gloves
				{ 5, 220563 }, -- Boots of the Atal'ai Blood Shaman
				{ 6, 220599 }, -- Drakestone of the Blood Prophet
				{ 7, 220598 }, -- Drakestone of the Nightmare Harbinger
				{ 8, 220559 }, -- Revitalized Drake Scale Leggings
				{ 9, 220606 }, -- Idol of the Dream
				{ 10, 220607 }, -- Totem of Tormented Ancestry
				{ 11, 220597 }, -- Drakestone of the Dream Harbinger
				{ 12, 220512 }, -- Immaculate Goldsteel Helmet
				{ 13, 220589 }, -- Serpent's Striker
				{ 14, 220596 }, -- Ancient Divining Rod
				{ 16,  220636 }, -- Atal'ai Blood Icon
				{ 17,  220637 }, -- Atal'ai Ritual Token
			},
		},
		{ -- STEranikus
			name = AL["Shade of Eranikus"],
			npcID = 218571,
			Level = GetForVersion(50,50),
			DisplayIDs = {{117504}},
			[NORMAL_DIFF] = {
				{ 1, 220604 }, -- Nightmare Trophy
				{ 2, 220622 }, -- Perfectly Preserved Dragon's Eye
				{ 3, 220564 }, -- Restored Slitherscale Boots
				{ 4, 220603 }, -- Rod of Irreversible Corrosion
				{ 5, 220523 }, -- Visage of the Exiled
				{ 6, 220600 }, -- Crest of Preeminence
				{ 7, 220574 }, -- Sharpened Tooth of Eranikus
				{ 8, 220573 }, -- Dreadstalker's Hunting Bow
				{ 9, 220595 }, -- Nightmare Focus Staff
				{ 10, 220579 }, -- Witch Doctor's Stick of Mojo
				{ 11, 220585 }, -- Degraded Dire Nail
				{ 12, 220582 }, -- Dragon's Cry
				{ 16,  220636 }, -- Atal'ai Blood Icon
				{ 17,  220637 }, -- Atal'ai Ritual Token
				{ 19,  221475 }, -- Essence of Eranikus
			},
		},
		{ -- STAvatarofHakkar
			name = AL["Avatar of Hakkar"],
			npcID = 221394,
			DisplayIDs = {{8053}},
			AtlasMapBossID = 3,
			Level = 48,
			[NORMAL_DIFF] = {
				{ 1, 221363 }, -- Scapula of the Fallen Avatar
				{ 2, 221363 }, -- Scapula of the Fallen Avatar
				{ 4, 220608 }, -- Featherskin Drape
				{ 5, 220530 }, -- Will of the Atal'ai Warrior
				{ 6, 220577 }, -- Might of the Blood Loa
				{ 7, 220557 }, -- Cursed Windscale Sarong
				{ 8, 220562 }, -- Bloodshot Battle Greaves
				{ 9,  220636 }, -- Atal'ai Blood Icon
				{ 10,  220637 }, -- Atal'ai Ritual Token
				{ 12, 220634 }, -- Atal'ai Blood Ritual Charm
				{ 13, 220633 }, -- Atal'ai Blood Ritual Badge
				{ 14, 220632 }, -- Atal'ai Blood Ritual Medallion
				{ 16, 220590 }, -- Spire of Hakkari Worship
				{ 17, 220620 }, -- Wind Serpent Skull
				{ 18, 220534 }, -- Eternal Embrace of the Wind Serpent
				{ 19, 220686 }, -- Chieftain's Bane
				{ 20, 220588 }, -- Cobra Fang Claw
			},
		},
		{ -- STTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  10630 }, -- Soulcatcher Halo
				{ 2,  10632 }, -- Slimescale Bracers
				{ 3,  10631 }, -- Murkwater Gauntlets
				{ 4,  10633 }, -- Silvershell Leggings
				{ 5,  10629 }, -- Mistwalker Boots
				{ 6,  10634 }, -- Mindseye Circle
				{ 7,  10624 }, -- Stinging Bow
				{ 8,  10623 }, -- Winter's Bite
				{ 9,  10625 }, -- Stealthblade
				{ 10, 10626 }, -- Ragehammer
				{ 11, 10628 }, -- Deathblow
				{ 12, 10627 }, -- Bludgeon of the Grinning Dog
				{ 16, 223326 }, -- Hakkari Shroud
				{ 17, 223325 }, -- Hakkari Breastplate
				{ 18, 223327 }, -- Mark of Hakkar
				{ 20, 16216 }, -- Formula: Enchant Cloak - Greater Resistance
				{ 21, 15733 }, -- Pattern: Green Dragonscale Leggings
			},
		},
	},
}
