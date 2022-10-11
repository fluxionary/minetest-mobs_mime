

--
-- Mime's sticky node
--

-- Source
minetest.register_node("mobs_mime:glue", {
	description = mobs_mime.l10n("Mime glue"),
	groups = {liquid = 1, disable_jump = 1},
	drawtype = "liquid",
	tiles = {
		{
			name = "default_water_source_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.0,
			},
		},
		{
			name = "default_water_source_animated.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.0,
			},
		},
	},
	alpha = 191,
	color = "#ff0000",
	post_effect_color = {a=191, r=60, g=40, b=80},
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	pointable = false,
	buildable_to = true,
	liquidtype = "source",
	liquid_alternative_flowing = "mobs_mime:glue_flowing",
	drowning = 1,
	liquid_viscosity = 7,
	liquid_renewable = false,

	on_construct = function(pos)
		minetest.get_node_timer(pos):start(mobs_mime.glueNodeTimeout)
	end,

	on_timer = function(pos, elapsed)
		minetest.set_node(pos, {name = "air"})
		return true
	end
})

-- Flowing glue
minetest.register_node("mobs_mime:glue_flowing", {
	description = mobs_mime.l10n("Mime glue flowing"),
	groups = {liquid = 1, disable_jump = 1},
	drawtype = "flowingliquid",
	tiles = {"default_water_source_animated.png"},
	special_tiles = {
		{
			name = "default_water_source_animated.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.0,
			},
		},
		{
			name = "default_water_source_animated.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.0,
			},
		},
	},
	alpha = 191,
	color = "#ff0000",
	post_effect_color = {a=191, r=60, g=40, b=80},
	paramtype = "light",
	paramtype2 = "flowingliquid",
	is_ground_content = false,
	walkable = false,
	pointable = false,
	buildable_to = true,
	liquidtype = "flowing",
	liquid_alternative_flowing = "mobs_mime:glue_flowing",
	liquid_alternative_source = "mobs_mime:glue",
	liquid_range = 4,
	drowning = 1,
	liquid_viscosity = 7,
	liquid_renewable = false,

	on_construct = function(pos)
		minetest.get_node_timer(pos):start(mobs_mime.glueNodeTimeout)
	end,

	on_timer = function(pos, elapsed)
		minetest.set_node(pos, {name = "air"})
		return true
	end
})
