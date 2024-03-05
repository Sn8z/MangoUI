local _, mUI = ...
local LSM = LibStub("LibSharedMedia-3.0")

hooksecurefunc(BuffFrame.AuraContainer, "UpdateGridLayout", function(self, auras)
	for _, aura in ipairs(auras) do
		local icon = aura.Icon
		icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

		local size = mUI.profile.settings.borderSize or 1
		local border = CreateFrame("Frame", nil, aura, "BackdropTemplate")
		border:SetPoint("TOPLEFT", icon, "TOPLEFT", -size, size)
		border:SetPoint("BOTTOMRIGHT", icon, "BOTTOMRIGHT", size, -size)
		border:SetBackdrop({
			edgeFile = [[Interface\AddOns\MangoUI\Media\border.tga]],
			edgeSize = size
		})
		border:SetBackdropColor(0, 0, 0, 0)
		border:SetBackdropBorderColor(0, 0, 0, 1)

		aura.Count:SetFont(LSM:Fetch("font", mUI.profile.settings.font), 16, "OUTLINE")
		aura.Count:ClearAllPoints()
		aura.Count:SetPoint("CENTER", aura, "TOP", 0, 0)

		aura.Duration:ClearAllPoints()
		aura.Duration:SetPoint("TOP", aura.Icon, "BOTTOM", 0, -1)
	end
end)
