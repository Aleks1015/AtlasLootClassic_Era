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
local data = AtlasLoot.ItemDB:Add(addonname, 1, 1)

local AL = AtlasLoot.Locales
local ALIL = AtlasLoot.IngameLocales

local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", 1, nil, true)
local ALLIANCE_DIFF
local HORDE_DIFF
local LOAD_DIFF
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

local QUEST_EXTRA_ITTYPE = data:AddExtraItemTableType("Quest")
local PRICE_EXTRA_ITTYPE = data:AddExtraItemTableType("Price")
local SET_EXTRA_ITTYPE = data:AddExtraItemTableType("Set")

local FACTIONS3_CONTENT = data:AddContentType(AL["Seasonal"], ATLASLOOT_RAID20_COLOR)
local FACTIONS_CONTENT = data:AddContentType(AL["Factions"], ATLASLOOT_FACTION_COLOR)
local FACTIONS2_CONTENT = data:AddContentType(AL["Secondary factions"], {0.1, 0.3, 0.1, 1})

local FACTIONS_HORDE_CONTENT, FACTIONS_ALLI_CONTENT
if UnitFactionGroup("player") == "Horde" then
    FACTIONS_HORDE_CONTENT = data:AddContentType(FACTION_HORDE, ATLASLOOT_HORDE_COLOR)
    FACTIONS_ALLI_CONTENT = data:AddContentType(FACTION_ALLIANCE, ATLASLOOT_ALLIANCE_COLOR)
else
    FACTIONS_ALLI_CONTENT = data:AddContentType(FACTION_ALLIANCE, ATLASLOOT_ALLIANCE_COLOR)
    FACTIONS_HORDE_CONTENT = data:AddContentType(FACTION_HORDE, ATLASLOOT_HORDE_COLOR)
end

--[[
0 - Unknown
1 - Hated
2 - Hostile
3 - Unfriendly
4 - Neutral
5 - Friendly
6 - Honored
7 - Revered
8 - Exalted
]]--

local AD_INSIGNIA_FORMAT_BLUE, AD_INSIGNIA_FORMAT_EPIC = "|cff0070dd%d|r",  "|cffa335ee%d|r" -- format(AD_INSIGNIA_FORMAT, 30)
data["ArgentDawn"] = {
	FactionID = 529,
	ContentType = FACTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Exalted
			name = ALIL["Exalted"],
			[NORMAL_DIFF] = {
				{ 1, "f529rep8" },
				{ 2, 18182 }, -- Chromatic Mantle of the Dawn
				{ 3, 227819}, -- Blessed Flame Mantle of the Dawn
				{ 17,  22523, 22524, [ATLASLOOT_IT_AMOUNT1] = format(AD_INSIGNIA_FORMAT_EPIC, 27), [ATLASLOOT_IT_AMOUNT2] = format(AD_INSIGNIA_FORMAT_EPIC, 27) }, -- Insignia of the Dawn / Crusade
				{ 18,  22523, 22524, [ATLASLOOT_IT_AMOUNT1] = format(AD_INSIGNIA_FORMAT_BLUE, 6), [ATLASLOOT_IT_AMOUNT2] = format(AD_INSIGNIA_FORMAT_BLUE, 6) }, -- Insignia of the Dawn / Crusade
			},
		},
		{ -- Revered
			name = ALIL["Revered"],
			[NORMAL_DIFF] = {
				{ 1, "f529rep7" },
				{ 2, 13810 }, -- Blessed Sunfruit
				{ 3, 13813 }, -- Blessed Sunfruit Juice
				{ 5,  19217 }, -- Pattern: Argent Shoulders
				{ 6,  19329 }, -- Pattern: Golden Mantle of the Dawn
				{ 7,  12698 }, -- Plans: Dawnbringer Shoulders
				{ 8,  19205 }, -- Plans: Gloves of the Dawn
				{ 9,  19447 }, -- Formula: Enchant Bracer - Healing
				{ 11,  18171 }, -- Arcane Mantle of the Dawn
				{ 12,  18169 }, -- Flame Mantle of the Dawn
				{ 13,  18170 }, -- Frost Mantle of the Dawn
				{ 14,  18172 }, -- Nature Mantle of the Dawn
				{ 15, 18173 }, -- Shadow Mantle of the Dawn
				{ 17,  22523, 22524, [ATLASLOOT_IT_AMOUNT1] = format(AD_INSIGNIA_FORMAT_EPIC, 45), [ATLASLOOT_IT_AMOUNT2] = format(AD_INSIGNIA_FORMAT_EPIC, 45) }, -- Insignia of the Dawn / Crusade
				{ 18,  22523, 22524, [ATLASLOOT_IT_AMOUNT1] = format(AD_INSIGNIA_FORMAT_BLUE, 7), [ATLASLOOT_IT_AMOUNT2] = format(AD_INSIGNIA_FORMAT_BLUE, 7) }, -- Insignia of the Dawn / Crusade
				{ 20, "INV_Box_02", nil, AL["Upgrades"], nil },
				{ 21, 227888 }, -- Argent Elite Shoulders
				{ 22, 227818 }, -- Glowing Mantle of the Dawn
				{ 23, 227859 }, -- Shimmering Dawnbringer Shoulders
				{ 24, 227817 }, -- Radiant Gloves of the Dawn
			},
		},
		{ -- Honored
			name = ALIL["Honored"],
			[NORMAL_DIFF] = {
				{ 1, "f529rep6" },
				{ 2,  19216 }, -- Pattern: Argent Boots
				{ 3,  19328 }, -- Pattern: Dawn Treaders
				{ 4,  19203 }, -- Plans: Girdle of the Dawn
				{ 5,  19442 }, -- Formula: Powerful Anti-Venom
				{ 6,  19446 }, -- Formula: Enchant Bracer - Mana Regeneration
				{ 7, 13482 }, -- Recipe: Transmute Air to Fire
				{ 17,  22523, 22524, [ATLASLOOT_IT_AMOUNT1] = format(AD_INSIGNIA_FORMAT_EPIC, 75), [ATLASLOOT_IT_AMOUNT2] = format(AD_INSIGNIA_FORMAT_EPIC, 75) }, -- Insignia of the Dawn / Crusade
				{ 18,  22523, 22524, [ATLASLOOT_IT_AMOUNT1] = format(AD_INSIGNIA_FORMAT_BLUE, 20), [ATLASLOOT_IT_AMOUNT2] = format(AD_INSIGNIA_FORMAT_BLUE, 20) }, -- Insignia of the Dawn / Crusade
				{ 20, "INV_Box_02", nil, AL["Upgrades"], nil },
				{ 21,  227816 }, -- Argent Elite Boots
				{ 22,  227815 }, -- Fine Dawn Treaders
				{ 23,  227814 }, -- Radiant Girdle of the Dawn
			},
		},
		{ -- Friendly
			name = ALIL["Friendly"],
			[NORMAL_DIFF] = {
				{ 1, "f529rep5" },
				{ 2,  13724 }, -- Enriched Manna Biscuit
				{ 17,  22523, 22524, [ATLASLOOT_IT_AMOUNT1] = format(AD_INSIGNIA_FORMAT_EPIC, 110), [ATLASLOOT_IT_AMOUNT2] = format(AD_INSIGNIA_FORMAT_EPIC, 110) }, -- Insignia of the Dawn / Crusade
				{ 18,  22523, 22524, [ATLASLOOT_IT_AMOUNT1] = format(AD_INSIGNIA_FORMAT_BLUE, 30), [ATLASLOOT_IT_AMOUNT2] = format(AD_INSIGNIA_FORMAT_BLUE, 30) }, -- Insignia of the Dawn / Crusade
			},
		},
	},
}

