local _, mUI = ...
local LSM = LibStub("LibSharedMedia-3.0")

local UnitClass = UnitClass

function mUI:CreateStaggerBar(self)
	local _, _, classIndex = UnitClass('player')
	if classIndex ~= 10 then return end -- Check for Monk
	local Stagger = CreateFrame('StatusBar', nil, self)
	if mUI.db.player.classpower.detach then
		Stagger:SetSize(mUI.db.player.classpower.width, mUI.db.player.classpower.height)
		Stagger:SetPoint('LEFT', UIParent, 'CENTER', mUI.db.player.classpower.x, mUI.db.player.classpower.y)
	else
		Stagger:SetHeight(mUI.db.player.classpower.height)
		Stagger:SetPoint('BOTTOMLEFT', self.Health, 'TOPLEFT', 0, 2)
		Stagger:SetPoint('BOTTOMRIGHT', self.Health, 'TOPRIGHT', 0, 2)
	end
	Stagger:SetStatusBarTexture(LSM:Fetch("statusbar", mUI.db.settings.texture))
	mUI:CreateBorder(Stagger)
	local sBackground = Stagger:CreateTexture(nil, "BACKGROUND")
	sBackground:SetAllPoints(Stagger)
	sBackground:SetColorTexture(0.15, 0.15, 0.15, 1)
	self.Stagger = Stagger
	self.Stagger.db = sBackground
end
