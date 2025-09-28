name = "Seasons Changer Improved"
description = "Choose from up to 28 seasons from every DLC to play with in a single world.\n\n"
author = "Pinky Cat, Original: Hectorzx"
version = "1.0"
--[[
-- == EXTRAS ==
-- TODO: Add random season/length as an option.
-- DONE: min and maxiumn length for random season length
-- DONE: option to select which seasons can be randomize into
-- Make RandDayOffsetRange format like "-4/+4".
-- Add override option to change season of old maps
-- Add APORKALYPSE
-- Add optional beahvior for caves/volcano to flood during Monsoon.
-- Custom season day segs. A possible mod all on its own.
-- == BUGS ==
-- Make sure sleeping bags, tents, APORKALYPSE, Caves, Volcano, Skyworthy, and Seaworthy don't cause issues with changing season length when skipping a long period of days.
-- FIXED: Check if same seasons, different lengths work properly now.
-- Having brambles spawn everywhere in Huge world can end up writing too much to the save file, causing the save file to go over the 16 bit load limit and become unabled to be loaded.
-- Index to index nil value with CavesRain(). Caves load in the OG mod, so why does the game crash when the code is the same?
-- Possible tigersharker.lua issue with nonexistant actions table with onSeasonChange and onLoad when using non-SW seasons.
-- Spring has snow cover.
-- == RESEARCH ==
-- Having same type of season one after another would only speed up the sinwaves for season percentage.
--]]
forumthread = ""
api_version = 6

dont_starve_compatible = true
reign_of_giants_compatible = true
shipwrecked_compatible = true
hamlet_compatible = true

icon_atlas = "modicon.xml"
icon = "modicon.tex"

local season_options = {
							{description = "Autumn", data = "autumn"},		-- [1]
							{description = "Winter", data = "winter"},		-- [2]
							{description = "Spring", data = "spring"},		-- [3]
							{description = "Summer", data = "summer"},		-- [4]
							{description = "Mild", data = "mild"},			-- [5]		
							{description = "Hurricane", data = "wet"},	    -- [6]
							{description = "Monsoon", data = "green"},	    -- [7]
							{description = "Dry", data = "dry"},			-- [8]
							{description = "Temperate", data = "temperate"},-- [9]
							{description = "Humid", data = "humid"},		-- [10]
							{description = "Lush", data = "lush"},			-- [11]
							--{description = "Aporkalypse", data = "aporkalypse"},
							{description = "None", data = "none"},			-- [12]
							{description = "Random", data = "random"},			-- [13]
						}

local day_options = {}
for i=1, 51, 1 do
    day_options[i] = {description=(i).." Days", data=i} -- Code from Insanity Effects mod.
end

