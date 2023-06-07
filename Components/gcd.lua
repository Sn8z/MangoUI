local AddonName, mUI = ...
local oUF = mUI.oUF

local Update = function(self, event, unit)
	if self.GCD then
		local start, duration = GetSpellCooldown(61305)
		if (not start) then return end
		if (not duration) then duration = 0 end

		if (duration == 0) then
			self.GCD:Hide()
		else
			self.GCD.starttime = start
			self.GCD.duration = duration
			self.GCD:Show()
		end
	end
end

local OnUpdateGCD = function(self)
	local perc = (GetTime() - self.starttime) / self.duration
	if perc > 1 then
		self:Hide()
	else
		self:SetValue(perc)
	end
end

local OnHideGCD = function(self)
	self:SetScript('OnUpdate', nil)
end

local OnShowGCD = function(self)
	self:SetScript('OnUpdate', OnUpdateGCD)
end

local function Enable(self, unit)
	if (self.GCD and UnitIsUnit(unit, 'player')) then
		self.GCD:Hide()
		self.GCD.starttime = 0
		self.GCD.duration = 0
		self.GCD:SetMinMaxValues(0, 1)

		self:RegisterEvent('ACTIONBAR_UPDATE_COOLDOWN', Update, true)
		self.GCD:SetScript('OnHide', OnHideGCD)
		self.GCD:SetScript('OnShow', OnShowGCD)
	end
end

local function Disable(self)
	if self.GCD then
		self.GCD:Hide()
	end
end

oUF:AddElement('GCD', Update, Enable, Disable)