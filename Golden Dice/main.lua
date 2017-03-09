local GoldenDice = RegisterMod("Golden Dice", 1);
local goldendice_item = Isaac.GetItemIdByName("Golden Dice");
local game = Game();

local specialItems = {
	118,
	283,
	105,
	52,
	168,
	331,
	329,
	114,
	153,
	169,
	223,
	182
}

function GoldenDice:use_goldendice()
	local entities = Isaac.GetRoomEntities();
	local player = Isaac.GetPlayer(0);
	for a = 1, #entities do
		local currentEntity = entities[a];
		if (currentEntity.Type == EntityType.ENTITY_PICKUP) and (currentEntity.Variant == PickupVariant.PICKUP_COLLECTIBLE) then
			if (player:GetNumCoins() == 99) then
				player:AddCoins(-99);
				currentEntity:ToPickup():Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, specialItems[math.random(0,11)], false);
			else
				player:DischargeActiveItem();
			end
		end
	end
end

GoldenDice:AddCallback(ModCallbacks.MC_USE_ITEM, GoldenDice.use_goldendice, goldendice_item);