local _, mUI = ...
local LSM = LibStub("LibSharedMedia-3.0")

local UnitClass = UnitClass

function mUI:CreateStaggerBar(self)
	local _, _, classIndex = UnitClass('player')
	if classIndex ~= 10 then return end -- Check for Monk
	local Stagger = CreateFrame('StatusBar', nil, self)
	Stagger:SetSize(380, 6)
	Stagger:SetPoint('CENTER', UIParent, 'CENTER', 0, -158)
	Stagger:SetStatusBarTexture(LSM:Fetch("statusbar", mUI.config.defaultTexture))
	mUI:CreateBorder(Stagger)
	local sBackground = Stagger:CreateTexture(nil, "BACKGROUND")
	sBackground:SetAllPoints(Stagger)
	sBackground:SetColorTexture(0.15, 0.15, 0.15, 1)
	self.Stagger = Stagger
	self.Stagger.db = sBackground
end