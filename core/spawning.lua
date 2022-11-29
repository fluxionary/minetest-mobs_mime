--
-- Mob's spawner
--

mobs:spawn({
	name = "mobs_mime:mime",
	nodes = {
		"group:crumbly",
		"group:cracky",
		"group:stone",
		"group:tree",
		"group:wood",
		"group:leaves",
	},
	interval = mobs_mime.spawnInterval, -- Seconds
	chance = mobs_mime.spawnChance, -- Chance: 1 = always, 2 = 50%, etc.
	min_light = 0,
	max_light = 5, -- Dim light and below
	min_height = mobs_mime.minHeight, -- World's bottom
	max_height = mobs_mime.maxHeight, -- World's top
	active_object_count = mobs_mime.AOC, -- 1 mob per active map area
	day_toggle = false, -- Spawn regardless of nighttime or nighttime
})

-- Spawn Egg

mobs:register_egg("mobs_mime:mime", mobs_mime.l10n("Mime"), "default_chest_front.png")

--
-- Alias
--

mobs:alias_mob("mobs:mime", "mobs_mime:mime")
