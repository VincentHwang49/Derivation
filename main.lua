local Derivation = RegisterMod("Derivation", 1);
local derivation_item = Isaac.GetItemIdByName("Derivation");
local debug_text = "top kek";

local exceptionList = {
	{EntityType.ENTITY_FAT_BAT, EntityType.ENTITY_ONE_TOOTH}, -- "Fat Bat" to "One Tooth"
	{EntityType.FLAMINGHOPPER, EntityType.HOPPER}, -- "Flaming Hopper" to "Hopper"
	{305, EntityType.HOPPER}, -- "Ministro" to "Hopper"
	{300, EntityType.ENTITY_HOST} -- "Mushroom" to "Host"
}

local specialExceptionList = {
	278, -- Black Globin
	EntityType.ENTITY_LITTLE_HORN,
	-- All the types after this should not be derivated, no matter what!
	406
}

-- Variantless Exception
local function variantlessException(a, cE)
	cE:Remove();
	Isaac.Spawn(exceptionList[a][2], 0, cE.SubType, cE.Position, cE.Velocity, player)
end
-- Special Exception
local function specialException(cE)
	if (cE.Type == specialExceptionList[1]) then
		cE:Remove();
		Isaac.Spawn(EntityType.ENTITY_GLOBIN, 2, cE.SubType, cE.Position, cE.Velocity, player)
	end
	if (cE.Type == specialExceptionList[2]) then
		if not (cE.Variant == 1) then
			if not (cE.SubType == 0) then
				cE:Remove();
				Isaac.Spawn(EntityType.ENTITY_LITTLE_HORN, cE.Variant, 0, cE.Position, cE.Velocity, player)
			end
		end
	end
end

local function checkException(cE)
	local result = {0,0}
	-- Check if in variantless exception list
	for a = 1, #exceptionList do
		if cE.Type == exceptionList[a] then
			result = {a,1};
		end
	end
	-- Check if in special exception list
	for a = 1, #specialExceptionList do
		if cE.Type == specialExceptionList[a] then
			result = {a,2};
		end
	end
	return result;
end

-- On use
function Derivation:use_derivation()
	local entities = Isaac.GetRoomEntities();
	local player = Isaac.GetPlayer(0);
	for a = 1, #entities do
		local cE = entities[a];
		local chex = checkException(cE);
		
		-- General Procedure
		if ((cE:IsVulnerableEnemy()) and (chex[1] == 0 and chex[2] == 0)) and ((cE.Variant - 1) >= 0) then
			cE:Remove();
			Isaac.Spawn(cE.Type, (cE.Variant - 1), cE.SubType, cE.Position, cE.Velocity, player)
		-- Exceptional Procedures
		else
			if cE:IsVulnerableEnemy() then
				if (chex[2] == 1) then
					variantlessException(chex[1], cE);
				elseif (chex[2] == 2) then
					specialException(cE);
				end
			end
		end
	end
	-- Return true for the animation to play upon usage.
	return true;
end

-- For testing
function Derivation:testing()
	local player = Isaac.GetPlayer(0);
	if ((Game():GetFrameCount()) == 1) then
		rxy = math.random(100,200);
		Isaac.Spawn(15, 0, 0, Vector(rxy, rxy), Vector(1,0), player);
		Isaac.Spawn(15, 1, 0, Vector(rxy, rxy), Vector(1,0), player);
		Isaac.Spawn(15, 2, 0, Vector(rxy, rxy), Vector(1,0), player);
	end
end

-- For Debugging
function Derivation:renderText()
	local entities = Isaac.GetRoomEntities();
	for a = 1, #entities do
		local cE = entities[a];
		local cEX = Game():GetRoom():WorldToScreenPosition(cE.Position, 2).X
		local cEY = Game():GetRoom():WorldToScreenPosition(cE.Position, 2).Y
		local tText = "Type: " .. tostring(cE.Type)
		local sText = "Subtype: " .. tostring(cE.SubType)
		local vText = "Variant: " .. tostring(cE.Variant)
		local chex = checkException(cE);
		if (cE:IsVulnerableEnemy()) then
			Isaac.RenderText(tText, (cEX - 20), (cEY - 70), 200, 0, 0, 120)
			Isaac.RenderText(vText, (cEX - 20), (cEY - 60), 0, 200, 0, 120)
			Isaac.RenderText(sText, (cEX - 20), (cEY - 50), 0, 0, 200, 120)
			Isaac.RenderText(tostring(((cE:IsVulnerableEnemy()) and (chex[1] == 0 and chex[2] == 0)) and ((cE.Variant - 1) >= 0)), (cEX - 20), (cEY - 80), 1, 1, 1, 120)
		end
	end
end

Derivation:AddCallback(ModCallbacks.MC_USE_ITEM, Derivation.use_derivation, derivation_item);
Derivation:AddCallback(ModCallbacks.MC_POST_RENDER, Derivation.renderText);
--Derivation:AddCallback(ModCallbacks.MC_POST_UPDATE, Derivation.testing);
