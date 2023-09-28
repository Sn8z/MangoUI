local _, mUI = ...
local LSM = LibStub("LibSharedMedia-3.0")

function mUI:CreateHealthPrediction(self)

	local WIDTH = {
		player = mUI.db.player.width,
		target = mUI.db.target.width,
		pet = mUI.db.pet.width,
		targettarget = mUI.db.targettarget.width,
		focus = mUI.db.focus.width,
		raid = mUI.db.raid.width,
		party = mUI.db.party.width
	}

	local frameLevel = self.Health:GetFrameLevel()
	local width = WIDTH[self.unit] or 150

	local healAbsorbBar = CreateFrame('StatusBar', nil, self.Health)
	healAbsorbBar:SetPoint('TOPRIGHT', self.Health:GetStatusBarTexture())
	healAbsorbBar:SetPoint('BOTTOMRIGHT', self.Health:GetStatusBarTexture())
	healAbsorbBar:SetFrameLevel(frameLevel)
	healAbsorbBar:SetWidth(width)
	healAbsorbBar:SetReverseFill(true)
	healAbsorbBar:SetStatusBarTexture(LSM:Fetch("statusbar", mUI.db.settings.texture))
	healAbsorbBar:SetStatusBarColor(0.75, 0.75, 0, 0.6)

	local overHealAbsorb = self.Health:CreateTexture(nil, 'OVERLAY')
	overHealAbsorb:SetWidth(5)
	overHealAbsorb:SetPoint('TOPRIGHT', self.Health, 'TOPLEFT')
	overHealAbsorb:SetPoint('BOTTOMRIGHT', self.Health, 'BOTTOMLEFT')

	local myBar = CreateFrame('StatusBar', nil, self.Health)
	myBar:SetPoint('TOPLEFT', self.Health:GetStatusBarTexture(), 'TOPRIGHT')
	myBar:SetPoint('BOTTOMLEFT', self.Health:GetStatusBarTexture(), 'BOTTOMRIGHT')
	myBar:SetFrameLevel(frameLevel)
	myBar:SetWidth(width)
	myBar:SetStatusBarTexture(LSM:Fetch("statusbar", mUI.db.settings.texture))
	myBar:SetStatusBarColor(0, 1, 0, 0.4)

	local otherBar = CreateFrame('StatusBar', nil, self.Health)
	otherBar:SetPoint('TOPLEFT', myBar:GetStatusBarTexture(), 'TOPRIGHT')
	otherBar:SetPoint('BOTTOMLEFT', myBar:GetStatusBarTexture(), 'BOTTOMRIGHT')
	otherBar:SetFrameLevel(frameLevel)
	otherBar:SetWidth(width)
	otherBar:SetStatusBarTexture(LSM:Fetch("statusbar", mUI.db.settings.texture))
	otherBar:SetStatusBarColor(0, 1, 0, 0.4)

	local absorbBar = CreateFrame("StatusBar", nil, self.Health)
	absorbBar:SetPoint("TOP")
	absorbBar:SetPoint("BOTTOM")
	absorbBar:SetPoint("LEFT", self.Health:GetStatusBarTexture(), "RIGHT")
	absorbBar:SetWidth(width)
	absorbBar:SetStatusBarTexture(LSM:Fetch("statusbar", mUI.db.settings.texture))
	absorbBar:SetStatusBarColor(0.8, 0.8, 0.8, 0.4)

	local overAbsorb = self.Health:CreateTexture(nil, 'OVERLAY')
	overAbsorb:SetWidth(5)
	overAbsorb:SetPoint('TOPLEFT', self.Health, 'TOPRIGHT')
	overAbsorb:SetPoint('BOTTOMLEFT', self.Health, 'BOTTOMRIGHT')

	self.HealthPrediction = {
		healAbsorbBar = healAbsorbBar,
		myBar = myBar,
		otherBar = otherBar,
		absorbBar = absorbBar,
		overAbsorb = overAbsorb,
		overHealAbsorb = overHealAbsorb,
	}
end
