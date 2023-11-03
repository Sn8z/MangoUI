local _, mUI = ...
local LSM = LibStub("LibSharedMedia-3.0")

local ALTERNATE_POWER_INDEX = Enum.PowerType.Alternate or 10
local UnitPower, UnitPowerMax, UnitIsConnected, GetUnitPowerBarInfo = UnitPower, UnitPowerMax, UnitIsConnected,
		GetUnitPowerBarInfo

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

	local Power = CreateFrame('StatusBar', nil, self.Health)
	Power:SetStatusBarTexture(LSM:Fetch("statusbar", mUI.profile.settings.powerTexture))

	if settings.power.style == "DETACH" and self.unit == "player" then
		Power:SetSize(settings.power.width, settings.power.height)
		Power:SetPoint("CENTER", UIParent, "CENTER", settings.power.x, settings.power.y)
	elseif settings.power.style == "LEFT" then
		Power:SetPoint("LEFT", self, "BOTTOMLEFT", 6, 0)
		Power:SetSize(settings.power.width, settings.power.height)
	elseif settings.power.style == "RIGHT" then
		Power:SetPoint("RIGHT", self, "BOTTOMRIGHT", -6, 0)
		Power:SetSize(settings.power.width, settings.power.height)
	elseif settings.power.style == "INSET" then
		Power:SetPoint("LEFT", self, "BOTTOMLEFT", 6, 0)
		Power:SetPoint("RIGHT", self, "BOTTOMRIGHT", -6, 0)
		Power:SetHeight(mUI.db.player.power.height)
	else
		Power:SetHeight(settings.power.height)
		Power:SetPoint("TOPLEFT", self, "BOTTOMLEFT", 0, 0)
		Power:SetPoint("TOPRIGHT", self, "BOTTOMRIGHT", 0, 0)
	end

	if settings.power.showText then
		local PowerAmount = Power:CreateFontString(nil, "OVERLAY")
		PowerAmount:SetPoint("CENTER", Power, "CENTER", 0, 0)
		PowerAmount:SetFont(LSM:Fetch("font", mUI.profile.settings.font), settings.power.fontSize or 12, "THINOUTLINE")
		self:Tag(PowerAmount, "[mango:pp]")
	end

	Power.colorDisconnected = true
	Power.colorTapping = false
	Power.colorThreat = false
	Power.colorPower = true

	Power.frequentUpdates = self.unit == 'player' or self.unit == 'target'
	Power.displayAltPower = self.unit == 'boss'
	mUI:CreateBorder(Power)

	if mUI.profile.settings.smooth then
		Mixin(Power, SmoothStatusBarMixin)
		Power.Override = SmoothUpdate
	end

	local bg = Power:CreateTexture(nil, 'BACKGROUND')
	bg:SetAllPoints(Power)
	bg:SetTexture(LSM:Fetch("statusbar", mUI.profile.settings.powerTexture))
	bg.multiplier = 0.4
	Power.bg = bg

	Power.GetDisplayPower = GetDisplayPower
	Power.PostUpdate = PostUpdatePower
	self.Power = Power
end
