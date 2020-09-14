dofile_once("data/scripts/lib/utilities.lua")

SetRandomSeed( GameGetFrameNum(), GameGetFrameNum() )
if Random(1,10) <= 6 then return end

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )
local target_id = EntityGetClosest( x, y, "")

print(EntityGetTags( entity_id ))

local blacklist={"$animal_longleg",""}
for i=1,#blacklist do
	if EntityGetName( target_id ) == blacklist[i] then return end
end

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