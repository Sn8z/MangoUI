local _, mUI = ...
local oUF = mUI.oUF
local LSM = LibStub('LibSharedMedia-3.0')

local _, class = UnitClass("player")
local playerColor = oUF.colors.class[class]

local partyAuras = {
	-- Evoker
	[366155] = true, -- Reversion
	[355941] = true, -- Dream Breath
	[364343] = true, -- Echo
	[373862] = true, -- Temporal Anomaly
	[363534] = true, -- Rewind
	[360827] = true, -- Blistering Scales
	[395152] = true, -- Ebon Might
	[409311] = true, -- Prescience
	[410089] = true, -- Prescience
	[369459] = true, -- Source of Magic
	-- Druid
	[102351] = true, -- Cenarion Ward
	[33763] = true, -- Lifebloom
	[8936] = true,  -- Regrowth
	[774] = true,   -- Rejuvenation
	[155777] = true, -- Rejuvenation Germination
	[48438] = true, -- Wild Growth
	[29166] = true, -- Innervate
	[102342] = true, -- Ironbark
	-- Monk
	[325209] = true, -- Enveloping Breath
	[124682] = true, -- Enveloping Mist
	[191837] = true, -- Essence Font
	[116849] = true, -- Life Cocoon
	[119611] = true, -- Renewing Mist
	[115175] = true, -- Soothing Mist
	[116841] = true, -- Tiger's Lust
	-- Paladin
	[156910] = true, -- Beacon of Faith
	[53563] = true, -- Beacon of Light
	[200025] = true, -- Beacon of Virtue
	[223306] = true, -- Bestow Faith
	[243174] = true, -- Sacred Dawn
	[200654] = true, -- Tyr's Deliverance
	[287286] = true, -- Glimmer of Light
	-- Priest
	[214206] = true, -- Atonement
	[152118] = true, -- Clarity of Will
	[47788] = true, -- Guardian Spirit
	[208065] = true, -- Light of T'uure
	[21562] = true, -- PW: Fortitude
	[17] = true,    -- PW: Shield
	[33076] = true, -- Prayer of Mending
	[139] = true,   -- Renew
	[6788] = true,  -- Weakened Soul
	[10060] = true, -- Power Infusion
	-- Shaman
	[204288] = true, -- Earth Shield
	[52127] = true, -- Water Shield
	[61295] = true, -- Riptide
	[325174] = true, -- Spirit Link Totem
	-- Rogue
	[59628] = true, -- Tricks of the Trade
	[57934] = true, -- Tricks of the Trade
	-- Demon Hunter
	[209426] = true, -- Darkness
	-- Hunter
	[35079] = true, -- Misdirect
	[34477] = true, -- Misdirect
	-- Warlock
	[20707] = true, -- Soulstone
	-- Death Knight
	[145629] = true, -- Anti-Magic Zone
}

local function GrowHorizontal(self, from, to)
	for i = from, to do
		local button = self[i]
		if not button then break end
		if i == 1 then
			button:SetPoint("CENTER", -(((self.width + self.spacing) * (to - 1)) / 2), 0)
		else
			button:SetPoint("LEFT", self[i - 1], "RIGHT", self.spacing, 0)
		end
	end
end

-- Player buff filter
local function PlayerAuraFilter(element, unit, data)
	if mUI.profile.player.buffs.exclude[data.spellId] then
		return false
	end

	if mUI.profile.player.buffs.include[data.spellId] then
		return true
	end

	if data.nameplateShowPersonal and mUI.profile.player.buffs.blizzard then
		return true
	end

	return false
end

-- Party buffs filter
local function PartyAuraFilter(element, unit, data)
	if data.isPlayerAura and partyAuras[data.spellId] then
		return true
	else
		return false
	end
end

-- Raid buffs filter
local function RaidAuraFilter(element, unit, data)
	if data.isPlayerAura and partyAuras[data.spellId] then
		return true
	else
		return false
	end
end

