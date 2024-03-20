local AddonName, mUI = ...
local LSM = LibStub('LibSharedMedia-3.0')

function mUI:CreateRunes(self)
	if UnitExists(self.unit) and UnitClass(self.unit) == "Death Knight" then
		local Runes = {}
		local numberOfRunes = 6
		local totalSpacing = mUI.db.player.classpower.spacing * (numberOfRunes - 1)
		for i = 1, 6 do
			local Rune = CreateFrame("StatusBar", nil, self)
			Rune:SetHeight(mUI.db.player.classpower.height)

			if mUI.db.player.classpower.detach then
				Rune:SetWidth((mUI.db.player.classpower.width - totalSpacing) / numberOfRunes)
				Rune:SetPoint("LEFT", UIParent, "CENTER",
					mUI.db.player.classpower.x + ((i - 1) * (Rune:GetWidth() + mUI.db.player.classpower.spacing)),
					mUI.db.player.classpower.y)
			else
				Rune:SetWidth((self:GetWidth() - totalSpacing) / numberOfRunes)
				Rune:SetPoint("BOTTOMLEFT", self, "TOPLEFT",
					(i - 1) * (Rune:GetWidth() + mUI.db.player.classpower.spacing), 0)
			end

			Rune:SetStatusBarTexture(LSM:Fetch("statusbar", mUI.profile.settings.powerTexture))

			local bg = Rune:CreateTexture(nil, "BACKGROUND")
			bg:SetTexture(LSM:Fetch("statusbar", mUI.profile.settings.powerTexture))
			bg:SetAllPoints()
			bg.multiplier = 1 / 6
			Rune.bg = bg

			mUI:CreateBorder(Rune)

			Runes.colorSpec = true
			Runes.sortOrder = "asc"
			Runes[i] = Rune
		end
		self.Runes = Runes
	end
end
