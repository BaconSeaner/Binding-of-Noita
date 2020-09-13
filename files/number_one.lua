local entity_id = GetUpdatedEntityID()

local lua_comp = EntityGetFirstComponent( entity_id, "LuaComponent" )
local source = nil
if lua_comp then
    source = ComponentGetValue2( lua_comp, "script_source_file" )
end
if source == "data/scripts/projectiles/megalaser_launch.lua" then return end

local proj_comps = EntityGetComponent( entity_id, "ProjectileComponent" )
if proj_comps then
    for i, comp in ipairs(proj_comps) do
        local lifetime = ComponentGetValue2( comp, "lifetime" )
        ComponentSetValue2( comp, "lifetime", lifetime / 5 )
    end
end