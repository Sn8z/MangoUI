local _, mUI = ...

local removedDebuffs = {
	[206151] = true, -- Challenger's Burden
}

local TargetDebuffs = {
	[188389] = true, -- Flame Shock
	[315341] = true, -- Between the Eyes
	[316220] = true, -- Find Weakness
	[1943] = true, -- Rupture
	[703] = true,  -- Garrote
	[394036] = true,   -- Serrated Bonespike
	[360194] = true,   -- Deathmark
	[357209] = true, -- Fire Breath
	[164812] = true, -- Moonfire
	[164815] = true, -- Sunfire
	[202347] = true, -- Stellar Flare
	[271788] = true, -- Serpent Sting
	[14914] = true, -- Holy Fire
	[589] = true, -- Shadow Word: Pain
	[34914] = true,   -- Vampiric Touch
	[335467] = true,   -- Devouring Plague
	[375901] = true,   -- Mindgames
	[214621] = true, -- Schism
	[204213] = true, -- Purge the Wicked
	[157736] = true, -- Immolate
	[197277] = true, -- Judgment
	[207771] = true, -- Fiery Brand
	[207407] = true, -- Soul Carver
	[370966] = true, -- The Hunt
	[370969] = true, -- The Hunt
}

local function RaidAuraFilter(element, unit, data)
	if data.isRaid or data.isBossAura then
		return true
	else
		return false
	end
end

local function AuraFilter(element, unit, data)
	if not removedDebuffs[data.spellId] then
		return true
	else
		return false
	end
end

local function TargetAuraFilter(element, unit, data)
	if TargetDebuffs[data.spellId] and data.isPlayerAura then
		return true
	else
		return false
	end
end

local function PostCreateButton(self, button)
	button.Overlay:SetTexture([[Interface\AddOns\MangoUI\Media\debuffoverlay.tga]])
	button.Overlay:SetAllPoints()
	button.Overlay:SetTexCoord(0, 1, 0, 1)
	button:SetFrameStrata("LOW")
	button.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
end

local function PostCreateButtonBorder(self, button)
	mUI:CreateBorder(button)
	button:SetFrameStrata("LOW")
	button.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
end

function mUI:CreateDebuffs(self)
	if self.unit == "targettarget" or self.unit == "pet" then return end
	local Debuffs = CreateFrame('Frame', nil, self)

	if self.unit == 'player' then
		Debuffs:SetPoint('TOPLEFT', self.Health, 'BOTTOMLEFT', 0, -5)
		Debuffs.initialAnchor = 'TOPLEFT'
		Debuffs['growth-x'] = 'RIGHT'
		Debuffs['growth-y'] = 'DOWN'
		Debuffs.size = 32
		Debuffs.spacing = 5
		Debuffs.FilterAura = AuraFilter
		Debuffs.PostCreateButton = PostCreateButton
		Debuffs.showType = true
	elseif self.unit == 'target' then
		Debuffs:SetPoint('BOTTOMLEFT', self.Health, 'TOPLEFT', 0, 5)
		Debuffs.initialAnchor = 'BOTTOMLEFT'
		Debuffs['growth-x'] = 'RIGHT'
		Debuffs['growth-y'] = 'UP'
		Debuffs.size = 28
		Debuffs.spacing = 5
		Debuffs.FilterAura = TargetAuraFilter
		Debuffs.PostCreateButton = PostCreateButtonBorder
		Debuffs.showType = false
	elseif string.match(self.unit, "^boss[123456789]$") then
		Debuffs:SetPoint('TOPRIGHT', self.Health, 'TOPLEFT', -5, 0)
		Debuffs.initialAnchor = 'TOPRIGHT'
		Debuffs['growth-x'] = 'LEFT'
		Debuffs['growth-y'] = 'DOWN'
		Debuffs.size = 28
		Debuffs.spacing = 5
		Debuffs.FilterAura = TargetAuraFilter
		Debuffs.PostCreateButton = PostCreateButtonBorder
		Debuffs.showType = false
	elseif self.unit == 'party' then
		Debuffs:SetPoint('BOTTOMLEFT', self.Health, 'BOTTOMRIGHT', 5, 0)
		Debuffs.size = 28
		Debuffs.spacing = 5
		Debuffs.initialAnchor = 'BOTTOMLEFT'
		Debuffs['growth-x'] = 'RIGHT'
		Debuffs['growth-y'] = 'UP'
		Debuffs.FilterAura = AuraFilter
		Debuffs.PostCreateButton = PostCreateButton
		Debuffs.showType = true
	elseif self.unit == 'raid' then
		Debuffs:SetPoint('BOTTOMLEFT', self.Health, 'BOTTOMLEFT', 3, 3)
		Debuffs.size = 18
		Debuffs.spacing = 5
		Debuffs.initialAnchor = 'BOTTOMLEFT'
		Debuffs['growth-x'] = 'RIGHT'
		Debuffs['growth-y'] = 'UP'
		Debuffs.FilterAura = RaidAuraFilter
		Debuffs.PostCreateButton = PostCreateButton
		Debuffs.showType = true
	else
		Debuffs:SetPoint('BOTTOMLEFT', self.Health, 'BOTTOMRIGHT', 5, 0)
		Debuffs.size = 28
		Debuffs.spacing = 5
		Debuffs.initialAnchor = 'BOTTOMLEFT'
		Debuffs['growth-x'] = 'RIGHT'
		Debuffs['growth-y'] = 'UP'
		Debuffs.PostCreateButton = PostCreateButton
		Debuffs.showType = true
	end

	Debuffs:SetSize(Debuffs.size * 8, Debuffs.size * 2)
	self.Debuffs = Debuffs
end