local _, mUI = ...

local function UpdateThreatBorder(self, event, unit)
	if unit ~= self.unit then return end

	local status = UnitThreatSituation(unit)
	if status and status > 1 then
		self.border:SetBackdropBorderColor(1, 0, 0)
	else
		self.border:SetBackdropBorderColor(0, 0, 0)
	end
end

function mUI:CreateThreatIndicator(self)
	if not self.border then return end
	local threat = CreateFrame("Frame", nil, self)
	self.ThreatIndicator = threat
	self.ThreatIndicator.Override = UpdateThreatBorder
end


