local entity_id = GetUpdatedEntityID()

local source = nil
local lua_comp = EntityGetFirstComponent( entity_id, "LuaComponent" )
if lua_comp then source = ComponentGetValue2( lua_comp, "script_source_file" ) end
if source == "data/scripts/projectiles/megalaser_launch.lua" then return end    --Incompatible with this projectile

local proj_comps = EntityGetComponent( entity_id, "ProjectileComponent" )
if proj_comps then                                              
    for i, comp in ipairs(proj_comps) do
        local lifetime = ComponentGetValue2( comp, "lifetime" )
        ComponentSetValue2( comp, "lifetime", lifetime / 5 )    --Find lifetime in projectile components and adjust them
    end
end