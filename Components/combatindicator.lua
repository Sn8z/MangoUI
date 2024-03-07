local _, mUI = ...

function mUI:CreateCombatIndicator(self)
	local CombatIndicator = self.Indicators:CreateTexture(nil, "OVERLAY")
	PixelUtil.SetSize(CombatIndicator, 26, 26)
	PixelUtil.SetPoint(CombatIndicator, "CENTER", self, "TOP", 0, 0)
	self.CombatIndicator = CombatIndicator
end
