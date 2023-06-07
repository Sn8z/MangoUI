local _, mUI = ...
local LSM = LibStub("LibSharedMedia-3.0")

function mUI:CreateHealthValue(self)
	if self.unit == "targettarget" or self.unit == "party" or self.unit == "pet" then return end
	local hpValue = self.Health:CreateFontString(nil, "OVERLAY")
	hpValue:SetPoint("CENTER", self.Health, "CENTER", 0, 0)
	hpValue:SetFont(LSM:Fetch("font", mUI.config.defaultFont), 14, "THINOUTLINE")
	self:Tag(hpValue, "[mango:hp]")
end