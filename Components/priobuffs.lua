local _, mUI = ...
local LSM = LibStub("LibSharedMedia-3.0")

local defensives = {
	-- Monk
	[122783] = true, -- Diffuse Magic
	[122278] = true, -- Dampen Harm
	[125174] = true, -- Touch of Karma
	[120954] = true, -- Fortified Brew
	-- Demon Hunter
	[203819] = true, -- Demon Spikes
	[212800] = true, -- Blur
	[209426] = true, -- Darkness
	[188501] = true, -- Spectral Sight
	[187827] = true, -- Metamorphosis
	[196555] = true, -- Netherwalk
	-- Druid
	[22812] = true, -- Barkskin
	[192081] = true, -- Ironfur
	[61336] = true, -- Survival Instincts
	-- Priest
	[19236] = true, -- Desperate Prayer
	[586] = true,   -- Fade
	[47585] = true, -- Dispersion
	[27827] = true, -- Spirit of Redemption
	-- Paladin
	[184662] = true, -- Shield of Vengeance
	[642] = true,   -- Divine Shield
	-- Warrior
	[23920] = true, -- Spell Reflection
	-- Rogue
	[31224] = true, -- Cloak of Shadows
	[1966] = true,  -- Feint
	[5277] = true,  -- Evasion
	-- Evoker
	[363916] = true, -- Obsidian Scales
	[374348] = true, -- Renewing Blaze
}

local externals = {
	-- Monk
	[116841] = true, -- Tiger's Lust
	[116849] = true, -- Life Cocoon
	-- Demon Hunter
	[209426] = true, -- Darkness
	-- Druid
	[102342] = true, -- Ironbark
	[29166] = true, -- Innervate
	-- Priest
	[10060] = true, -- Power Infusion
	[47788] = true, -- Guardian Spirit
	-- Paladin
	[1022] = true,  -- Blessing of Protection
	[1044] = true,  -- Blessing of Freedom
	[6940] = true,  -- Blessing of Sacrifice
	-- Warrior
	[97463] = true, -- Rallying Cry
	-- Shaman
	[325174] = true, -- Spirit Link Totem
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

local function PlayerBuffFilter(_, _, data)
	if externals[data.spellId] and not data.isPlayerAura then
		return true
	else
		return false
	end
end

local function BuffFilter(_, _, data)
	if defensives[data.spellId] or externals[data.spellId] then
		return true
	else
		return false
	end
end

local function PostCreateButton(self, button)
	button:SetFrameStrata("LOW")
	mUI:CreateBorder(button)
	button.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

	button.Cooldown:SetHideCountdownNumbers(true)
	button.Cooldown:SetSwipeColor(0, 0, 0, 0.8)
	button.Cooldown:SetDrawEdge(false)
	button.Cooldown:SetReverse(true)

	button.Count:SetFont(LSM:Fetch("font", mUI.profile.settings.font), 20, "OUTLINE")
	button.Count:ClearAllPoints()
	button.Count:SetPoint("CENTER", button, "TOP", 0, 0)
end

function mUI:CreatePrioBuffs(self)
	local PrioBuffs = CreateFrame("Frame", nil, self)
	if self.unit == "player" then
		PrioBuffs:SetPoint("CENTER")
		PrioBuffs.initialAnchor = "BOTTOMRIGHT"
		PrioBuffs["growth-x"] = "LEFT"
		PrioBuffs["growth-y"] = "UP"
		PrioBuffs.width = 24
		PrioBuffs.height = 24
		PrioBuffs.spacing = 6
		PrioBuffs.FilterAura = PlayerBuffFilter
	elseif self.unit == "party" then
		PrioBuffs:SetPoint("CENTER")
		PrioBuffs.initialAnchor = "BOTTOMRIGHT"
		PrioBuffs["growth-x"] = "LEFT"
		PrioBuffs["growth-y"] = "UP"
		PrioBuffs.width = 26
		PrioBuffs.height = 26
		PrioBuffs.spacing = 3
		PrioBuffs.FilterAura = BuffFilter
	elseif self.unit == "raid" then
		PrioBuffs:SetPoint("CENTER")
		PrioBuffs.initialAnchor = "BOTTOMRIGHT"
		PrioBuffs["growth-x"] = "LEFT"
		PrioBuffs["growth-y"] = "UP"
		PrioBuffs.width = 24
		PrioBuffs.height = 24
		PrioBuffs.spacing = 5
		PrioBuffs.FilterAura = BuffFilter
	end
	PrioBuffs.showDebuffType = false
	PrioBuffs.onlyShowPlayer = false
	PrioBuffs.PostCreateButton = PostCreateButton
	PrioBuffs.SetPosition = GrowHorizontal
	PrioBuffs:SetSize((PrioBuffs.width or PrioBuffs.size) * 8, (PrioBuffs.height or PrioBuffs.size) * 2)
	PrioBuffs.reanchorIfVisibleChanged = true
	self.Auras = PrioBuffs
end
