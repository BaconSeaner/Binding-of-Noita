table.insert( actions,
{
	id          = "LOKIS_HORNS",
	name 		= "Loki's Horns",
	description = "Chance to shoot a cross(4) shot",
	sprite 		= "mods/Binding-of-Noita/files/actions/lokis_horns.png",
	type 		= ACTION_TYPE_MODIFIER,
	spawn_level			= "0,1,2,3,4,5,6",
	spawn_probability	= "5,4,2,1,1,1,1",
	price = 50,
	mana = 0,
	--max_uses = 100,
	action 		= function()
		SetRandomSeed( GameGetFrameNum(), GameGetFrameNum() )
		local rnd = Random(1,4)
		if rnd ~= 1 then return end
		draw_actions(4, true)
		c.pattern_degrees = 180
	end,
} )

table.insert( actions,
{
	id          = "3_DOLLAR_BILL",
	name 		= "3 Dollar Bill",
	description = "A rainbow of spells!",
	sprite 		= "mods/Binding-of-Noita/files/actions/3_dollar_bill.png",
	type 		= ACTION_TYPE_PROJECTILE,
	spawn_level			= "0,1,2,3,4,5,6",
	spawn_probability	= "1,1,1,2,5,6,6",
	price = 320,
	mana = 35,
	--max_uses = 100,
	action 		= function()
		SetRandomSeed( GameGetFrameNum(), GameGetFrameNum() )
		local types = {"lance","laser","bouncy_orb","spore_pod","tentacle","rubber_ball","slime","arrow","fireball_ray","bullet_heavy","light_bullet","bullet","light_bullet_blue","bubbleshot"}
		local rnd = Random(1, #types)
		local rand_shot = tostring(types[rnd]) .. ".xml"
		add_projectile("data/entities/projectiles/deck/" .. rand_shot)
		c.fire_rate_wait = c.fire_rate_wait + 10
	end,
} )

table.insert( actions,
{
	id          = "BOBS_HEAD",
	name 		= "Bob's Rotten Head",
	description = "Acidic Bomb",
	sprite 		= "mods/Binding-of-Noita/files/actions/bobs_head.png",
	type 		= ACTION_TYPE_PROJECTILE,
	spawn_level			= "0,1,2,3,4,5,6",
	spawn_probability	= "1,1,1,1,1,1,1",
	price = 160,
	mana = 50,
	max_uses = 16,
	action 		= function()
			add_projectile("mods/Binding-of-Noita/files/actions/bobs_head.xml")
			c.fire_rate_wait = c.fire_rate_wait + 50
	end,
} )

table.insert( actions,
{
	id          = "BRIMSTONE",
	name 		= "Brimstone",
	description = "It radiates with energy!",
	sprite 		= "mods/Binding-of-Noita/files/actions/brimstone.png",
	type 		= ACTION_TYPE_PROJECTILE,
	spawn_level			= "0,1,2,3,4,5,6",
	spawn_probability	= "1,1,1,1,1,1,1",
	price = 1666,
	mana = 90,
	--max_uses = 100,
	action 		= function()
			add_projectile("mods/binding-of-noita/files/actions/brimstone_charge.xml")

			add_projectile("mods/binding-of-noita/files/actions/brimstone_beam.xml")
			add_projectile("mods/binding-of-noita/files/actions/brimstone_beam.xml")
			add_projectile("mods/binding-of-noita/files/actions/brimstone_beam.xml")
			add_projectile("mods/binding-of-noita/files/actions/brimstone_beam.xml")
			add_projectile("mods/binding-of-noita/files/actions/brimstone_beam.xml")
			
			add_projectile("mods/binding-of-noita/files/actions/brimstone.xml")
			c.fire_rate_wait = c.fire_rate_wait + 70
			shot_effects.recoil_knockback = shot_effects.recoil_knockback + 30.0
	end,
} )

table.insert( actions,
{
	id          = "DR_FETUS",
	name 		= "Dr.Fetus",
	description = "Unlimited bombs!",
	sprite 		= "mods/Binding-of-Noita/files/actions/dr_fetus.png",
	type 		= ACTION_TYPE_PROJECTILE,
	spawn_level			= "0,1,2,3,4,5,6",
	spawn_probability	= "1,1,1,1,1,1,1",
	price = 1350,
	mana = 90,
	--max_uses = 0,
	--custom_xml_file = "data/entities/misc/custom_cards/bomb.xml",
	action 		= function()
		add_projectile("data/entities/projectiles/bomb.xml")
		c.fire_rate_wait = c.fire_rate_wait + 120
	end,
} )

table.insert( actions,
{
	id          = "INFESTATION2",
	name 		= "Infestation 2",
	description = "Enemeies are infested!",
	sprite 		= "mods/Binding-of-Noita/files/actions/infestation2.png",
	--sprite_unidentified = "data/ui_gfx/gun_actions/freeze_unidentified.png",
	type 		= ACTION_TYPE_MODIFIER,
	spawn_level			= "0,1,2,3,4,5,6",
	spawn_probability	= "1,1,1,1,1,1,1",
	price = 450,
	mana = 25,
	--max_uses = 50,
	action 		= function()
		SetRandomSeed( GameGetFrameNum(), GameGetFrameNum() )
		local rnd = Random(1,10)
		if rnd >= 7 then return end
		c.extra_entities = c.extra_entities .. "mods/binding-of-noita/files/actions/infestation2.xml,"
		draw_actions( 1, true )
	end,
} )