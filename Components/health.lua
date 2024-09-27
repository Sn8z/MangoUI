local _, mUI = ...
local LSM = LibStub("LibSharedMedia-3.0")

local function setup(element)
	element:SetStatusBarTexture(LSM:Fetch("statusbar", mUI.profile.settings.healthTexture))
	if mUI.profile.settings.dark then
		element.colorHealth = true
		element.colorClass = false
		element.colorReaction = false
	else
		element.colorHealth = false
		element.colorClass = true
		element.colorReaction = true
	end
end

local function SmoothUpdate(self, event, unit)
	if (not unit or self.unit ~= unit) then return end
	local element = self.Health

	if (event == "MANGO_UPDATE") then
		setup(element)
	end

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
	--Health:SetStatusBarTexture(LSM:Fetch("statusbar", mUI.profile.settings.healthTexture))
	Health:SetAllPoints()
	setup(Health)
	self.Health = Health

	local hBackground = Health:CreateTexture(nil, "BACKGROUND")
	hBackground:SetAllPoints(Health)
	hBackground:SetTexture(LSM:Fetch("statusbar", mUI.profile.settings.healthTexture))
	self.Health.bg = hBackground

	mUI:CreateHealthBorder(self, true)

	Health.frequentUpdates = true
	Health.colorTapping = true
	Health.colorDisconnected = true

	-- if mUI.profile.settings.dark then
	-- 	Health.colorHealth = true
	-- else
	-- 	Health.colorClass = true
	-- 	Health.colorReaction = true
	-- end
	hBackground.multiplier = 1 / 5

	if mUI.profile.settings.smooth then
		Mixin(Health, SmoothStatusBarMixin)
		Health.Override = SmoothUpdate
	end
end
