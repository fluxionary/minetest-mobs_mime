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
-- Global function
--


-- Used to detect the node upon wich the mob has been spawned
mobs_mime.fn_DetectNodeUnder = function(a_t_mobile, a_f_offset)
	local v_position = a_t_mobile:get_pos()
	local s_nodeName = ''

	if (v_position ~= nil) then
		v_position.y = (v_position.y - a_f_offset)
		s_nodeName = minetest.get_node(v_position).name
	end

	return s_nodeName
end


-- Used to fetch the texture of the aforementioned node
mobs_mime.fn_DetectTexture = function(a_s_nodename)
	local t_nodeTile = {}
	local t_mobTextures = {}

	if (a_s_nodename ~= nil) then
		t_nodeTile = minetest.registered_nodes[a_s_nodename]

		if (t_nodeTile ~= nil) then
			local s_nodeTileTop = ''
			local s_nodeTileBottom = ''
			local s_nodeTileSides = ''

			s_nodeTileTop = t_nodeTile["tiles"][1]
			--print("Top: " .. s_nodeTileTop)
			
			table.insert(t_mobTextures, s_nodeTileTop)


			if (t_nodeTile["tiles"][2] ~= nil) then
				s_nodeTileBottom = t_nodeTile["tiles"][2]
				--print("Bottom: " .. s_nodeTileBottom)

				table.insert(t_mobTextures, s_nodeTileBottom)

			else
				table.insert(t_mobTextures, s_nodeTileTop)
				table.insert(t_mobTextures, s_nodeTileTop)
				table.insert(t_mobTextures, s_nodeTileTop)
				table.insert(t_mobTextures, s_nodeTileTop)
				table.insert(t_mobTextures, s_nodeTileTop)

			end

			if (t_nodeTile["tiles"][3] ~= nil) then
				if (t_nodeTile["tiles"][3].name ~= nil) then 
					s_nodeTileSides = t_nodeTile["tiles"][3].name
					--print("Sides: " .. s_nodeTileSides)

					table.insert(t_mobTextures, s_nodeTileSides)
					table.insert(t_mobTextures, s_nodeTileSides)
					table.insert(t_mobTextures, s_nodeTileSides)
					table.insert(t_mobTextures, s_nodeTileSides)
				else
					s_nodeTileSides = t_nodeTile["tiles"][3]

					--print("Sides: " .. s_nodeTileSides)

					table.insert(t_mobTextures, s_nodeTileSides)
					table.insert(t_mobTextures, s_nodeTileSides)
					table.insert(t_mobTextures, s_nodeTileSides)
					table.insert(t_mobTextures, s_nodeTileSides)
				end
			end
		end
	end

	--print(dump(t_mobTextures))

	return t_mobTextures
end
