local _, mUI = ...
local LSM = LibStub("LibSharedMedia-3.0")

function mUI:CreateSecondaryPowerBar(self)
	if not self then return end

	local AdditionalPower = CreateFrame("StatusBar", nil, self.Health)
	AdditionalPower:SetStatusBarTexture(LSM:Fetch("statusbar", mUI.profile.settings.powerTexture))
	PixelUtil.SetPoint(AdditionalPower, "BOTTOMLEFT", self, "BOTTOMLEFT", 0, 0)
	PixelUtil.SetPoint(AdditionalPower, "BOTTOMRIGHT", self, "BOTTOMRIGHT", 0, 0)
	PixelUtil.SetHeight(AdditionalPower, 4)
	--AdditionalPower:SetFrameLevel(self.Health:GetFrameLevel() + 1)

	AdditionalPower.colorPower = true
	AdditionalPower.colorClass = true
	AdditionalPower.frequentUpdates = true

	local Background = AdditionalPower:CreateTexture(nil, "BACKGROUND")
	Background:SetAllPoints(AdditionalPower)
	Background:SetTexture(LSM:Fetch("statusbar", mUI.profile.settings.powerTexture))
	Background.multiplier = 1 / 4
	AdditionalPower.bg = Background

	self.AdditionalPower = AdditionalPower
end
