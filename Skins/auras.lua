local addonName, mUI = ...
local LSM = LibStub("LibSharedMedia-3.0")

local function SkinAura(aura)
	if aura.isAuraAnchor or aura.skinned then return end
	local icon = aura.Icon
	if icon then
		icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	end

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
	border:SetFrameLevel(2)
	aura.Border = border

	if aura.Count then
		aura.Count:SetFont(LSM:Fetch("font", mUI.profile.settings.font), 14, "OUTLINE")
		aura.Count:ClearAllPoints()
		aura.Count:SetPoint("CENTER", icon, "TOP", 0, 0)
	end

	if aura.Duration then
		aura.Duration:SetFont(LSM:Fetch("font", mUI.profile.settings.font), 10, "OUTLINE")
	end

	if aura.DebuffBorder then
		aura.DebuffBorder:SetTexture([[Interface\AddOns\MangoUI\Media\debuffoverlay.tga]])
		aura.DebuffBorder:SetAllPoints(icon)
		aura.DebuffBorder:SetTexCoord(0, 1, 0, 1)
	end

	if aura.TempEnchantBorder then
		aura.TempEnchantBorder:SetTexture([[Interface\AddOns\MangoUI\Media\highlight.tga]])
		aura.TempEnchantBorder:SetAllPoints(icon)
		aura.TempEnchantBorder:SetTexCoord(0, 1, 0, 1)
		aura.TempEnchantBorder:SetVertexColor(0.7, 0.2, 3, 1)
	end

	aura.skinned = true
end

local function SkinAuras()
	hooksecurefunc(BuffFrame.AuraContainer, "UpdateGridLayout", function(self, auras)
		for _, aura in ipairs(auras) do
			SkinAura(aura)
		end
	end)

	hooksecurefunc(DebuffFrame.AuraContainer, "UpdateGridLayout", function(self, auras)
		for _, aura in ipairs(auras) do
			SkinAura(aura)
		end
	end)
end

local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(_, event, name)
	if mUI.profile.settings.auras.enabled and addonName == name then
		SkinAuras()
	end
end)
