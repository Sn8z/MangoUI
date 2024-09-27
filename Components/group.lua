local _, mUI = ...
local LSM = LibStub("LibSharedMedia-3.0")

function mUI:CreateGroupNumber(self)
	if self.unit ~= "player" then return end
	local grpNumber = self.Texts:CreateFontString(nil, "OVERLAY")
	PixelUtil.SetPoint(grpNumber, "RIGHT", self.Texts, "RIGHT", -3, 0)
	grpNumber:SetFont(LSM:Fetch("font", mUI.profile.settings.font), 12, "THINOUTLINE")
	self:Tag(grpNumber, "[mango:group]")
end
