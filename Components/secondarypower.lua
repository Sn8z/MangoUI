local _, mUI = ...
local LSM = LibStub("LibSharedMedia-3.0")

function mUI:CreateSecondaryPowerBar(self)
	if not self then return end

	local AdditionalPower = CreateFrame("StatusBar", nil, self)
	AdditionalPower:SetStatusBarTexture(LSM:Fetch("statusbar", mUI.profile.settings.powerTexture))
	AdditionalPower:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", 0, 0)
	AdditionalPower:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", 0, 0)
	AdditionalPower:SetFrameLevel(self.Health:GetFrameLevel() + 1)

	-- TODO: add as settings
	AdditionalPower:SetHeight(4)
	--mUI:CreateBorder(AdditionalPower)
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
