dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

local target = EntityGetName( EntityGetClosest( x, y, "") )
if ( target ~= "$animal_longleg" and target ~= "$projectile_default" and target ~= "unknown" and target ~= "") then

	SetRandomSeed( GameGetFrameNum(), GameGetFrameNum() )
	local entity_count = Random(1, 2)

	for j=1,entity_count do
		local eid = EntityLoad( "data/entities/animals/longleg.xml", x, y )

		local charm_component = GetGameEffectLoadTo( eid, "CHARM", true )
		--if ( charm_component == 0 ) then return end
		if( charm_component ) then
			ComponentSetValue( charm_component, "frames", -1 )
		end

		-- so that hatched enemies don't drop gold
		local lua_components = EntityGetComponent( eid, "LuaComponent")
		if( lua_components ~= nil ) then
			for i,lua_comp in ipairs(lua_components) do
				if( ComponentGetValue( lua_comp, "script_death") == "data/scripts/items/drop_money.lua" ) then
					-- this crashes the game, so let's just set this to NULL
					-- EntityRemoveComponent( eid, lua_comp )
					ComponentSetValue( lua_comp, "script_death", "" )
				end
			end
		end

		local damagemodels = EntityGetComponent( eid, "DamageModelComponent" )
		if( damagemodels ~= nil ) then
			for i,damagemodel in ipairs(damagemodels) do
				local max_hp = tonumber( ComponentGetValue( damagemodel, "max_hp" ) )

				max_hp = max_hp * 4
				
				ComponentSetValue( damagemodel, "max_hp", max_hp )
				ComponentSetValue( damagemodel, "hp", max_hp )
			end
		end
	end
end