data["Timbermaw"] = {
	FactionID = 576,
	ContentType = FACTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Exalted
			name = ALIL["Exalted"],
			[NORMAL_DIFF] = {
				{ 1, "f576rep8" },
				{ 2, 21326 }, -- Defender of the Timbermaw
			},
		},
		{ -- Revered
			name = ALIL["Revered"],
			[NORMAL_DIFF] = {
				{ 1, "f576rep7" },
				{ 2, 19218 }, -- Pattern: Mantle of the Timbermaw
				{ 3, 19327 }, -- Pattern: Timbermaw Brawlers
				{ 4, 19204 }, -- Plans: Heavy Timbermaw Boots
				{ 6, 227808 }, -- Rugged Mantle of the Timbermaw
				{ 7, 227809 }, -- Studded Timbermaw Brawlers
				{ 8, 227810 }, -- Dense Timbermaw Boots
			},
		},
		{ -- Honored
			name = ALIL["Honored"],
			[NORMAL_DIFF] = {
				{ 1, "f576rep6" },
				{ 2,  16768 }, -- Furbolg Medicine Pouch
				{ 3,  16769 }, -- Furbolg Medicine Totem
				{ 4, 19202 }, -- Plans: Heavy Timbermaw Belt
				{ 5, 19326 }, -- Pattern: Might of the Timbermaw
				{ 6, 19215 }, -- Pattern: Wisdom of the Timbermaw
				{ 7, 19445 }, -- Formula: Enchant Weapon - Agility
				{ 9, 227807 }, -- Dense Timbermaw Belt
				{ 10, 227805 }, -- Ferocity of the Timbermaw
				{ 11, 228190 }, -- Knowledge of the Timbermaw
			},
		},
		{ -- Friendly
			name = ALIL["Friendly"],
			[NORMAL_DIFF] = {
				{ 1, "f576rep5" },
				{ 2,  13484 }, -- Recipe: Transmute Earth to Water
				{ 3,  15754 }, -- Pattern: Warbear Woolies
				{ 4,  15742 }, -- Pattern: Warbear Harness
				{ 5,  22392 }, -- Formula: Enchant 2H Weapon - Agility
				{ 7,  227804 }, -- Dire Warbear Woolies
				{ 8,  227803 }, -- Dire Warbear Harness
			},
		},
	},
}

