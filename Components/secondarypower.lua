local _, mUI = ...
local LSM = LibStub("LibSharedMedia-3.0")

function mUI:CreateSecondaryPowerBar(self)
	if not self then return end
	local AdditionalPower = CreateFrame('StatusBar', nil, self.Health)

	AdditionalPower:SetStatusBarTexture(LSM:Fetch("statusbar", mUI.db.settings.texture))
	AdditionalPower:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", 0, 0)
	AdditionalPower:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", 0, 0)
	AdditionalPower:SetHeight(2)

	mUI:CreateBorder(AdditionalPower)

	local Background = AdditionalPower:CreateTexture(nil, 'BACKGROUND')
	Background:SetAllPoints(AdditionalPower)
	Background:SetTexture(LSM:Fetch("statusbar", mUI.db.settings.texture))
	Background.multiplier = 1 / 3

	AdditionalPower.colorPower = true
	AdditionalPower.colorClass = true
	AdditionalPower.frequentUpdates = true

	AdditionalPower.bg = Background
	self.AdditionalPower = AdditionalPower
end
