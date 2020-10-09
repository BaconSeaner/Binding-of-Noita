-- Chance of proc
SetRandomSeed(GameGetFrameNum(), GameGetFrameNum())
if Random(1,5) ~= 1 then return end

-- Enable all components
local entity_id = GetUpdatedEntityID()

for _,comp in pairs(EntityGetAllComponents( entity_id )) do
	EntitySetComponentIsEnabled( entity_id, comp, true )
end