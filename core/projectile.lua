--
-- Mob's projectile
--

mobs:register_arrow("mobs_mime:glue_arrow", {
	visual = "sprite",
	visual_size = { x = 0.5, y = 0.5 },
	textures = { "mobs_mime_projectile.png" },
	velocity = 18, -- Nodes per second
	physical = true,
	collide_with_objects = true,

	on_step = function(self, dtime, moveresult)
		self.timer = self.timer + dtime
		if self.timer > self.lifetime then
			self.object:remove()
			return
		end

		local pos = self.object:get_pos()

		minetest.add_particle({
			pos = pos,
			velocity = { x = 0, y = 0, z = 0 },
			acceleration = { x = 0, y = 0, z = 0 },
			expirationtime = 0.125 or 0.25,
			collisiondetection = false,
			texture = "mobs_mime_projectile.png",
			size = 1.25,
			glow = 0,
		})

		for _, collision in ipairs(moveresult.collisions) do
			local cpos
			if collision.type == "node" then
				local node = minetest.get_node(collision.node_pos)
				if node.name == "air" or node.name == "ignore" or not minetest.registered_nodes[node.name] then
					self.object:remove()
					return
				end

				cpos = collision.node_pos
			elseif collision.type == "object" then
				cpos = collision.object:get_pos()
			end

			if cpos then
				mobs_mime.pr_GlueRing(cpos, 1)
				self.object:remove()
				return
			end
		end

		self.lastpos = pos
	end,
})
