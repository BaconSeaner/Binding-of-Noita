local entity_id = GetUpdatedEntityID()
local proj_comps = EntityGetComponent( entity_id, "ProjectileComponent" )

if proj_comps then                                              
    for i, comp in ipairs(proj_comps) do
		ComponentSetValue2( comp, "collide_with_world" , true )
		ComponentSetValue2( comp, "bounces_left" , 16 )
		ComponentSetValue2( comp, "bounce_energy" , 0.9 )
		ComponentSetValue2( comp, "bounce_always" , true )
		ComponentSetValue2( comp, "bounce_at_any_angle" , true )
		ComponentSetValue2( comp, "on_collision_die" , false )
		ComponentSetValue2( comp, "collide_with_entities" , true )
    end
end
