local _, mUI = ...

local UnitIsUnit, UnitExists = UnitIsUnit, UnitExists

local function updateBorder(self)
	if UnitExists("target") and UnitIsUnit(self.unit, "target") then
		self.Border:SetBackdropBorderColor(1, 1, 1, 1)
	else
		self.Border:SetBackdropBorderColor(0, 0, 0, 1)
	end
end

function mUI:CreateBorder(self, showTargeted)
	showTargeted = showTargeted or false
	local size = 1 -- TODO: load this from profile
	local border = CreateFrame('Frame', nil, self, "BackdropTemplate")
	border:SetPoint("TOPLEFT", self, "TOPLEFT", -size, size)
	border:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", size, -size)
	border:SetFrameStrata(self:GetFrameStrata())
	border:SetFrameLevel(self:GetFrameLevel())
	border:SetBackdrop({
		edgeFile = [[Interface\AddOns\MangoUI\Media\border.tga]],
		edgeSize = size
	})
	border:SetBackdropColor(0, 0, 0, 0)
	border:SetBackdropBorderColor(0, 0, 0, 1)
	self.Border = border

	if showTargeted and self.unit ~= "target" then
		self:RegisterEvent("PLAYER_TARGET_CHANGED", updateBorder, true)
	end
end