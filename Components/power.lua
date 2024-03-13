local _, mUI = ...
local LSM = LibStub("LibSharedMedia-3.0")

local ALTERNATE_POWER_INDEX = Enum.PowerType.Alternate or 10

local function GetDisplayPower(element)
	local unit = element.__owner.unit
	local barInfo = GetUnitPowerBarInfo(unit)

	if barInfo then
		return ALTERNATE_POWER_INDEX, barInfo.minPower
	end
end

local function SmoothUpdate(self, event, unit)
	if (self.unit ~= unit) then return end
	local element = self.Power

	local displayType, min
	if (element.displayAltPower) then
		displayType, min = element:GetDisplayPower()
	end

	local cur, max = UnitPower(unit, displayType), UnitPowerMax(unit, displayType)
	element:SetMinMaxSmoothedValue(min or 0, max)

	if (UnitIsConnected(unit)) then
		element:SetSmoothedValue(cur)
	else
		element:SetSmoothedValue(max)
	end

	element.cur = cur
	element.min = min
	element.max = max
	element.displayType = displayType

	if (element.PostUpdate) then
		element:PostUpdate(unit, cur, min, max)
	end
end

local function PostUpdatePower(element, unit, cur, min, max)
	local shouldShow = max ~= 0
	element:SetShown(shouldShow)
end

function mUI:CreatePowerBar(self)
	local unit = self.unit
	if string.match(self.unit, "^boss[123456789]$") then
		unit = "boss"
	end
	local settings = mUI.profile[unit]
	if settings == nil or settings.power == nil then return end
	if settings.power.enabled == false then return end

	local Power = CreateFrame("StatusBar", "Power", self)
	Power:SetStatusBarTexture(LSM:Fetch("statusbar", mUI.profile.settings.powerTexture))
	Power:SetFrameLevel(self.Health:GetFrameLevel() + 1)

	if settings.power.style == "DETACH" and self.unit == "player" then
		PixelUtil.SetPoint(Power, "CENTER", UIParent, "CENTER", settings.power.x, settings.power.y)
		PixelUtil.SetSize(Power, settings.power.width, settings.power.height)
		mUI:AddMover(Power, "Player Power", function(x, y)
			settings.power.x = x
			settings.power.y = y
		end)
	elseif settings.power.style == "LEFT" then
		PixelUtil.SetPoint(Power, "LEFT", self, "BOTTOMLEFT", 6, 0)
		PixelUtil.SetSize(Power, settings.power.width, settings.power.height)
	elseif settings.power.style == "RIGHT" then
		PixelUtil.SetPoint(Power, "RIGHT", self, "BOTTOMRIGHT", -6, 0)
		PixelUtil.SetSize(Power, settings.power.width, settings.power.height)
	elseif settings.power.style == "INSET" then
		PixelUtil.SetPoint(Power, "LEFT", self, "BOTTOMLEFT", 6, 0)
		PixelUtil.SetPoint(Power, "RIGHT", self, "BOTTOMRIGHT", -6, 0)
		PixelUtil.SetHeight(Power, settings.power.height)
	else
		PixelUtil.SetPoint(Power, "TOPLEFT", self, "BOTTOMLEFT", 0, 0)
		PixelUtil.SetPoint(Power, "TOPRIGHT", self, "BOTTOMRIGHT", 0, 0)
		PixelUtil.SetHeight(Power, settings.power.height)
	end

	if settings.power.showText then
		local PowerAmount = self.Texts:CreateFontString(nil, "OVERLAY")
		PixelUtil.SetPoint(PowerAmount, "CENTER", Power, "CENTER", 0, 0)
		PowerAmount:SetFont(LSM:Fetch("font", mUI.profile.settings.font), settings.power.fontSize or 12, "THINOUTLINE")
		self:Tag(PowerAmount, "[mango:pp]")
	end

	Power.colorTapping = false
	Power.colorThreat = false
	Power.colorPower = true

	Power.frequentUpdates = self.unit == "player" or self.unit == "target"
	Power.displayAltPower = self.unit == "boss"

	mUI:CreateBorder(Power)

	if mUI.profile.settings.smooth then
		Mixin(Power, SmoothStatusBarMixin)
		Power.Override = SmoothUpdate
	end

	local bg = Power:CreateTexture(nil, "BACKGROUND")
	bg:SetAllPoints(Power)
	bg:SetTexture(LSM:Fetch("statusbar", mUI.profile.settings.powerTexture))
	bg.multiplier = 0.4
	Power.bg = bg

	Power.GetDisplayPower = GetDisplayPower
	Power.PostUpdate = PostUpdatePower
	self.Power = Power


	local powerPrediction = CreateFrame("StatusBar", nil, Power)
	powerPrediction:SetStatusBarTexture(LSM:Fetch("statusbar", mUI.profile.settings.powerTexture))
	powerPrediction:SetStatusBarColor(0.7, 0.7, 0.7, 0.5)
	powerPrediction:SetReverseFill(true)
	powerPrediction:SetPoint("TOP")
	powerPrediction:SetPoint("BOTTOM")
	powerPrediction:SetPoint("RIGHT", Power:GetStatusBarTexture(), "RIGHT")
	powerPrediction:SetWidth(200)

	if self.PowerPrediction then
		self.PowerPrediction.mainBar = powerPrediction
	else
		self.PowerPrediction = {
			mainBar = powerPrediction,
		}
	end
end
