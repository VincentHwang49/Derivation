local VincentsCoat = RegisterMod("Vincent's Coat", 1);
local red = 0;
local storage = 0;
local game = Game();

function VincentsCoat:onDamage(entity, dmgAmount, dmgFlag, source, dmgCountdownFrames)
	red = red + 1;
	local player = Isaac.GetPlayer(0)
	local pColor = player:GetColor();
	if (entity.Type == player.Type) and not ((red + storage) >= 255) then
		storage = storage + dmgAmount;
		player:SetColor(Color((pColor.R + dmgAmount),pColor.G, pColor.B, pColor.A, pColor.RO, pColor.GO, pColor.BO), 0, 1, false, false)
	elseif (entity.Type == player.Type) and ((red + storage) >= 255) then
		local position = Vector(player.Position.X - 50, player.Position.Y)
		Isaac.Spawn(3, TearVariant.DIAMOND, 0, position, Vector(-5,-5), player)
	end
end

VincentsCoat:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, VincentsCoat.onDamage)