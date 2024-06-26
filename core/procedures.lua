local yaw_tolerance = 0.01

--
-- Global procedure
--
-- Used to keep the mob's rotation aligned when passive
function mobs_mime.fix_yaw(self)
	if (not mobs_mime.keepAligned) or self.state == "attack" then
		return
	end

	local yaw = self.object:get_yaw()
	if not yaw then
		return
	end

	local yaw_i = yaw * (2 / math.pi)
	local yaw_j = math.round(yaw_i)

	if math.abs(yaw_i - yaw_j) > yaw_tolerance then
		local new_yaw = (math.pi / 2) * yaw_j

		self.object:set_yaw(new_yaw)
		self.target_yaw = new_yaw
		self.delay = 0
	end
end

local offsets = {
	vector.new(0, -1, 0),
	vector.new(0, 1, 0),
	vector.new(-1, 0, 0),
	vector.new(1, 0, 0),
	vector.new(0, 0, -1),
	vector.new(0, 0, 1),
	vector.new(-1, -1, 0),
	vector.new(-1, 1, 0),
	vector.new(1, -1, 0),
	vector.new(1, 1, 0),
	vector.new(-1, 0, -1),
	vector.new(-1, 0, 1),
	vector.new(1, 0, -1),
	vector.new(1, 0, 1),
	vector.new(0, -1, -1),
	vector.new(0, -1, 1),
	vector.new(0, 1, -1),
	vector.new(0, 1, 1),
	vector.new(-1, -1, -1),
	vector.new(-1, -1, 1),
	vector.new(-1, 1, -1),
	vector.new(-1, 1, 1),
	vector.new(1, -1, -1),
	vector.new(1, -1, 1),
	vector.new(1, 1, -1),
	vector.new(1, 1, 1),
}

function mobs_mime.in_a_wall(self, pos)
	local collisionbox = self.object:get_properties().collisionbox
	for i = 1, #collisionbox do
		collisionbox[i] = collisionbox[i] * 0.90
	end

	for i = 1, 4, 3 do
		for j = 2, 5, 3 do
			for k = 3, 6, 3 do
				local edge = vector.new(collisionbox[i], collisionbox[j], collisionbox[k])
				local node_pos = vector.round(edge + pos)
				local node = minetest.get_node(node_pos)
				local def = minetest.registered_nodes[node.name]

				if (not def) or (def.drawtype == "normal" and def.walkable) then
					return true
				end
			end
		end
	end

	return false
end

function mobs_mime.escape_a_wall(self)
	local pos = self.object:get_pos()

	for _, offset in ipairs(offsets) do
		local p2 = pos + offset
		if not (mobs_mime.in_a_wall(self, p2) or minetest.is_protected(p2, "mobs_mime:mime")) then
			self.object:set_pos(p2)
			return true
		end
	end

	return false
end

local function is_nodelike(node_def)
	return (
		node_def.drawtype == "normal"
		or node_def.drawtype == "liquid"
		or node_def.drawtype == "flowingliquid"
		or node_def.drawtype == "glasslike"
		or node_def.drawtype == "glasslike_framed"
		or node_def.drawtype == "glasslike_framed_optional"
		or node_def.drawtype == "allfaces"
		or node_def.drawtype == "allfaces_optional"
	)
end

function mobs_mime.copy_nearby_mob(self)
	local pos = self.object:get_pos()

	for _, object in ipairs(minetest.get_objects_inside_radius(pos, 8)) do
		if not futil.is_player(object) then
			local ent = object:get_luaentity()
			if ent and ent.name ~= "mobs_mime:mime" then
				local props = object:get_properties()
				local cb = props.collisionbox
				local valid_collisionbox = (cb[1] ~= cb[4]) and (cb[2] ~= cb[5]) and (cb[3] ~= cb[6])
				if props.physical and props.pointable and props.visual == "mesh" and valid_collisionbox then
					if self.mimicking == object then
						return true
					end

					self.mimicking = object

					self.object:set_properties({
						visual = "mesh",
						textures = props.textures,
						use_texture_alpha = props.use_texture_alpha,
						mesh = props.mesh,
						visual_size = props.visual_size,
						collisionbox = props.collisionbox,
						selectionbox = props.selectionbox,
					})

					if mobs_mime.in_a_wall(self, pos) then
						-- some entities have so large collisionboxes that mimes can't escape with escape_a_wall()
						-- avoid them from glitching too deep into the ground
						pos.y = math.round(pos.y) - 0.5 - cb[2]
						self.object:set_pos(pos)
					end

					self.walk_velocity = ent.walk_velocity
					self.randomly_turn = ent.randomly_turn
					self.stand_chance = ent.stand_chance
					self.walk_chance = (ent.walk_chance or 0) > 0 and ent.walk_chance or mobs_mime.moveChance
					self.jump = ent.jump
					self.jump_height = ent.jump_height
					self.stepheight = ent.stepheight
					self.fear_height = ent.fear_height
					self.floats = ent.floats
					local fly_in = { "mobs_mime:glue", "mobs_mime:glue_flowing" }
					if ent.fly_in then
						if type(ent.fly_in) == "table" then
							table.insert_all(fly_in, ent.fly_in)
						else
							table.insert(fly_in, ent.fly_in)
						end
					end
					self.fly_in = fly_in

					return true
				end
			end
		end
	end
	return false
