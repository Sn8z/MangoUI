local _, mUI = ...
local LSM = LibStub("LibSharedMedia-3.0")

local _, class = UnitClass("player")
local playerColor = RAID_CLASS_COLORS[class]

local function isKickable(self, unit)
	-- Check if you can kick the cast
	local name, text, texture, startTimeMS, endTimeMS, isTradeSkill, castID, notInterruptible, spellId = UnitCastingInfo(
	unit)
	if (not name) then
		name, text, texture, startTimeMS, endTimeMS, isTradeSkill, notInterruptible, spellId = UnitChannelInfo(unit)
	end
	self:SetAlpha(1)
	if (notInterruptible) then
		if (self.Icon) then
			self.Icon:SetDesaturated(true)
		end
		self:SetStatusBarColor(0.3, 0.3, 0.3, 1)
	else
		if (self.Icon) then
			self.Icon:SetDesaturated(false)
		end
		if unit == 'player' then
			self:SetStatusBarColor(playerColor.r, playerColor.g, playerColor.b, 1)
		else
			self:SetStatusBarColor(1, 0.6, 0, 1)
		end
	end
end


function mUI:CreateCastbar(self)
	local Castbar = CreateFrame('StatusBar', nil, self.Health)
	local texture = LSM:Fetch("statusbar", mUI.db.settings.texture)
	Castbar:SetStatusBarTexture(texture)
	Castbar:SetStatusBarColor(1, 0.6, 0, 1)
	Castbar.timeToHold = 0.5
	
	mUI:CreateBorder(Castbar)
	
	local cBackground = Castbar:CreateTexture(nil, "BACKGROUND")
	cBackground:SetAllPoints(Castbar)
	cBackground:SetColorTexture(0.1, 0.1, 0.1, 1)
	cBackground.multiplier = 0.5
	Castbar.bg = cBackground
	
	local font = LSM:Fetch("font", mUI.db.settings.font)
	
	local SpellCasttime = Castbar:CreateFontString(nil, "OVERLAY")
	SpellCasttime:SetPoint("RIGHT", -4, 0)
	SpellCasttime:SetFont(font, 14, "THINOUTLINE")
	Castbar.Time = SpellCasttime

	local SpellName = Castbar:CreateFontString(nil, "OVERLAY")
	SpellName:SetPoint("LEFT", 4, 0)
	SpellName:SetFont(font, 14, "THINOUTLINE")
	Castbar.Text = SpellName

	if self.unit == 'player' then
		Castbar:ClearAllPoints()
		Castbar:SetSize(250, 26)
		Castbar:SetPoint('CENTER', UIParent, 'CENTER', 0, -420)

		local safeZone = Castbar:CreateTexture(nil, 'OVERLAY')
		safeZone:SetVertexColor(0.69, 0.31, 0.31, 0.5)
		Castbar.SafeZone = safeZone

	elseif self.unit == 'focus' then
		Castbar:ClearAllPoints()
		Castbar:SetSize(250, 26)
		Castbar:SetPoint('CENTER', UIParent, 'CENTER', 0, -150)
	else
		Castbar:ClearAllPoints()
		Castbar:SetHeight(20)
		if(self.Power) then
			Castbar:SetPoint('TOPLEFT', self.Power, 'BOTTOMLEFT', 0, -10)
			Castbar:SetPoint('TOPRIGHT', self.Power, 'BOTTOMRIGHT', 0, -10)
		else
			Castbar:SetPoint('TOPLEFT', self.Health, 'BOTTOMLEFT', 0, -6)
			Castbar:SetPoint('TOPRIGHT', self.Health, 'BOTTOMRIGHT', 0, -6)
		end
	end

	--if self.unit ~= 'player' then
	--	local Shield = Castbar:CreateTexture(nil, 'OVERLAY')
	--	Shield:SetTexture([[Interface\AddOns\MangoUI\Media\shield.tga]])
	--	Shield:SetSize(26, 26)
	--	Shield:SetPoint('CENTER', Castbar, 'LEFT', -5, 0)
	--	Castbar.Shield = Shield
	--end

	self.Castbar = Castbar
	self.Castbar.PostCastStart = isKickable
	self.Castbar.PostChannelStart = isKickable
	self.Castbar.PostCastNotInterruptible = isKickable
	self.Castbar.PostCastInterruptible = isKickable
end
