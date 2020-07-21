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
-- Mime's skin
--

-- Rarely dropped when the mob dies
minetest.register_craftitem('mobs_mime:mime_skin', {
	description = mobs_mime.l10n('Skin of the mime'),
	inventory_image = 'mobs_mime_skin.png',
	wield_scale = {x = 1.0, y = 1.0, z = 1.0}
})

minetest.register_alias('mime_skin', 'mobs_mime:mime_skin')
