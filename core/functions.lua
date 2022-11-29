--
-- Global function
--

mobs_mime.fn_NodeUnder = function(a_v_position)
	if not a_v_position or (type(a_v_position) ~= "table") or (not next(a_v_position)) then
		return
	end
	local v_position = vector.round(a_v_position)

	local v_difference = { x = 0, y = 5, z = 0 }
	local v_target = vector.subtract(v_position, v_difference)

	local r_pointed = minetest.raycast(v_position, v_target, false, false)
	local u_thing = r_pointed:next()

	while u_thing do
		if u_thing.type == "node" then
			return minetest.get_node(u_thing.under).name
		end

		u_thing = r_pointed:next()
	end
end

local function simplify(tiles)
	local simple = {}
	for _, tile in ipairs(tiles) do
		if type(tile) == "table" then
			table.insert(simple, tile.name)
		else
			table.insert(simple, tile)
		end
	end

	return simple
end

mobs_mime.fn_NodesTextures = function(node_name)
	if not node_name then
		return
	end

	local node_def = minetest.registered_nodes[node_name]

	if not (node_def and node_def.tiles and #node_def.tiles > 0) then
		return
	end

	local textures
	local tiles = simplify(node_def.tiles)

	if #tiles == 1 or node_def.drawtype == "glasslike_framed" or node_def.drawtype == "glasslike_framed_optional" then
		textures = {
			tiles[1],
			tiles[1],
			tiles[1],
			tiles[1],
			tiles[1],
			tiles[1],
		}
	elseif #tiles == 2 then
		textures = {
			tiles[1],
			tiles[2],
			tiles[1],
			tiles[1],
			tiles[1],
			tiles[1],
		}
	elseif #tiles == 3 then
		textures = {
			tiles[1],
			tiles[2],
			tiles[3],
			tiles[3],
			tiles[3],
			tiles[3],
		}
	elseif #tiles == 4 then
		textures = {
			tiles[1],
			tiles[2],
			tiles[3],
			tiles[4],
			tiles[3],
			tiles[4],
		}
	elseif #tiles == 5 then
		textures = {
			tiles[1],
			tiles[2],
			tiles[3],
			tiles[4],
			tiles[5],
			tiles[4],
		}
	else
		textures = {
			tiles[1],
			tiles[2],
			tiles[3],
			tiles[4],
			tiles[5],
			tiles[6],
		}
	end

	return textures
end
