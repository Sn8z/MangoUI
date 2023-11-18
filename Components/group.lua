local _, mUI = ...
local LSM = LibStub("LibSharedMedia-3.0")

function mUI:CreateGroupNumber(self)
	if self.unit ~= 'player' then return end
	local grpNumber = self.Health:CreateFontString(nil, "OVERLAY")
	local fSize = 12
	grpNumber:SetPoint("RIGHT", self.Health, "RIGHT", -3, 0)
	grpNumber:SetFont(LSM:Fetch("font", mUI.db.settings.font), fSize, "THINOUTLINE")
	self:Tag(grpNumber, "[mango:group]")
end