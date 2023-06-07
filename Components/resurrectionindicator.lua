local _, mUI = ...

function mUI:CreateResurrectionIndicator(self)
	local ResurrectIndicator = self.Health:CreateTexture(nil, 'OVERLAY')
	ResurrectIndicator:SetSize(32, 32)
	ResurrectIndicator:SetPoint('TOP', self)
	self.ResurrectIndicator = ResurrectIndicator
end