data["ThoriumBrotherhood"] = {
	FactionID = 59,
	ContentType = FACTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Exalted
			name = ALIL["Exalted"],
			[NORMAL_DIFF] = {
				{ 1, "f59rep8" },
				{ 2,  20040 }, -- Plans: Dark Iron Boots
				{ 3,  19210 }, -- Plans: Ebon Hand
				{ 4,  19211 }, -- Plans: Blackguard
				{ 5,  19212 }, -- Plans: Nightfall
				{ 17, "INV_Box_02", nil, AL["Upgrades"], nil },
				{ 18, 227842 }, -- Ebon Fist
				{ 19, 227840 }, -- Implacable Blackguard
				{ 20, 227843 }, -- Reaving Nightfall
				{ 21, 228929 }, -- Tempered Dark Iron Boots
				{ 22, 228924 }, -- Tempered Dark Iron Boots
				{ 23, 228927 }, -- Tempered Dark Iron Boots
				{ 24, 228926 }, -- Tempered Dark Iron Boots
				{ 25, 228925 }, -- Tempered Dark Iron Boots
				{ 26, 228928 }, -- Tempered Dark Iron Boots
			},
		},
		{ -- Revered
			name = ALIL["Revered"],
			[NORMAL_DIFF] = {
				{ 1, "f59rep7" },
				{ 2,  19220 }, -- Pattern: Flarecore Leggings
				{ 3,  19333 }, -- Pattern: Molten Belt
				{ 4,  19332 }, -- Pattern: Corehound Belt
				{ 5,  17053 }, -- Plans: Fiery Chain Shoulders
				{ 6,  19331 }, -- Pattern: Chromatic Gauntlets
				{ 7,  19207 }, -- Plans: Dark Iron Gauntlets
				{ 8,  17052 }, -- Plans: Dark Iron Leggings
				{ 9,  19208 }, -- Plans: Black Amnesty
				{ 10,  19209 }, -- Plans: Blackfury
				{ 11, 19449 }, -- Formula: Enchant Weapon - Mighty Intellect
				{ 17, "INV_Box_02", nil, AL["Upgrades"], nil },
				{ 18, 227839 }, -- Fine Flarecore Leggings
				{ 19, 227837 }, -- Thick Corehound Belt
				{ 20, 227834 }, -- Molten Chain Shoulders
				{ 21, 227838 }, -- Shining Chromatic Gauntlets
				{ 22, 227835 }, -- Tempered Dark Iron Gauntlets
				{ 23, 227836 }, -- Tempered Dark Iron Leggings
				{ 24, 227832 }, -- Tempered Black Amnesty
				{ 25, 227833 }, -- Glaive of Obsidian Fury
			},
		},
		{ -- Honored
			name = ALIL["Honored"],
			[NORMAL_DIFF] = {
				{ 1, "f59rep6" },
				{ 2,  17017 }, -- Pattern: Flarecore Mantle
				{ 3,  19219 }, -- Pattern: Flarecore Robe
				{ 4,  19330 }, -- Pattern: Lava Belt
				{ 5,  17049 }, -- Plans: Fiery Chain Girdle
				{ 6,  17025 }, -- Pattern: Black Dragonscale Boots
				{ 7,  19206 }, -- Plans: Dark Iron Helm
				{ 8,  17059 }, -- Plans: Dark Iron Reaver
				{ 9,  17060 }, -- Plans: Dark Iron Destroyer
				{ 10,  19448 }, -- Formula: Enchant Weapon - Mighty Spirit
				{ 17, "INV_Box_02", nil, AL["Upgrades"], nil },
				{ 18, 227830 }, -- Fine Flarecore Mantle
				{ 19, 227831 }, -- Fine Flarecore Robe
				{ 20, 227828 }, -- Lavawalker Belt
				{ 21, 227827 }, -- Molten Chain Girdle
				{ 22, 227829 }, -- Hardened Black Dragonscale Boots
				{ 23, 227824 }, -- Tempered Dark Iron Helm
				{ 24, 227826 }, -- Dark Iron Flame Reaver
				{ 25, 227825 }, -- Molten Dark Iron Destroyer
			},
		},
		{ -- Friendly
			name = ALIL["Friendly"],
			[NORMAL_DIFF] = {
				{ 1, "f59rep5" },
				{ 2,  17018 }, -- Pattern: Flarecore Gloves
				{ 3,  17023 }, -- Pattern: Molten Helm
				{ 4,  17022 }, -- Pattern: Corehound Boots
				{ 5,  17051 }, -- Plans: Dark Iron Bracers
				{ 6,  20761 }, -- Recipe: Transmute Elemental Fire
				{ 7,  19444 }, -- Formula: Enchant Weapon - Strength
				{ 17, "INV_Box_02", nil, AL["Upgrades"], nil },
				{ 18, 227823 }, -- Fine Flarecore Gloves
				{ 19, 227821 }, -- Flamekissed Molten Helm
				{ 20, 227822 }, -- Thick Corehound Boots
				{ 21, 227820 }, -- Tempered Dark Iron Bracers
			},
		},
	},
}

