local _, mUI = ...
local LSM = LibStub("LibSharedMedia-3.0")

function mUI:CreateAbsorbsNumber(self)
	local absNumber = self.Health:CreateFontString(nil, "OVERLAY")
	local fSize = 14
	absNumber:SetPoint("BOTTOMLEFT", self.Health, "BOTTOMLEFT", 3, 3)
	absNumber:SetFont(LSM:Fetch("font", mUI.db.settings.font), fSize, "THINOUTLINE")
	self:Tag(absNumber, "[mango:absorbs]")
end
