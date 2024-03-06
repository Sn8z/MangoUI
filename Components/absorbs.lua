local _, mUI = ...
local LSM = LibStub("LibSharedMedia-3.0")

function mUI:CreateAbsorbsNumber(self)
	local absNumber = self.Health:CreateFontString(nil, "OVERLAY")
	absNumber:SetPoint("TOPRIGHT", -6, 6)
	absNumber:SetFont(LSM:Fetch("font", mUI.db.settings.font), 12, "THINOUTLINE")
	absNumber:SetTextColor(0.1, 0.6, 1, 1)
	self:Tag(absNumber, "[mango:absorbs]")
end