data["CenarionCircle"] = {
	FactionID = 609,
	ContentType = FACTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Exalted
			name = ALIL["Exalted"],
			[NORMAL_DIFF] = {
				{ 1, "f609rep8" },
				{ 2,  20382 }, -- Pattern: Dreamscale Breastplate
				{ 17,  21188 }, -- Fist of Cenarius
				{ 18,  21180 }, -- Earthstrike
				{ 19,  21190 }, -- Wrath of Cenarius
			},
		},
		{ -- Revered
			name = ALIL["Revered"],
			[NORMAL_DIFF] = {
				{ 1, "f609rep7" },
				{ 2,  22683 }, -- Pattern: Gaea's Embrace
				{ 3,  22312 }, -- Pattern: Satchel of Cenarius
				{ 4,  22774 }, -- Pattern: Sylvan Vest
				{ 5,  22771 }, -- Pattern: Bramblewood Helm
				{ 6,  20508 }, -- Pattern: Spitfire Breastplate
				{ 7,  20511 }, -- Pattern: Sandstalker Breastplate
				{ 8,  22766 }, -- Plans: Ironvine Breastplate
				{ 9,  22219 }, -- Plans: Jagged Obsidian Shield
				{ 17,  21184 }, -- Deeprock Bracers
				{ 18,  21186 }, -- Rockfury Bracers
				{ 19,  21185 }, -- Earthcalm Orb
				{ 20,  21189 }, -- Might of Cenarius
			},
		},
		{ -- Honored
			name = ALIL["Honored"],
			[NORMAL_DIFF] = {
				{ 1, "f609rep6" },
				{ 2,  22773 }, -- Pattern: Sylvan Crown
				{ 3,  22770 }, -- Pattern: Bramblewood Boots
				{ 4,  20507 }, -- Pattern: Spitfire Gauntlets
				{ 5,  20510 }, -- Pattern: Sandstalker Gauntlets
				{ 6,  22767 }, -- Plans: Ironvine Gloves
				{ 7,  22214 }, -- Plans: Light Obsidian Belt
				{ 8,  20733 }, -- Formula: Enchant Cloak - Greater Nature Resistance
				{ 17,  21181 }, -- Grace of Earth
				{ 18,  21183 }, -- Earthpower Vest
				{ 19,  21182 }, -- Band of Earthen Might
			},
		},
		{ -- Friendly
			name = ALIL["Friendly"],
			[NORMAL_DIFF] = {
				{ 1, "f609rep5" },
				{ 2,  22772 }, -- Pattern: Sylvan Shoulders
				{ 3,  22310 }, -- Pattern: Cenarion Herb Bag
				{ 4,  22769 }, -- Pattern: Bramblewood Belt
				{ 5,  20506 }, -- Pattern: Spitfire Bracers
				{ 6,  20509 }, -- Pattern: Sandstalker Bracers
				{ 7,  22768 }, -- Plans: Ironvine Belt
				{ 8,  22209 }, -- Plans: Heavy Obsidian Belt
				{ 9,  20732 }, -- Formula: Enchant Cloak - Greater Fire Resistance
				{ 17,  21178 }, -- Gloves of Earthen Power
				{ 18,  21187 }, -- Earthweave Cloak
				{ 19,  21179 }, -- Band of Earthen Wrath
			},
		},
	},
}

data["ZandalarTribe"] = {
	FactionID = 270,
	ContentType = FACTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Exalted
			name = ALIL["Exalted"],
			[NORMAL_DIFF] = {
				{ 1, "f270rep8" },
				{ 2,  20013 }, -- Recipe: Living Action Potion
				{ 3,  20077 }, -- Zandalar Signet of Might
				{ 4,  20076 }, -- Zandalar Signet of Mojo
				{ 5,  20078 }, -- Zandalar Signet of Serenity
			},
		},
		{ -- Revered
			name = ALIL["Revered"],
			[NORMAL_DIFF] = {
				{ 1, "f270rep7" },
				{ 2,  19764 }, -- Pattern: Bloodvine Vest
				{ 3,  19769 }, -- Pattern: Primal Batskin Jerkin
				{ 4,  19772 }, -- Pattern: Blood Tiger Breastplate
				{ 5,  19776 }, -- Plans: Bloodsoul Breastplate
				{ 6,  19779 }, -- Plans: Darksoul Breastplate
				{ 7,  20011 }, -- Recipe: Mageblood Potion
				{ 17,  20080 }, -- Sheen of Zanza
				{ 18,  20079 }, -- Spirit of Zanza
				{ 19,  20081 }, -- Swiftness of Zanza
			},
		},
		{ -- Honored
			name = ALIL["Honored"],
			[NORMAL_DIFF] = {
				{ 1, "f270rep6" },
				{ 2,  19765 }, -- Pattern: Bloodvine Leggings
				{ 3,  20000 }, -- Schematic: Bloodvine Goggles
				{ 4,  19770 }, -- Pattern: Primal Batskin Gloves
				{ 5,  19773 }, -- Pattern: Blood Tiger Shoulders
				{ 6,  19777 }, -- Plans: Bloodsoul Shoulders
				{ 7,  19780 }, -- Plans: Darksoul Leggings
				{ 8,  20014 }, -- Recipe: Major Troll's Blood Potion
				{ 9,  20756 }, -- Formula: Brilliant Wizard Oil
				{ 10,  20031 }, -- Essence Mango
			},
		},
		{ -- Friendly
			name = ALIL["Friendly"],
			[NORMAL_DIFF] = {
				{ 1, "f270rep5" },
				{ 2,  19766 }, -- Pattern: Bloodvine Boots
				{ 3,  19771 }, -- Pattern: Primal Batskin Bracers
				{ 4,  20001 }, -- Schematic: Bloodvine Lens
				{ 5,  19778 }, -- Plans: Bloodsoul Gauntlets
				{ 6,  19781 }, -- Plans: Darksoul Shoulders
				{ 7,  20012 }, -- Recipe: Greater Dreamless Sleep
				{ 8,  20757 }, -- Formula: Brilliant Mana Oil
			},
		},
	},
}

