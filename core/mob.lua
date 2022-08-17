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

local yaw_tolerance = 0.01

local function bad_yaw(self)
	local yaw = self.object:get_yaw()
	return (
		yaw and
		math.abs(yaw) > yaw_tolerance and
		math.abs(yaw - (math.pi / 2)) > yaw_tolerance and
		math.abs(yaw - math.pi) > yaw_tolerance and
		math.abs(yaw - (3 * math.pi / 2)) > yaw_tolerance
	)
end

--
-- Mob's character sheet
--

mobs:register_mob("mobs_mime:mime", {
	--nametag = mobs_mime.l10n("Mime"),
	type = "monster",
	hp_min = (minetest.PLAYER_MAX_HP_DEFAULT - 5),
	hp_max = minetest.PLAYER_MAX_HP_DEFAULT,	-- Same as player
	armor = 100,								-- Same as player
	lifetimer = 60 * 60 * 5,
	lifetime = 60 * 60 * 5,
	walk_velocity = 0.1,		-- Nodes per second
	run_velocity = 5,		-- Nodes per second
	randomly_turn = false,
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
	fly_in = {"mobs_mime:glue", "mobs_mime:glue_flowing"},
	reach = 4,				-- Same as player
	docile_by_day = false,	-- Attacks regardless of daytime or nighttime
	attack_chance = 99,		-- 1% chance it will attack
	attack_monsters = true,
	attack_animals = true,
	attack_npcs = false,
	attack_players = true,
	group_attack = false,	-- If a mime gets attacked, other mimes won't help
	attack_type = "dogshoot", 		-- If in view range, shoot glue, then melee
	arrow = "mobs_mime:glue_arrow",	-- Glue shot
	dogshoot_switch = 1,			-- Switch to dogfight after shooting
	dogshoot_count_max = 3,			-- 3secs for shooting
	dogshoot_count2_max = 2,		-- 2secs for melee attacking
	pathfinding = 1,
	shoot_interval = 1.5,
	shoot_offset = 1.5,
	makes_footstep_sound = true,	-- It may give away the mob's presence
	drops = {
		{name = "default:gold", chance = 4, min = 1, max = 2},
		{name = "mobs_mime:mime_skin", chance = 8, min = 1, max = 2},
	},
	visual = "cube",
	visual_size = {x = 1, y = 1, z = 1},
	collisionbox = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
	selectionbox = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
	textures = 	{
		"default_chest_top.png",	-- +Y
		"default_chest_top.png",	-- -Y
		"default_chest_side.png",	-- +X
		"default_chest_side.png",	-- -X
		"default_chest_front.png",	-- +Z
		"default_chest_side.png"	-- -Z
	},

	on_rightclick = function(self, clicker)
		self:do_attack(clicker)
	end,

	on_spawn = function(self)
		if not self.object and self.object:get_pos() then return end
		local pos = self.object:get_pos()
		if not pos then return end

		mobs_mime.pr_SetTexture(self, pos)

		self.f_mobs_mime_timer = 0.0
		self.f_next_mobs_mime_timer = 150 + 300 * math.random()
	end,

	do_punch = function(self, hitter, time_from_last_punch, tool_capabilities, direction)
		local hit_params = minetest.get_hit_params({fleshy = 100}, tool_capabilities, time_from_last_punch)
		if hit_params.hp > 0 then
			self.object:set_properties({
				visual = "cube",
				textures = {
					"default_chest_top.png",	-- +Y
					"default_chest_top.png",	-- -Y
					"default_chest_side.png",	-- +X
					"default_chest_side.png",	-- -X
					"default_chest_front.png",	-- +Z
					"default_chest_side.png"	-- -Z
				},
				visual_size = {x = 1, y = 1, z = 1},
				use_texture_alpha = false,
				mesh = nil,
				itemname = nil,
			})
			self.mimicking = nil
		end
	end,

	do_custom = function(self, dtime)
		if not (self and self.object and self.object:get_pos()) then
			return
		end

		if self.state ~= "attack" then
			self.f_mobs_mime_timer = (self.f_mobs_mime_timer + dtime)

			if (self.f_mobs_mime_timer >= (self.f_next_mobs_mime_timer or 300.0)) then
				mobs_mime.pr_SetTexture(self, self.object:get_pos())

				self.f_mobs_mime_timer = 0.0
				self.f_next_mobs_mime_timer = 150 + 300 * math.random()
			end
		end

		if self.attack and self.attack ~= self.mimicking then
			mobs_mime.copy_nearby_mob(self, self.object:get_pos())
		end

		if type(self.mimicking) ~= "userdata" then
			if (mobs_mime.keepAligned == true) and bad_yaw(self) then
				mobs_mime.pr_SetYaw(self, ({0, math.pi / 2, math.pi, 3 * math.pi / 2})[math.random(1, 4)])
			end

			self.walk_velocity = 0.1
			self.randomly_turn = false
			self.stand_chance = mobs_mime.stopChance
			self.walk_chance = mobs_mime.moveChance
			self.jump = true
			self.jump_height = 0.01
			self.stepheight = 1.1
			self.fear_height = 3
			self.floats = 0
			self.fly_in = {"mobs_mime:glue", "mobs_mime:glue_flowing"}
		end
	end
})
