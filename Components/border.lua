local _, mUI = ...

local UnitIsUnit, UnitExists = UnitIsUnit, UnitExists

local function updateBorder(self)
	if UnitExists("target") and UnitIsUnit(self.unit, "target") then
		self.Border:SetBackdropBorderColor(1, 1, 1, 1)
	else
		self.Border:SetBackdropBorderColor(0, 0, 0, 1)
	end
end

function mUI:CreateHealthBorder(self, showTargeted)
	showTargeted = showTargeted or false
	local borderSize = mUI.profile.settings.borderSize or 1
	local border = CreateFrame("Frame", nil, self.Health, "BackdropTemplate")
	border:SetAllPoints()
	border:SetBackdrop({
		edgeFile = [[Interface\AddOns\MangoUI\Media\border.tga]],
		edgeSize = borderSize,
	})
	border:SetBackdropBorderColor(0, 0, 0, 1)
	self.Border = border

	if showTargeted and self.unit ~= "target" then
		self:RegisterEvent("PLAYER_TARGET_CHANGED", updateBorder, true)
		self:RegisterEvent("GROUP_ROSTER_UPDATE", updateBorder, true)
		self:RegisterEvent("PLAYER_REGEN_DISABLED", updateBorder, true)
	end
end

function mUI:CreateBorder(self)
	local borderSize = mUI.profile.settings.borderSize or 1
	local border = CreateFrame("Frame", nil, self, "BackdropTemplate")
	border:SetAllPoints()
	border:SetBackdrop({
		edgeFile = [[Interface\AddOns\MangoUI\Media\border.tga]],
		edgeSize = borderSize,
	})
	border:SetBackdropBorderColor(0, 0, 0, 1)
	self.Border = border
end
