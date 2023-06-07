local _, mUI = ...

function mUI:CreateSummonIndicator(self)
	local Summon = self.Health:CreateTexture(nil, "OVERLAY")
	Summon:SetPoint('CENTER', self, 'CENTER')
	Summon:SetSize(32, 32)
	self.SummonIndicator = Summon
end