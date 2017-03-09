local ShieldMod = RegisterMod("BL2ShieldMod", 1)
local floornumber = Game():GetLevel():GetStage()
local player = Isaac.GetPlayer(0)
local damage = player.Damage
local game = Game()

local ShieldID = {
	BEESHIELD = Isaac.GetItemIdByName("Bee Shield")
}

local HasShield = {
	BeeShield = false
}

local function UpdateShield(player)
	HasShield.BeeShield = player:HasCollectible(ShieldID.BEESHIELD)
end

function ShieldMod:onPlayerInit(player)
	UpdateShield(player)
end

function ShieldMod:onUpdate(player)

	-- Spawn item on startup
	if game:GetFrameCount() == 1 then
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, ShieldID.BEESHIELD, Vector(320, 300), Vector(0,0), nil)
	end
	
	UpdateShield(player)
	
	if player:HasCollectible(ShieldID.BEESHIELD) then
		if not player:HasFullHearts() then 
			damage = damage - ((damage / 5) + (floornumber / 5))
		end
		player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
		player:EvaluateItems()
	end
end

function ShieldMod:onCache(player, cacheFlag)
	if (cacheFlag == CacheFlag.CACHE_DAMAGE) then
		if player:HasCollectible(ShieldID.BEESHIELD) then
			if player:HasFullHearts() then 
				damage = damage + ((damage / 5) + (floornumber / 5))
			end
		end
	end
end

function ShieldMod:Update()
	if player:HasCollectible(ShieldID.BEESHIELD) then
		if player:HasFullHearts() then 
			damage = damage + ((damage / 5) + (floornumber / 5))
		else 
			damage = damage - ((damage / 5) + (floornumber / 5))
		end
		player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
		player:EvaluateItems()
	end
end

ShieldMod:AddCallback(ModCallbacks.MC_POST_UPDATE, ShieldMod.Update)
ShieldMod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, ShieldMod.onUpdate)
ShieldMod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, ShieldMod.onPlayerInit)
ShieldMod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, ShieldMod.onCache)