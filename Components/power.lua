local _, mUI = ...
local LSM = LibStub("LibSharedMedia-3.0")

local ALTERNATE_POWER_INDEX = Enum.PowerType.Alternate or 10
local UnitPower, UnitPowerMax, UnitIsConnected, GetUnitPowerBarInfo = UnitPower, UnitPowerMax, UnitIsConnected,
		GetUnitPowerBarInfo

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
end

local function GetDisplayPower(element)
	local unit = element.__owner.unit
	local barInfo = GetUnitPowerBarInfo(unit)

	if barInfo then
		return ALTERNATE_POWER_INDEX, barInfo.minPower
	end
end

local function PostUpdatePower(element, unit, cur, min, max)
	local shouldShow = max ~= 0
	element:SetShown(shouldShow)
end

function mUI:CreatePowerBar(self)
	local Power = CreateFrame('StatusBar', nil, self)
	Power:SetStatusBarTexture(LSM:Fetch("statusbar", mUI.db.settings.texture))

	if self.unit == "player" then
		if mUI.db.player.power.detach then
			Power:SetSize(mUI.db.player.power.width, mUI.db.player.power.height)
			Power:SetPoint('CENTER', UIParent, 'CENTER', mUI.db.player.power.x, mUI.db.player.power.y)
		else
			Power:SetHeight(mUI.db.player.power.height)
			Power:SetPoint('TOPLEFT', self.Health, 'BOTTOMLEFT', 0, -2)
			Power:SetPoint('TOPRIGHT', self.Health, 'BOTTOMRIGHT', 0, -2)
		end

		local PowerAmount = Power:CreateFontString(nil, "OVERLAY")
		PowerAmount:SetPoint("CENTER", Power, "CENTER", 0, 0)
		PowerAmount:SetFont(LSM:Fetch("font", mUI.db.settings.font), 16, "THINOUTLINE")
		self:Tag(PowerAmount, "[mango:pp]")
	elseif self.unit == 'target' then
		Power:SetHeight(2)
		Power:SetPoint('TOPLEFT', self.Health, 'BOTTOMLEFT', 0, -2)
		Power:SetPoint('TOPRIGHT', self.Health, 'BOTTOMRIGHT', 0, -2)

		local PowerAmount = Power:CreateFontString(nil, "OVERLAY")
		PowerAmount:SetPoint('CENTER', Power, 'CENTER', 0, 0)
		PowerAmount:SetFont(LSM:Fetch("font", mUI.db.settings.font), 14, "THINOUTLINE")
		self:Tag(PowerAmount, "[mango:pp]")
	elseif self.unit == 'party' then
		Power:SetHeight(2)
		Power:SetPoint('TOPLEFT', self.Health, 'BOTTOMLEFT', 0, -2)
		Power:SetPoint('TOPRIGHT', self.Health, 'BOTTOMRIGHT', 0, -2)
	else
		Power:SetHeight(2)
		Power:SetPoint('TOPLEFT', self.Health, 'BOTTOMLEFT', 0, -2)
		Power:SetPoint('TOPRIGHT', self.Health, 'BOTTOMRIGHT', 0, -2)
	end

	Power.colorPower = true
	Power.frequentUpdates = self.unit == 'player' or self.unit == 'target'
	Power.displayAltPower = self.unit == 'boss'

	mUI:CreateBorder(Power)

	if mUI.db.settings.smooth then
		Mixin(Power, SmoothStatusBarMixin)
		Power.Override = SmoothUpdate
	end

	local bg = Power:CreateTexture(nil, 'BACKGROUND')
	bg:SetAllPoints(Power)
	bg:SetTexture(LSM:Fetch("statusbar", mUI.db.settings.texture))
	bg.multiplier = 1 / 3
	Power.bg = bg
	Power.GetDisplayPower = GetDisplayPower
	Power.PostUpdate = PostUpdatePower
	self.Power = Power
end
