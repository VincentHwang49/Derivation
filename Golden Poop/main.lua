local GoldenPoop = RegisterMod("Golden Poop", 1);
local goldenpoop_item = Isaac.GetItemIdByName("Golden Poop");
local game = Game();

function GoldenPoop:use_goldenpoop()
	local player = Isaac.GetPlayer(0);
	local ppos = player.Position;
	local gridIndex = game:GetRoom():GetGridIndex(ppos);
	game:GetRoom():SpawnGridEntity(gridIndex, GridEntityType.GRID_POOP, 3, RNG():GetSeed(), 0);
end

GoldenPoop:AddCallback(ModCallbacks.MC_USE_ITEM, GoldenPoop.use_goldenpoop, goldenpoop_item);