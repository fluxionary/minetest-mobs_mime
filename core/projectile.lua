--[[
	Mobs Mime - Adds a monster mimicking its surrounding nodes.
	Copyright © 2020 Hamlet <hamlatcodeberg@riseup.net> and contributors.

	Licensed under the EUPL, Version 1.2 or – as soon they will be
	approved by the European Commission – subsequent versions of the
	EUPL (the "Licence");
	You may not use this work except in compliance with the Licence.
	You may obtain a copy of the Licence at:

	https:--joinup.ec.europa.eu/software/page/eupl
	https:--eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:32017D0863

	Unless required by applicable law or agreed to in writing,
	software distributed under the Licence is distributed on an
	"AS IS" basis,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
	implied.
	See the Licence for the specific language governing permissions
	and limitations under the Licence.

--]]


--
-- Mob's projectile
--

mobs:register_arrow('mobs_mime:glue_arrow', {
	visual = 'sprite',
	visual_size = {x = 0.5, y = 0.5},
	textures = {'mobs_mime_projectile.png'},
	velocity = 18,	-- Nodes per second
	tail = 1,
	tail_texture = 'mobs_mime_projectile.png',
	tail_size = 1.25,
	expire = 0.125,

	hit_player = function(self, player)
		local v_position = player:get_pos()

		mobs_mime.pr_GlueRing(v_position, 1) -- 1 node around
	end,

	hit_mob = function(self, player)
		local v_position = player:get_pos()

		mobs_mime.pr_GlueRing(v_position, 1) -- 1 node around
	end,

	hit_object = function(self, player)
		local v_position = player:get_pos()

		mobs_mime.pr_GlueRing(v_position, 1) -- 1 node around
	end,

	hit_node = function(self, pos, node)
		mobs_mime.pr_GlueRing(pos, 1) -- 1 node around
	end,
})
