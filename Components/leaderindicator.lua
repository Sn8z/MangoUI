local _, mUI = ...

local function UpdateLeaderIndicator(self, event)
	local leader = self.LeaderIndicator
	if UnitIsGroupLeader(self.unit) then
		leader:SetTexture([[Interface\AddOns\MangoUI\Media\leader.tga]])
		leader:Show()
	else
		leader:Hide()
	end
end

function mUI:CreateLeaderIndicator(self)
	local LeaderIndicator = self.Health:CreateTexture(nil, 'OVERLAY')
	LeaderIndicator:SetSize(16, 6)
	LeaderIndicator:SetPoint('BOTTOMLEFT', self.Health, 'TOPLEFT', 0, 3)
	LeaderIndicator.Override = UpdateLeaderIndicator
	self.LeaderIndicator = LeaderIndicator
end
