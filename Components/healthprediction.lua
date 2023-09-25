local _, mUI = ...
local LSM = LibStub("LibSharedMedia-3.0")

function mUI:CreateHealthPrediction(self)

	local WIDTH = {
		player = mUI.db.player.width,
		target = mUI.db.target.width,
		pet = 110,
		raid = 70,
		party = 140
	}

	local health = self.Health
	local frameLevel = health:GetFrameLevel()
	local width = WIDTH[self.unit] or WIDTH['pet']

	local healAbsorbBar = CreateFrame('StatusBar', nil, health)
	healAbsorbBar:SetPoint('TOPRIGHT', health:GetStatusBarTexture())
	healAbsorbBar:SetPoint('BOTTOMRIGHT', health:GetStatusBarTexture())
	healAbsorbBar:SetFrameLevel(frameLevel)
	healAbsorbBar:SetWidth(width)
	healAbsorbBar:SetReverseFill(true)
	healAbsorbBar:SetStatusBarTexture(LSM:Fetch("statusbar", mUI.db.settings.texture))
	healAbsorbBar:SetStatusBarColor(0.75, 0.75, 0, 0.6)

	local overHealAbsorb = health:CreateTexture(nil, 'OVERLAY')
	overHealAbsorb:SetWidth(5)
	overHealAbsorb:SetPoint('TOPRIGHT', health, 'TOPLEFT')
	overHealAbsorb:SetPoint('BOTTOMRIGHT', health, 'BOTTOMLEFT')

	local myBar = CreateFrame('StatusBar', nil, health)
	myBar:SetPoint('TOPLEFT', health:GetStatusBarTexture(), 'TOPRIGHT')
	myBar:SetPoint('BOTTOMLEFT', health:GetStatusBarTexture(), 'BOTTOMRIGHT')
	myBar:SetFrameLevel(frameLevel)
	myBar:SetWidth(width)
	myBar:SetStatusBarTexture(LSM:Fetch("statusbar", mUI.db.settings.texture))
	myBar:SetStatusBarColor(0, 1, 0, 0.5)

	local otherBar = CreateFrame('StatusBar', nil, health)
	otherBar:SetPoint('TOPLEFT', myBar:GetStatusBarTexture(), 'TOPRIGHT')
	otherBar:SetPoint('BOTTOMLEFT', myBar:GetStatusBarTexture(), 'BOTTOMRIGHT')
	otherBar:SetFrameLevel(frameLevel)
	otherBar:SetWidth(width)
	otherBar:SetStatusBarTexture(LSM:Fetch("statusbar", mUI.db.settings.texture))
	otherBar:SetStatusBarColor(0, 1, 0, 0.5)

	local absorbBar = CreateFrame('StatusBar', nil, health)
	absorbBar:SetPoint('TOPLEFT', otherBar:GetStatusBarTexture(), 'TOPRIGHT')
	absorbBar:SetPoint('BOTTOMLEFT', otherBar:GetStatusBarTexture(), 'BOTTOMRIGHT')
	absorbBar:SetFrameLevel(frameLevel)
	absorbBar:SetWidth(width)
	absorbBar:SetStatusBarTexture(LSM:Fetch("statusbar", mUI.db.settings.texture))
	absorbBar:SetStatusBarColor(0.8, 0.8, 1, 0.6)

	local overAbsorb = health:CreateTexture(nil, 'OVERLAY')
	overAbsorb:SetWidth(5)
	overAbsorb:SetPoint('TOPLEFT', health, 'TOPRIGHT')
	overAbsorb:SetPoint('BOTTOMLEFT', health, 'BOTTOMRIGHT')

	self.HealthPrediction = {
		healAbsorbBar = healAbsorbBar,
		myBar = myBar,
		otherBar = otherBar,
		absorbBar = absorbBar,
		overAbsorb = overAbsorb,
		overHealAbsorb = overHealAbsorb,
	}
end