day_options[1].description = "1 Day"
day_options[5].description = "5 Days (V Short)"
day_options[10].description = "10 Days (Short)"
day_options[15].description = "15 Days (Medium)"
day_options[20].description = "20 Days (Default)"
day_options[25].description = "25 Days (Long)"
day_options[30].description = "30 Days (V Long)"
day_options[50].description = "50 Days (EX Long)"
day_options[51] = {description = "Random", data = "random"}
-- day_options[#day_options].description = "Vanilla" -- The # refers to last entry

local random_day_options = {}
for i=1, 50, 1 do
    random_day_options[i] = {description=(i).." Days", data=i}
end

random_day_options[1].description = "1 Day"
random_day_options[5].description = "5 Days (V Short)"
random_day_options[10].description = "10 Days (Short)"
random_day_options[15].description = "15 Days (Medium)"
random_day_options[20].description = "20 Days (Default)"
random_day_options[25].description = "25 Days (Long)"
random_day_options[30].description = "30 Days (V Long)"
random_day_options[50].description = "50 Days (EX Long)"

local random_offset_options = {}
for i=1, 51, 1 do
    random_offset_options[i] = {description=(i-1).." Days", data=i-1}
end

random_offset_options[1].description = "Off"
random_offset_options[2].description = "1 Day"
random_offset_options[6].description = "5 Days (V Short)"
random_offset_options[11].description = "10 Days (Short)"
random_offset_options[16].description = "15 Days (Medium)"
random_offset_options[21].description = "20 Days (Default)"
random_offset_options[26].description = "25 Days (Long)"
random_offset_options[31].description = "30 Days (V Long)"
random_offset_options[51].description = "50 Days (EX Long)"

local function ConfigSeason(id, label, default)
    return {
        name    = id,
        label   = label,
        default = default,
        options = season_options,
    }
end
local function ConfigDay(id, label, default)
    return {
        name    = id,
        label   = label,
        default = default,
        options = day_options,
    }
end
-- To add more seasons, increase the number for self.season_limit_number in seasonmanager_pork.lua
configuration_options =
{
	-- SEASON PAGE 1 --
	ConfigSeason("SEASON_1", "1º Season", season_options[3].data),
	ConfigSeason("SEASON_2", "2º Season", season_options[11].data),
	ConfigSeason("SEASON_3", "3º Season", season_options[8].data),
	ConfigSeason("SEASON_4", "4º Season", season_options[10].data),
	ConfigSeason("SEASON_5", "5º Season", season_options[8].data),
	ConfigSeason("SEASON_6", "6º Season", season_options[6].data),
	ConfigSeason("SEASON_7", "7º Season", season_options[12].data),
	ConfigDay("SEASON_1_LENGTH", "1º Season Length", day_options[10].data),
	ConfigDay("SEASON_2_LENGTH", "2º Season Length", day_options[10].data),
	ConfigDay("SEASON_3_LENGTH", "3º Season Length", day_options[10].data),
	ConfigDay("SEASON_4_LENGTH", "4º Season Length", day_options[10].data),
	ConfigDay("SEASON_5_LENGTH", "5º Season Length", day_options[10].data),
	ConfigDay("SEASON_6_LENGTH", "6º Season Length", day_options[10].data),
	ConfigDay("SEASON_7_LENGTH", "7º Season Length", day_options[10].data),

	-- SEASON PAGE 2 --
	ConfigSeason("SEASON_8", "8º Season", season_options[12].data),
	ConfigSeason("SEASON_9", "9º Season", season_options[12].data),
	ConfigSeason("SEASON_10", "10º Season", season_options[12].data),
	ConfigSeason("SEASON_11", "11º Season", season_options[12].data),
	ConfigSeason("SEASON_12", "12º Season", season_options[12].data),
	ConfigSeason("SEASON_13", "13º Season", season_options[12].data),
	ConfigSeason("SEASON_14", "14º Season", season_options[12].data),
	ConfigDay("SEASON_8_LENGTH", "8º Season Length", day_options[10].data),
	ConfigDay("SEASON_9_LENGTH", "9º Season Length", day_options[10].data),
	ConfigDay("SEASON_10_LENGTH", "10º Season Length", day_options[10].data),
	ConfigDay("SEASON_11_LENGTH", "11º Season Length", day_options[10].data),
	ConfigDay("SEASON_12_LENGTH", "12º Season Length", day_options[10].data),
	ConfigDay("SEASON_13_LENGTH", "13º Season Length", day_options[10].data),
	ConfigDay("SEASON_14_LENGTH", "14º Season Length", day_options[10].data),

	-- SEASON PAGE 3 --
	ConfigSeason("SEASON_15", "15º Season", season_options[12].data),
	ConfigSeason("SEASON_16", "16º Season", season_options[12].data),
	ConfigSeason("SEASON_17", "17º Season", season_options[12].data),
	ConfigSeason("SEASON_18", "18º Season", season_options[12].data),
	ConfigSeason("SEASON_19", "19º Season", season_options[12].data),
	ConfigSeason("SEASON_20", "20º Season", season_options[12].data),
	ConfigSeason("SEASON_21", "21º Season", season_options[12].data),
	ConfigDay("SEASON_15_LENGTH", "15º Season Length", day_options[10].data),
	ConfigDay("SEASON_16_LENGTH", "16º Season Length", day_options[10].data),
	ConfigDay("SEASON_17_LENGTH", "17º Season Length", day_options[10].data),
	ConfigDay("SEASON_18_LENGTH", "18º Season Length", day_options[10].data),
	ConfigDay("SEASON_19_LENGTH", "19º Season Length", day_options[10].data),
	ConfigDay("SEASON_20_LENGTH", "20º Season Length", day_options[10].data),
	ConfigDay("SEASON_21_LENGTH", "21º Season Length", day_options[10].data),

	-- SEASON PAGE 4 --
	ConfigSeason("SEASON_22", "22º Season", season_options[12].data),
	ConfigSeason("SEASON_23", "23º Season", season_options[12].data),
	ConfigSeason("SEASON_24", "24º Season", season_options[12].data),
	ConfigSeason("SEASON_25", "25º Season", season_options[12].data),
	ConfigSeason("SEASON_26", "26º Season", season_options[12].data),
	ConfigSeason("SEASON_27", "27º Season", season_options[12].data),
	ConfigSeason("SEASON_28", "28º Season", season_options[12].data),
	ConfigDay("SEASON_22_LENGTH", "22º Season Length", day_options[10].data),
	ConfigDay("SEASON_23_LENGTH", "23º Season Length", day_options[10].data),
	ConfigDay("SEASON_24_LENGTH", "24º Season Length", day_options[10].data),
	ConfigDay("SEASON_25_LENGTH", "25º Season Length", day_options[10].data),
	ConfigDay("SEASON_26_LENGTH", "26º Season Length", day_options[10].data),
	ConfigDay("SEASON_27_LENGTH", "27º Season Length", day_options[10].data),
	ConfigDay("SEASON_28_LENGTH", "28º Season Length", day_options[10].data),

	-- EXTRA OPTIONS PAGE 1 --
	-- The "hover" option for mod config is a DST exclusive modding feature, so its text won't appear ingame in DS. --
	
	{
		name = "BRAMBLES_EVERYWHERE",
		label = "Brambles on all biomes",
		hover = "Spawn brambles on all biomes during Lush season.",
		options =	{
						{description = "No", data = 0},
						{description = "Yes", data = 1},

					},
		default = 0,
	},

	{
		name = "RANDOM_LENGTH_MIN",
		label = "Min Random Length",
		hover = "The minimum amount of days a season can be randomized to.",
		options = random_day_options,
		default = 1,
	},

	{
		name = "RANDOM_LENGTH_MAX",
		label = "Max Random Length",
		hover = "The maximum amount of days a season can be randomized to.",
		options = random_day_options,
		default = 20,
	},

	{
		name = "RANDOM_LENGTH_OFFSET",
		label = "Random Day Offset Range",
		hover = "Randomly determine the amount of days to add/remove from a season's length",
		options = random_offset_options,
		default = 0,
	},
	{
		name = "MOD_CONFIG_SEASON_RANDOM_TITLE",
		label = "Random: Season Allowed",
		options = {
				        {description = "----", data = "----"},
				  },
		default = "----",
	},
	{
		name = "RANDOM_ALLOW_AUTUMN",
		label = "Autumn",
		hover = "Allow Autumn as a possible option to randomized to.",
		options =	{
						{description = "No", data = false},
						{description = "Yes", data = true},
					},
		default = true,
	},
	{
		name = "RANDOM_ALLOW_WINTER",
		label = "Winter",
		hover = "Allow Winter as a possible option to randomized to.",
		options =	{
						{description = "No", data = false},
						{description = "Yes", data = true},
					},
		default = true,
	},
	{
		name = "RANDOM_ALLOW_SPRING",
		label = "Spring",
		hover = "Allow Spring as a possible option to randomized to.",
		options =	{
						{description = "No", data = false},
						{description = "Yes", data = true},
					},
		default = true,
	},
	{
		name = "RANDOM_ALLOW_SUMMER",
		label = "Summer",
		hover = "Allow Summer as a possible option to randomized to.",
		options =	{
						{description = "No", data = false},
						{description = "Yes", data = true},
					},
		default = true,
	},
	{
		name = "RANDOM_ALLOW_MILD",
		label = "Mild",
		hover = "Allow Mild as a possible option to randomized to.",
		options =	{
						{description = "No", data = false},
						{description = "Yes", data = true},
					},
		default = true,
	},
	{
		name = "RANDOM_ALLOW_WET",
		label = "Hurricane",
		hover = "Allow Hurricane as a possible option to randomized to.",
		options =	{
						{description = "No", data = false},
						{description = "Yes", data = true},
					},
		default = true,
	},
	{
		name = "RANDOM_ALLOW_GREEN",
		label = "Monsoon",
		hover = "Allow Monsoon as a possible option to randomized to.",
		options =	{
						{description = "No", data = false},
						{description = "Yes", data = true},
					},
		default = true,
	},
	{
		name = "RANDOM_ALLOW_DRY",
		label = "Dry",
		hover = "Allow Dry as a possible option to randomized to.",
		options =	{
						{description = "No", data = false},
						{description = "Yes", data = true},
					},
		default = true,
	},
	{
		name = "RANDOM_ALLOW_TEMPERATE",
		label = "Temperate",
		hover = "Allow Temperate as a possible option to randomized to.",
		options =	{
						{description = "No", data = false},
						{description = "Yes", data = true},
					},
		default = true,
	},
	{
		name = "RANDOM_ALLOW_HUMID",
		label = "Humid",
		hover = "Allow Humid as a possible option to randomized to.",
		options =	{
						{description = "No", data = false},
						{description = "Yes", data = true},
					},
		default = true,
	},
	{
		name = "RANDOM_ALLOW_LUSH",
		label = "Lush",
		hover = "Allow Lush as a possible option to randomized to.",
		options =	{
						{description = "No", data = false},
						{description = "Yes", data = true},
					},
		default = true,
	},
	--[[{
		name = "RANDOM_ALLOW_APORKALYPSE",
		label = "Aporkalypse",
		hover = "Allow Aporkalypse as a possible option to randomized to.",
		options =	{
						{description = "No", data = false},
						{description = "Yes", data = true},
					},
		default = true,
	},
	]]
	{
		name = "RANDOM_ALLOW_NONE",
		label = "None",
		hover = "Allow None as a possible option to randomized to.",
		options =	{
						{description = "No", data = false},
						{description = "Yes", data = true},
					},
		default = true,
	},
}