local _, mUI = ...

function mUI:CreateSummonIndicator(self)
	local Summon = self.Indicators:CreateTexture(nil, "OVERLAY")
	PixelUtil.SetSize(Summon, 32, 32)
	PixelUtil.SetPoint(Summon, "CENTER", self, "CENTER", 0, 0)
	self.SummonIndicator = Summon
end
