local _, mUI = ...

function mUI:CreateReadyCheck(self)
	local ReadyCheck = self.Indicators:CreateTexture(nil, "OVERLAY")
	PixelUtil.SetSize(ReadyCheck, 26, 26)
	PixelUtil.SetPoint(ReadyCheck, "CENTER", self, "CENTER", 0, 0)

	ReadyCheck.readyTexture = [[Interface\AddOns\MangoUI\Media\Icons\greencheck.tga]]
	ReadyCheck.notReadyTexture = [[Interface\AddOns\MangoUI\Media\Icons\cross.tga]]
	ReadyCheck.waitingTexture = [[Interface\AddOns\MangoUI\Media\Icons\waiting.tga]]

	--ReadyCheck.readyTexture = [[Interface\AddOns\MangoUI\Media\green.tga]]
	--ReadyCheck.notReadyTexture = [[Interface\AddOns\MangoUI\Media\red.tga]]
	--ReadyCheck.waitingTexture = [[Interface\AddOns\MangoUI\Media\yellow.tga]]

	self.ReadyCheckIndicator = ReadyCheck
end