end

-- Used to apply a texture to the mob
mobs_mime.pr_SetTexture = function(self)
	if not self.object then
		return
	end

	local pos = self.object:get_pos()

	if not pos then
		return
	end

	if mobs_mime.copy_nearby_mob(self) then
		return
	end

	if math.random(mobs_mime.chestChance) == 1 then
		self.object:set_properties({
			visual = "cube",
			textures = mobs_mime.get_chest_textures(),
			visual_size = { x = 1, y = 1, z = 1 },
			collisionbox = { -0.5, -0.5, -0.5, 0.5, 0.5, 0.5 },
			selectionbox = { -0.5, -0.5, -0.5, 0.5, 0.5, 0.5, rotate = true },
			use_texture_alpha = false,
			mesh = nil,
			itemname = nil,
		})
		self.mimicking = nil
		self.object:set_pos(vector.round(pos))
		return
	end

	local s_nodeName = mobs_mime.fn_NodeUnder(pos)

	if not s_nodeName or (type(s_nodeName) ~= "string") or (s_nodeName == "") then
		return
	end

	local node_def = minetest.registered_nodes[s_nodeName]
	if not node_def then
		return
	end

	local use_texture_alpha = node_def.use_texture_alpha == "clip" or node_def.use_texture_alpha == "blend"

	if is_nodelike(node_def) then
		local textures = mobs_mime.fn_NodesTextures(s_nodeName)
		if textures then
			self.object:set_properties({
				visual = "cube",
				textures = textures,
				visual_size = { x = 1, y = 1, z = 1 },
				collisionbox = { -0.5, -0.5, -0.5, 0.5, 0.5, 0.5 },
				selectionbox = { -0.5, -0.5, -0.5, 0.5, 0.5, 0.5, rotate = true },
				use_texture_alpha = use_texture_alpha,
			})
			self.mimicking = s_nodeName
			self.object:set_pos(vector.round(pos))
			mobs_mime.fix_yaw(self)
		end
	elseif node_def.drawtype == "mesh" then
		local scale = (node_def.visual_scale or 1) * 10 -- this isn't documented anywhere
		self.object:set_properties({
			visual = "mesh",
			textures = node_def.tiles,
			use_texture_alpha = use_texture_alpha,
			mesh = node_def.mesh,
			collisionbox = futil.node_collision_box_to_object_collisionbox(node_def.collision_box),
			selectionbox = futil.node_selection_box_to_object_selectionbox(node_def.selection_box, true),
			visual_size = { x = scale, y = scale, z = scale },
		})
		self.mimicking = s_nodeName
		self.object:set_pos(vector.round(pos))
		mobs_mime.fix_yaw(self)
	elseif node_def.drawtype == "plantlike" then
		local scale = (node_def.visual_scale or 1) * 10
		self.object:set_properties({
			visual = "mesh",
			textures = { node_def.tiles[1] },
			use_texture_alpha = use_texture_alpha,
			mesh = "mobs_mime_plantlike.obj",
			collisionbox = futil.node_collision_box_to_object_collisionbox(node_def.collision_box),
			selectionbox = futil.node_selection_box_to_object_selectionbox(node_def.selection_box, true),
			visual_size = { x = scale, y = scale, z = scale },
		})
		self.mimicking = s_nodeName
		self.object:set_pos(vector.round(pos))
		mobs_mime.fix_yaw(self)
	elseif node_def.drawtype ~= "airlike" then
		-- https://github.com/minetest/minetest/blob/176e674a51bb27f3c239dd217214dca0a2f2a1d1/doc/lua_api.md?plain=1#L8433
		local scale = 2 / 3
		self.object:set_properties({
			visual = "wielditem",
			wield_item = s_nodeName,
			visual_size = { x = scale, y = scale, z = scale },
		})
		self.mimicking = s_nodeName
		self.object:set_pos(vector.round(pos))
		mobs_mime.fix_yaw(self)
	end
end

-- Check for free space and place a new node
mobs_mime.pr_PlaceNode = function(pos)
	if not pos or type(pos) ~= "table" or not next(pos) then
		return
	end
	local s_oldNodeName = minetest.get_node(pos).name

	if s_oldNodeName == "air" then
		minetest.set_node(pos, { name = "mobs_mime:glue" })
	end
end

-- Used to place glue around the target
mobs_mime.pr_GlueRing = function(pos, radius)
	local gpos = { y = 0, x = 0, z = 0 }

	for x = -radius, radius do
		gpos.x = pos.x + x

		for y = -radius, radius do
			gpos.y = pos.y + y

			for z = -radius, radius do
				gpos.z = pos.z + z

				mobs_mime.pr_PlaceNode(gpos)
			end
		end
	end
end
