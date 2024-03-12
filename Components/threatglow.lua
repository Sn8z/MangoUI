local _, mUI = ...

local function threatCheck(self)
	if not self.unit then return end

	local status = UnitThreatSituation(self.unit)
	if status and status > 1 then
		if status == 2 then
			self.ThreatGlow:SetBackdropBorderColor(1, 0.6, 0, 1)
		elseif status == 3 then
			self.ThreatGlow:SetBackdropBorderColor(1, 0, 0, 1)
		else
			self.ThreatGlow:SetBackdropBorderColor(1, 0, 0, 1)
		end
		self.ThreatGlow:Show()
	else
		self.ThreatGlow:Hide()
	end
end

function mUI:CreateThreatGlow(self)
	if not self.unit then return end
	local size = 4
	local glow = CreateFrame("Frame", nil, self, "BackdropTemplate")
	glow:SetBackdrop({
		edgeFile = [[Interface\AddOns\MangoUI\Media\borderglow.tga]],
		edgeSize = size,
	})
	PixelUtil.SetPoint(glow, "TOPLEFT", self, "TOPLEFT", -size, size)
	PixelUtil.SetPoint(glow, "BOTTOMRIGHT", self, "BOTTOMRIGHT", size, -size)
	glow:SetFrameStrata(self:GetFrameStrata())
	glow:SetFrameLevel(self:GetFrameLevel())
	glow:SetBackdropColor(0, 0, 0, 0)
	glow:SetBackdropBorderColor(1, 1, 1, 1)
	glow:Hide()

	self:RegisterEvent("UNIT_THREAT_SITUATION_UPDATE", threatCheck)
	self:RegisterEvent("UNIT_THREAT_LIST_UPDATE", threatCheck)

	self.ThreatGlow = glow
end