data["BroodOfNozdormu"] = {
	FactionID = 910,
	ContentType = FACTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Exalted
			name = ALIL["Exalted"],
			[NORMAL_DIFF] = {
				{ 1, "f910rep8" },
				{ 2, 21210 }, --Signet Ring of the Bronze Dragonflight / 80
				{ 3, 21205 }, --Signet Ring of the Bronze Dragonflight / 80
				{ 4, 21200 }, --Signet Ring of the Bronze Dragonflight / 80
			},
		},
		{ -- Revered
			name = ALIL["Revered"],
			[NORMAL_DIFF] = {
				{ 1, "f910rep7" },
				{ 2, 21209 }, --Signet Ring of the Bronze Dragonflight / 75
				{ 3, 21204 }, --Signet Ring of the Bronze Dragonflight / 75
				{ 4, 21199 }, --Signet Ring of the Bronze Dragonflight / 75
			},
		},
		{ -- Honored
			name = ALIL["Honored"],
			[NORMAL_DIFF] = {
				{ 1, "f910rep6" },
				{ 2, 21208 }, --Signet Ring of the Bronze Dragonflight / 70
				{ 3, 21203 }, --Signet Ring of the Bronze Dragonflight / 70
				{ 4, 21198 }, --Signet Ring of the Bronze Dragonflight / 70
			},
		},
		{ -- Friendly
			name = ALIL["Friendly"],
			[NORMAL_DIFF] = {
				{ 1, "f910rep5" },
				{ 2, 21207 }, --Signet Ring of the Bronze Dragonflight / 65
				{ 3, 21202 }, --Signet Ring of the Bronze Dragonflight / 65
				{ 4, 21197 }, --Signet Ring of the Bronze Dragonflight / 65
			},
		},
		{ -- Neutral
			name = ALIL["Neutral"],
			[NORMAL_DIFF] = {
				{ 1, "f910rep4" },
				{ 2, 21206 }, --Signet Ring of the Bronze Dragonflight / 60
				{ 3, 21201 }, --Signet Ring of the Bronze Dragonflight / 60
				{ 4, 21196 }, --Signet Ring of the Bronze Dragonflight / 60
			},
		},
	},
}

data["HydraxianWaterlords"] = {
	FactionID = 749,
	ContentType = FACTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Exalted
			name = ALIL["Exalted"],
			[NORMAL_DIFF] = {
				{ 1, "f749rep8" },
				{ 2, 227926}, -- Hydraxian Coronation
				{ 4, 227915}, -- Duke's Domain
			},
		},
		{ -- Revered
			name = ALIL["Revered"],
			[NORMAL_DIFF] = {
				{ 1, "f749rep7" },
				{ 2, 22687 }, -- Pattern: Glacial Wrists
				{ 3, 22698 }, -- Pattern: Icy Scale Bracers
				{ 4, 22705 }, -- Plans: Icebane Bracers
				{ 5, 22695 }, -- Pattern: Polar Bracers
				{ 17, 22754 }, -- Eternal Quintessence
			},
		},
		{ -- Honored
			name = ALIL["Honored"],
			[NORMAL_DIFF] = {
				{ 1, "f749rep6" },
				{ 2, 17333 }, -- Aqual Quintessence
			},
		},
	},
}


data["BloodsailBuccaneers"] = {
	FactionID = 87,
	ContentType = FACTIONS2_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Friendly
			name = ALIL["Friendly"],
			[NORMAL_DIFF] = {
				{ 1, "f87rep5" },
				{ 2, 12185 }, -- Bloodsail Admiral's Hat
				{ 3, 22742 }, -- Bloodsail Shirt
				{ 4, 22743 }, -- Bloodsail Sash
				{ 5, 22745 }, -- Bloodsail Pants
			},
		},
	},
}

