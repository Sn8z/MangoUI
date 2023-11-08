local _, mUI = ...
local oUF = mUI.oUF
local LSM = LibStub("LibSharedMedia-3.0")

local _, class = UnitClass("player")
local playerColor = oUF.colors.class[class]

local function PostCastFail(self, unit, spellID)
	self:SetStatusBarColor(1, 0, 0, 1)
end

local function PostCastStart(self, unit)
	if self.notInterruptible then
		self:SetStatusBarColor(0.3, 0.3, 0.3, 1)
	else
		if unit == 'player' then
			self:SetStatusBarColor(playerColor.r, playerColor.g, playerColor.b, 1)
		else
			self:SetStatusBarColor(1, 0.6, 0, 1)
		end
	end
end

local function PostUpdateStage(self, stage)
	if stage == 1 then
		self:SetStatusBarColor(1, 1, 1)
	elseif stage == 2 then
		self:SetStatusBarColor(1, 0.8, 0.2)
	elseif stage == 3 then
		self:SetStatusBarColor(1, 0.6, 0)
	elseif stage == 4 then
		self:SetStatusBarColor(1, 0.2, 0)
	end
end

function mUI:CreateCastbar(self)
	local unit = self.unit
	if string.match(self.unit, "^boss[123456789]$") then
		unit = "boss"
	end
	local settings = mUI.profile[unit]
	if settings == nil or settings.castbar == nil then return end
	if settings.castbar.enabled == false then return end

	local Castbar = CreateFrame("StatusBar", nil, self)
	Castbar:SetStatusBarTexture(LSM:Fetch("statusbar", mUI.profile.settings.castbarTexture))
	Castbar.timeToHold = 0.5
	mUI:CreateBorder(Castbar)

	local cbBackground = Castbar:CreateTexture(nil, "BACKGROUND")
	cbBackground:SetAllPoints(Castbar)
	cbBackground:SetColorTexture(0.1, 0.1, 0.1, 1)
	cbBackground.multiplier = 0.5
	Castbar.bg = cbBackground

	if settings.castbar.icon and false then
		local Icon = Castbar:CreateTexture(nil, 'OVERLAY')
		Icon:SetSize(settings.castbar.height, settings.castbar.height)
		Icon:SetPoint('TOPLEFT', Castbar, 'TOPLEFT')
		Icon:SetTexCoord(0.2, 0.8, 0.2, 0.8)
		Castbar.Icon = Icon
	end

	if settings.castbar.shield then
		local Shield = Castbar:CreateTexture(nil, 'OVERLAY')
		Shield:SetTexture([[Interface\AddOns\MangoUI\Media\shield.tga]])
		Shield:SetSize(26, 26)
		Shield:SetPoint('CENTER', Castbar, 'LEFT', -5, 0)
		Castbar.Shield = Shield
	end

	local font = LSM:Fetch("font", mUI.profile.settings.font)

	local SpellCasttime = Castbar:CreateFontString(nil, "OVERLAY")
	SpellCasttime:SetPoint("RIGHT", -4, 0)
	SpellCasttime:SetFont(font, 14, "THINOUTLINE")
	Castbar.Time = SpellCasttime

	local SpellName = Castbar:CreateFontString(nil, "OVERLAY")
	if Castbar.Icon then
		SpellName:SetPoint("LEFT", Castbar.Icon:GetWidth() + 4, 0)
	else
		SpellName:SetPoint("LEFT", 4, 0)
	end
	SpellName:SetFont(font, 14, "THINOUTLINE")
	Castbar.Text = SpellName

	Castbar:ClearAllPoints()
	if settings.castbar.detach and settings.castbar.detach ~= nil then
		Castbar:SetSize(settings.castbar.width, settings.castbar.height)
		Castbar:SetPoint('CENTER', UIParent, 'CENTER', settings.castbar.x, settings.castbar.y)
	else
		Castbar:SetHeight(settings.castbar.height)
		Castbar:SetPoint('TOPLEFT', self, 'BOTTOMLEFT', 0, -6) -- Find a way to calculate these numbers in a smart way
		Castbar:SetPoint('TOPRIGHT', self, 'BOTTOMRIGHT', 0, -6)
	end

	Castbar.PostUpdateStage = PostUpdateStage
	Castbar.PostCastFail = PostCastFail
	Castbar.PostCastStart = PostCastStart
	self.Castbar = Castbar
end
