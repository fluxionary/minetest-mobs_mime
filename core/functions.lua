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
-- Global function
--


-- Used to detect the node upon wich the mob has been spawned
mobs_mime.fn_NodeUnder = function(a_v_position)
	local s_nodeName = ''
	local v_position = a_v_position

	v_position.y = (v_position.y - 1)
	s_nodeName = minetest.get_node(v_position).name

	return s_nodeName
end


-- Used to apply the texture of the aforementioned node
mobs_mime.fn_NodesTextures = function(a_s_nodename)
	local s_nodeTextures = ''

	if (a_s_nodename == 'default:stone') then
		s_nodeTextures = {
			'default_stone.png',
			'default_stone.png',
			'default_stone.png',
			'default_stone.png',
			'default_stone.png',
			'default_stone.png'
		}

	elseif (a_s_nodename == 'default:cobble') then
		s_nodeTextures = {
			'default_cobble.png',
			'default_cobble.png',
			'default_cobble.png',
			'default_cobble.png',
			'default_cobble.png',
			'default_cobble.png'
		}

	elseif (a_s_nodename == 'default:stonebrick') then
		s_nodeTextures = {
			'default_stone_brick.png',
			'default_stone_brick.png',
			'default_stone_brick.png',
			'default_stone_brick.png',
			'default_stone_brick.png',
			'default_stone_brick.png'
		}

	elseif (a_s_nodename == 'default:stone_block') then
		s_nodeTextures = {
			'default_stone_block.png',
			'default_stone_block.png',
			'default_stone_block.png',
			'default_stone_block.png',
			'default_stone_block.png',
			'default_stone_block.png'
		}

	elseif (a_s_nodename == 'default:mossycobble') then
		s_nodeTextures = {
			'default_mossycobble.png',
			'default_mossycobble.png',
			'default_mossycobble.png',
			'default_mossycobble.png',
			'default_mossycobble.png',
			'default_mossycobble.png'
		}

	elseif (a_s_nodename == 'default:desert_stone') then
		s_nodeTextures = {
			'default_desert_stone.png',
			'default_desert_stone.png',
			'default_desert_stone.png',
			'default_desert_stone.png',
			'default_desert_stone.png',
			'default_desert_stone.png'
		}

	elseif (a_s_nodename == 'default:desert_cobble') then
		s_nodeTextures = {
			'default_desert_cobble.png',
			'default_desert_cobble.png',
			'default_desert_cobble.png',
			'default_desert_cobble.png',
			'default_desert_cobble.png',
			'default_desert_cobble.png'
		}

	elseif (a_s_nodename == 'default:desert_stonebrick') then
		s_nodeTextures = {
			'default_desert_stone_brick.png',
			'default_desert_stone_brick.png',
			'default_desert_stone_brick.png',
			'default_desert_stone_brick.png',
			'default_desert_stone_brick.png',
			'default_desert_stone_brick.png'
		}

	elseif (a_s_nodename == 'default:desert_stone_block') then
		s_nodeTextures = {
			'default_desert_stone_block.png',
			'default_desert_stone_block.png',
			'default_desert_stone_block.png',
			'default_desert_stone_block.png',
			'default_desert_stone_block.png',
			'default_desert_stone_block.png'
		}

	elseif (a_s_nodename == 'default:sandstone') then
		s_nodeTextures = {
			'default_sandstone.png',
			'default_sandstone.png',
			'default_sandstone.png',
			'default_sandstone.png',
			'default_sandstone.png',
			'default_sandstone.png'
		}

	elseif (a_s_nodename == 'default:sandstonebrick') then
		s_nodeTextures = {
			'default_sandstone_brick.png',
			'default_sandstone_brick.png',
			'default_sandstone_brick.png',
			'default_sandstone_brick.png',
			'default_sandstone_brick.png',
			'default_sandstone_brick.png'
		}

	elseif (a_s_nodename == 'default:sandstone_block') then
		s_nodeTextures = {
			'default_sandstone_block.png',
			'default_sandstone_block.png',
			'default_sandstone_block.png',
			'default_sandstone_block.png',
			'default_sandstone_block.png',
			'default_sandstone_block.png'
		}

	elseif (a_s_nodename == 'default:desert_sandstone') then
		s_nodeTextures = {
			'default_desert_sandstone.png',
			'default_desert_sandstone.png',
			'default_desert_sandstone.png',
			'default_desert_sandstone.png',
			'default_desert_sandstone.png',
			'default_desert_sandstone.png'
		}

	elseif (a_s_nodename == 'default:desert_sandstone_brick') then
		s_nodeTextures = {
			'default_desert_sandstone_brick.png',
			'default_desert_sandstone_brick.png',
			'default_desert_sandstone_brick.png',
			'default_desert_sandstone_brick.png',
			'default_desert_sandstone_brick.png',
			'default_desert_sandstone_brick.png'
		}

	elseif (a_s_nodename == 'default:desert_sandstone_block') then
		s_nodeTextures = {
			'default_desert_sandstone_block.png',
			'default_desert_sandstone_block.png',
			'default_desert_sandstone_block.png',
			'default_desert_sandstone_block.png',
			'default_desert_sandstone_block.png',
			'default_desert_sandstone_block.png'
		}

	elseif (a_s_nodename == 'default:silver_sandstone') then
		s_nodeTextures = {
			'default_silver_sandstone.png',
			'default_silver_sandstone.png',
			'default_silver_sandstone.png',
			'default_silver_sandstone.png',
			'default_silver_sandstone.png',
			'default_silver_sandstone.png'
		}

	elseif (a_s_nodename == 'default:silver_sandstone_brick') then
		s_nodeTextures = {
			'default_silver_sandstone_brick.png',
			'default_silver_sandstone_brick.png',
			'default_silver_sandstone_brick.png',
			'default_silver_sandstone_brick.png',
			'default_silver_sandstone_brick.png',
			'default_silver_sandstone_brick.png'
		}

	elseif (a_s_nodename == 'default:silver_sandstone_block') then
		s_nodeTextures = {
			'default_silver_sandstone_block.png',
			'default_silver_sandstone_block.png',
			'default_silver_sandstone_block.png',
			'default_silver_sandstone_block.png',
			'default_silver_sandstone_block.png',
			'default_silver_sandstone_block.png'
		}

	elseif (a_s_nodename == 'default:obsidian') then
		s_nodeTextures = {
			'default_obsidian.png',
			'default_obsidian.png',
			'default_obsidian.png',
			'default_obsidian.png',
			'default_obsidian.png',
			'default_obsidian.png'
		}

	elseif (a_s_nodename == 'default:obsidianbrick') then
		s_nodeTextures = {
			'default_obsidian_brick.png',
			'default_obsidian_brick.png',
			'default_obsidian_brick.png',
			'default_obsidian_brick.png',
			'default_obsidian_brick.png',
			'default_obsidian_brick.png'
		}

	elseif (a_s_nodename == 'default:obsidian_block') then
		s_nodeTextures = {
			'default_obsidian_block.png',
			'default_obsidian_block.png',
			'default_obsidian_block.png',
			'default_obsidian_block.png',
			'default_obsidian_block.png',
			'default_obsidian_block.png'
		}

	elseif (a_s_nodename == 'default:dirt') then
		s_nodeTextures = {
			'default_dirt.png',
			'default_dirt.png',
			'default_dirt.png',
			'default_dirt.png',
			'default_dirt.png',
			'default_dirt.png'
		}

	elseif (a_s_nodename == 'default:dirt_with_grass') then
		s_nodeTextures = {
			'default_grass.png', 'default_dirt.png',
			'default_dirt.png^default_grass_side.png',
			'default_dirt.png^default_grass_side.png',
			'default_dirt.png^default_grass_side.png',
			'default_dirt.png^default_grass_side.png'
		}

	elseif (a_s_nodename == 'default:dirt_with_grass_footsteps') then
		s_nodeTextures = {
			'default_grass.png^default_footprint.png', 'default_dirt.png',
			'default_dirt.png^default_grass_side.png',
			'default_dirt.png^default_grass_side.png',
			'default_dirt.png^default_grass_side.png',
			'default_dirt.png^default_grass_side.png'
		}

	elseif (a_s_nodename == 'default:dirt_with_dry_grass') then
		s_nodeTextures = {
			'default_dry_grass.png', 'default_dirt.png',
			'default_dirt.png^default_dry_grass_side.png',
			'default_dirt.png^default_dry_grass_side.png',
			'default_dirt.png^default_dry_grass_side.png',
			'default_dirt.png^default_dry_grass_side.png'
		}

	elseif (a_s_nodename == 'default:dirt_with_snow') then
		s_nodeTextures = {
			'default_snow.png', 'default_dirt.png',
			'default_dirt.png^default_snow_side.png',
			'default_dirt.png^default_snow_side.png',
			'default_dirt.png^default_snow_side.png',
			'default_dirt.png^default_snow_side.png'
		}

	elseif (a_s_nodename == 'default:dirt_with_rainforest_litter') then
		s_nodeTextures = {
			'default_rainforest_litter.png', 'default_dirt.png',
			'default_dirt.png^default_rainforest_litter_side.png',
			'default_dirt.png^default_rainforest_litter_side.png',
			'default_dirt.png^default_rainforest_litter_side.png',
			'default_dirt.png^default_rainforest_litter_side.png'
		}

	elseif (a_s_nodename == 'default:dirt_with_coniferous_litter') then
		s_nodeTextures = {
			'default_coniferous_litter.png', 'default_dirt.png',
			'default_dirt.png^default_coniferous_litter_side.png',
			'default_dirt.png^default_coniferous_litter_side.png',
			'default_dirt.png^default_coniferous_litter_side.png',
			'default_dirt.png^default_coniferous_litter_side.png'
		}

	elseif (a_s_nodename == 'default:dry_dirt') then
		s_nodeTextures = {
			'default_dry_dirt.png',
			'default_dry_dirt.png',
			'default_dry_dirt.png',
			'default_dry_dirt.png',
			'default_dry_dirt.png',
			'default_dry_dirt.png'
		}

	elseif (a_s_nodename == 'default:dry_dirt_with_dry_grass') then
		s_nodeTextures = {
			'default_dry_grass.png', 'default_dry_dirt.png',
			'default_dry_dirt.png^default_dry_grass_side.png',
			'default_dry_dirt.png^default_dry_grass_side.png',
			'default_dry_dirt.png^default_dry_grass_side.png',
			'default_dry_dirt.png^default_dry_grass_side.png'
		}

	elseif (a_s_nodename == 'default:permafrost') then
		s_nodeTextures = {
			'default_permafrost.png',
			'default_permafrost.png',
			'default_permafrost.png',
			'default_permafrost.png',
			'default_permafrost.png',
			'default_permafrost.png'
		}

	elseif (a_s_nodename == 'default:permafrost_with_stones') then
		s_nodeTextures = {
			'default_permafrost.png^default_stones.png',
			'default_permafrost.png',
			'default_permafrost.png^default_stones_side.png',
			'default_permafrost.png^default_stones_side.png',
			'default_permafrost.png^default_stones_side.png',
			'default_permafrost.png^default_stones_side.png'
		}

	elseif (a_s_nodename == 'default:permafrost_with_moss') then
		s_nodeTextures = {
			'default_moss.png', 'default_permafrost.png',
			'default_permafrost.png^default_moss_side.png',
			'default_permafrost.png^default_moss_side.png',
			'default_permafrost.png^default_moss_side.png',
			'default_permafrost.png^default_moss_side.png'
		}

	elseif (a_s_nodename == 'default:sand') then
		s_nodeTextures = {
			'default_sand.png',
			'default_sand.png',
			'default_sand.png',
			'default_sand.png',
			'default_sand.png',
			'default_sand.png'
		}

	elseif (a_s_nodename == 'default:desert_sand') then
		s_nodeTextures = {
			'default_desert_sand.png',
			'default_desert_sand.png',
			'default_desert_sand.png',
			'default_desert_sand.png',
			'default_desert_sand.png',
			'default_desert_sand.png'
		}

	elseif (a_s_nodename == 'default:silver_sand') then
		s_nodeTextures = {
			'default_silver_sand.png',
			'default_silver_sand.png',
			'default_silver_sand.png',
			'default_silver_sand.png',
			'default_silver_sand.png',
			'default_silver_sand.png'
		}

	elseif (a_s_nodename == 'default:gravel') then
		s_nodeTextures = {
			'default_gravel.png',
			'default_gravel.png',
			'default_gravel.png',
			'default_gravel.png',
			'default_gravel.png',
			'default_gravel.png'
		}

	elseif (a_s_nodename == 'default:clay') then
		s_nodeTextures = {
			'default_clay.png',
			'default_clay.png',
			'default_clay.png',
			'default_clay.png',
			'default_clay.png',
			'default_clay.png'
		}

	elseif (a_s_nodename == 'default:snow') then
		s_nodeTextures = {
			'default_snow.png',
			'default_snow.png',
			'default_snow.png',
			'default_snow.png',
			'default_snow.png',
			'default_snow.png'
		}

	elseif (a_s_nodename == 'default:snowblock') then
		s_nodeTextures = {
			'default_snow.png',
			'default_snow.png',
			'default_snow.png',
			'default_snow.png',
			'default_snow.png',
			'default_snow.png'
		}

	elseif (a_s_nodename == 'default:ice') then
		s_nodeTextures = {
			'default_ice.png',
			'default_ice.png',
			'default_ice.png',
			'default_ice.png',
			'default_ice.png',
			'default_ice.png'
		}

	elseif (a_s_nodename == 'default:cave_ice') then
		s_nodeTextures = {
			'default_ice.png',
			'default_ice.png',
			'default_ice.png',
			'default_ice.png',
			'default_ice.png',
			'default_ice.png'
		}

	elseif (a_s_nodename == 'default:tree') then
		s_nodeTextures = {
			'default_tree_top.png', 'default_tree_top.png',
			'default_tree.png', 'default_tree.png',
			'default_tree.png', 'default_tree.png'
		}

	elseif (a_s_nodename == 'default:wood') then
		s_nodeTextures = {
			'default_wood.png',
			'default_wood.png',
			'default_wood.png',
			'default_wood.png',
			'default_wood.png',
			'default_wood.png'
		}

	elseif (a_s_nodename == 'default:leaves') then
		s_nodeTextures = {
			'default_leaves.png',
			'default_leaves.png',
			'default_leaves.png',
			'default_leaves.png',
			'default_leaves.png',
			'default_leaves.png'
		}

	elseif (a_s_nodename == 'default:jungletree') then
		s_nodeTextures = {
			'default_jungletree_top.png', 'default_jungletree_top.png',
			'default_jungletree.png', 'default_jungletree.png',
			'default_jungletree.png', 'default_jungletree.png'
		}

	elseif (a_s_nodename == 'default:junglewood') then
		s_nodeTextures = {
			'default_junglewood.png',
			'default_junglewood.png',
			'default_junglewood.png',
			'default_junglewood.png',
			'default_junglewood.png',
			'default_junglewood.png'
		}

	elseif (a_s_nodename == 'default:jungleleaves') then
		s_nodeTextures = {
			'default_jungleleaves.png',
			'default_jungleleaves.png',
			'default_jungleleaves.png',
			'default_jungleleaves.png',
			'default_jungleleaves.png',
			'default_jungleleaves.png'
		}

	elseif (a_s_nodename == 'default:pine_tree') then
		s_nodeTextures = {
			'default_pine_tree_top.png', 'default_pine_tree_top.png',
			'default_pine_tree.png', 'default_pine_tree.png',
			'default_pine_tree.png', 'default_pine_tree.png'
		}

	elseif (a_s_nodename == 'default:pine_wood') then
		s_nodeTextures = {
			'default_pine_wood.png',
			'default_pine_wood.png',
			'default_pine_wood.png',
			'default_pine_wood.png',
			'default_pine_wood.png',
			'default_pine_wood.png'
		}

	elseif (a_s_nodename == 'default:pine_needles') then
		s_nodeTextures = {
			'default_pine_needles.png',
			'default_pine_needles.png',
			'default_pine_needles.png',
			'default_pine_needles.png',
			'default_pine_needles.png',
			'default_pine_needles.png'
		}

	elseif (a_s_nodename == 'default:acacia_tree') then
		s_nodeTextures = {
			'default_acacia_tree_top.png', 'default_acacia_tree_top.png',
			'default_acacia_tree.png', 'default_acacia_tree.png',
			'default_acacia_tree.png', 'default_acacia_tree.png'
		}

	elseif (a_s_nodename == 'default:acacia_wood') then
		s_nodeTextures = {
			'default_acacia_wood.png',
			'default_acacia_wood.png',
			'default_acacia_wood.png',
			'default_acacia_wood.png',
			'default_acacia_wood.png',
			'default_acacia_wood.png'
		}

	elseif (a_s_nodename == 'default:acacia_leaves') then
		s_nodeTextures = {
			'default_acacia_leaves.png',
			'default_acacia_leaves.png',
			'default_acacia_leaves.png',
			'default_acacia_leaves.png',
			'default_acacia_leaves.png',
			'default_acacia_leaves.png'
		}

	elseif (a_s_nodename == 'default:aspen_tree') then
		s_nodeTextures = {
			'default_aspen_tree_top.png', 'default_aspen_tree_top.png',
			'default_aspen_tree.png', 'default_aspen_tree.png',
			'default_aspen_tree.png', 'default_aspen_tree.png'
		}

	elseif (a_s_nodename == 'default:aspen_wood') then
		s_nodeTextures = {
			'default_aspen_wood.png',
			'default_aspen_wood.png',
			'default_aspen_wood.png',
			'default_aspen_wood.png',
			'default_aspen_wood.png',
			'default_aspen_wood.png'
		}

	elseif (a_s_nodename == 'default:aspen_leaves') then
		s_nodeTextures = {
			'default_aspen_leaves.png',
			'default_aspen_leaves.png',
			'default_aspen_leaves.png',
			'default_aspen_leaves.png',
			'default_aspen_leaves.png',
			'default_aspen_leaves.png'
		}

	elseif (a_s_nodename == 'default:stone_with_coal') then
		s_nodeTextures = {
			'default_stone.png^default_mineral_coal.png',
			'default_stone.png^default_mineral_coal.png',
			'default_stone.png^default_mineral_coal.png',
			'default_stone.png^default_mineral_coal.png',
			'default_stone.png^default_mineral_coal.png',
			'default_stone.png^default_mineral_coal.png'
		}

	elseif (a_s_nodename == 'default:coalblock') then
		s_nodeTextures = {
			'default_coal_block.png',
			'default_coal_block.png',
			'default_coal_block.png',
			'default_coal_block.png',
			'default_coal_block.png',
			'default_coal_block.png'
		}

	elseif (a_s_nodename == 'default:stone_with_iron') then
		s_nodeTextures = {
			'default_stone.png^default_mineral_iron.png',
			'default_stone.png^default_mineral_iron.png',
			'default_stone.png^default_mineral_iron.png',
			'default_stone.png^default_mineral_iron.png',
			'default_stone.png^default_mineral_iron.png',
			'default_stone.png^default_mineral_iron.png'
		}

	elseif (a_s_nodename == 'default:steelblock') then
		s_nodeTextures = {
			'default_steel_block.png',
			'default_steel_block.png',
			'default_steel_block.png',
			'default_steel_block.png',
			'default_steel_block.png',
			'default_steel_block.png'
		}

	elseif (a_s_nodename == 'default:stone_with_copper') then
		s_nodeTextures = {
			'default_stone.png^default_mineral_copper.png',
			'default_stone.png^default_mineral_copper.png',
			'default_stone.png^default_mineral_copper.png',
			'default_stone.png^default_mineral_copper.png',
			'default_stone.png^default_mineral_copper.png',
			'default_stone.png^default_mineral_copper.png'
		}

	elseif (a_s_nodename == 'default:copperblock') then
		s_nodeTextures = {
			'default_copper_block.png',
			'default_copper_block.png',
			'default_copper_block.png',
			'default_copper_block.png',
			'default_copper_block.png',
			'default_copper_block.png'
		}

	elseif (a_s_nodename == 'default:stone_with_tin') then
		s_nodeTextures = {
			'default_stone.png^default_mineral_tin.png',
			'default_stone.png^default_mineral_tin.png',
			'default_stone.png^default_mineral_tin.png',
			'default_stone.png^default_mineral_tin.png',
			'default_stone.png^default_mineral_tin.png',
			'default_stone.png^default_mineral_tin.png'
		}

	elseif (a_s_nodename == 'default:tinblock') then
		s_nodeTextures = {
			'default_tin_block.png',
			'default_tin_block.png',
			'default_tin_block.png',
			'default_tin_block.png',
			'default_tin_block.png',
			'default_tin_block.png'
		}

	elseif (a_s_nodename == 'default:bronzeblock') then
		s_nodeTextures = {
			'default_bronze_block.png',
			'default_bronze_block.png',
			'default_bronze_block.png',
			'default_bronze_block.png',
			'default_bronze_block.png',
			'default_bronze_block.png'
		}

	elseif (a_s_nodename == 'default:stone_with_mese') then
		s_nodeTextures = {
			'default_stone.png^default_mineral_mese.png',
			'default_stone.png^default_mineral_mese.png',
			'default_stone.png^default_mineral_mese.png',
			'default_stone.png^default_mineral_mese.png',
			'default_stone.png^default_mineral_mese.png',
			'default_stone.png^default_mineral_mese.png'
		}

	elseif (a_s_nodename == 'default:mese') then
		s_nodeTextures = {
			'default_mese_block.png',
			'default_mese_block.png',
			'default_mese_block.png',
			'default_mese_block.png',
			'default_mese_block.png',
			'default_mese_block.png'
		}

	elseif (a_s_nodename == 'default:stone_with_gold') then
		s_nodeTextures = {
			'default_stone.png^default_mineral_gold.png',
			'default_stone.png^default_mineral_gold.png',
			'default_stone.png^default_mineral_gold.png',
			'default_stone.png^default_mineral_gold.png',
			'default_stone.png^default_mineral_gold.png',
			'default_stone.png^default_mineral_gold.png'
		}

	elseif (a_s_nodename == 'default:goldblock') then
		s_nodeTextures = {
			'default_gold_block.png',
			'default_gold_block.png',
			'default_gold_block.png',
			'default_gold_block.png',
			'default_gold_block.png',
			'default_gold_block.png'
		}

	elseif (a_s_nodename == 'default:stone_with_diamond') then
		s_nodeTextures = {
			'default_stone.png^default_mineral_diamond.png',
			'default_stone.png^default_mineral_diamond.png',
			'default_stone.png^default_mineral_diamond.png',
			'default_stone.png^default_mineral_diamond.png',
			'default_stone.png^default_mineral_diamond.png',
			'default_stone.png^default_mineral_diamond.png'
		}

	elseif (a_s_nodename == 'default:diamondblock') then
		s_nodeTextures = {
			'default_diamond_block.png',
			'default_diamond_block.png',
			'default_diamond_block.png',
			'default_diamond_block.png',
			'default_diamond_block.png',
			'default_diamond_block.png'
		}

	else
		s_nodeTextures = {
			'default_chest_top.png',	-- +Y
			'default_chest_top.png',	-- -Y
			'default_chest_side.png',	-- +X
			'default_chest_side.png',	-- -X
			'default_chest_front.png',	-- +Z
			'default_chest_side.png'	-- -Z
		}

	end

	return s_nodeTextures
end
