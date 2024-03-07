local _, mUI = ...

function mUI:CreateResurrectionIndicator(self)
	local ResurrectIndicator = self.Indicators:CreateTexture(nil, "OVERLAY")
	PixelUtil.SetSize(ResurrectIndicator, 32, 32)
	PixelUtil.SetPoint(ResurrectIndicator, "CENTER", self, "CENTER", 0, 0)
	self.ResurrectIndicator = ResurrectIndicator
end
