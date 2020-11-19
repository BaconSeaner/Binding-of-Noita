local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

-- If passing through enemy proc effect and stop script
local target_ids = EntityGetInRadiusWithTag( x, y, 16, "enemy" )
if #target_ids ~= 0 then
print("Hit!")
	-- Proc the eye of belial effect
	EntityLoadToEntity( "mods/Binding-of-Noita/files/actions/eye_of_belial_effect.xml", entity_id )
	-- Stop this script from executing again to prevent lag
	local comp = EntityGetFirstComponent( entity_id, "LuaComponent")
	ComponentSetValue2( comp, "script_source_file" , "" )
end