local function PostCreateButtonParty(self, button)
	button:SetFrameStrata("LOW")
	mUI:CreateBorder(button)
	button.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

	button.Cooldown:SetHideCountdownNumbers(true)
	button.Cooldown:SetSwipeColor(0, 0, 0, 0.8)
	button.Cooldown:SetDrawEdge(false)
	button.Cooldown:SetReverse(true)

	button.Count:SetFont(LSM:Fetch("font", mUI.profile.settings.font), 16, "OUTLINE")
	button.Count:ClearAllPoints()
	button.Count:SetPoint("CENTER", button, "TOP", 0, 0)
end

local function PostCreateButton(self, button)
	button:SetFrameStrata("LOW")
	mUI:CreateBorder(button)
	button.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

	-- https://wowpedia.fandom.com/wiki/UIOBJECT_Cooldown
	button.Cooldown:SetSwipeColor(0, 0, 0, 0.6)
	button.Cooldown:SetDrawEdge(false)
	button.Cooldown:SetReverse(true)
	button.Cooldown:SetCountdownFont(LSM:Fetch("font", mUI.profile.settings.font), 8, "OUTLINE")

	button.Count:SetFont(LSM:Fetch("font", mUI.profile.settings.font), 14, "OUTLINE")
	button.Count:ClearAllPoints()
	button.Count:SetPoint("CENTER", button, "BOTTOM", 0, 0)
	button.Count:SetTextColor(playerColor.r, playerColor.g, playerColor.b, 1)
end

function mUI:CreateBuffs(self)
	local Buffs = CreateFrame('Frame', nil, self)
	if self.unit == 'player' then
		Buffs:SetPoint("CENTER", UIParent, "CENTER", 0, -120)
		Buffs.initialAnchor = 'BOTTOMRIGHT'
		Buffs['growth-x'] = 'LEFT'
		Buffs['growth-y'] = 'UP'
		Buffs.width = 34
		Buffs.height = 28
		Buffs.spacing = 2
		Buffs.showDebuffType = false
		Buffs.onlyShowPlayer = false
		Buffs.FilterAura = PlayerAuraFilter
		Buffs.PostCreateButton = PostCreateButton
		Buffs.SetPosition = GrowHorizontal
	elseif self.unit == 'target' then
		Buffs:SetPoint('TOPLEFT', self, 'BOTTOMLEFT', 0, -30)
		Buffs.initialAnchor = 'TOPLEFT'
		Buffs['growth-x'] = 'RIGHT'
		Buffs['growth-y'] = 'DOWN'
		Buffs.size = 26
		Buffs.spacing = 2
		Buffs.showDebuffType = true
		Buffs.onlyShowPlayer = false
		Buffs.PostCreateButton = PostCreateButton
	elseif self.unit == 'party' then
		Buffs:SetPoint('TOPRIGHT', self.Health, 'TOPRIGHT', -3, -3)
		Buffs.initialAnchor = 'TOPRIGHT'
		Buffs['growth-x'] = 'LEFT'
		Buffs['growth-y'] = 'DOWN'
		Buffs.size = 20
		Buffs.spacing = 2
		Buffs.showDebuffType = true
		Buffs.FilterAura = PartyAuraFilter
		Buffs.PostCreateButton = PostCreateButtonParty
	elseif self.unit == 'raid' then
		Buffs:SetPoint('TOPRIGHT', self.Health, 'TOPRIGHT', -3, -3)
		Buffs.initialAnchor = 'TOPRIGHT'
		Buffs['growth-x'] = 'LEFT'
		Buffs['growth-y'] = 'DOWN'
		Buffs.size = 18
		Buffs.spacing = 2
		Buffs.showDebuffType = true
		Buffs.FilterAura = RaidAuraFilter
		Buffs.PostCreateButton = PostCreateButtonParty
	else
		Buffs:SetPoint("BOTTOMLEFT", self.Health, "TOPLEFT", 0, 5)
		Buffs.initialAnchor = "BOTTOMLEFT"
		Buffs['growth-x'] = "RIGHT"
		Buffs['growth-y'] = "UP"
		Buffs.size = 28
		Buffs.spacing = 2
		Buffs.showDebuffType = true
		Buffs.PostCreateButton = PostCreateButton
	end

	Buffs:SetSize((Buffs.width or Buffs.size) * 8, (Buffs.height or Buffs.size) * 2)
	Buffs.reanchorIfVisibleChanged = true
	self.Buffs = Buffs
end
