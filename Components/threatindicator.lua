local _, mUI = ...

function mUI:CreateThreatIndicator(self)
	local size = 8
	local ThreatIndicator = self:CreateTexture(nil, 'BACKGROUND')
	ThreatIndicator:SetTexture([[Interface\AddOns\MangoUI\Media\glow.tga]])
	ThreatIndicator:SetPoint('TOPLEFT', self, 'TOPLEFT', -size, size)
	ThreatIndicator:SetPoint('BOTTOMRIGHT', self, 'BOTTOMRIGHT', size, -size)
	ThreatIndicator:SetVertexColor(1, 0, 0)
	self.ThreatIndicator = ThreatIndicator
end




