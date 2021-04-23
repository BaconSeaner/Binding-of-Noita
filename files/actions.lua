function clone_next_projectile( how_many )				-- TODO: Can be improved with mana checking
	for i, action in ipairs( deck ) do	
		if action.type == ACTION_TYPE_PROJECTILE then	-- Find next projectile in deck
			for j = 1, how_many do						-- Act it how_many times
				action.action() 
			end	return									-- Return after next projectile is cloned
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
	spawn_level			= "0,2,4,6",
	spawn_probability	= ".3,.7,.7,.7",
	price = 260,
	mana = 25,
	action 		= function()
		c.fire_rate_wait = c.fire_rate_wait + 10
		local types = {"brimstone", "lance","laser","bouncy_orb","tentacle",
			"rubber_ball","slime","arrow","fireball_ray","bullet_heavy",
			"light_bullet","bullet","light_bullet_blue","bubbleshot"}
		SetRandomSeed( GameGetFrameNum(), GameGetFrameNum() )
		local rand_shot = tostring( types[Random(1, #types)] ) .. ".xml"

		if rand_shot == "brimstone.xml" then	-- Unique case for brimstone
			add_projectile("mods/Binding-of-Noita/files/actions/brimstone_charge.xml")
			for i=1,5 do
				add_projectile("mods/Binding-of-Noita/files/actions/brimstone_beam.xml")
			end
			add_projectile("mods/Binding-of-Noita/files/actions/brimstone.xml")
		else									-- Default case
			add_projectile("data/entities/projectiles/deck/" .. rand_shot)
		end
	end,
} )

table.insert( actions,
{
	id          = "BOBS_HEAD",
	name 		= "Bob's Rotten Head",
	description = "Acidic Bomb",
	sprite 		= "mods/Binding-of-Noita/files/sprites/bobs_head.png",
	type 		= ACTION_TYPE_PROJECTILE,
	spawn_level			= "0,2,3",
	spawn_probability	= "1,1,.5",
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
	spawn_probability	= ".2,.2,.3,.5,.5,.9,.9",
	price = 1666,
	mana = 125,
	action 		= function()
		add_projectile("mods/Binding-of-Noita/files/actions/brimstone_charge.xml")
		-- Initial smaller beam
		for i=1,5 do
			add_projectile("mods/Binding-of-Noita/files/actions/brimstone_beam.xml")
		end
		-- Powerful beams to be combined in lua
		add_projectile("mods/Binding-of-Noita/files/actions/brimstone.xml")
		c.fire_rate_wait = c.fire_rate_wait + 70
		shot_effects.recoil_knockback = shot_effects.recoil_knockback + 30.0
	end,
} )

chem_counter = 0                -- To determine every even shot
table.insert( actions,
{
	id          = "CHEMICAL_PEEL",
	name 		= "Chemical Peel",
	description = "Every second cast deals extra damage",
	sprite 		= "mods/Binding-of-Noita/files/sprites/chemical_peel.png",
	type 		= ACTION_TYPE_MODIFIER,
	spawn_level                       = "0,1,2,3,4,5,6",
	spawn_probability                 = ".4,.4,.4,.4,.4,.4,.4",
	price = 250,
	mana = 7,
	action 		= function()	-- Add effect to every even shot
		if chem_counter % 2 == 0 then
			c.extra_entities = c.extra_entities .. "data/entities/particles/tinyspark_green.xml,"
			c.damage_projectile_add = .1
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
	spawn_level			= "0,3,4,5,6",
	spawn_probability	= ".5,.3,.3,.3,.3",
	price = 750,
	mana = 65,
	action 		= function()
		add_projectile("data/entities/projectiles/bomb.xml")
		c.fire_rate_wait = c.fire_rate_wait + 120
	end,
} )

table.insert( actions,
{
	id          = "EYE_OF_BELIAL",
	name 		= "Eye of Belial",
	description = "Possessed spells!",
	sprite 		= "mods/Binding-of-Noita/files/sprites/eye_of_belial.png",
	type 		= ACTION_TYPE_MODIFIER,
	spawn_level			= "0,1,2,3,4,5,6",
	spawn_probability	= ".2,.2,.3,.3,.4,.4,.5",
	price = 566,
	mana = 13,
	action 		= function()
		c.extra_entities = c.extra_entities .. "mods/Binding-of-Noita/files/actions/eye_of_belial.xml,"
		draw_actions( 1, true )
	end,
} )

table.insert( actions,
{
	id          = "FRUIT_CAKE",
	name 		= "Fruit Cake",
	description = "A rainbow of modifiers!",
	sprite 		= "mods/Binding-of-Noita/files/sprites/fruit_cake.png",
	type 		= ACTION_TYPE_MODIFIER,
	spawn_level			= "1,2,3,4,5,6",
	spawn_probability	= ".2,.2,.2,.2,.2,.2",
	price = 280,
	mana = 15,
	action 		= function()
		local types = {"infestation2", "rubber_cement", "polyphemus", "number_one",
			"spoon_bender", "ouija_board", "moms_eyeshadow", "mutant_spider", "eye_of_belial"}

		SetRandomSeed( GameGetFrameNum(), GameGetFrameNum() )
		local rand_mod = tostring( types[Random(1, #types)] ) .. ".xml,"
		if rand_mod == "mutant_spider.xml," then
			c.fire_rate_wait = c.fire_rate_wait + 15
			c.pattern_degrees = 10
			clone_next_projectile(3)
		else
			c.extra_entities = c.extra_entities .. "mods/Binding-of-Noita/files/actions/" .. rand_mod
		end

		draw_actions( 1, true )
	end,
} )

table.insert( actions,
{
	id          = "HEAD_OF_THE_KEEPER",
	name 		= "Head of the Keeper",
	description = "Spells have chance to drop gold on hit",
	sprite 		= "mods/Binding-of-Noita/files/sprites/head_of_the_keeper.png",
	type 		= ACTION_TYPE_MODIFIER,
	spawn_level			= "0,1,2,3,4,5,6",
	spawn_probability	= ".2,.2,.2,.2,.2,.2,.2",
	price = 400,
	mana = 5,
	action 		= function()
		SetRandomSeed( GameGetFrameNum(), GameGetFrameNum() )
		if Random(1,4) == 1 then
			c.extra_entities = c.extra_entities .. "mods/Binding-of-Noita/files/actions/head_of_the_keeper.xml,"
		end
		c.extra_entities = c.extra_entities .. "data/entities/particles/gold_sparks.xml,"
		draw_actions( 1, true )
	end,
} )

table.insert( actions,
{
	id          = "INFESTATION_2",
	name 		= "Infestation 2",
	description = "Chance to infest enemies",
	sprite 		= "mods/Binding-of-Noita/files/sprites/infestation2.png",
	type 		= ACTION_TYPE_MODIFIER,
	spawn_level			= "1,3,5,6",
	spawn_probability	= ".3,.3,.4,.5",
	price = 400,
	mana = 20,
	action 		= function()
		c.extra_entities = c.extra_entities .. "mods/Binding-of-Noita/files/actions/infestation2.xml,"
		draw_actions( 1, true )
	end,
} )

table.insert( actions,
{
	id          = "IPECAC",
	name 		= "Ipecac",
	description = "Explosive bile!",
	sprite 		= "mods/Binding-of-Noita/files/sprites/ipecac.png",
	type 		= ACTION_TYPE_MODIFIER,
	spawn_level			= "0,1,2,3,4,5,6",
	spawn_probability	= ".2,.2,.2,.3,.2,.2,.2",
	price = 650,
	mana = 30,
	action 		= function()
		c.speed_multiplier = c.speed_multiplier * 0.3
		c.fire_rate_wait = c.fire_rate_wait + 40
		current_reload_time = current_reload_time + 40
		c.extra_entities = c.extra_entities .. "mods/Binding-of-Noita/files/actions/ipecac.xml,"
		draw_actions( 1, true )
	end,
} )

table.insert( actions,
{
	id          = "LOKIS_HORNS",
	name 		= "Loki's Horns",
	description = "Chance to shoot a cross shot",
	sprite 		= "mods/Binding-of-Noita/files/sprites/lokis_horns.png",
	type 		= ACTION_TYPE_MODIFIER,
	spawn_level			= "0,1,3,5",
	spawn_probability	= ".9,.9,.9,.9",
	price = 50,
	mana = 8,
	action 		= function()
		c.pattern_degrees = 180
		SetRandomSeed( GameGetFrameNum(), GameGetFrameNum() )
		if Random( 1, 5 ) == 1 then
			clone_next_projectile( 3 )	-- Clone 3 in addition to drawn projectile
		end
		draw_actions( 1, true )
	end,
} )

table.insert( actions,			-- NOTE: Some unintened entities may be getting charmed
{
	id          = "MOMS_EYESHADOW",
	name 		= "Mom's Eyeshadow",
	description = "Chance to charm enemies",
	sprite 		= "mods/Binding-of-Noita/files/sprites/moms_eyeshadow.png",
	type 		= ACTION_TYPE_MODIFIER,
	spawn_level			= "0,2,3,4,5",
	spawn_probability	= ".2,.3,.4,.5,.5",
	price = 400,
	mana = 25,
	action 		= function()
		c.extra_entities = c.extra_entities .. "mods/Binding-of-Noita/files/actions/moms_eyeshadow.xml,"
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
	spawn_level			= "0,2,3,4,5,6",
	spawn_probability	= ".2,.2,.3,.3,.4,.4",
	price = 550,
	mana = 20,
	action 		= function()
		c.fire_rate_wait = c.fire_rate_wait + 24
		c.pattern_degrees = 10
		clone_next_projectile( 3 )	-- Clone 3 in addition to drawn projectile
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
	spawn_level                       = "1,2,3,4",
	spawn_probability                 = "1,.6,.3,.1",
	price = 300,
	mana = 5,
	action 		= function()
			c.fire_rate_wait = c.fire_rate_wait * .5
			current_reload_time = current_reload_time * .5
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
	spawn_probability                 = ".2,.4,.6,.6,.8,1,1",
	price = 366,
	mana = 6,
	action 		= function()
		c.extra_entities    = c.extra_entities .. "mods/Binding-of-Noita/files/actions/ouija_board.xml,"
		draw_actions( 1, true )
	end,
} )

table.insert( actions,
{
	id          = "PLAYDOUGH_COOKIE",
	name 		= "Playdough Cookie",
	description = "A rainbow of effects!",
	sprite 		= "mods/Binding-of-Noita/files/sprites/playdough_cookie.png",
	type 		= ACTION_TYPE_MODIFIER,
	spawn_level			= "0,1,2,3,4,5,6",
	spawn_probability	= ".2,.2,.2,.2,.2,.2,.2",
	price = 280,
	mana = 15,
	action 		= function()
		local types = {"confusion", "apply_on_fire", "charm_short", "frozen_short", "drunk", "oiled",
			"electricity", "rainbow_farts", "poison", "radioactive", "jarate", "bloody" }

		SetRandomSeed( GameGetFrameNum(), GameGetFrameNum() )
		local rand_effect = tostring( types[Random(1, #types)] ) .. ".xml,"
		c.game_effect_entities = c.game_effect_entities .. "data/entities/misc/effect_" .. rand_effect
		c.extra_entities = c.extra_entities .. "mods/Binding-of-Noita/files/actions/playdough_cookie.xml,"

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
	spawn_probability                 = "0.4,0.4,0.4,0.4",
	price = 950,
	mana = 40,
	action 		= function()
		shot_effects.recoil_knockback = shot_effects.recoil_knockback + 30.0
		c.damage_projectile_add = .6
		c.speed_multiplier	= c.speed_multiplier * .6
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
	description = "Bouncy effect",
	sprite 		= "mods/Binding-of-Noita/files/sprites/rubber_cement.png",
	type 		= ACTION_TYPE_MODIFIER,
	spawn_level                       = "0,3,4,5,6",
	spawn_probability                 = ".3,.7,.7,.7,.7",
	price = 300,
	mana = 5,
	action 		= function()
		c.extra_entities    = c.extra_entities .. "mods/Binding-of-Noita/files/actions/rubber_cement.xml,"
		c.bounces = c.bounces + 16
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
	spawn_probability                 = "0.2,0.2,0.2,0.2",
	price = 1777,
	mana = 77,
	action 		= function()
		shot_effects.recoil_knockback = shot_effects.recoil_knockback + 30.0
		c.damage_projectile_add = .8
		c.speed_multiplier = c.speed_multiplier * .4
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
	spawn_probability                 = ".6,.3,.6,.3,.6,.3",
	price = 180,
	mana = 15,
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
	spawn_probability	= ".8,.8",
	price = 240,
	mana = 6,
	action 		= function()
		c.lightning_count = c.lightning_count + 1
		SetRandomSeed( GameGetFrameNum(), GameGetFrameNum() )
		if Random(1, 5) == 10 then
			c.damage_electricity_add = c.damage_electricity_add + 0.1
		end
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
	spawn_probability	= "0.2,0.2,.5,.5,.5,.5,.5",
	price = 480,
	mana = 4,
	action 		= function()
		c.lightning_count = c.lightning_count + 1
		c.fire_rate_wait = 7
		--for i, action in ipairs( deck ) do					-- No reload if last projectile in deck
		--	print(action.id)
		--end
		if next(deck) == nil then
			current_reload_time = 7
		end
		SetRandomSeed( GameGetFrameNum(), GameGetFrameNum() )
		if Random(1, 10) == 10 then
			c.damage_electricity_add = c.damage_electricity_add + 0.1
		end
		add_projectile("mods/Binding-of-Noita/files/actions/technology.xml")
	end,
} )

table.insert( actions,
{
	id          = "THE_WIZ",
	name 		= "The Wiz",
	description = "Double shot, R U a wizard?",
	sprite 		= "mods/Binding-of-Noita/files/sprites/the_wiz.png",
	type 		= ACTION_TYPE_MODIFIER,
	spawn_level			= "0,1,2,3",
	spawn_probability	= ".4,.4,.4,.4",
	price = 75,
	mana = 5,
	action 		= function()
		c.pattern_degrees = 30
		clone_next_projectile( 1 )	--Clone drawn projectile
		draw_actions( 1, true )		--Draw modifiers and projectile
	end,
} )

---------------------------------------------------------
--------------------ABANDONED FOR NOW--------------------

--table.insert( actions,		--Possible solution may be inserting split action into deck
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
--		clone_next_projectile( 2 )	-- This is just action.action() 2 times (From the next drawn action)
--		draw_actions( 1, true )		-- Draw modifiers and projectile
--
--		-- Find the cloned actions by tag
--		local entity_id = GetUpdatedEntityID()
--		local x, y = EntityGetTransform( entity_id )
--		local clone_ids = EntityGetInRadiusWithTag( x, y, 16, "card_action" )
--		for _,clone_id in pairs( clone_ids ) do
--			-- This is a bad approach
--		end
--	end,
--} )