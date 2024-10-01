local _, mUI = ...

function mUI:CreateTotems(self)
	if self.unit ~= "player" or not mUI.profile.totems.enabled then return end

	local Totems = {}
	for i = 1, 5 do
		local Totem = CreateFrame("Button", "MangoTotem" .. i, self)
		PixelUtil.SetSize(Totem, mUI.profile.totems.width, mUI.profile.totems.height)

		if i == 1 then
			PixelUtil.SetPoint(Totem, mUI.profile.totems.anchor, UIParent, mUI.profile.totems.parentAnchor,
				mUI.profile.totems.x, mUI.profile.totems.y)
			mUI:AddMover(Totem, "Totems", function(x, y)
				mUI.profile.totems.x = x
				mUI.profile.totems.y = y
			end)
		else
			PixelUtil.SetPoint(Totem, "LEFT", Totems[i - 1], "RIGHT", 4, 0)
		end
		mUI:CreateBorder(Totem)

		local Icon = Totem:CreateTexture(nil, "OVERLAY")
		Icon:SetAllPoints()
		Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

		local Cooldown = CreateFrame("Cooldown", "MangoTotemCD" .. i, Totem, "CooldownFrameTemplate")
		Cooldown:SetAllPoints()

		Totem.Icon = Icon
		Totem.Cooldown = Cooldown
		Totems[i] = Totem
	end
	self.Totems = Totems
end
