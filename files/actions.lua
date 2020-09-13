table.insert( actions,
{
	id          = "LOKIS_HORNS",
	name 		= "Loki's Horns",
	description = "Chance to shoot a cross shot with most spells",
	sprite 		= "mods/Binding-of-Noita/files/sprites/lokis_horns.png",
	type 		= ACTION_TYPE_MODIFIER,
	spawn_level			= "0,1,2,3,4,5,6",
	spawn_probability	= "2,2,2,2,1,1,1",
	price = 50,
	mana = 0,
	--max_uses = 100,
	action 		= function()
		c.pattern_degrees = 180
		SetRandomSeed( GameGetFrameNum(), GameGetFrameNum() )
		if Random( 1, 4 ) == 1 then								--if 1/4 chance of proc
			for i, action in ipairs( deck ) do					--Within the deck (inorder)
				if action.type == ACTION_TYPE_PROJECTILE then	--Find first projectile action (within deck)
					for i = 1, 3 do action.action() end			--Then act it an additional 3 times
					break										--(Break so only FIRST projectile is proc'ed)
				end
			end
		end
		draw_actions( 1, true )
	end,
} )

table.insert( actions,
{
	id          = "3_DOLLAR_BILL",
	name 		= "3 Dollar Bill",
	description = "A rainbow of spells!",
	sprite 		= "mods/Binding-of-Noita/files/sprites/3_dollar_bill.png",
	type 		= ACTION_TYPE_PROJECTILE,
	spawn_level			= "0,1,2,3,4,5,6",
	spawn_probability	= "1,1,1,1,2,2,3",
	price = 260,
	mana = 30,
	--max_uses = 100,
	action 		= function()
		SetRandomSeed( GameGetFrameNum(), GameGetFrameNum() )
		local types = {"lance","laser","bouncy_orb","spore_pod",
			"tentacle","rubber_ball","slime","arrow","fireball_ray",
			"bullet_heavy","light_bullet","bullet","light_bullet_blue","bubbleshot"}
		local rand_shot = tostring( types[Random(1, #types)] ) .. ".xml"
		add_projectile("data/entities/projectiles/deck/" .. rand_shot)
		c.fire_rate_wait = c.fire_rate_wait + 10
	end,
} )

table.insert( actions,
{
	id          = "BOBS_HEAD",
	name 		= "Bob's Rotten Head",
	description = "Acidic Bomb",
	sprite 		= "mods/Binding-of-Noita/files/sprites/bobs_head.png",
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
	sprite 		= "mods/Binding-of-Noita/files/sprites/brimstone.png",
	type 		= ACTION_TYPE_PROJECTILE,
	spawn_level			= "0,1,2,3,4,5,6",
	spawn_probability	= "1,1,1,1,1,1,1",
	price = 1666,
	mana = 90,
	--max_uses = 100,
	action 		= function()
			add_projectile("mods/Binding-of-Noita/files/actions/brimstone_charge.xml")

			add_projectile("mods/Binding-of-Noita/files/actions/brimstone_beam.xml")
			add_projectile("mods/Binding-of-Noita/files/actions/brimstone_beam.xml")
			add_projectile("mods/Binding-of-Noita/files/actions/brimstone_beam.xml")
			add_projectile("mods/Binding-of-Noita/files/actions/brimstone_beam.xml")
			add_projectile("mods/Binding-of-Noita/files/actions/brimstone_beam.xml")
			
			add_projectile("mods/Binding-of-Noita/files/actions/brimstone.xml")
			c.fire_rate_wait = c.fire_rate_wait + 70
			shot_effects.recoil_knockback = shot_effects.recoil_knockback + 30.0
	end,
} )

table.insert( actions,
{
	id          = "DR_FETUS",
	name 		= "Dr.Fetus",
	description = "Unlimited bombs!",
	sprite 		= "mods/Binding-of-Noita/files/sprites/dr_fetus.png",
	type 		= ACTION_TYPE_PROJECTILE,
	spawn_level			= "0,1,2,3,4,5,6",
	spawn_probability	= "1,1,1,1,1,1,1",
	price = 750,
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
	id          = "INFESTATION_2",
	name 		= "Infestation 2",
	description = "Enemeies are infested!",
	sprite 		= "mods/Binding-of-Noita/files/sprites/infestation2.png",
	--sprite_unidentified = "data/ui_gfx/gun_actions/freeze_unidentified.png",
	type 		= ACTION_TYPE_MODIFIER,
	spawn_level			= "0,1,2,3,4,5,6",
	spawn_probability	= "1,1,1,1,1,1,1",
	price = 400,
	mana = 25,
	--max_uses = 50,
	action 		= function()
		c.extra_entities = c.extra_entities .. "mods/Binding-of-Noita/files/actions/infestation2.xml,"
		draw_actions( 1, true )
	end,
} )

table.insert( actions,
{
	id          = "TECH_2",
	name 		= "Technology 2",
	description = "Bzzzzzzzzzt!",
	sprite 		= "mods/Binding-of-Noita/files/sprites/technology_2.png",
	type 		= ACTION_TYPE_PROJECTILE,
	spawn_level			= "2,3,4,5,6",
	spawn_probability	= "1,1,1,1,1",
	price = 1200,
	mana = 4,
	--max_uses = 100,
	action 		= function()
			c.lightning_count = c.lightning_count + 1
			c.damage_electricity_add = c.damage_electricity_add + 0.01
			c.extra_entities = c.extra_entities .. "data/entities/particles/electricity.xml,"
			add_projectile("mods/Binding-of-Noita/files/actions/technology.xml")
			c.fire_rate_wait = c.fire_rate_wait - 100
			current_reload_time = current_reload_time - current_reload_time + 4
	end,
} )

table.insert( actions,
{
	id          = "TECH_1",
	name 		= "Technology",
	description = "Bzzzt!",
	sprite 		= "mods/Binding-of-Noita/files/sprites/technology_1.png",
	type 		= ACTION_TYPE_PROJECTILE,
	spawn_level			= "0,1",
	spawn_probability	= "1,1",
	price = 240,
	mana = 4,
	--max_uses = 100,
	action 		= function()
			c.lightning_count = c.lightning_count + 1
			c.damage_electricity_add = c.damage_electricity_add + 0.01
			c.extra_entities = c.extra_entities .. "data/entities/particles/electricity.xml,"
			add_projectile("mods/Binding-of-Noita/files/actions/technology.xml")
	end,
} )

table.insert( actions,
{
	id          = "POLYPHEMUS",
	name 		= "Polyphemus",
	description = "Crippling damage",
	sprite 		= "mods/Binding-of-Noita/files/sprites/polyphemus.png",
	type 		= ACTION_TYPE_MODIFIER,
	spawn_level                       = "3,4,5,6",
	spawn_probability                 = "0.4,0.4,0.4,0.4",
	price = 950,
	mana = 40,
	action 		= function()
		c.damage_projectile_add = c.damage_projectile_add + .7
		c.speed_multiplier = c.speed_multiplier * 0.4
		c.gore_particles    = c.gore_particles + 10
		c.fire_rate_wait    = (c.fire_rate_wait + 1) * 4
		current_reload_time = (current_reload_time + 1) * 4
		c.extra_entities    = c.extra_entities .. "data/entities/particles/tinyspark_red.xml,"
		shot_effects.recoil_knockback = shot_effects.recoil_knockback + 15.0
		draw_actions( 1, true )
	end,
} )

table.insert( actions,
{
	id          = "SACRED_HEART",
	name 		= "Sacred Heart",
	description = "Guides your spells with holy might",
	sprite 		= "mods/Binding-of-Noita/files/sprites/sacred_heart.png",
	type 		= ACTION_TYPE_MODIFIER,
	spawn_level                       = "4,5,6",
	spawn_probability                 = "0.2,0.2,0.2",
	price = 1777,
	mana = 75,
	action 		= function()
		c.damage_projectile_add = c.damage_projectile_add + 1
		c.speed_multiplier = c.speed_multiplier * 0.5
		c.gore_particles    = c.gore_particles + 10
		c.fire_rate_wait    = (c.fire_rate_wait + 1) * 4
		current_reload_time = (current_reload_time + 1) * 4
		c.extra_entities    = c.extra_entities .. "mods/Binding-of-Noita/files/actions/sacred_heart.xml,"
		shot_effects.recoil_knockback = shot_effects.recoil_knockback + 30.0
		draw_actions( 1, true )
	end,
} )

table.insert( actions,
{
	id          = "SPOON_BENDER",
	name 		= "Spoon Bender",
	description = "Lighlty psychic spells",
	sprite 		= "mods/Binding-of-Noita/files/sprites/spoon_bender.png",
	type 		= ACTION_TYPE_MODIFIER,
	spawn_level                       = "1,2,3,4,5,6",
	spawn_probability                 = "0.5,0.5,0.5,0.5,0.5.0,5",
	price = 180,
	mana = 20,
	action 		= function()
		c.extra_entities    = c.extra_entities .. "mods/Binding-of-Noita/files/actions/spoon_bender.xml,"
		draw_actions( 1, true )
	end,
} )

table.insert( actions,
{
	id          = "NUMBER_ONE",
	name 		= "Number One!",
	description = "High fire rate at the cost of range.",
	sprite 		= "mods/Binding-of-Noita/files/sprites/number_one.png",
	type 		= ACTION_TYPE_MODIFIER,
	spawn_level                       = "1,2,3,4,5,6",
	spawn_probability                 = "0.5,0.5,0.5,0.5,0.5.0,5",
	price = 300,
	mana = 5,
	action 		= function()
			c.fire_rate_wait = c.fire_rate_wait / 2
			current_reload_time = current_reload_time / 2
			c.extra_entities    = c.extra_entities .. "mods/Binding-of-Noita/files/actions/number_one.xml,"
			draw_actions( 1, true )
	end,
} )