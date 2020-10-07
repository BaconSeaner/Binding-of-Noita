dofile_once("data/scripts/lib/utilities.lua")

SetRandomSeed( GameGetFrameNum(), GameGetFrameNum() )
if Random(1,3) == 1 then return end		--Chance of proc

local entity_id = GetUpdatedEntityID()	--Init...
local x, y = EntityGetTransform( entity_id )
local target_id = EntityGetClosestWithTag( x, y, "enemy")

local hit = false						--Verify target was hit and is an intended entity
for k, v in pairs(EntityGetInRadiusWithTag( x, y, 2, "enemy" )) do
	if v == target_id then
		hit = true
	end
end
if not hit or EntityGetName( target_id ) == "$animal_longleg" then return end

local entity_count = Random(1, 2)		--Spawn 1 or 2 friends!
for j=1,entity_count do
	local eid = EntityLoad( "data/entities/animals/longleg.xml", x, y )

	local charm_component = GetGameEffectLoadTo( eid, "CHARM", true )
	if( charm_component ) then
		ComponentSetValue( charm_component, "frames", -1 )
	end

										--So that hatched enemies don't drop gold
	local lua_components = EntityGetComponent( eid, "LuaComponent")
	if( lua_components ~= nil ) then
		for i,lua_comp in ipairs(lua_components) do
			if( ComponentGetValue( lua_comp, "script_death") == "data/scripts/items/drop_money.lua" ) then
				ComponentSetValue( lua_comp, "script_death", "" )
			end
		end
	end
										--Super-friends!
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