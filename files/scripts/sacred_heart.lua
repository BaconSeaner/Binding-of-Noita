local entity_id = GetUpdatedEntityID()
local proj_comps = EntityGetComponent( entity_id, "ProjectileComponent" )

if proj_comps then                                              
    for i, comp in ipairs(proj_comps) do
        local lifetime = ComponentGetValue2( comp, "lifetime" )
        ComponentSetValue2( comp, "lifetime", lifetime * 4 )
        ComponentSetValue2( comp, "penetrate_world", true )
        ComponentSetValue2( comp, "penetrate_world_velocity_coeff", 0.33 )
    end
end