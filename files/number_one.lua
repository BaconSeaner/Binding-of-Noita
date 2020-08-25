local entity_id = GetUpdatedEntityID()
local proj_comps = EntityGetComponent( entity_id, "ProjectileComponent" )

if proj_comps then
    for i, comp in ipairs(proj_comps) do
        local lifetime = ComponentGetValue2( comp, "lifetime" )
        ComponentSetValue2( comp, "lifetime", lifetime / 5 )
    end
end