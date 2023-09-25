local _, mUI = ...
local LSM = LibStub("LibSharedMedia-3.0")

function mUI:CreateStatusText(self)
	local unitName = self.Health:CreateFontString(nil, "OVERLAY")
	unitName:SetPoint("CENTER", self.Health, "CENTER", 0, -15)
	local fSize = 12
	unitName:SetFont(LSM:Fetch("font", mUI.db.settings.font), fSize, "THINOUTLINE")
	self:Tag(unitName, "[status]")
end