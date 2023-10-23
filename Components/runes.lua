local AddonName, mUI = ...
local LSM = LibStub('LibSharedMedia-3.0')

function mUI:CreateRunes(self)
	if UnitExists(self.unit) and UnitClass(self.unit) == "Death Knight" then
		local Runes = {}
		local numberOfRunes = 6
		local totalSpacing = mUI.db.player.classpower.spacing * (numberOfRunes - 1)
		for index = 1, 6 do
			-- Position and size of the rune bar indicators
			local Rune = CreateFrame('StatusBar', nil, self)
			Rune:SetHeight(mUI.db.player.classpower.height)

			if mUI.db.player.classpower.detach then
				Rune:SetWidth((mUI.db.player.classpower.width - totalSpacing) / numberOfRunes)
				Rune:SetPoint('LEFT', UIParent, 'CENTER', mUI.db.player.classpower.x + ((index - 1) * (Rune:GetWidth() + mUI.db.player.classpower.spacing)), mUI.db.player.classpower.y)
			else
				Rune:SetWidth((self:GetWidth() - totalSpacing) / numberOfRunes)
				Rune:SetPoint('BOTTOMLEFT', self, 'TOPLEFT',
					(index - 1) * (Rune:GetWidth() + mUI.db.player.classpower.spacing), 5)
			end

			Rune:SetStatusBarTexture(LSM:Fetch("statusbar", mUI.profile.settings.powerTexture))
			Rune:GetStatusBarTexture():SetHorizTile(false)
			mUI:CreateBorder(Rune)

			local bg = Rune:CreateTexture(nil, 'BACKGROUND')
			bg:SetAllPoints(Rune)
			bg:SetTexture(LSM:Fetch("statusbar", mUI.profile.settings.powerTexture))
			bg.multiplier = 1 / 2
			Rune.bg = bg

			Runes.sortOrder = 'asc'
			Runes[index] = Rune
		end
		self.Runes = Runes
	end
end
