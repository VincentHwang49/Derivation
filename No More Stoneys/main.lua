local MyMod = RegisterMod("Earthshaker",1)
local Earthshaker = Isaac.GetItemIdByName("Earthshaker")

function MyMod:Update()
local player = Isaac.GetPlayer(0)
	if player:HasCollectible(Earthshaker) then
		Isaac.Spawn(EntityType.ENTITY_EFFECT,EffectVariant.SHOCKWAVE, 0, player.Position,Vector(1,1),player))
	end
end
	
MyMod:AddCallback(ModCallbacks.MC_POST_UPDATE, MyMod.Update)