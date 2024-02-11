local _, mUI = ...
local LSM = LibStub("LibSharedMedia-3.0")

local UnitClass = UnitClass

function mUI:CreateStaggerBar(self)
	local _, _, classIndex = UnitClass('player')
	if classIndex ~= 10 then return end -- Check for Monk
	local Stagger = CreateFrame('StatusBar', nil, self)
	if mUI.profile.player.classpower.detach then
		Stagger:SetSize(mUI.profile.player.classpower.width, mUI.profile.player.classpower.height)
		Stagger:SetPoint('LEFT', UIParent, 'CENTER', mUI.profile.player.classpower.x, mUI.profile.player.classpower.y)
	else
		Stagger:SetHeight(mUI.profile.player.classpower.height)
		Stagger:SetPoint('BOTTOMLEFT', self.Health, 'TOPLEFT', 0, 2)
		Stagger:SetPoint('BOTTOMRIGHT', self.Health, 'TOPRIGHT', 0, 2)
	end
	Stagger:SetStatusBarTexture(LSM:Fetch("statusbar", mUI.profile.settings.powerTexture))

	local bg = CreateFrame("Frame", "StaggerBg", Stagger, "BackdropTemplate")
	local borderSize = mUI.profile.settings.borderSize or 1
	bg:SetBackdrop({
		bgFile = [[Interface\AddOns\MangoUI\Media\border.tga]],
		edgeFile = [[Interface\AddOns\MangoUI\Media\border.tga]],
		edgeSize = borderSize,
	})
	bg:SetPoint("TOPLEFT", Stagger, -borderSize, borderSize)
	bg:SetPoint("BOTTOMRIGHT", Stagger, borderSize, -borderSize)
	bg:SetFrameStrata("BACKGROUND")
	bg:SetBackdropColor(0.15, 0.15, 0.15, 1)
	bg:SetBackdropBorderColor(0, 0, 0, 1)
	Stagger.Background = bg

	self.Stagger = Stagger
end
