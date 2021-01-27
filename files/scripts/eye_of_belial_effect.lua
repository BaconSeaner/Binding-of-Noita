local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

-- If passed through an enemy: Proc effect then stop script
local target_ids = EntityGetInRadiusWithTag( x, y, 16, "enemy" )
if #target_ids ~= 0 then
	-- Proc the eye of belial effect
	EntityLoadToEntity( "mods/Binding-of-Noita/files/actions/eye_of_belial_effect.xml", entity_id )
	
	local proj_comps = EntityGetComponent( entity_id, "ProjectileComponent" )
    if proj_comps then                                              
        for i, comp in ipairs(proj_comps) do
            ComponentSetValue2( comp, "on_collision_die" , false )
        end
    end
    
	-- Prevent this script from executing again
	local comp = EntityGetFirstComponent( entity_id, "LuaComponent")
	ComponentSetValue2( comp, "script_source_file" , "" )
end