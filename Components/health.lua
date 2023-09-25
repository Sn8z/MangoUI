local _, mUI = ...
local LSM = LibStub("LibSharedMedia-3.0")

local UnitHealth, UnitHealthMax, UnitIsConnected = UnitHealth, UnitHealthMax, UnitIsConnected

local function SmoothUpdate(self, event, unit)
	if (not unit or self.unit ~= unit) then return end
	local element = self.Health

	local cur, max = UnitHealth(unit), UnitHealthMax(unit)
	element:SetMinMaxSmoothedValue(0, max)

	if (UnitIsConnected(unit)) then
		element:SetSmoothedValue(cur)
	else
		element:SetSmoothedValue(max)
	end

	element.cur = cur
	element.max = max
end

function mUI:CreateHealth(self)
	local Health = CreateFrame("StatusBar", nil, self)
	Health:SetStatusBarTexture(LSM:Fetch("statusbar", mUI.db.settings.texture))
	Health:SetAllPoints()

	local hBackground = Health:CreateTexture(nil, "BACKGROUND")
	hBackground:SetAllPoints(Health)
	hBackground:SetTexture(LSM:Fetch("statusbar", mUI.db.settings.texture))

	Health.frequentUpdates = true
	Health.colorTapping = true
	Health.colorDisconnected = true
	Health.colorClass = true
	Health.colorReaction = true
	Health.colorHealth = true
	hBackground.multiplier = 1 / 3

	if mUI.db.settings.smooth then
		Mixin(Health, SmoothStatusBarMixin)
		Health.Override = SmoothUpdate
	end

	self.Health = Health
	self.Health.bg = hBackground
end