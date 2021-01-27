local entity_id = GetUpdatedEntityID()

local proj_comps = EntityGetComponent( entity_id, "ProjectileComponent" )
if proj_comps then                                              
    for i, comp in ipairs(proj_comps) do
        local lifetime = ComponentGetValue2( comp, "lifetime" )
        ComponentSetValue2( comp, "lifetime", lifetime * 2 )
		ComponentSetValue2( comp, "collide_with_entities" , false )
    end
end

--local damage = ComponentGetValue2( EntityGetFirstComponent( entity_id, "ProjectileComponent"), "damage" )
--ComponentSetValue2( EntityGetFirstComponent( entity_id, "AreaDamageComponent"), "damage_per_frame", damage / 2 )