data["WintersaberTrainers"] = {
	FactionID = 589,
	ContentType = FACTIONS2_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Exalted
			name = ALIL["Exalted"],
			[ALLIANCE_DIFF] = {
				{ 1, "f589rep8", [ATLASLOOT_IT_ALLIANCE] = true },
				{ 2, 13086, [ATLASLOOT_IT_ALLIANCE] = true }, -- Reins of the Winterspring Frostsaber
			},
		},
	},
}

data["AzerothCommerceAuthority"] = {
	FactionID = 2586,
	ContentType = FACTIONS3_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Exalted
			name = ALIL["Exalted"],
			[ALLIANCE_DIFF] = {
				{ 1, "f2586rep8" },
				{ 2, 223164 }, -- Curiosity Cowl
				{ 3, 223169 }, -- Tenacity Cap
				{ 4, 223172 }, -- Tenacity Chain
				{ 6, 223186 }, -- Supply Expediter
				{ 7, 223162 }, -- Handy Courier Haversack
				{ 8, 220639 }, -- Lledra's Inanimator

			},
		},
		{ -- Revered
			name = ALIL["Revered"],
			[ALLIANCE_DIFF] = {
				{ 1, "f2586rep7" },
				{ 2, 217399 }, -- Recipe: Lesser Arcane Elixir
				{ 3, 219021 }, -- Hefty Courier Pack
				{ 5, 223161 }, -- Empty Supply Crate
				{ 16, 219135 }, -- Curiosity Pendant
				{ 17, 219136 }, -- Tenacity Pendant
				{ 18, 219137 }, -- Initiative Pendant
			},
		},
		{ -- Honored
			name = ALIL["Honored"],
			[ALLIANCE_DIFF] = {
				{ 1, "f2586rep6" },
				{ 2, 211384 }, -- Sturdy Courier Bag
				{ 4, 210779 }, -- Plans: Mantle of the Second War
				{ 5, 211247 }, -- Pattern: Phoenix Bindings
				{ 6, 212230 }, -- Schematic: Soul Vessel
				{ 8, 223160 }, -- Bargain Bush
				{ 16, 219022 }, -- Hauler's Ring
				{ 17, 219023 }, -- Clerk's Ring
				{ 18, 219024 }, -- Messenger's Ring
			},
		},
		{ -- Friendly
			name = ALIL["Friendly"],
			[ALLIANCE_DIFF] = {
				{ 1, "f2586rep5" },
				{ 2, 211382 }, -- Small Courier Satchel
				{ 3, 212588 }, -- Provisioner's Gloves
				{ 4, 212589 }, -- Courier Treads
				{ 5, 212590 }, -- Hoist Strap
				{ 7, 211386 }, -- Spell Notes: Arcane Surge
				{ 8, 211387 }, -- Rune of Beckoning Light
				{ 9, 211392 }, -- Rune of Everlasting Affliction
				{ 10, 211391 }, -- Rune of Healing Rain
				{ 11, 211385 }, -- Rune of Serpent Spread
				{ 12, 211393 }, -- Rune of Single-Minded Fury
				{ 13, 206992 }, -- Rune of Skull Bash
				{ 14, 211390 }, -- Rune of Teasing
				{ 15, 205950 }, -- Tenebrous Epiphany

			},
		},
	},
}

	data["DurotarSupplyAndLogistics"] = {
	FactionID = 2587,
	ContentType = FACTIONS3_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Exalted
			name = ALIL["Exalted"],
			[HORDE_DIFF] = {
				{ 1, "f2587rep8" },
				{ 2, 223164 }, -- Curiosity Cowl
				{ 3, 223169 }, -- Tenacity Cap
				{ 4, 223172 }, -- Tenacity Chain
				{ 6, 223186 }, -- Supply Expediter
				{ 7, 223162 }, -- Handy Courier Haversack
				{ 8, 220639 }, -- Lledra's Inanimator

			},
		},
		{ -- Revered
			name = ALIL["Revered"],
			[HORDE_DIFF] = {
				{ 1, "f2587rep7" },
				{ 2, 217399 }, -- Recipe: Lesser Arcane Elixir
				{ 3, 219021 }, -- Hefty Courier Pack
				{ 5, 223161 }, -- Empty Supply Crate
				{ 16, 219135 }, -- Curiosity Pendant
				{ 17, 219136 }, -- Tenacity Pendant
				{ 18, 219137 }, -- Initiative Pendant
			},
		},
		{ -- Honored
			name = ALIL["Honored"],
			[HORDE_DIFF] = {
				{ 1, "f2587rep6" },
				{ 2, 211384 }, -- Sturdy Courier Bag
				{ 4, 210779 }, -- Plans: Mantle of the Second War
				{ 5, 211247 }, -- Pattern: Phoenix Bindings
				{ 6, 212230 }, -- Schematic: Soul Vessel
				{ 8, 223160 }, -- Bargain Bush
				{ 16, 219022 }, -- Hauler's Ring
				{ 17, 219023 }, -- Clerk's Ring
				{ 18, 219024 }, -- Messenger's Ring
			},
		},
		{ -- Friendly
			name = ALIL["Friendly"],
			[HORDE_DIFF] = {
				{ 1, "f2587rep5" },
				{ 2, 211382 }, -- Small Courier Satchel
				{ 3, 212588 }, -- Provisioner's Gloves
				{ 4, 212589 }, -- Courier Treads
				{ 5, 212590 }, -- Hoist Strap
				{ 7, 211386 }, -- Spell Notes: Arcane Surge
				{ 8, 211387 }, -- Rune of Beckoning Light
				{ 9, 211392 }, -- Rune of Everlasting Affliction
				{ 10, 211391 }, -- Rune of Healing Rain
				{ 11, 211385 }, -- Rune of Serpent Spread
				{ 12, 211393 }, -- Rune of Single-Minded Fury
				{ 13, 206992 }, -- Rune of Skull Bash
				{ 14, 211390 }, -- Rune of Teasing
				{ 15, 205950 }, -- Tenebrous Epiphany
			},
		},
	},
}

