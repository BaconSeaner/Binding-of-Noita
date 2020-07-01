table.insert( actions,
{
	id          = "LOKIS_HORNS",
	name 		= "Loki's Horns",
	description = "Chance to shoot a cross(4) shot",
	sprite 		= "mods/Binding-of-Noita/files/actions/lokis_horns.png",
	type 		= ACTION_TYPE_MODIFIER,
	spawn_level			= "0,1,2,3,4,5,6",
	spawn_probability	= "10,10,5,1,1,1,1",
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
	spawn_probability	= "1,1,1,2,5,10,10",
	price = 320,
	mana = 25,
	--max_uses = 100,
	action 		= function()
		SetRandomSeed( GameGetFrameNum(), GameGetFrameNum() )
		local types = {"lance","laser","bouncy_orb","spore_pod","tentacle","rubber_ball","slime","bullet","arrow","fireball_ray","bullet_heavy","light_bullet","light_bullet_blue"}
		local rnd = Random(1, #types)
		local rand_shot = tostring(types[rnd]) .. ".xml"
		add_projectile("data/entities/projectiles/deck/" .. rand_shot)
		c.fire_rate_wait = c.fire_rate_wait + 7
	end,
} )