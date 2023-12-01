local _, mUI = ...
local LSM = LibStub("LibSharedMedia-3.0")

function mUI:CreateUnitName(self)
	local unitName = self.Health:CreateFontString(nil, "ARTWORK")
	local fSize = 16
	if self.unit == 'player' then
		unitName:SetPoint("LEFT", self.Health, "TOPLEFT", 6, 0)
		fSize = 16
	elseif self.unit == 'target' then
		unitName:SetPoint("RIGHT", self.Health, "TOPRIGHT", -6, 0)
		fSize = 16
	elseif self.unit == 'focus' then
		unitName:SetPoint("RIGHT", self.Health, "TOPRIGHT", -6, 0)
		fSize = 14
	elseif self.unit == 'party' then
		unitName:SetPoint("LEFT", self.Health, "TOPLEFT", 6, 0)
		fSize = 14
	elseif string.match(self.unit, "^boss[123456789]$") then
		unitName:SetPoint("RIGHT", self.Health, "TOPRIGHT", -6, 0)
		fSize = 14
	else
		unitName:SetPoint("CENTER", self.Health, "CENTER", 0, 0)
		fSize = 14
	end
	unitName:SetFont(LSM:Fetch("font", mUI.db.settings.font), fSize, "THINOUTLINE")
	self:Tag(unitName, "[name]")
	self.Name = unitName
end