local _, mUI = ...

function mUI:CreateRaidTarget(self)
	local RaidTarget = self.Health:CreateTexture(nil, "OVERLAY")
	PixelUtil.SetSize(RaidTarget, 32, 32)
	PixelUtil.SetPoint(RaidTarget, "CENTER", self, "TOP", 0, 0)
	self.RaidTargetIndicator = RaidTarget
end
