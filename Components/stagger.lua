local _, mUI = ...
local LSM = LibStub("LibSharedMedia-3.0")

local UnitClass = UnitClass

function mUI:CreateStaggerBar(self)
	local _, _, classIndex = UnitClass("player")
	if classIndex ~= 10 then return end
	local Stagger = CreateFrame("StatusBar", "MangoStagger", self)
	if mUI.profile.player.classpower.detach then
		PixelUtil.SetSize(Stagger, mUI.profile.player.classpower.width, mUI.profile.player.classpower.height)
		PixelUtil.SetPoint(
			Stagger,
			"LEFT",
			UIParent,
			"CENTER",
			mUI.profile.player.classpower.x,
			mUI.profile.player.classpower.y
		)
	else
		PixelUtil.SetHeight(Stagger, mUI.profile.player.classpower.height)
		PixelUtil.SetPoint(Stagger, "BOTTOMLEFT", self.Health, "TOPLEFT", 0, 2)
		PixelUtil.SetPoint(Stagger, "BOTTOMRIGHT", self.Health, "TOPRIGHT", 0, 2)
	end
	Stagger:SetStatusBarTexture(LSM:Fetch("statusbar", mUI.profile.settings.powerTexture))
	mUI:CreateBorder(Stagger)

	local bg = Stagger:CreateTexture(nil, "BACKGROUND")
	bg:SetTexture(LSM:Fetch("statusbar", mUI.profile.settings.powerTexture))
	bg:SetAllPoints()
	bg.multiplier = 1 / 6
	Stagger.bg = bg

	self.Stagger = Stagger
end
