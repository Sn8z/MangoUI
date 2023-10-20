local _, mUI = ...

function mUI:CreateTotems(self)
	if self.unit ~= 'player' then return end
	local Totems = {}
	for index = 1, 5 do
		local Totem = CreateFrame('Button', nil, self)
		Totem:SetSize(32, 32)
		Totem:SetPoint('BOTTOMLEFT', UIParent, 'BOTTOMLEFT', (index * (Totem:GetWidth() + 3)) + 520, 120)
		mUI:CreateBorder(Totem)

		local Icon = Totem:CreateTexture(nil, 'OVERLAY')
		Icon:SetAllPoints()
		Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

		local Cooldown = CreateFrame('Cooldown', nil, Totem, 'CooldownFrameTemplate')
		Cooldown:SetAllPoints()

		Totem.Icon = Icon
		Totem.Cooldown = Cooldown
		Totems[index] = Totem
	end

	self.Totems = Totems
end
