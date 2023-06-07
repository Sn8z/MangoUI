local _, mUI = ...

local function UpdateRoleIndicator(self, event)
	local role = UnitGroupRolesAssigned(self.unit)
	if role == "HEALER" then
		self.GroupRoleIndicator:SetTexture([[Interface\AddOns\MangoUI\Media\healer.tga]])
	elseif role == "TANK" then
		self.GroupRoleIndicator:SetTexture([[Interface\AddOns\MangoUI\Media\tank.tga]])
	else
		self.GroupRoleIndicator:SetTexture([[Interface\AddOns\MangoUI\Media\dps.tga]])
	end
end

function mUI:CreateRoleIndicator(self)
	--if self.unit ~= "party" and self.unit ~= "player" then return end
	local indicator = self.Health:CreateTexture(nil, 'OVERLAY')
	indicator:SetSize(12, 12)
	indicator:SetPoint('BOTTOMRIGHT', self.Health, 'BOTTOMRIGHT', -3, 3)
	indicator.Override = UpdateRoleIndicator
	self.GroupRoleIndicator = indicator
end