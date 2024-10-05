local _, mUI = ...
local oUF = mUI.oUF
local LSM = LibStub('LibSharedMedia-3.0')

local _, class = UnitClass("player")
local playerColor = oUF.colors.class[class]

local removedDebuffs = {
	[206151] = true, -- Challenger's Burden
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
	if not data.isPlayerAura then return false end

	if mUI.profile.target.debuffs.include[data.spellId] then
		return true
	end

	if mUI.profile.target.debuffs.exclude[data.spellId] then
		return false
	end

	if data.nameplateShowPersonal and mUI.profile.target.debuffs.blizzard then
		return true
	end

	return false
end

local function PostCreateButton(self, button)
	button:SetFrameStrata("LOW")

	button.Overlay:SetTexture([[Interface\AddOns\MangoUI\Media\debuffoverlay.tga]])
	button.Overlay:SetAllPoints()
	button.Overlay:SetTexCoord(0, 1, 0, 1)

	button.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

	button.Cooldown:SetSwipeColor(0, 0, 0, 0.6)
	button.Cooldown:SetDrawEdge(false)
	button.Cooldown:SetReverse(true)
	button.Cooldown:SetCountdownFont(LSM:Fetch("font", mUI.profile.settings.font), 8, "OUTLINE")
end

local function PostCreateButtonBorder(self, button)
	mUI:CreateBorder(button)
	button:SetFrameStrata("LOW")
	button.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

	button.Cooldown:SetSwipeColor(0, 0, 0, 0.6)
	button.Cooldown:SetDrawEdge(false)
	button.Cooldown:SetReverse(true)
	button.Cooldown:SetCountdownFont(LSM:Fetch("font", mUI.profile.settings.font), 8, "OUTLINE")

	button.Count:SetFont(LSM:Fetch("font", mUI.profile.settings.font), 14, "OUTLINE")
	button.Count:ClearAllPoints()
	button.Count:SetPoint("CENTER", button, "BOTTOM", 0, 0)
	button.Count:SetTextColor(playerColor.r, playerColor.g, playerColor.b, 1)
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
		Debuffs.spacing = 2
		Debuffs.FilterAura = AuraFilter
		Debuffs.PostCreateButton = PostCreateButton
		Debuffs.showType = true
	elseif self.unit == 'target' then
		Debuffs:SetPoint('BOTTOMLEFT', self.Health, 'TOPLEFT', 0, 5)
		Debuffs.initialAnchor = 'BOTTOMLEFT'
		Debuffs['growth-x'] = 'RIGHT'
		Debuffs['growth-y'] = 'UP'
		Debuffs.width = 34
		Debuffs.height = 28
		Debuffs.spacing = 2
		Debuffs.FilterAura = TargetAuraFilter
		Debuffs.PostCreateButton = PostCreateButtonBorder
		Debuffs.showType = false
	elseif string.match(self.unit, "^boss[123456789]$") then
		Debuffs:SetPoint('TOPRIGHT', self.Health, 'TOPLEFT', -5, 0)
		Debuffs.initialAnchor = 'TOPRIGHT'
		Debuffs['growth-x'] = 'LEFT'
		Debuffs['growth-y'] = 'DOWN'
		Debuffs.size = 28
		Debuffs.spacing = 2
		Debuffs.FilterAura = TargetAuraFilter
		Debuffs.PostCreateButton = PostCreateButtonBorder
		Debuffs.showType = false
	elseif self.unit == 'party' then
		Debuffs:SetPoint('BOTTOMLEFT', self.Health, 'BOTTOMRIGHT', 5, 0)
		Debuffs.size = 36
		Debuffs.spacing = 2
		Debuffs.initialAnchor = 'BOTTOMLEFT'
		Debuffs['growth-x'] = 'RIGHT'
		Debuffs['growth-y'] = 'UP'
		Debuffs.FilterAura = AuraFilter
		Debuffs.PostCreateButton = PostCreateButton
		Debuffs.showType = true
	elseif self.unit == 'raid' then
		Debuffs:SetPoint('BOTTOMLEFT', self.Health, 'BOTTOMLEFT', 3, 3)
		Debuffs.size = 18
		Debuffs.spacing = 2
		Debuffs.initialAnchor = 'BOTTOMLEFT'
		Debuffs['growth-x'] = 'RIGHT'
		Debuffs['growth-y'] = 'UP'
		Debuffs.FilterAura = RaidAuraFilter
		Debuffs.PostCreateButton = PostCreateButton
		Debuffs.showType = true
	else
		Debuffs:SetPoint('BOTTOMLEFT', self.Health, 'BOTTOMRIGHT', 5, 0)
		Debuffs.size = 28
		Debuffs.spacing = 2
		Debuffs.initialAnchor = 'BOTTOMLEFT'
		Debuffs['growth-x'] = 'RIGHT'
		Debuffs['growth-y'] = 'UP'
		Debuffs.PostCreateButton = PostCreateButton
		Debuffs.showType = true
	end

	Debuffs:SetSize((Debuffs.width or Debuffs.size) * 8, (Debuffs.height or Debuffs.size) * 2)
	self.Debuffs = Debuffs
end
