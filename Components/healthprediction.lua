local _, mUI = ...
local LSM = LibStub("LibSharedMedia-3.0")

function mUI:CreateHealthPrediction(self)
	local WIDTH = {
		player = mUI.profile.player.width,
		target = mUI.profile.target.width,
		pet = mUI.profile.pet.width,
		targettarget = mUI.profile.targettarget.width,
		focus = mUI.profile.focus.width,
		raid = mUI.profile.raid.width,
		party = mUI.profile.party.width
	}

	local frameLevel = self.Health:GetFrameLevel()
	local width = WIDTH[self.unit] or 150

	local myBar = CreateFrame('StatusBar', nil, self.Health)
	myBar:SetPoint('TOPLEFT', self.Health:GetStatusBarTexture(), 'TOPRIGHT')
	myBar:SetPoint('BOTTOMLEFT', self.Health:GetStatusBarTexture(), 'BOTTOMRIGHT')
	myBar:SetFrameLevel(frameLevel)
	myBar:SetWidth(width)
	myBar:SetStatusBarTexture([[Interface\AddOns\MangoUI\Media\flat.tga]])
	myBar:SetStatusBarColor(0, 1, 0, 0.4)

	local otherBar = CreateFrame('StatusBar', nil, self.Health)
	otherBar:SetPoint('TOPLEFT', myBar:GetStatusBarTexture(), 'TOPRIGHT')
	otherBar:SetPoint('BOTTOMLEFT', myBar:GetStatusBarTexture(), 'BOTTOMRIGHT')
	otherBar:SetFrameLevel(frameLevel)
	otherBar:SetWidth(width)
	otherBar:SetStatusBarTexture([[Interface\AddOns\MangoUI\Media\flat.tga]])
	otherBar:SetStatusBarColor(0, 1, 0, 0.4)

	local absorbBar = CreateFrame("StatusBar", nil, self.Health)
	absorbBar:SetPoint("TOP")
	absorbBar:SetPoint("BOTTOM")
	absorbBar:SetPoint("LEFT", otherBar:GetStatusBarTexture(), "RIGHT")
	absorbBar:SetFrameLevel(frameLevel)
	absorbBar:SetWidth(width)
	absorbBar:SetStatusBarTexture([[Interface\AddOns\MangoUI\Media\flat.tga]])
	absorbBar:GetStatusBarTexture():SetHorizTile(true)
	absorbBar:SetStatusBarColor(0.1, 0.65, 0.7, 0.5)

	local healAbsorbBar = CreateFrame('StatusBar', nil, self.Health)
	healAbsorbBar:SetPoint("TOP")
	healAbsorbBar:SetPoint("BOTTOM")
	healAbsorbBar:SetPoint("RIGHT", self.Health:GetStatusBarTexture())
	healAbsorbBar:SetFrameLevel(frameLevel + 1)
	healAbsorbBar:SetWidth(width)
	healAbsorbBar:SetReverseFill(true)
	healAbsorbBar:SetStatusBarTexture([[Interface\AddOns\MangoUI\Media\flat.tga]])
	healAbsorbBar:GetStatusBarTexture():SetHorizTile(true)
	healAbsorbBar:SetStatusBarColor(0.5, 0.5, 0.5, 0.5)

	local overAbsorb = self.Health:CreateTexture(nil, 'OVERLAY')
	overAbsorb:SetPoint("TOP")
	overAbsorb:SetPoint("BOTTOM")
	overAbsorb:SetPoint("LEFT", self.Health, "RIGHT")
	overAbsorb:SetWidth(5)

	local overHealAbsorb = self.Health:CreateTexture(nil, 'OVERLAY')
	overHealAbsorb:SetPoint("TOP")
	overHealAbsorb:SetPoint("BOTTOM")
	overHealAbsorb:SetPoint("RIGHT", self.Health, "LEFT")
	overHealAbsorb:SetWidth(5)

	self.HealthPrediction = {
		healAbsorbBar = healAbsorbBar,
		myBar = myBar,
		otherBar = otherBar,
		absorbBar = absorbBar,
		overAbsorb = overAbsorb,
		overHealAbsorb = overHealAbsorb,
	}
end
