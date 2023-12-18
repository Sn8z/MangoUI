local _, mUI = ...

local function UpdateLeaderIndicator(self, event)
	local leader = self.LeaderIndicator
	if UnitIsGroupLeader(self.unit) then
		leader:SetTexture([[Interface\AddOns\MangoUI\Media\Icons\leader.tga]])
		--leader:SetTexture([[Interface\AddOns\MangoUI\Media\leader.tga]])
		leader:Show()
	else
		leader:Hide()
	end
end

function mUI:CreateLeaderIndicator(self)
	local LeaderIndicator = self.Health:CreateTexture(nil, 'OVERLAY')
	LeaderIndicator:SetSize(20, 20)
	LeaderIndicator:SetPoint("BOTTOMRIGHT", self.Health, "TOPRIGHT", -3, -6)
	LeaderIndicator.Override = UpdateLeaderIndicator
	self.LeaderIndicator = LeaderIndicator
end
