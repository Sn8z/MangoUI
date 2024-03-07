local _, mUI = ...
local LSM = LibStub("LibSharedMedia-3.0")

function mUI:CreateStatusText(self)
	local unitName = self.Texts:CreateFontString(nil, "OVERLAY")
	PixelUtil.SetPoint(unitName, "CENTER", self, "CENTER", 0, -15)
	unitName:SetFont(LSM:Fetch("font", mUI.db.settings.font), 12, "THINOUTLINE")
	self:Tag(unitName, "[status]")
end
