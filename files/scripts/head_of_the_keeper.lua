SetRandomSeed( GameGetFrameNum(), GameGetFrameNum() )
if Random(1,5) ~= 1 then return end		-- Chance of proc

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

for i=1, Random(1,2) do
	local eid = EntityLoad( "data/entities/items/pickup/goldnugget_10.xml", x, y )
end