--
-- Mime's skin
--

-- Rarely dropped when the mob dies
minetest.register_craftitem("mobs_mime:mime_skin", {
	description = mobs_mime.l10n("Skin of the mime"),
	inventory_image = "mobs_mime_skin.png",
	wield_scale = { x = 1.0, y = 1.0, z = 1.0 },
})

minetest.register_alias("mime_skin", "mobs_mime:mime_skin")
