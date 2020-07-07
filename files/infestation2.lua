dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

--local components = EntityGetComponent( entity_id, "VariableStorageComponent" )
--local entity_list_name = "monsters"

--if ( components ~= nil ) then
--	for key,comp_id in pairs(components) do
--		local var_name = ComponentGetValue( comp_id, "name" )
--		if ( var_name == "entity_list" ) then
--			entity_list_name = ComponentGetValue( comp_id, "value_string" )
--		end
--	end
--end

SetRandomSeed( GameGetFrameNum(), GameGetFrameNum() )
local entity_count = Random(1, 2)

for j=1,entity_count do
	local eid = EntityLoad( "data/entities/animals/longleg.xml", x, y )

	local charm_component = GetGameEffectLoadTo( eid, "CHARM", true )
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