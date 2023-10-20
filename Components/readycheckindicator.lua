local _, mUI = ...

function mUI:CreateReadyCheck(self)
	local ReadyCheck = self.Health:CreateTexture(nil, 'OVERLAY')
	ReadyCheck:SetSize(18, 18)
	ReadyCheck:SetPoint('BOTTOMLEFT', self, 'BOTTOMLEFT', 3, 3)
	ReadyCheck.readyTexture = [[Interface\AddOns\MangoUI\Media\green.tga]]
	ReadyCheck.notReadyTexture = [[Interface\AddOns\MangoUI\Media\red.tga]]
	ReadyCheck.waitingTexture = [[Interface\AddOns\MangoUI\Media\yellow.tga]]
	self.ReadyCheckIndicator = ReadyCheck
end
