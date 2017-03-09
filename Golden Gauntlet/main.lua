local GoldenGauntlet = RegisterMod("Golden Gauntlet", 1);
local goldengauntlet_item = Isaac.GetItemIdByName("Golden Gauntlet");
local roomsUsed = {}

function GoldenGauntlet:use_goldengauntlet()
	roomsUsed[Game():GetRoom():GetSpawnSeed()] = true
	local entities = Isaac.GetRoomEntities();
	local player = Isaac.GetPlayer(0);
	Game():GetRoom():TurnGold();
	for a = 1, #entities do
		local currentEntity = entities[a];
		if currentEntity:IsVulnerableEnemy() then
			currentEntity:AddMidasFreeze(EntityRef(currentEntity) , 999999999);
		end
	end
end

function GoldenGauntlet:update()
	local entities = Isaac.GetRoomEntities();
	if roomsUsed[Game():GetRoom():GetSpawnSeed()] then
		Game():GetRoom():TurnGold();
		for a = 1, #entities do
			local currentEntity = entities[a];
			if currentEntity:IsVulnerableEnemy() then
				currentEntity:RemoveStatusEffects();
				currentEntity:AddMidasFreeze(EntityRef(currentEntity) , 999999999);
			end
		end
	end
end


GoldenGauntlet:AddCallback(ModCallbacks.MC_USE_ITEM, GoldenGauntlet.use_goldengauntlet, goldengauntlet_item);
GoldenGauntlet:AddCallback(ModCallbacks.MC_POST_UPDATE, GoldenGauntlet.update);