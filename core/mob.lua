--
-- Mob's character sheet
--

mobs:register_mob("mobs_mime:mime", {
	--nametag = mobs_mime.l10n("Mime"),
	type = "monster",
	hp_min = (minetest.PLAYER_MAX_HP_DEFAULT - 5),
	hp_max = minetest.PLAYER_MAX_HP_DEFAULT, -- Same as player
	armor = 100, -- Same as player
	lifetimer = 60 * 60 * 5,
	lifetime = 60 * 60 * 5,
	walk_velocity = 0.1, -- Nodes per second
	run_velocity = 5, -- Nodes per second
	randomly_turn = false,
	stand_chance = mobs_mime.stopChance,
	walk_chance = mobs_mime.moveChance,
	jump = true, -- Required in orded to turn when there's an obstacle
	jump_height = 0.01, -- Barely noticeable, required to change direction
	stepheight = 1.1, -- It can walk onto 1 node
	pushable = false, -- It can't be moved by pushing
	view_range = 14, -- Active block
	damage = 4, -- 1/5 of 20HP, that is 20 hearts
	knock_back = true, -- It can be knocked back by hits
	fear_height = 3, -- It won't fall if the height is too steep
	water_damage = 0, -- Doesn't take damage from water
	lava_damage = 20, -- It dies if it falls into lava
	light_damage = 0, -- Doesn't take damage from light
	light_damage_min = (minetest.LIGHT_MAX / 2),
	light_damage_max = minetest.LIGHT_MAX, -- Sunlight
	suffocation = 0, -- Doesn't drown
	floats = 0, -- Doesn't swim
	fly_in = {
		"mobs_mime:glue",
		"mobs_mime:glue_flowing",
		"default:water_source",
		"default:water_flowing",
		"default:river_water_source",
		"default:river_water_flowing",
	},
	reach = 4, -- Same as player
	docile_by_day = false, -- Attacks regardless of daytime or nighttime
	attack_chance = 99, -- 1% chance it will attack
	attack_monsters = true,
	attack_animals = true,
	attack_npcs = false,
	attack_players = true,
	group_attack = false, -- If a mime gets attacked, other mimes won't help
	attack_type = "dogshoot", -- If in view range, shoot glue, then melee
	arrow = "mobs_mime:glue_arrow", -- Glue shot
	dogshoot_switch = 1, -- Switch to dogfight after shooting
	dogshoot_count_max = 3, -- 3secs for shooting
	dogshoot_count2_max = 2, -- 2secs for melee attacking
	pathfinding = 1,
	shoot_interval = 1.5,
	shoot_offset = 1.5,
	makes_footstep_sound = true, -- It may give away the mob's presence
	drops = {
		{ name = "default:gold", chance = 4, min = 1, max = 2 },
		{ name = "mobs_mime:mime_skin", chance = 8, min = 1, max = 2 },
	},
	visual = "cube",
	visual_size = { x = 1, y = 1, z = 1 },
	collisionbox = { -0.5, -0.5, -0.5, 0.5, 0.5, 0.5 },
	selectionbox = { -0.5, -0.5, -0.5, 0.5, 0.5, 0.5, rotate = true },
	textures = mobs_mime.get_chest_textures(),

	on_rightclick = function(self, clicker)
		self:do_attack(clicker)
	end,

	on_spawn = function(self)
		if not self.object then
			return
		end

		mobs_mime.pr_SetTexture(self)

		self.f_mobs_mime_timer = 0.0
		self.f_next_mobs_mime_timer = 150 + 300 * math.random()

		local yaw = (math.pi / 2) * math.random(0, 3)
		self.object:set_yaw(yaw)
		self.target_yaw = yaw
		self.delay = 0
	end,

	do_punch = function(self, hitter, time_from_last_punch, tool_capabilities, direction)
		local hit_params = minetest.get_hit_params({ fleshy = 100 }, tool_capabilities, time_from_last_punch)
		if hit_params.hp > 0 then
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
		end
	end,
	do_attack = function(self, attack)
		if self.state == "attack" then
			return
		end

		local attack_ent = attack:get_luaentity() or {}
		local protected = attack_ent.protected
		if protected == true or type(protected) == "number" and protected > 0 then
			return
		end

		self.attack = attack
		self.state = "attack"

		if math.random(100) < 90 then
			self:mob_sound(self.sounds.war_cry)
		end
	end,

	do_custom = function(self, dtime)
		if not self then
			return
		end

		local obj = self.object

		if not obj then
			return
		end

		local pos = obj:get_pos()

		if not pos then
			return
		end

		if mobs_mime.in_a_wall(self, pos) and not mobs_mime.escape_a_wall(self) then
			obj:set_hp(0, "in a wall")
			return
		end

		if self.state == "attack" then
			local attack = self.attack

			if attack then
				local attack_ent = attack:get_luaentity() or {}
				local protected = attack_ent.protected
				if protected == true or type(protected) == "number" and protected > 0 then
					self.attack = nil
				elseif attack ~= self.mimicking and not minetest.is_player(attack) then
					mobs_mime.copy_nearby_mob(self)
				end
			end
		else
			self.f_mobs_mime_timer = (self.f_mobs_mime_timer + dtime)

			if self.f_mobs_mime_timer >= (self.f_next_mobs_mime_timer or 300.0) then
				mobs_mime.pr_SetTexture(self)

				self.f_mobs_mime_timer = 0.0
				self.f_next_mobs_mime_timer = 150 + 300 * math.random()
			end
		end

		if type(self.mimicking) ~= "userdata" then
			mobs_mime.fix_yaw(self)

			self.walk_velocity = 0.1
			self.randomly_turn = false
			self.stand_chance = mobs_mime.stopChance
			self.walk_chance = mobs_mime.moveChance
			self.jump = true
			self.jump_height = 0.01
			self.stepheight = 1.1
			self.fear_height = 3
			self.floats = 0
			self.fly_in = {
				"mobs_mime:glue",
				"mobs_mime:glue_flowing",
				"default:water_source",
				"default:water_flowing",
				"default:river_water_source",
				"default:river_water_flowing",
			}
		end
	end,
})
