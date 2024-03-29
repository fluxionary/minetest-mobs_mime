futil.check_version({ year = 2023, month = 11, day = 4 }) -- collision/selection box stuff

mobs_mime = fmod.create()

--
-- Constants
--

-- Used for localization
mobs_mime.l10n = minetest.get_translator("mobs_mime")

-- Spawner frequency, stated in seconds.
mobs_mime.spawnInterval = tonumber(minetest.settings:get("mobs_mime_spawn_interval")) or 60

-- Spawning chance; 1 = always, 2 = 50%, etc.
mobs_mime.spawnChance = tonumber(minetest.settings:get("mobs_mime_spawn_chance")) or 36000

-- Number of mimes per active mapchunk.
mobs_mime.AOC = tonumber(minetest.settings:get("mobs_mime_aoc")) or 1

-- Min spawn height, stated in nodes.
mobs_mime.minHeight = tonumber(minetest.settings:get("mobs_mime_min_height")) or -30912

-- Max spawn height, stated in nodes.
mobs_mime.maxHeight = tonumber(minetest.settings:get("mobs_mime_max_height")) or 31000

-- Chance that the mob will move if standing; 0 to 100
mobs_mime.moveChance = tonumber(minetest.settings:get("mobs_mime_move_chance")) or 1

-- Chance that the mob will stop if moving; 0 to 100
mobs_mime.stopChance = tonumber(minetest.settings:get("mobs_mime_stop_chance")) or 1

-- Keep the mime aligned when not moving; true or false
mobs_mime.keepAligned = minetest.settings:get_bool("mobs_mime_keep_aligned", true)

-- Chance that the mob will seem a chest
mobs_mime.chestChance = tonumber(minetest.settings:get("mobs_mime_chest_chance")) or 20

-- Time after which the mime's glue will fade away
mobs_mime.glueNodeTimeout = tonumber(minetest.settings:get("mobs_mime_glue_timeout")) or 7

--
-- Procedures
--

-- Minetest logger
local pr_LogMessage = function()
	-- Constant
	local s_LOG_LEVEL = minetest.settings:get("debug_log_level")

	-- Body
	if (s_LOG_LEVEL == nil) or (s_LOG_LEVEL == "action") or (s_LOG_LEVEL == "info") or (s_LOG_LEVEL == "verbose") then
		minetest.log("action", "[Mod] Mobs mime [v0.3.2] loaded.")
	end
end

-- Subfiles loader
local pr_LoadSubFiles = function()
	-- Constant
	local s_MOD_PATH = minetest.get_modpath("mobs_mime")

	-- Body
	dofile(s_MOD_PATH .. "/core/functions.lua")
	dofile(s_MOD_PATH .. "/core/procedures.lua")
	dofile(s_MOD_PATH .. "/core/craft_item.lua")
	dofile(s_MOD_PATH .. "/core/nodes.lua")
	dofile(s_MOD_PATH .. "/core/projectile.lua")
	dofile(s_MOD_PATH .. "/core/mob.lua")
	dofile(s_MOD_PATH .. "/core/spawning.lua")

	dofile(s_MOD_PATH .. "/glue_gun.lua")
end

--
-- Main body
--

pr_LoadSubFiles()
pr_LogMessage()
