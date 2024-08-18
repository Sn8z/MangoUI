local _, mUI = ...
local oUF = mUI.oUF

local playerCanDispel = {
	Magic = false,
	Curse = false,
	Poison = false,
	Disease = false
}

local debuffColors = {
    Curse = { 0.8, 0, 1 },
    Disease = { 0.8, 0.6, 0 },
    Magic = { 0, 0.8, 1 },
    Poison = { 0, 0.8, 0 }
}

local function Update(self, event, unit)
	if (unit ~= self.unit) then	return end

	local canDispel, debuffType = false, nil
	for i = 1, 40 do
		local name, _, _, type = C_UnitAuras.GetAuraDataByIndex(unit, i, "HARMFUL")

		if(name and type) then
			if (playerCanDispel[type]) then
				debuffType = type
				canDispel = true
				break
			else
				debuffType = nil
				break
			end
		end
	end

	if (self.DispelHighlight and canDispel) then
		local color = debuffColors[debuffType]
		self.DispelHighlight:SetVertexColor(color[1], color[2], color[3], 1)
		self.DispelHighlight:Show()
	else
		self.DispelHighlight:Hide()
	end
end

local function Enable(self)
	if(self.DispelHighlight) then
		local texture = self.Health:CreateTexture(nil, 'OVERLAY')
		texture:SetTexture([[Interface\AddOns\MangoUI\Media\dispel.tga]])
		texture:SetBlendMode("ADD")
		texture:SetVertexColor(1, 1, 1, 0)
		texture:SetAllPoints()
		self.DispelHighlight = texture
		self:RegisterEvent('UNIT_AURA', Update)
		return true
	end
end

local function Disable(self)
	if (self.DispelHighlight) then
		self:UnregisterEvent('UNIT_AURA', Update)
	end
end

oUF:AddElement('DispelHighlight', nil, Enable, Disable)

local dispels = {
	magic = { 88423, 527, 32375, 360823, 77130, 4987, 115450 },
	curse = { 2782, 392378, 374251, 383016, 51886, 475 },
	disease = { 390632, 213634, 374251, 393024, 213644, 388874, 218164 },
	poison = { 2782, 392378, 360823, 365585, 374251, 393024, 213644, 388874, 218164 }
}

local function checkSpells(spellTable)
	for _, spellID in ipairs(spellTable) do
		if IsSpellKnown(spellID, false) then
			return true
		end
	end
	return false
end

local Handler = CreateFrame('Frame')
Handler:RegisterEvent('SPELLS_CHANGED')
Handler:SetScript('OnEvent', function(self, event)
		playerCanDispel.Magic = checkSpells(dispels.magic) or IsSpellKnown(89808, true)
		playerCanDispel.Curse = checkSpells(dispels.curse)
		playerCanDispel.Disease = checkSpells(dispels.disease)
		playerCanDispel.Poison = checkSpells(dispels.poison)
	end
)
