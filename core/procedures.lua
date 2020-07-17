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

-- Used to apply a texture to the mob
mobs_mime.pr_SetTexture = function(self, a_s_position)
	local s_nodeName = mobs_mime.fn_NodeUnder(a_s_position)

	local t_nodeTexture = mobs_mime.fn_NodesTextures(s_nodeName)

	if (t_nodeTexture ~= nil) then
		self.object:set_properties({
			textures = t_nodeTexture,
			base_texture = t_nodeTexture
		})
	end
end


-- Check for free space and place a new node
mobs_mime.pr_PlaceNode = function(pos)
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

		for i_value = -a_i_offset, a_i_offset do
			v_coordinates.z = (a_v_position.z + i_value)

			mobs_mime.pr_PlaceNode(v_coordinates)
		end
	end
end
