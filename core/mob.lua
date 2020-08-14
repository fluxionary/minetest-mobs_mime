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
-- Mob's character sheet
--

mobs:register_mob('mobs_mime:mime', {
	--nametag = mobs_mime.l10n('Mime'),
	type = 'monster',
	hp_min = (minetest.PLAYER_MAX_HP_DEFAULT - 5),
	hp_max = minetest.PLAYER_MAX_HP_DEFAULT,	-- Same as player
	armor = 100,								-- Same as player
	walk_velocity = 1,		-- Nodes per second
	run_velocity = 5,		-- Nodes per second
	stand_chance = mobs_mime.stopChance,
	walk_chance = mobs_mime.moveChance,
	jump = true,		-- Required in orded to turn when there's an obstacle
	jump_height = 0.01,		-- Barely noticeable, required to change direction
	stepheight = 1.1,		-- It can walk onto 1 node
	pushable = false,		-- It can't be moved by pushing
	view_range = 14,		-- Active block
	damage = 4,				-- 1/5 of 20HP, that is 20 hearts
	knock_back = true,		-- It can be knocked back by hits
	fear_height = 3,		-- It won't fall if the height is too steep
	water_damage = 0,		-- Doesn't take damage from water
	lava_damage = 20,		-- It dies if it wals into lava
	light_damage = 0,		-- Doesn't take damage from light
	light_damage_min = (minetest.LIGHT_MAX / 2),
	light_damage_max = minetest.LIGHT_MAX,			-- Sunlight
	suffocation = 0,		-- Doesn't drown
	floats = 0,				-- Doesn't swim
	fly_in = {'mobs_mime:glue', 'mobs_mime:glue_flowing'},
	reach = 4,				-- Same as player
	docile_by_day = false,	-- Attacks regardless of daytime or nighttime
	attack_chance = 75,		-- 75% chance it will attack
	attack_monsters = false,
	attack_animals = true,
	attack_npcs = true,
	attack_players = true,
	group_attack = false,	-- If a mime gets attacked, other mimes won't help
	attack_type = 'dogshoot', 		-- If in view range, shoot glue, then melee
	arrow = 'mobs_mime:glue_arrow',	-- Glue shot
	dogshoot_switch = 1,			-- Switch to dogfight after shooting
	dogshoot_count_max = 3,			-- 3secs for shooting
	dogshoot_count2_max = 2,		-- 2secs for melee attacking
	pathfinding = 1,
	shoot_interval = 1.5,
	shoot_offset = 1.5,
	makes_footstep_sound = true,	-- It may give away the mob's presence
	drops = {
		{name = 'default:gold', chance = 4, min = 1, max = 2},
		{name = 'mobs_mime:mime_skin', chance = 8, min = 1, max = 2},
	},
	visual = 'cube',
	visual_size = {x = 1, y = 1, z = 1},
	collisionbox = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
	selectionbox = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
	textures = 	{
		'default_chest_top.png',	-- +Y
		'default_chest_top.png',	-- -Y
		'default_chest_side.png',	-- +X
		'default_chest_side.png',	-- -X
		'default_chest_front.png',	-- +Z
		'default_chest_side.png'	-- -Z
	},

	on_die = function(self, pos)
	end,

	on_rightclick = function(name, entity_definition)
	end,

	on_spawn = function(self)

		-- Used for the camouflaging
		self.f_mobs_mime_timer = 0.0

		local v_position = self.object:get_pos()

		math.randomseed(os.time())
		local i_dice = math.random(mobs_mime.chestChance);

		if (i_dice ~= 1) then
			minetest.after(4.0, mobs_mime.pr_SetTexture, self, v_position)
		end

	end,

	do_custom = function(self, dtime)
		self.f_mobs_mime_timer = (self.f_mobs_mime_timer + dtime)

		-- Run every 10 seconds
		if (self.f_mobs_mime_timer >= 10.0) then
			mobs_mime.pr_SetTexture(self, self.object:get_pos())

			self.f_mobs_mime_timer = 0.0
		end

		-- Run constantly
		if (mobs_mime.keepAligned == true) then
			mobs_mime.pr_SetYaw(self, 0.0)
		end
	end
})
