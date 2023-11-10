local _, mUI = ...
local oUF = mUI.oUF
local LSM = LibStub('LibSharedMedia-3.0')

local _, class = UnitClass("player")
local playerColor = oUF.colors.class[class]

local playerAuras = {
	[116841] = true, -- Tiger's Lust
	[388193] = true, -- Faeline Stomp
	[195630] = true, -- Elusive Brawler
	[387184] = true, -- Weapons of Order
	[137639] = true, -- Storm Earth Fire
	[152173] = true, -- Serenity
	[196741] = true, -- Hit Combo
	[202090] = true, -- Teachings of the Monastery
	[388026] = true, -- Ancient Teachings
	[116847] = true, -- Rushing Jade Wind
	[322507] = true, -- Celestial Brew
	[325092] = true, -- Purified Chi
	[122783] = true, -- Diffuse Magic
	[122278] = true, -- Dampen Harm
	[125174] = true, -- Touch of Karma
	[120954] = true, -- Fortified Brew
	[203819] = true, -- Demon Spikes
	[212800] = true, -- Blur
	[209426] = true, -- Darkness
	[258920] = true, -- Immolation Aura
	[208628] = true, -- Momentum
	[162264] = true, -- Metamorphosis
	[187827] = true, -- Metamorphosis
	[188501] = true, -- Spectral Sight
	[102342] = true, -- Ironbark
	[22812] = true, -- Barkskin
	[192081] = true, -- Ironfur
	[61336] = true, -- Survival Instincts
	[124974] = true, -- Natures Vigil
	[29166] = true, -- Innervate
	[48518] = true, -- Lunar Eclipse
	[48517] = true, -- Solar Eclipse
	[191034] = true, -- Starfall
	[372505] = true, -- Berserk
	[19236] = true, -- Desperate Prayer
	[586] = true,   -- Fade
	[121557] = true, -- Angelic Feather
	[47585] = true, -- Dispersion
	[15286] = true, -- Vampiric Embrace
	[1022] = true,  -- Blessing of Protection
	[184662] = true, -- Shield of Vengeance
	[642] = true,   -- Divine Shield
	[1044] = true,  -- Blessing of Freedom
	[6940] = true,  -- Blessing of Sacrifice
	[10060] = true, -- Power Infusion
	[194249] = true, -- Voidform
	[97463] = true, -- Rallying Cry
	[23920] = true, -- Spell Reflection
	[184362] = true, -- Enrage
	[85739] = true, -- Whirlwind
	[1784] = true,  -- Stealth
	[13877] = true, -- Blade Flurry
	[315496] = true, -- Slice and Dice
	[315341] = true, -- Between The Eyes
	[13750] = true, -- Adrenaline Rush
	[394758] = true, -- Flagellation
	[384631] = true, -- Flagellation
	[185422] = true, -- Shadow Dance
	[212283] = true, -- Symbols of Death
	[121471] = true, -- Shadow Blades
	[393969] = true, -- Danse Macabre
	[381623] = true, -- Thistle Tea
	[277925] = true, -- Shuriken Tornado
	[31224] = true, -- Cloak of Shadows
	[1966] = true,  -- Feint
	[5277] = true,  -- Evasion
	[115192] = true,  -- Subterfuge
	[358267] = true, -- Hover
	[363916] = true, -- Obsidian Scales
	[374348] = true, -- Renewing Blaze
	[370553] = true, -- Tip the Scales
	[375087] = true, -- Dragonrage
}

local function PlayerAuraFilter(element, unit, data)
	if playerAuras[data.spellId] then
		return true
	else
		return false
	end
end

local function PartyAuraFilter(element, unit, data)
	if data.isPlayerAura and (data.duration > 0 and data.duration <= 500) then
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

	button.Count:SetFont(LSM:Fetch("font", mUI.profile.settings.font), 20, "OUTLINE")
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
		Buffs:SetPoint('BOTTOMRIGHT', self, 'TOPRIGHT', 0, 8)
		Buffs.initialAnchor = 'BOTTOMRIGHT'
		Buffs['growth-x'] = 'LEFT'
		Buffs['growth-y'] = 'UP'
		Buffs.width = 34
		Buffs.height = 28
		Buffs.spacing = 5
		Buffs.showDebuffType = false
		Buffs.onlyShowPlayer = false
		Buffs.FilterAura = PlayerAuraFilter
		Buffs.PostCreateButton = PostCreateButton
	elseif self.unit == 'target' then
		Buffs:SetPoint('TOPLEFT', self, 'BOTTOMLEFT', 0, -30)
		Buffs.initialAnchor = 'TOPLEFT'
		Buffs['growth-x'] = 'RIGHT'
		Buffs['growth-y'] = 'DOWN'
		Buffs.size = 26
		Buffs.spacing = 5
		Buffs.showDebuffType = true
		Buffs.onlyShowPlayer = false
		Buffs.PostCreateButton = PostCreateButton
	elseif self.unit == 'party' then
		Buffs:SetPoint('TOPRIGHT', self.Health, 'TOPRIGHT', -3, -3)
		Buffs.initialAnchor = 'TOPRIGHT'
		Buffs['growth-x'] = 'LEFT'
		Buffs['growth-y'] = 'DOWN'
		Buffs.size = 18
		Buffs.spacing = 5
		Buffs.showDebuffType = true
		Buffs.FilterAura = PartyAuraFilter
		Buffs.PostCreateButton = PostCreateButtonParty
	elseif self.unit == 'raid' then
		Buffs:SetPoint('TOPRIGHT', self.Health, 'TOPRIGHT', -3, -3)
		Buffs.initialAnchor = 'TOPRIGHT'
		Buffs['growth-x'] = 'LEFT'
		Buffs['growth-y'] = 'DOWN'
		Buffs.size = 18
		Buffs.spacing = 5
		Buffs.showDebuffType = true
		Buffs.FilterAura = PartyAuraFilter
		Buffs.PostCreateButton = PostCreateButtonParty
	else
		Buffs:SetPoint('BOTTOMLEFT', self.Health, 'TOPLEFT', 0, 3)
		Buffs.initialAnchor = 'BOTTOMLEFT'
		Buffs['growth-x'] = 'RIGHT'
		Buffs['growth-y'] = 'UP'
		Buffs.size = 18
		Buffs.spacing = 5
		Buffs.showDebuffType = true
		Buffs.onlyShowPlayer = true
		Buffs.PostCreateButton = PostCreateButton
	end

	Buffs:SetSize((Buffs.width or Buffs.size) * 8, (Buffs.height or Buffs.size) * 2)
	self.Buffs = Buffs
end
