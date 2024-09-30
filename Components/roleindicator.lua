local _, mUI = ...

local function UpdateRoleIndicator(self)
	local role = UnitGroupRolesAssigned(self.unit)
	if role == "HEALER" then
		self.GroupRoleIndicator:SetTexture([[Interface\AddOns\MangoUI\Media\icons\healer.tga]])
	elseif role == "TANK" then
		self.GroupRoleIndicator:SetTexture([[Interface\AddOns\MangoUI\Media\icons\tank.tga]])
	else
		self.GroupRoleIndicator:SetTexture(nil)
	end
end

function mUI:CreateRoleIndicator(self)
	local indicator = self.Indicators:CreateTexture(nil, "OVERLAY")
	PixelUtil.SetSize(indicator, 14, 14)
	PixelUtil.SetPoint(indicator, "BOTTOMRIGHT", self, "BOTTOMRIGHT", -5, 5)
	indicator.Override = UpdateRoleIndicator
	self.GroupRoleIndicator = indicator
end
