function clone_next_projectile( how_many )
	for i, action in ipairs( deck ) do					
		if action.type == ACTION_TYPE_PROJECTILE then	--Find (inorder) projectile action within deck
			for i = 1, how_many do						--Act it N times
				action.action() 
			end	break									--Break so only next (first) projectile is cloned
		end
	end
end

table.insert( actions,
{
	id          = "3_DOLLAR_BILL",
	name 		= "3 Dollar Bill",
	description = "A rainbow of spells!",
	sprite 		= "mods/Binding-of-Noita/files/sprites/3_dollar_bill.png",
	type 		= ACTION_TYPE_PROJECTILE,
	spawn_level			= "0,1,2,3,4,5,6",
	spawn_probability	= "1,1,1,1,1,1,1",
	price = 260,
	mana = 30,
	action 		= function()
		local types = {"lance","laser","bouncy_orb","spore_pod","tentacle",
			"rubber_ball","slime","arrow","fireball_ray","bullet_heavy",
			"light_bullet","bullet","light_bullet_blue","bubbleshot"}	--List of random shots
		SetRandomSeed( GameGetFrameNum(), GameGetFrameNum() )
		local rand_shot = tostring( types[Random(1, #types)] ) .. ".xml"--Select random projectile and add ".xml"
		add_projectile("data/entities/projectiles/deck/" .. rand_shot)	--Add file path to selected projectile, then add_projectile
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
	mana = 40,
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
	action 		= function()
		add_projectile("mods/Binding-of-Noita/files/actions/brimstone_charge.xml")
		--Charge effect
		add_projectile("mods/Binding-of-Noita/files/actions/brimstone_beam.xml")
		add_projectile("mods/Binding-of-Noita/files/actions/brimstone_beam.xml")
		add_projectile("mods/Binding-of-Noita/files/actions/brimstone_beam.xml")
		add_projectile("mods/Binding-of-Noita/files/actions/brimstone_beam.xml")
		add_projectile("mods/Binding-of-Noita/files/actions/brimstone_beam.xml")
		--Extra entities before main entity so they may be used in lua
		add_projectile("mods/Binding-of-Noita/files/actions/brimstone.xml")
		c.fire_rate_wait = c.fire_rate_wait + 70
		shot_effects.recoil_knockback = shot_effects.recoil_knockback + 30.0
	end,
} )

chem_counter = 0				--This may be a janky approach but goddamn it this works!
table.insert( actions,
{
	id          = "CHEMICAL_PEEL",
	name 		= "Chemical Peel",
	description = "Every second cast deals extra damage",
	sprite 		= "mods/Binding-of-Noita/files/sprites/chemical_peel.png",
	type 		= ACTION_TYPE_MODIFIER,
	spawn_level                       = "0,1,2,3,4,5,6",
	spawn_probability                 = "1,1,1,1,1,1,1",
	price = 250,
	mana = 7,
	action 		= function()	--Add damage to every even shot
		if chem_counter % 2 == 0 then
			c.extra_entities = c.extra_entities .. "data/entities/particles/tinyspark_green.xml,"
			c.damage_projectile_add = .2
		end

		chem_counter = chem_counter + 1
		draw_actions( 1, true )
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
	mana = 65,
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
	type 		= ACTION_TYPE_MODIFIER,
	spawn_level			= "0,1,2,3,4,5,6",
	spawn_probability	= "1,1,1,1,1,1,1",
	price = 400,
	mana = 25,
	action 		= function()
		c.extra_entities = c.extra_entities .. "mods/Binding-of-Noita/files/actions/infestation2.xml,"
		draw_actions( 1, true )
	end,
} )

table.insert( actions,
{
	id          = "LOKIS_HORNS",
	name 		= "Loki's Horns",
	description = "Chance to shoot a cross shot.",
	sprite 		= "mods/Binding-of-Noita/files/sprites/lokis_horns.png",
	type 		= ACTION_TYPE_MODIFIER,
	spawn_level			= "0,1,2,3,4,5,6",
	spawn_probability	= "1,1,1,1,1,1,1",
	price = 50,
	mana = 8,
	action 		= function()
		c.pattern_degrees = 180
		SetRandomSeed( GameGetFrameNum(), GameGetFrameNum() )
		if Random( 1, 5 ) == 1 then
			clone_next_projectile( 3 )	--Clone 3 in addition to drawn projectile
		end
		draw_actions( 1, true )
	end,
} )

table.insert( actions,
{
	id          = "MUTANT_SPIDER",
	name 		= "Mutant Spider",
	description = "Quad shot!",
	sprite 		= "mods/Binding-of-Noita/files/sprites/mutant_spider.png",
	type 		= ACTION_TYPE_MODIFIER,
	spawn_level			= "0,1,2,3,4,5,6",
	spawn_probability	= "1,1,1,1,1,1,1",
	price = 550,
	mana = 20,
	action 		= function()
		c.fire_rate_wait = c.fire_rate_wait + 24
		c.pattern_degrees = 10
		clone_next_projectile( 3 )	--Clone 3 in addition to drawn projectile
		draw_actions( 1, true )
	end,
} )

table.insert( actions,
{
	id          = "NUMBER_ONE",
	name 		= "Number One!",
	description = "High fire rate at the cost of range",
	sprite 		= "mods/Binding-of-Noita/files/sprites/number_one.png",
	type 		= ACTION_TYPE_MODIFIER,
	spawn_level                       = "1,2,3,4,5,6",
	spawn_probability                 = "1,1,1,1,1,1",
	price = 300,
	mana = 5,
	action 		= function()
			c.fire_rate_wait = c.fire_rate_wait / 2
			current_reload_time = current_reload_time / 2
			c.extra_entities    = c.extra_entities .. "mods/Binding-of-Noita/files/actions/number_one.xml,"
			draw_actions( 1, true )
	end,
} )

table.insert( actions,
{
	id          = "OUIJA_BOARD",
	name 		= "Ouija Board",
	description = "Spectral spells",
	sprite 		= "mods/Binding-of-Noita/files/sprites/ouija_board.png",
	type 		= ACTION_TYPE_MODIFIER,
	spawn_level                       = "0,1,2,3,4,5,6",
	spawn_probability                 = "1,1,1,1,1,1,1",
	price = 366,
	mana = 6,
	action 		= function()
			c.extra_entities    = c.extra_entities .. "mods/Binding-of-Noita/files/actions/ouija_board.xml,"
			draw_actions( 1, true )
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
	spawn_probability                 = "0.5,0.5,0.5,0.5",
	price = 950,
	mana = 40,
	action 		= function()
		shot_effects.recoil_knockback = shot_effects.recoil_knockback + 30.0
		c.damage_projectile_add = .4
		c.speed_multiplier	= c.speed_multiplier * .5
		c.gore_particles	= c.gore_particles + 15
		c.fire_rate_wait	= c.fire_rate_wait + 75
		current_reload_time = current_reload_time + 75
		c.extra_entities	= c.extra_entities .. "mods/Binding-of-Noita/files/actions/polyphemus.xml,"
		draw_actions( 1, true )
	end,
} )

table.insert( actions,
{
	id          = "RUBBER_CEMENT",
	name 		= "Rubber Cement",
	description = "Adds a bouncy effect",
	sprite 		= "mods/Binding-of-Noita/files/sprites/rubber_cement.png",
	type 		= ACTION_TYPE_MODIFIER,
	spawn_level                       = "0,1,2,3,4,5,6",
	spawn_probability                 = "1,1,1,1,1,1,1",
	price = 300,
	mana = 5,
	action 		= function()
		c.extra_entities    = c.extra_entities .. "mods/Binding-of-Noita/files/actions/rubber_cement.xml,"
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
	spawn_level                       = "3,4,5,6",
	spawn_probability                 = "0.25,0.25,0.25,0.25",
	price = 1777,
	mana = 77,
	action 		= function()
		shot_effects.recoil_knockback = shot_effects.recoil_knockback + 30.0
		c.damage_projectile_add = .6
		c.speed_multiplier = c.speed_multiplier * .5
		c.gore_particles = c.gore_particles + 15
		c.fire_rate_wait = c.fire_rate_wait + 75
		current_reload_time = current_reload_time + 75
		c.extra_entities    = c.extra_entities .. "mods/Binding-of-Noita/files/actions/sacred_heart.xml,"
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
	spawn_probability                 = "0.8,0.8,0.8,0.8,0.8,0.8",
	price = 180,
	mana = 20,
	action 		= function()
		c.extra_entities    = c.extra_entities .. "mods/Binding-of-Noita/files/actions/spoon_bender.xml,"
		draw_actions( 1, true )
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
	mana = 6,
	action 		= function()
		c.lightning_count = c.lightning_count + 1
		c.damage_electricity_add = c.damage_electricity_add + 0.01
		c.extra_entities = c.extra_entities .. "data/entities/particles/electricity.xml,"
		add_projectile("mods/Binding-of-Noita/files/actions/technology.xml")
	end,
} )

table.insert( actions,
{
	id          = "TECH_2",
	name 		= "Technology 2",
	description = "Bzzzzzzzzzt!",
	sprite 		= "mods/Binding-of-Noita/files/sprites/technology_2.png",
	type 		= ACTION_TYPE_PROJECTILE,
	spawn_level			= "0,1,2,3,4,5,6",
	spawn_probability	= "0.5,0.5,1,1,1,1,1",
	price = 480,
	mana = 4,
	action 		= function()
		c.lightning_count = c.lightning_count + 1
		c.damage_electricity_add = c.damage_electricity_add + 0.01
		c.fire_rate_wait = c.fire_rate_wait - 100
		current_reload_time = 4
		c.extra_entities = c.extra_entities .. "data/entities/particles/electricity.xml,"
		add_projectile("mods/Binding-of-Noita/files/actions/technology.xml")
	end,
} )

table.insert( actions,
{
	id          = "THE_WIZ",
	name 		= "The Wiz",
	description = "Double wiz shot!",
	sprite 		= "mods/Binding-of-Noita/files/sprites/the_wiz.png",
	type 		= ACTION_TYPE_MODIFIER,
	spawn_level			= "0,1,2,3,4,5,6",
	spawn_probability	= "1,1,1,1,1,1,1",
	price = 75,
	mana = 5,
	action 		= function()
		c.pattern_degrees = 30
		clone_next_projectile( 1 )	--Clone drawn projectile
		draw_actions( 1, true )		--Draw modifiers and projectile
	end,
} )

--table.insert( actions,		--TODO: parasite.lua - make clones split on collision
--{
--	id          = "PARASITE",
--	name 		= "Parasite",
--	description = "The parasite infects your wand",
--	sprite 		= "mods/Binding-of-Noita/files/sprites/parasite.png",
--	type 		= ACTION_TYPE_MODIFIER,
--	spawn_level			= "0,1,2,3,4",
--	spawn_probability	= "2,2,1,1,1",
--	price = 50,
--	mana = 0,
--	action 		= function()
--		c.pattern_degrees = 180
--		clone_next_projectile( 2 )	
--		draw_actions( 1, true )
--	end,
--} )