local Niko = RegisterMod("Niko", 1);
local debug_text = "Nothing"
local mH = 0;
local sH = 0;
local bH = 0;
local eH = 0;

function Niko:updaterino()
	local player = Isaac.GetPlayer(0);
	if (player:GetName() == "Niko") then
		debug_text = "Inside";
		mH = player:GetMaxHearts();
		if (mH > 0) then
			player:AddMaxHearts(-1, false);
		end
		sH = player:GetSoulHearts();
		if (sH > 1) then
			player:AddSoulHearts(-1);
		end
		bH = player:GetBlackHearts();
		if (bH > 1) then
			player:AddBlackHearts(-1);
		end
		eH = player:GetEternalHearts();
		if (eH > 0) then
			player:AddEternalHearts(-1);
		end
	end
end

function Niko:renderText()
	Isaac.RenderText(debug_text, 300, 400, 255, 0, 0, 255);
end

--Niko:AddCallback(ModCallbacks.MC_POST_UPDATE, Niko.updaterino);
Niko:AddCallback(ModCallbacks.MC_POST_RENDER, Niko.updaterino);
