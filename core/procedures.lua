--[[
	Mobs Mime - Adds a monster mimicking its surrounding nodes.
	Copyright © 2020 Hamlet and contributors.

	Licensed under the EUPL, Version 1.2 or – as soon they will be
	approved by the European Commission – subsequent versions of the
	EUPL (the "Licence");
	You may not use this work except in compliance with the Licence.
	You may obtain a copy of the Licence at:

	https://joinup.ec.europa.eu/software/page/eupl
	https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:32017D0863

	Unless required by applicable law or agreed to in writing,
	software distributed under the Licence is distributed on an
	"AS IS" basis,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
	implied.
	See the Licence for the specific language governing permissions
	and limitations under the Licence.

--]]


--
-- Global procedure
--

-- Used to keep the mob's rotation aligned when passive
mobs_mime.pr_SetYaw = function(a_t_mobile, a_f_yaw)
	if (a_t_mobile.state ~= 'attack') then
		a_t_mobile.object:set_yaw(a_f_yaw);
	end
end

local function is_nodelike(node_def)
	return (
		node_def.drawtype == "normal" or
		node_def.drawtype == "liquid" or
		node_def.drawtype == "flowingliquid" or
		node_def.drawtype == "glasslike" or
		node_def.drawtype == "glasslike_framed" or
		node_def.drawtype == "glasslike_framed_optional" or
		node_def.drawtype == "allfaces" or
		node_def.drawtype == "allfaces_optional"
	)
end

function mobs_mime.copy_nearby_mob(self, a_s_position)
	for _, object in ipairs(minetest.get_objects_inside_radius(a_s_position, 8)) do
		if not minetest.is_player(object) then
			local ent = object:get_luaentity()
			if ent.name ~= "mobs_mime:mime" then
				local props = object:get_properties()
				if props.physical and props.pointable and props.visual == "mesh" then
					self.object:set_properties({
						visual = "mesh",
						textures = props.textures,
						use_texture_alpha = props.use_texture_alpha,
						mesh = props.mesh,
						visual_size = props.visual_size,
					})

					self.mimicking = object
					return true
				end
			end
		end
	end
	return false
end

-- Used to apply a texture to the mob
mobs_mime.pr_SetTexture = function(self, a_s_position)
	if not self.object or not a_s_position or type(a_s_position) ~= "table" or not next(a_s_position) then
		return
	end

	if math.random(4) == 1 then
		self.object:set_properties({
			visual = "cube",
			textures = {
				'default_chest_top.png',
				'default_chest_top.png',
				'default_chest_side.png',
				'default_chest_side.png',
				'default_chest_front.png',
				'default_chest_side.png',
			},
			visual_size = {x = 1, y = 1, z = 1},
			use_texture_alpha = true,
			mesh = nil,
			itemname = nil,
		})
		self.mimicking = nil
		self.object:set_pos(vector.round(a_s_position))
		return
	end

	if mobs_mime.copy_nearby_mob(self, a_s_position) then
		return
	end

	local s_nodeName = mobs_mime.fn_NodeUnder(a_s_position)

	if not s_nodeName or (type(s_nodeName) ~= "string") or (s_nodeName == "") then
		return
	end

	local node_def = minetest.registered_nodes[s_nodeName]
	if not node_def then
		return
	end

	if is_nodelike(node_def) then
		self.object:set_properties({
			visual = "cube",
			textures = mobs_mime.fn_NodesTextures(s_nodeName),
			visual_size = {x = 1, y = 1, z = 1},
			use_texture_alpha = true,
			mesh = nil,
			itemname = nil,
		})
		self.mimicking = s_nodeName
		self.object:set_pos(vector.round(a_s_position))

	elseif node_def.drawtype == "mesh" then
		local scale = (node_def.visual_scale or 1) * 10 -- this isn't documented anywhere
		self.object:set_properties({
			visual = "mesh",
			textures = node_def.tiles,
			use_texture_alpha = true,
			mesh = node_def.mesh,
			visual_size = {x = scale, y = scale, z = scale},
			itemname = nil,
		})
		self.mimicking = s_nodeName
		self.object:set_pos(vector.round(a_s_position))

	elseif node_def.drawtype ~= "airlike" then
		local scale = 2 / 3 -- this isn't documented anywhere and seems to vary a little between drawtypes
		self.object:set_properties({
			visual = "wielditem",
			wield_item = s_nodeName,
			visual_size = {x = scale, y = scale, z = scale},
			textures = nil,
			mesh = nil,
		})
		self.mimicking = s_nodeName
		self.object:set_pos(vector.round(a_s_position))
	end
end


-- Check for free space and place a new node
mobs_mime.pr_PlaceNode = function(pos)
	if not pos or type(pos) ~= "table" or not next(pos) then return end
	local s_oldNodeName = minetest.get_node(pos).name

	if (s_oldNodeName == 'air') then
		minetest.set_node(pos, {name = 'mobs_mime:glue'})
	end
end


-- Used to place glue around the target
mobs_mime.pr_GlueRing = function(a_v_position, a_i_offset)
	local v_coordinates = {y = a_v_position.y, x = 0.0, z = 0.0}

	for i_value = -a_i_offset, a_i_offset do
		v_coordinates.x = (a_v_position.x + i_value)

		for i_value_2 = -a_i_offset, a_i_offset do
			v_coordinates.z = (a_v_position.z + i_value_2)

			mobs_mime.pr_PlaceNode(v_coordinates)
		end
	end
end
