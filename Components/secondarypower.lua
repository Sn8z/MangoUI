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

	local altPowerPrediction = CreateFrame("StatusBar", nil, AdditionalPower)
	altPowerPrediction:SetStatusBarTexture(LSM:Fetch("statusbar", mUI.profile.settings.powerTexture))
	altPowerPrediction:SetStatusBarColor(0.7, 0.7, 0.7, 0.5)
	altPowerPrediction:SetReverseFill(true)
	altPowerPrediction:SetPoint("TOP")
	altPowerPrediction:SetPoint("BOTTOM")
	altPowerPrediction:SetPoint("RIGHT", AdditionalPower:GetStatusBarTexture(), "RIGHT")
	altPowerPrediction:SetWidth(200)

	if self.PowerPrediction then
		self.PowerPrediction.altBar = altPowerPrediction
	else
		self.PowerPrediction = {
			altBar = altPowerPrediction,
		}
	end
end
