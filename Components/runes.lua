local AddonName, mUI = ...
local LSM = LibStub('LibSharedMedia-3.0')

function mUI:CreateRunes(self)
	if UnitExists(self.unit) and UnitClass(self.unit) == "Death Knight" then
		local Runes = {}
		for index = 1, 6 do
			-- Position and size of the rune bar indicators
			local Rune = CreateFrame('StatusBar', nil, self.Health)
			Rune:SetSize(220 / 6, 14)
			Rune:SetPoint('BOTTOMLEFT', self.Health, 'TOPLEFT', (index - 1) * ((220 / 6) + 5), 5)
			Rune:SetStatusBarTexture(LSM:Fetch("statusbar", mUI.config.defaultTexture))
			Rune:GetStatusBarTexture():SetHorizTile(false)
			mUI:CreateBorder(Rune)

			local bg = Rune:CreateTexture(nil, 'BACKGROUND')
			bg:SetAllPoints(Rune)
			bg:SetTexture(LSM:Fetch("statusbar", mUI.config.defaultTexture))
			bg.multiplier = 1 / 2
			Rune.bg = bg

			Runes.sortOrder = 'asc'
			Runes[index] = Rune
		end
		self.Runes = Runes
	end
end
