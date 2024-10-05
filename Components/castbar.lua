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

	local iconSize = settings.castbar.height
	if settings.castbar.icon then
		local IconFrame = CreateFrame("Frame", nil, Castbar, "BackdropTemplate")
		PixelUtil.SetPoint(IconFrame, "RIGHT", Castbar, "LEFT", 0, 0)
		PixelUtil.SetSize(IconFrame, iconSize, iconSize)
		IconFrame:SetBackdrop({
			edgeFile = [[Interface\AddOns\MangoUI\Media\border.tga]],
			edgeSize = 1,
		})
		IconFrame:SetBackdropBorderColor(0, 0, 0, 1)

		local Icon = IconFrame:CreateTexture(nil, "BACKGROUND")
		Icon:SetAllPoints(IconFrame)
		Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		Castbar.Icon = Icon
	end

	if settings.castbar.shield then
		local Shield = Castbar:CreateTexture(nil, "OVERLAY")
		Shield:SetTexture([[Interface\AddOns\MangoUI\Media\shield.tga]])
		PixelUtil.SetSize(Shield, 26, 26)
		PixelUtil.SetPoint(Shield, "CENTER", Castbar, "LEFT", -5, 0)
		Castbar.Shield = Shield
	end

	local font = LSM:Fetch("font", mUI.profile.settings.font)

	local SpellCasttime = Castbar:CreateFontString(nil, "OVERLAY")
	SpellCasttime:SetPoint("RIGHT", -4, 0)
	SpellCasttime:SetFont(font, 14, "OUTLINE")
	Castbar.Time = SpellCasttime

	local SpellName = Castbar:CreateFontString(nil, "OVERLAY")
	PixelUtil.SetPoint(SpellName, "LEFT", Castbar.Icon, "RIGHT", 4, 0)

	SpellName:SetFont(font, 14, "OUTLINE")
	Castbar.Text = SpellName

	Castbar:ClearAllPoints()
	if settings.castbar.detach and settings.castbar.detach ~= nil then
		if settings.castbar.icon then
			PixelUtil.SetSize(Castbar, settings.castbar.width - iconSize, settings.castbar.height)
			PixelUtil.SetPoint(Castbar, "CENTER", UIParent, "CENTER", settings.castbar.x + iconSize,
				settings.castbar.y)
		else
			PixelUtil.SetSize(Castbar, settings.castbar.width, settings.castbar.height)
			PixelUtil.SetPoint(Castbar, "CENTER", UIParent, "CENTER", settings.castbar.x, settings.castbar.y)
		end
		mUI:AddMover(Castbar, self.unit .. "_Castbar", function(x, y)
			settings.castbar.x = x
			settings.castbar.y = y
		end)
	else
		if settings.castbar.icon then
			PixelUtil.SetSize(Castbar, settings.castbar.width - iconSize, settings.castbar.height)
			PixelUtil.SetPoint(Castbar, "TOPLEFT", self, "BOTTOMLEFT", iconSize, settings.castbar.offsetY)
			PixelUtil.SetPoint(Castbar, "TOPRIGHT", self, "BOTTOMRIGHT", 0, settings.castbar.offsetY)
		else
			PixelUtil.SetHeight(Castbar, settings.castbar.height)
			PixelUtil.SetPoint(Castbar, "TOPLEFT", self, "BOTTOMLEFT", 0, settings.castbar.offsetY)
			PixelUtil.SetPoint(Castbar, "TOPRIGHT", self, "BOTTOMRIGHT", 0, settings.castbar.offsetY)
		end
	end

	Castbar.PostUpdateStage = PostUpdateStage
	Castbar.PostCastFail = PostCastFail
	Castbar.PostCastStart = PostCastStart
	self.Castbar = Castbar
end
