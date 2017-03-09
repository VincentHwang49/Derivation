local NoMoreStoneys = RegisterMod("No More Stoneys", 1);
local game = Game();

function NoMoreStoneys:updaterino()
	local entities = Isaac.GetRoomEntities();
	
	-- Entity Loop
	for a = 1, #entities do
	
		-- Necessary stuff
		local currentEntity = entities[a];
		local currentFloor = Game():GetLevel();
		local currentStage = currentFloor:GetStage();
		local currentStageType = currentFloor:GetStageType();
		local currentRoom = Game():GetRoom();
		
		-- Determining which fatty to spawn instead of stoney
		if (currentEntity.Type == 302) then
			currentEntity:ToNPC():Remove();
			if (currentStage < 3) and (currentStageType == 2) then
				Isaac.Spawn(208, 2, 0, currentEntity.Position, currentEntity.Velocity, nil);
			elseif (currentStage > 2) then
				Isaac.Spawn(208, 1, 0, currentEntity.Position, currentEntity.Velocity, nil);
			else
				Isaac.Spawn(208, 0, 0, currentEntity.Position, currentEntity.Velocity, nil);
			end
		end
	end
end

NoMoreStoneys:AddCallback(ModCallbacks.MC_POST_UPDATE, NoMoreStoneys.updaterino);