local _, mUI = ...
local LSM = LibStub("LibSharedMedia-3.0")

function mUI:CreateHealthValue(self)
	if self.unit == "targettarget" or self.unit == "party" or self.unit == "pet" then return end
	local hpValue = self.Texts:CreateFontString(nil, "OVERLAY")
	PixelUtil.SetPoint(hpValue, "CENTER", self.Texts, "CENTER", 0, 0)
	hpValue:SetFont(LSM:Fetch("font", mUI.profile.settings.font), 14, "THINOUTLINE")
	self:Tag(hpValue, "[mango:hp]")
end
