local _, mUI = ...

function mUI:CreateCombatIndicator(self)
	local CombatIndicator = self.Health:CreateTexture(nil, 'OVERLAY')
	CombatIndicator:SetSize(26, 26)
	CombatIndicator:SetPoint('CENTER', self, 'TOP', 0, 0)
	self.CombatIndicator = CombatIndicator
end