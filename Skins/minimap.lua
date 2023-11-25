local _, mUI = ...

local f = CreateFrame("Frame")
f:RegisterEvent("VARIABLES_LOADED")
f:SetScript("OnEvent", function()
	if mUI.profile.settings.minimap.enabled then
		Minimap:SetMaskTexture([[Interface\AddOns\MangoUI\Media\white.tga]])
		local size = 2
		local border = CreateFrame("Frame", "MinimapBorder", Minimap, "BackdropTemplate")
		border:SetBackdrop({
			--edgeFile = [[Interface\AddOns\MangoUI\Media\borderglow.tga]],
			edgeFile = [[Interface\AddOns\MangoUI\Media\border.tga]],
			edgeSize = size,
		})
		border:SetPoint("TOPLEFT", Minimap, "TOPLEFT", -size, size)
		border:SetPoint("BOTTOMRIGHT", Minimap, "BOTTOMRIGHT", size, -size)
		border:SetFrameStrata(Minimap:GetFrameStrata())
		border:SetFrameLevel(Minimap:GetFrameLevel())
		border:SetBackdropColor(0, 0, 0, 1)
		border:SetBackdropBorderColor(0, 0, 0, 1)
		MinimapBackdrop:Hide()

		ExpansionLandingPageMinimapButton:ClearAllPoints()
		ExpansionLandingPageMinimapButton:SetParent(Minimap)
		ExpansionLandingPageMinimapButton:SetPoint("TOPRIGHT", 12, 12)

		function GetMinimapShape()
			return "SQUARE"
		end
	end
end)
