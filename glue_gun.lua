minetest.register_tool("mobs_mime:glue_gun", {
	description = "glue gun (shoot glue projectile)",
	short_description = "glue gun",
	inventory_image = "default_stick.png",
	groups = { not_in_creative_inventory = 1 },
	on_use = function(itemstack, user, pointed_thing)
		if not minetest.is_player(user) then
			return
		end

		local pos = user:get_pos()
		local dir = user:get_look_dir()
		local vel = user:get_velocity()

		local epos = vector.add(pos, vector.add({ x = 0, y = 1, z = 0 }, vector.multiply(dir, 2)))

		local obj = minetest.add_entity(epos, "mobs_mime:glue_arrow")
		obj:set_velocity(vector.add(vel, vector.multiply(dir, 18)))

		local ent = obj:get_luaentity()
		ent.switch = 1

		local yaw = user:get_look_horizontal()
		obj:set_yaw(yaw + math.pi / 2)
	end,
})
