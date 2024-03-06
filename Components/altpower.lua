local _, mUI = ...
local LSM = LibStub("LibSharedMedia-3.0")

function PostUpdateAltPower(element, _, cur, _, max)
	if cur and max then
		local perc = floor((cur / max) * 100)
		if perc < 35 then
			element:SetStatusBarColor(0, 1, 0)
		elseif perc < 70 then
			element:SetStatusBarColor(1, 1, 0)
		else
			element:SetStatusBarColor(1, 0, 0)
		end
	end
end

function mUI:CreateAltPowerBar(self)
	local AltPower = CreateFrame("StatusBar", nil, self)
	AltPower:SetStatusBarTexture(LSM:Fetch("statusbar", mUI.profile.settings.powerTexture))
	PixelUtil.SetPoint(AltPower, "TOPLEFT", self, "BOTTOMLEFT", 0, 3)
	PixelUtil.SetPoint(AltPower, "TOPRIGHT", self, "BOTTOMRIGHT", 0, 3)
	PixelUtil.SetHeight(AltPower, 2)
	mUI:CreateBorder(AltPower)

	self.AlternativePower = AltPower
	self.AlternativePower.PostUpdate = PostUpdateAltPower
end
