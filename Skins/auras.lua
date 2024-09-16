local addonName, mUI = ...
local LSM = LibStub("LibSharedMedia-3.0")

local function UpdateAuraDuration(self, timeLeft)
	local days = floor(timeLeft / 86400)
	local hours = floor((timeLeft % 86400) / 3600)
	local minutes = floor((timeLeft % 3600) / 60)
	local seconds = timeLeft % 60

	if timeLeft >= 86400 then
		self.Duration:SetFormattedText("%dd:%02dh", days, hours)
	elseif timeLeft >= 3600 then
		self.Duration:SetFormattedText("%dh:%02dm", hours, minutes)
	elseif timeLeft >= 60 then
		self.Duration:SetFormattedText("%d:%02d", minutes, seconds)
	else
		self.Duration:SetFormattedText("%d", seconds)
	end
end

local function SkinBuff(buff)
	if buff.isAuraAnchor or buff.skinned then return end
	local icon = buff.Icon
	if icon then
		icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	end

	local size = 2
	local border = CreateFrame("Frame", nil, buff, "BackdropTemplate")
	border:SetAllPoints(icon)
	border:SetBackdrop({
		edgeFile = [[Interface\AddOns\MangoUI\Media\border.tga]],
		edgeSize = size
	})
	border:SetBackdropBorderColor(0, 0, 0, 1)

	if buff.Count then
		buff.Count:SetFont(LSM:Fetch("font", mUI.profile.settings.font), 14, "OUTLINE")
		buff.Count:ClearAllPoints()
		buff.Count:SetPoint("CENTER", icon, "CENTER", 0, 0)
	end

	if buff.Duration then
		buff.Duration:SetFont(LSM:Fetch("font", mUI.profile.settings.font), 10, "OUTLINE")
	end

	if buff.DebuffBorder then
		buff.DebuffBorder:SetTexture([[Interface\AddOns\MangoUI\Media\debuffoverlay.tga]])
		buff.DebuffBorder:SetAllPoints(icon)
		buff.DebuffBorder:SetTexCoord(0, 1, 0, 1)
	end

	if buff.TempEnchantBorder then
		buff.TempEnchantBorder:SetTexture([[Interface\AddOns\MangoUI\Media\highlight.tga]])
		buff.TempEnchantBorder:SetAllPoints(icon)
		buff.TempEnchantBorder:SetTexCoord(0, 1, 0, 1)
		buff.TempEnchantBorder:SetVertexColor(0.7, 0.2, 3, 1)
	end

	buff.skinned = true
end

local function SkinDebuff(debuff)
	if debuff.isAuraAnchor or debuff.skinned then return end
	local icon = debuff.Icon
	if icon then
		icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	end

	if debuff.Count then
		debuff.Count:SetFont(LSM:Fetch("font", mUI.profile.settings.font), 14, "OUTLINE")
		debuff.Count:ClearAllPoints()
		debuff.Count:SetPoint("CENTER", icon, "TOP", 0, 0)
	end

	if debuff.Duration then
		debuff.Duration:SetFont(LSM:Fetch("font", mUI.profile.settings.font), 10, "OUTLINE")
	end

	if debuff.DebuffBorder then
		debuff.DebuffBorder:SetTexture([[Interface\AddOns\MangoUI\Media\debuffoverlay.tga]])
		debuff.DebuffBorder:SetAllPoints(icon)
		debuff.DebuffBorder:SetTexCoord(0, 1, 0, 1)
	end

	if debuff.TempEnchantBorder then
		debuff.TempEnchantBorder:SetTexture([[Interface\AddOns\MangoUI\Media\highlight.tga]])
		debuff.TempEnchantBorder:SetAllPoints(icon)
		debuff.TempEnchantBorder:SetTexCoord(0, 1, 0, 1)
		debuff.TempEnchantBorder:SetVertexColor(0.7, 0.2, 3, 1)
	end

	debuff.skinned = true
end

local function SkinAuras()
	hooksecurefunc(BuffFrame.AuraContainer, "UpdateGridLayout", function(self, auras)
		for _, aura in ipairs(auras) do
			SkinBuff(aura)
		end
	end)

	hooksecurefunc(DebuffFrame.AuraContainer, "UpdateGridLayout", function(self, auras)
		for _, aura in ipairs(auras) do
			SkinDebuff(aura)
		end
	end)

	for _, auraFrame in pairs(BuffFrame.auraFrames) do
		if auraFrame.UpdateDuration then
			hooksecurefunc(auraFrame, "UpdateDuration", UpdateAuraDuration)
		end
	end

	for _, auraFrame in pairs(DebuffFrame.auraFrames) do
		if auraFrame.UpdateDuration then
			hooksecurefunc(auraFrame, "UpdateDuration", UpdateAuraDuration)
		end
	end
end

local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(_, event, name)
	if mUI.profile.settings.auras and addonName == name then
		SkinAuras()
	end
end)