data["Emerald Wardens"] = {
	FactionID = 2641,
	ContentType = FACTIONS3_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Exalted
			name = ALIL["Exalted"],
			[NORMAL_DIFF] = {
				{ 1, "f2641rep8" },
				{ 2, 221442 }, -- Roar of the Guardian
				{ 3, 220621 }, -- Nightmare Resonance Crystal
				{ 4, 221440 }, -- Roar of the Dream
				{ 5, 221443 }, -- Roar of the Grove
			},
		},
		{ -- Revered
			name = ALIL["Revered"],
			[NORMAL_DIFF] = {
				{ 1, "f2641rep7" },
				{ 2, 221441 }, -- Warden of the Dream
				{ 3, 220649 }, -- Merithra's Inheritence
				{ 4, 221439 }, -- Armor of the Emerald Slumber
				
			},
		},
		{ -- Honored3
			name = ALIL["Honored (Mail/Plate)"],
			[NORMAL_DIFF] = {
				{ 1, "f2641rep6" },
				{ 2, "INV_Box_01", nil, AL["Mail"], nil },
				{ 3, 221391 }, --Emerald Scalemail Helmet
				{ 4, 221390 }, --Emerald Scalemail Breastplate
				{ 5, 221388 }, --Emerald Scalemail Leggings
				{ 7, 221402 }, --Emerald Chain Helmet
				{ 8, 221404 }, --Emerald Chain Breastplate
				{ 9, 221401 }, --Emerald Chain Leggings
				{ 11, 221397 }, --Emerald Laden Helmet
				{ 12, 221395 }, --Emerald Laden Breastplate
				{ 13, 221398 }, --Emerald Laden Leggings
				{ 16, "INV_Box_01", nil, AL["Plate"], nil },
				{ 17, 221376 }, --Emerald Dream Helm
				{ 18, 221380 }, --Emerald Dream Breastplate
				{ 19, 221377 }, --Emerald Dream Legplates
				{ 21, 221384 }, --Emerald Encrusted Helmet
				{ 22, 221382 }, --Emerald Encrusted Battleplate
				{ 23, 221385 }, --Emerald Encrusted Legplates
			},
		},
		{ -- Honored2
			name = ALIL["Honored (Cloth/Leather)"],
			[NORMAL_DIFF] = {
				{ 1, "f2641rep6" },
				{ 2, "INV_Box_01", nil, AL["Cloth"], nil },
				{ 3, 221425 }, --Emerald Enchanted Circlet
				{ 4, 221430 }, --Emerald Enchanted Robes
				{ 5, 221429 }, --Emerald Enchanted Pants
				{ 7, 221437 }, --Emerald Woven Circlet
				{ 8, 221434 }, --Emerald Woven Robes
				{ 9, 221435 }, --Emerald Woven Pants
				{ 16, "INV_Box_01", nil, AL["Leather"], nil },
				{ 17, 221408 }, --Emerald Leather Helm
				{ 18, 221406 }, --Emerald Leather Vest
				{ 19, 221410 }, --Emerald Leather Pants
				{ 21, 221413 }, --Emerald Dreamkeeper Helm
				{ 22, 221417 }, --Emerald Dreamkeeper Chest
				{ 23, 221414 }, --Emerald Dreamkeeper Pants
				{ 25, 221422 }, --Emerald Watcher Helm
				{ 26, 221419 }, --Emerald Watcher Vest
				{ 27, 221423 }, --Emerald Watcher Leggings
			},
		},
		{ -- Honored
			name = ALIL["Honored"],
			[NORMAL_DIFF] = {
				{ 1, "f2641rep6" },
				{ 2, 213407 }, -- Catnip
				{ 3, 221193 }, --Emerald Ring
				{ 4, 224006 }, --Emerald Ring
			},
		},
		{ -- Friendly2
			name = ALIL["Friendly (Mail/Plate)"],
			[NORMAL_DIFF] = {
				{ 1, "f2641rep5" },
				{ 2, "INV_Box_01", nil, AL["Mail"], nil },
				{ 3, 221392 }, --Emerald Scalemail Shoudlers
				{ 4, 221389 }, --Emerald Scalemail Gauntlets
				{ 5, 221393 }, --Emerald Scalemail Boots
				{ 7, 221399 }, --Emerald Laden Shoulders
				{ 8, 221396 }, --Emerald Laden Gauntlets
				{ 9, 221394 }, --Emerald Laden Boots
				{ 11, 221400 }, --Emerald Chain Shoudlers
				{ 12, 221403 }, --Emerald Chain Gauntlets
				{ 13, 221405 }, --Emerald Chain Boots
				{ 16, "INV_Box_01", nil, AL["Plate"], nil },
				{ 17, 221386 }, --Emerald Encrusted Spaulders
				{ 18, 221383 }, --Emerald Encrusted Handguards
				{ 19, 221387 }, --Emerald Encrusted Plate Boots
				{ 21, 221381 }, --Emerald Dream Pauldrons
				{ 22, 221378 }, --Emerald Dream Gauntlets
				{ 23, 221379 }, --Emerald Dream Sabatons
			},
		},
		{ -- Friendly2
			name = ALIL["Friendly (Cloth/Leather)"],
			[NORMAL_DIFF] = {
				{ 1, "f2641rep5" },
				{ 2, "INV_Box_01", nil, AL["Cloth"], nil },
				{ 3, 221431 }, --Emerald Enchanted Shoulders
				{ 4, 221427 }, --Emerald Enchanted Gloves
				{ 5, 221426 }, --Emerald Enchanted Boots
				{ 7, 221432 }, --Emerald Woven Mantle
				{ 8, 221436 }, --Emerald Woven Gloves
				{ 9, 221438 }, --Emerald Woven Boots
				{ 16, "INV_Box_01", nil, AL["Leather"], nil },
				{ 17, 221411 }, --Emerald Leather Shoulders
				{ 18, 221407 }, --Emerald Leather Gloves
				{ 19, 221409 }, --Emerald Leather Sabatons
				{ 21, 221416 }, --Emerald Dreamkeeper Shoulders
				{ 22, 221412 }, --Emerald Dreamkeeper Gloves
				{ 23, 221415 }, --Emerald Dreamkeeper Boots
				{ 25, 221424 }, --Emerald Watcher Shoulders
				{ 26, 221421 }, --Emerald Watcher Gloves
				{ 27, 221420 }, --Emerald Watcher Boots
			},
		},
		{ -- Friendly
			name = ALIL["Friendly"],
			[NORMAL_DIFF] = {
				{ 1, "f2641rep5" },
				{ 2, 221369 }, -- Nightmare Siphon
				{ 3, 221374 }, -- Anguish of the Dream
				{ 4, 221362 }, -- Weapon Cleaning Cloth
				{ 5, 223648 }, -- Dream Imbued Arrow
				{ 6, 224005 }, -- Emerald Ring
				{ 7, 224004 }, -- Emerald Ring
				{ 16, 221480 }, -- Spell Notes: Molten Armor
				{ 17, 221481 }, -- 	Nihilist Epiphany
				{ 18, 221482 }, -- 	Rune of Affliction
				{ 19, 221483 }, -- 	Rune of Burn
				{ 20, 221511 }, -- 	Rune of the Protector
				{ 21, 221512 }, -- 	Rune of Alacrity
				{ 22, 221515 }, -- 	Rune of Detonation
				{ 23, 221517 }, -- 	Rune of Bloodshed
				{ 24, 223288 }, -- 	Rune of the Hammer
			},
		},
		{ -- Friendly
			name = ALIL["Neutral"],
			[NORMAL_DIFF] = {
				{ 1, "f2641rep4" },
				{ 2, 212568 }, -- Wolfshead Trophy
				{ 3, 223912 }, -- Purification Potion
				{ 4, 223913 }, -- Major Healing Potion
				{ 5, 223914 }, -- Greater Healing Potion


			},
		},
	},
}

--[[
	data["Timbermaw"] = {
	FactionID = 59,
	ContentType = FACTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Exalted
			name = ALIL["Exalted"],
			[NORMAL_DIFF] = {
				{ 1, "f59rep8" },
			},
		},
		{ -- Revered
			name = ALIL["Revered"],
			[NORMAL_DIFF] = {
				{ 1, "f59rep7" },
			},
		},
		{ -- Honored
			name = ALIL["Honored"],
			[NORMAL_DIFF] = {
				{ 1, "f59rep6" },
			},
		},
		{ -- Friendly
			name = ALIL["Friendly"],
			[NORMAL_DIFF] = {
				{ 1, "f59rep5" },
			},
		},
	},
}
]]


