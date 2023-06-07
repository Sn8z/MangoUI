local _, mUI = ...

function mUI:CreateRaidTarget(self)
	local RaidTarget = self.Health:CreateTexture(nil, 'OVERLAY')
	RaidTarget:SetPoint('TOP', self, 0, 12)
	RaidTarget:SetSize(32, 32)
	self.RaidTargetIndicator = RaidTarget
end
