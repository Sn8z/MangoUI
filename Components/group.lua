local _, mUI = ...
local LSM = LibStub("LibSharedMedia-3.0")

function mUI:CreateGroupNumber(self)
	if self.unit ~= 'player' then return end
	local grpNumber = self.Health:CreateFontString(nil, "OVERLAY")
	local fSize = 14
	grpNumber:SetPoint("BOTTOMRIGHT", self.Health, "BOTTOMRIGHT", -3, 3)
	grpNumber:SetFont(LSM:Fetch("font", mUI.config.defaultFont), fSize, "THINOUTLINE")
	self:Tag(grpNumber, "[group]")
end