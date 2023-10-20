local _, mUI = ...

function mUI:CreateTotems(self)
	local Totems = {}
	for index = 1, 5 do
		-- Position and size of the totem indicator
		local Totem = CreateFrame('Button', nil, self)
		Totem:SetSize(40, 40)
		Totem:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", (index * (Totem:GetWidth() + 3)) + 520, 50)
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

	-- Register with oUF
	self.Totems = Totems
end
