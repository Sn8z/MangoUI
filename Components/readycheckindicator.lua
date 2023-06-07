local _, mUI = ...

function mUI:CreateReadyCheck(self)
	local ReadyCheck = self.Health:CreateTexture(nil, 'OVERLAY')
	ReadyCheck:SetSize(32, 32)
	ReadyCheck:SetPoint('CENTER', self)
	self.ReadyCheckIndicator = ReadyCheck
end
