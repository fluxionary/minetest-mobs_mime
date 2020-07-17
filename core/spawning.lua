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
-- Mob's spawner
--

mobs:spawn({
	name = 'mobs_mime:mime',
	nodes = {
		'group:crumbly',
		'group:cracky',
		'group:stone',
		'group:tree',
		'group:wood',
		'group:leaves'
	},
	interval = mobs_mime.spawnInterval,		-- Seconds
	chance = mobs_mime.spawnChance,			-- Chance: 1 = always, 2 = 50%, etc.
	min_light = 0,
	max_light = 5,							-- Dim light and below
	min_height = mobs_mime.minHeight,		-- World's bottom
	max_height = mobs_mime.maxHeight,		-- World's top
	active_object_count = mobs_mime.AOC,	-- 1 mob per active map area
	day_toggle = false,			-- Spawn regardless of nighttime or nighttime
})


-- Spawn Egg

mobs:register_egg('mobs_mime:mime', mobs_mime.l10n('Mime'),
	'default_chest_front.png')


--
-- Alias
--

mobs:alias_mob('mobs:mime', 'mobs_mime:mime')
