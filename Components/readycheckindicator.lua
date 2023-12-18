local _, mUI = ...

function mUI:CreateReadyCheck(self)
	local ReadyCheck = self.Health:CreateTexture(nil, 'OVERLAY')
	ReadyCheck:SetSize(26, 26)
	ReadyCheck:SetPoint("CENTER")

	ReadyCheck.readyTexture = [[Interface\AddOns\MangoUI\Media\Icons\greencheck.tga]]
	ReadyCheck.notReadyTexture = [[Interface\AddOns\MangoUI\Media\Icons\cross.tga]]
	ReadyCheck.waitingTexture = [[Interface\AddOns\MangoUI\Media\Icons\waiting.tga]]

	--ReadyCheck.readyTexture = [[Interface\AddOns\MangoUI\Media\green.tga]]
	--ReadyCheck.notReadyTexture = [[Interface\AddOns\MangoUI\Media\red.tga]]
	--ReadyCheck.waitingTexture = [[Interface\AddOns\MangoUI\Media\yellow.tga]]

	self.ReadyCheckIndicator = ReadyCheck
end
